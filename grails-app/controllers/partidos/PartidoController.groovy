package partidos



import static org.springframework.http.HttpStatus.*
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PartidoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Partido.list(params), model:[partidoInstanceCount: Partido.count()]
    }

    def show(Partido partidoInstance) {
        respond partidoInstance
    }

    def create() {
        respond new Partido(params)
    }

    @Transactional
    def save(Partido partidoInstance) {
        if (partidoInstance == null) {
            notFound()
            return
        }

        if (partidoInstance.hasErrors()) {
            respond partidoInstance.errors, view:'create'
            return
        }

        partidoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'partido.label', default: 'Partido'), partidoInstance.id])
                redirect partidoInstance
            }
            '*' { respond partidoInstance, [status: CREATED] }
        }
    }
	
	@Secured(['ROLE_USER'])
    def edit(Partido partidoInstance) {
        if(partidoInstance.local.torneo.usuario == springSecurityService.currentUser){
			respond partidoInstance
		}else{
			flash.message = "Acceso denegado (Sólo disponible para el administrador del torneo)"
			redirect controller:"torneo", action:"show", id:partidoInstance.local.torneo.id
		}
    }

    @Transactional
    def update(Partido partidoInstance) {
        if (partidoInstance == null) {
            notFound()
            return
        }

        if (partidoInstance.hasErrors()) {
            respond partidoInstance.errors, view:'edit'
            return
        }
		
		def locales = partidoInstance.local.jugadores
		def visitantes = partidoInstance.visitante.jugadores
	
		partidoInstance.goleadoresLocal.clear()
		partidoInstance.amonestadosLocal.clear()
		partidoInstance.expulsadosLocal.clear()
		partidoInstance.amonestadosVisitante.clear()
		partidoInstance.expulsadosVisitante.clear()
		partidoInstance.goleadoresVisitante.clear()
		
		for(j in locales){
			def n = j.id

			if(params."jugador[${n}]".amonestado == "on")
				partidoInstance.amonestadosLocal.add(j)
				
			if(params."jugador[${n}]".expulsado == "on")
				partidoInstance.expulsadosLocal.add(j)
				
			for(int i=0;i<params."jugador[${n}]".goles.toInteger(); i++)
				partidoInstance.goleadoresLocal.add(j)				
		}
		
		for(j in visitantes){
			def n = j.id

			if(params."jugador[${n}]".amonestado == "on")
				partidoInstance.amonestadosVisitante.add(j)
				
			if(params."jugador[${n}]".expulsado == "on")
				partidoInstance.expulsadosVisitante.add(j)
				
			for(int i=0;i<params."jugador[${n}]".goles.toInteger(); i++)
				partidoInstance.goleadoresVisitante.add(j)
		}

        partidoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = "Partido actualizado"
                redirect partidoInstance
            }
            '*'{ respond partidoInstance, [status: OK] }
        }
    }

    @Transactional
	@Secured(['ROLE_USER'])
    def delete(Partido partidoInstance) {
		if(partidoInstance.local.torneo.usuario == springSecurityService.currentUser){
	        if (partidoInstance == null) {
	            notFound()
	            return
	        }
	
	        def torneo = partidoInstance.torneo
			partidoInstance.delete flush:true
	
	        request.withFormat {
	            form multipartForm {
	                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Partido.label', default: 'Partido'), partidoInstance.id])
	                redirect controller:"torneo", action:"listaEquipos", id:torneo.id
	            }
	            '*'{ render status: NO_CONTENT }
	        }
		} else { 
			flash.message = "Acceso denegado (Sólo disponible para el administrador del torneo)"
			redirect controller:"torneo", action:"show", id:partidoInstance.local.torneo.id
		}
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'partido.label', default: 'Partido'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
