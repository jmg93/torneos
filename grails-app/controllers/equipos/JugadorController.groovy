package equipos



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Transactional(readOnly = true)
class JugadorController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Jugador.list(params), model:[jugadorInstanceCount: Jugador.count()]
    }

    def show(Jugador jugadorInstance) {
        respond jugadorInstance
    }

    def create() {
        respond new Jugador(params), model:[equipoId: params.equipoId]
    }

    @Transactional
    def save(Jugador jugadorInstance) {
		def equipoJ = jugadorInstance.equipo
		
		if (Jugador.where {(equipo==equipoJ) && (dni==jugadorInstance.dni)}) { //Si ya hay un jugador con el mismo DNI en el equipo no lo agrega
			flash.message = "Ya hay un jugador con el mismo DNI en el equipo"
			redirect controller:"equipo", action:"show", id:equipoJ.id
			return
		}
		
		if ((Jugador.where {(equipo==equipoJ) && (capitan==true)}) && jugadorInstance.capitan){ //Si ya hay un capitan en el equipo no lo agrega
			flash.message = "El equipo ya tiene un capitán"
			redirect controller:"equipo", action:"show", id:equipoJ.id
			return
		}		
		
		if (Jugador.findAllByNCamisetaAndEquipo(jugadorInstance.nCamiseta,equipoJ)){ //Si ya hay un jugador con el mismo número de camiseta no lo agrega
			flash.message = "No puede haber dos jugadores con el mismo número de camiseta"
			redirect controller:"equipo", action:"show", id:equipoJ.id
			return
		}
		
		
        if (jugadorInstance == null) {
            notFound()
            return
        }

        if (jugadorInstance.hasErrors()) {
            respond jugadorInstance.errors, view:'create'
            return
        }

        jugadorInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = "${jugadorInstance} agregado"
                redirect controller:"equipo", action:"show", id:equipoJ.id
            }
            '*' { respond jugadorInstance, [status: CREATED] }
        }
    }
	
	@Secured(['ROLE_USER'])
    def edit(Jugador jugadorInstance) {
        if(jugadorInstance.equipo.torneo.usuario == springSecurityService.currentUser){
			respond jugadorInstance
		}else{
			flash.message = "Acceso denegado (Sólo disponible para el administrador del torneo)"
			redirect action:"show", id:jugadorInstance.id
		}
    }

    @Transactional
    def update(Jugador jugadorInstance) {
        if (jugadorInstance == null) {
            notFound()
            return
        }

        if (jugadorInstance.hasErrors()) {
            respond jugadorInstance.errors, view:'edit'
            return
        }

        jugadorInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Jugador.label', default: 'Jugador'), jugadorInstance.id])
                redirect jugadorInstance
            }
            '*'{ respond jugadorInstance, [status: OK] }
        }
    }

    @Transactional
	@Secured(['ROLE_USER'])
    def delete(Jugador jugadorInstance) {
		if(jugadorInstance.equipo.torneo.usuario != springSecurityService.currentUser){
			flash.message = "Acceso denegado (Sólo disponible para el administrador del torneo)"
			redirect action:"show", id:jugadorInstance.id
			return
		}
		
        if (jugadorInstance == null) {
            notFound()
            return
        }

		def equipo = jugadorInstance.equipo
        jugadorInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Jugador.label', default: 'Jugador'), jugadorInstance.id])
                redirect controller:"equipo", action:"show", id:equipo.id
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'jugador.label', default: 'Jugador'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
