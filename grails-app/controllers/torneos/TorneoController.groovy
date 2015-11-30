package torneos



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import equipos.Equipo

import org.springframework.transaction.annotation.Transactional


@Transactional(readOnly = true)
class TorneoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def FixtureService
	def springSecurityService
	
	
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
	
	def listaEquipos(Torneo torneoInstance){
		def equipos = torneoInstance.equipos
		render(view:"aceptarEquipos", model: [equipos:equipos, torneoInstance:torneoInstance])
	}	
	
	def mostrarFixture(Torneo torneoInstance) {		
		if (FixtureService.torneoEmpezado(torneoInstance))
			render view:"mostrarFixture", model: [todosPartidos: torneoInstance.partidos, torneoInstance: torneoInstance]
		else{
			flash.message = "El fixture no ha sido generado todavía"
			redirect action:"show", id:torneoInstance.id
		}
	}
	
	def mostrarTabla(Torneo torneoInstance) {
		if (FixtureService.torneoEmpezado(torneoInstance)) {
			def cantPartidos = FixtureService.getCantidadPartidos(torneoInstance)
			def filas
			filas = FixtureService.calcularTablaPosiciones(torneoInstance)
			render(view: "tablaPosiciones",  model: [filas:filas, torneoInstance:torneoInstance])
		} else {
			flash.message = "El fixture no ha sido generado todavía"
			redirect action:"show", id:torneoInstance.id
		}		
	}
	
	def crearFixture(Torneo torneoInstance){
		def cantEquipos = FixtureService.getCantidadEquipos(torneoInstance) //obtiene cantidad de equipos aceptados en el torneo
		if (cantEquipos >= 2) { //para sortear el fixture tiene que haber minimo 2 equipos aceptados
			if ( (FixtureService.torneoEmpezado(torneoInstance) == false ) ) { // y tambien el torneo no tiene que estar empezado
				def todosPartidos = FixtureService.sortearFixture(torneoInstance)
				render(view: "mostrarFixture",  model: [todosPartidos:todosPartidos, torneoInstance:torneoInstance])
			} else {
				flash.message = "El fxture ya esta generado"
				redirect action:"listaEquipos", id:torneoInstance.id
			}
		} else {
			flash.message = "La cantidad de equipos aceptados tiene que ser 2 como minimo"
			redirect action:"listaEquipos", id:torneoInstance.id
		}
	}

	def verTablaGoleadores(Torneo torneoInstance){
		if (FixtureService.torneoEmpezado(torneoInstance)) {
			def resultado = FixtureService.calcularTablaGoleadores(torneoInstance)
			render(view: "tablaPosiciones_test",  model: [filas: resultado, torneoInstance: torneoInstance])
		} else {
			flash.message = "El torneo no ha empezado"
			redirect action:"show", id:torneoInstance.id 
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
		torneoInstance.usuario = springSecurityService.currentUser
		
		if (torneoInstance.fechaInicio<=torneoInstance.fechaLimite){
			flash.message = "La fecha de Inicio no puede ser anterior a la fecha Límite de inscripción"
			redirect action:"create"	
		} else {

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
                flash.message = message(code: 'default.created.message', args: [message(code: 'torneo.label', default: 'Torneo'), torneoInstance.id])
                redirect torneoInstance
            }
            '*' { respond torneoInstance, [status: CREATED] }
        }
		}
    }

    def edit(Torneo torneoInstance) {
        respond torneoInstance
    }

    @Transactional
    def update(Torneo torneoInstance) {
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
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Torneo.label', default: 'Torneo'), torneoInstance.id])
                redirect torneoInstance
            }
            '*'{ respond torneoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Torneo torneoInstance) {

        if (torneoInstance == null) {
            notFound()
            return
        }

        torneoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Torneo.label', default: 'Torneo'), torneoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
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
