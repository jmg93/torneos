package equipos



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class EquipoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def AdministrarService
	def FixtureService
	
	def agregarJugador(Equipo equipoInstance){
		forward controller:"jugador", action:"create", params:[equipoId: equipoInstance.id]
	}
		
	def aceptar(Equipo equipoInstance){
		def torneo = equipoInstance.torneo
		
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
                flash.message = message(code: 'default.created.message', args: [message(code: 'equipo.label', default: 'Equipo'), equipoInstance.id])
                redirect equipoInstance
            }
            '*' { respond equipoInstance, [status: CREATED] }
        }
    }

    def edit(Equipo equipoInstance) {
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
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Equipo.label', default: 'Equipo'), equipoInstance.id])
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
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Equipo.label', default: 'Equipo'), equipoInstance.id])
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
