package torneos



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.transaction.annotation.Transactional
import partidos.Partido
import equipos.Equipo


@Transactional(readOnly = true)
class TorneoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def FixtureService
	def springSecurityService

	def mostrarReglamento(Torneo torneoInstance){
		render view:"reglamento", model:[torneoInstance:torneoInstance]
	}
	
	def inscripcion(Torneo torneoInstance){
		if (new Date() < torneoInstance.fechaLimite){
			forward controller:"equipo", action:"create", params:[torneoId:torneoInstance.id]
		}else{
			flash.message = "La inscripción está cerrada"
			redirect action:"show", id:torneoInstance.id
		} 
	}
	
	def busquedaTorneo(){
		def listaFiltrada = Torneo.createCriteria().list(params) {
			if(params.parametro){
				ilike("nombre", "%${params.parametro}%")
			}
		
		}
		if(!listaFiltrada){
			flash.message = "El torneo ${params.parametro} no existe"
		}
		render view:"index", model:[listaFiltrada:listaFiltrada]
    }
	
	@Secured(['ROLE_USER'])
	def listaEquipos(Torneo torneoInstance){
		if(torneoInstance.usuario == springSecurityService.currentUser){
			def equipos = torneoInstance.equipos
			render(view:"aceptarEquipos", model: [equipos:equipos, torneoInstance:torneoInstance])
		}else{
			flash.message = "Acceso denegado (Sólo disponible para el administrador del torneo)"
			redirect action:"show", id:torneoInstance.id
		}
	}	
	
	def mostrarFixture(Torneo torneoInstance) {		
		if (FixtureService.torneoEmpezado(torneoInstance))
			render view:"mostrarFixture", model: [todosPartidos: torneoInstance.partidos, torneoInstance: torneoInstance]
		else{
			flash.message = "El torneo no ha empezado"
			render view:"mostrarFixture", model: [todosPartidos: torneoInstance.partidos, torneoInstance: torneoInstance]
		}
	}
	
	def mostrarTabla(Torneo torneoInstance) {
		if (FixtureService.torneoEmpezado(torneoInstance)) {
			def filas
			filas = FixtureService.calcularTablaPosiciones(torneoInstance)
			render(view: "tablaPosiciones",  model: [filas:filas, torneoInstance:torneoInstance])
		} else {
			flash.message = "El torneo no ha empezado"
			redirect action:"show", id:torneoInstance.id
		}		
	}
	
	@Secured(['ROLE_USER'])
	def crearFixture(Torneo torneoInstance){
		if (torneoInstance.usuario != springSecurityService.currentUser){
			flash.message = "Acceso denegado (Sólo disponible para el administrador del torneo)"
			redirect action:"show", id:torneoInstance.id
			return
		}
		def cantEquipos = FixtureService.getCantidadEquipos(torneoInstance) //obtiene cantidad de equipos aceptados en el torneo
		
		if(cantEquipos < 2){ //Si hay menos de dos equipos no tiene sentido
			flash.message = "La cantidad de equipos aceptados tiene que ser 2 como mínimo"
			redirect action:"listaEquipos", id:torneoInstance.id
			return
		}
		
		if (FixtureService.torneoEmpezado(torneoInstance)){ //Si el torneo ya empezo no se puede generar el fixture
			flash.message = "El torneo ya empezó, no podés generar otro fixture"
			redirect action:"listaEquipos", id:torneoInstance.id
			return
		}
		
		if(torneoInstance.fechaLimite > new Date()){ //Si la inscripción está abierta no se puede generar el fixture
			flash.message = "La inscripción todavía está abierta"
			redirect action:"listaEquipos", id:torneoInstance.id
			return
		}
		
		if(FixtureService.getCantidadPartidos(torneoInstance)>0){ //Si ya hay partidos significa que ya fue generado
			flash.message = "Ya generaste el fixture"
			redirect action:"listaEquipos", id:torneoInstance.id
			return
		}
		
		def todosPartidos = FixtureService.sortearFixture(torneoInstance)
		render(view: "mostrarFixture",  model: [todosPartidos:todosPartidos, torneoInstance:torneoInstance])
		
		/*if (cantEquipos >= 2) { //para sortear el fixture tiene que haber minimo 2 equipos aceptados
			if ( (FixtureService.torneoEmpezado(torneoInstance) == false ) && (torneoInstance.fechaLimite < new Date())) { // y tambien el torneo no tiene que estar empezado
				def todosPartidos = FixtureService.sortearFixture(torneoInstance)
				render(view: "mostrarFixture",  model: [todosPartidos:todosPartidos, torneoInstance:torneoInstance])
			} else {
				if((FixtureService.getCantidadPartidos(torneoInstance) == 0)){ //si ya se creo el fixture no se puede cambiar
					flash.message = "Ya generaste el fixture"
					redirect action:"listaEquipos", id:torneoInstance.id
				}else{
					flash.message = "El torneo ya empezó, no podés generar otro fixture"
					redirect action:"listaEquipos", id:torneoInstance.id
				}
			}
		} else {
			flash.message = "La cantidad de equipos aceptados tiene que ser 2 como mínimo"
			redirect action:"listaEquipos", id:torneoInstance.id
		}*/
	}

	def verTablaGoleadores(Torneo torneoInstance){
		if (FixtureService.torneoEmpezado(torneoInstance)) {
			def resultado = FixtureService.calcularTablaGoleadores(torneoInstance)
			render(view: "tablaGoleadores",  model: [filas: resultado, torneoInstance: torneoInstance])
		} else {
			redirect action:"show", id:torneoInstance.id
			flash.message = "El torneo no ha empezado"
		}
	}
	
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Torneo.list(params), model:[torneoInstanceCount: Torneo.count()]
    }

    def show(Torneo torneoInstance) {
		def filas = FixtureService.calcularTablaPosiciones(torneoInstance)
		def equiposAceptados = FixtureService.getCantidadEquipos(torneoInstance)		
        respond torneoInstance, model: [filas:filas, equiposAceptados:equiposAceptados]
    }

	@Secured(['ROLE_USER'])
    def create() {
        respond new Torneo(params)
    }

    @Transactional
    def save(Torneo torneoInstance) {
		def torneo=torneoInstance
		torneoInstance.usuario = springSecurityService.currentUser
		
		if (torneoInstance.nMaxJugadorXEquipo < torneoInstance.nMinJugadorXEquipo){
			flash.message = "El número máximo de jugadores por equipo debe ser mayor o igual al mínimo"
			redirect action:"create"
			return
		}
		
		if (torneoInstance.fechaInicio<=torneoInstance.fechaLimite){
			flash.message = "El límite de inscripción debe ser anterior a la fecha de inicio del torneo"
			redirect action:"create"
			return	
		}

		if (torneoInstance == null) {
            notFound()
            return
        }

        if (torneoInstance.hasErrors()) {
            respond torneoInstance.errors, view:'create'
            return
        }
		

        torneoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = "${torneoInstance} creado"
                redirect torneoInstance
            }
            '*' { respond torneoInstance, [status: CREATED] }
        }
	
    }
	
	@Secured(['ROLE_USER'])
    def edit(Torneo torneoInstance) {
        respond torneoInstance
    }

    @Transactional
    def update(Torneo torneoInstance) {
		if (torneoInstance.nMaxJugadorXEquipo < torneoInstance.nMinJugadorXEquipo){
			flash.message = "El número máximo de jugadores por equipo debe ser mayor o igual al mínimo"
			redirect action:"edit", id:torneoInstance.id
			return
		}
		
		if (torneoInstance.fechaInicio<=torneoInstance.fechaLimite){
			flash.message = "El límite de inscripción debe ser anterior a la fecha de inicio del torneo"
			redirect action:"edit", id:torneoInstance.id
			return
		}
		
        if (torneoInstance == null) {
            notFound()
            return
        }

        if (torneoInstance.hasErrors()) {
            respond torneoInstance.errors, view:'edit'
            return
        }

        torneoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = "${torneoInstance} actualizado"
                redirect torneoInstance
            }
            '*'{ respond torneoInstance, [status: OK] }
        }
    }
	
	@Secured(['ROLE_USER'])
    @Transactional
    def delete(Torneo torneoInstance) {		
		//si se borra un torneo que tiene partidos cargados, te tira un error de PK y FK por las tablas de los partidos.
		if(1){//Hay que ver como solucionar esto
			flash.message = "Funcionalidad no disponible por el momento"
			redirect action:"show", id:torneoInstance.id
			return
		}
		
		if (torneoInstance == null) {
            notFound()
            return
        }

        torneoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = "${torneoInstance} eliminado"
                redirect controller:"user", action:"show", id:torneoInstance.usuario.id
            }
            '*'{ render status: NO_CONTENT }
        }

    }
	
	// Se usa para cargar 10 equipoos de una
	def meterEquipos(Torneo torneoInstance) {
		
		FixtureService.crearEquipos(torneoInstance)
		flash.message = "ahi deberia haber hecho la magia"
		redirect action:"show", id:torneoInstance.id		
	}

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'torneo.label', default: 'Torneo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
