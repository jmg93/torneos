package equipos



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import partidos.Partido

@Transactional(readOnly = true)
class EquipoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def AdministrarService
	def FixtureService
	def springSecurityService
	
	
	def agregarJugador(Equipo equipoInstance){
		if(FixtureService.torneoEmpezado(equipoInstance.torneo)){
			if(equipoInstance.torneo.usuario == springSecurityService.currentUser){
				forward controller:"jugador", action:"create", params:[equipoId: equipoInstance.id]
				return
			}
			flash.message = "El torneo ya empezó, solo el administrador del torneo puede agregar jugadores al equipo"
			redirect action:"show", id:equipoInstance.id
			return
		}
		
	}
	
		/* Lo uso para cargar 10 jgadores de una en un equipo
	def meterJugadores(Equipo equipoInstance) {
		FixtureService.cargarJugadores(equipoInstance)
		flash.message = "deberia haber hecho la magia"
		redirect action:"show", id:equipoInstance.id
	}*/
	
	def partidosEquipo(Equipo equipoInstance){
		def partidosEquipo = Partido.where {((local==equipoInstance) || (visitante==equipoInstance)) && (torneo==equipoInstance.torneo)}
		render view:"partidosEquipo", model:[equipoInstance: equipoInstance, partidosEquipo: partidosEquipo]		
	}
	
	def aceptar(Equipo equipoInstance){
		def torneo = equipoInstance.torneo
		
		if (FixtureService.torneoEmpezado(torneo) ) {
			flash.message = "El torneo ya esta empezado por lo que no se puede agregar el equipo"
			redirect controller:"torneo", action:"listaEquipos", id:torneo.id
		} else {
		if (FixtureService.getCantidadEquipos(torneo) >= torneo.nMaxEquipos){
			flash.message = "El torneo ya tiene los ${torneo.nMaxEquipos} equipos permitidos"
			redirect controller:"torneo", action:"listaEquipos", id:torneo.id
		}else{
			if (equipoInstance.jugadores.size() > torneo.nMaxJugadorXEquipo) {
				flash.message = "El equipo tiene más jugadores de los que permite el torneo"
				redirect controller:"torneo", action:"listaEquipos", id:torneo.id	
			} else {
				if (equipoInstance.jugadores.size()< torneo.nMinJugadorXEquipo){
					flash.message = "El equipo tiene menos jugadores de los que permite el torneo"
					redirect controller:"torneo", action:"listaEquipos", id:torneo.id
				} else {
					AdministrarService.aceptarEquipo(equipoInstance)
					flash.message = "Equipo ${equipoInstance} aceptado en el torneo"
					redirect(controller:"torneo", action:"listaEquipos", id:torneo.id)
				}
			}
		}
	}
		
    }
	
	def eliminar(Equipo equipoInstance){
		def torneo = equipoInstance.torneo
		def nombre = equipoInstance.nombre
		flash.message = "${nombre} eliminado del torneo"
		torneo.equipos.remove(equipoInstance)
		equipoInstance.delete(flush:true)
		redirect(controller:"torneo", action:"listaEquipos", id:torneo.id)
	}

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Equipo.list(params), model:[equipoInstanceCount: Equipo.count()]
    }

    def show(Equipo equipoInstance) {
        respond equipoInstance
    }

    def create() {
        respond new Equipo(params)
    }

    @Transactional
    def save(Equipo equipoInstance) {
		if (Equipo.where {(torneo==equipoInstance.torneo) && (nombre==equipoInstance.nombre)}) {
			flash.message = "Ya hay un equipo con ese nombre"
			redirect controller:"torneo", action:"show", id:equipoInstance.torneo.id
			return		
		}
		
		if (equipoInstance == null) {
            notFound()
            return
        }

        if (equipoInstance.hasErrors()) {
            respond equipoInstance.errors, view:'create'
            return
        }
		
		equipoInstance.aceptado = false

        equipoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = "${equipoInstance} creado"
                redirect equipoInstance
            }
            '*' { respond equipoInstance, [status: CREATED] }
        }
    }

    def edit(Equipo equipoInstance) {
		if(1){
			flash.message = "Los equipos no se pueden editar"
			redirect view:"show", id:equipoInstance.id
			return
		}
        respond equipoInstance
    }

    @Transactional
    def update(Equipo equipoInstance) {
        if (equipoInstance == null) {
            notFound()
            return
        }

        if (equipoInstance.hasErrors()) {
            respond equipoInstance.errors, view:'edit'
            return
        }

        equipoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = "${equipoInstance} actualizado"
                redirect equipoInstance
            }
            '*'{ respond equipoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Equipo equipoInstance) {

        if (equipoInstance == null) {
            notFound()
            return
        }

        equipoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = "${equipoInstance} eliminado"
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'equipo.label', default: 'Equipo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
