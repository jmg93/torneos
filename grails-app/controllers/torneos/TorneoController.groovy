package torneos



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TorneoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	
	def FixtureService
	
	def mostrarFixture(Torneo torneoInstance) {
		
		if (torneoInstance.partidos.size() > 0)
			[todosPartidos: torneoInstance.partidos, torneoInstance: torneoInstance]
		else
			render "El fixture no ha sido generado todavía"

	}
	
	def mostrarTabla(Torneo torneoInstance) {
		def cantPartidos = torneoInstance.partidos.size()
		def todosPartidos
		if (cantPartidos != 0){
			todosPartidos = FixtureService.calcularTabla(torneoInstance)
			render "<h1> hola prueba </h1>"
			//render(view: "mostrarFixture",  model: [todosPartidos:todosPartidos, torneoInstance:torneoInstance])
		}
		else 
		{
			render "Todavia no se genero el fixture"
		}
	}
	
	def crearFixture(Torneo torneoInstance){		
		def cantPartidos = torneoInstance.partidos.size()
		def todosPartidos
		if (cantPartidos == 0){
			todosPartidos = FixtureService.sortearFixture(torneoInstance)
			render(view: "mostrarFixture",  model: [todosPartidos:todosPartidos, torneoInstance:torneoInstance])
		}else{
			render "Ya generaste el Fixture"
		}
	}

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Torneo.list(params), model:[torneoInstanceCount: Torneo.count()]
    }

    def show(Torneo torneoInstance) {
        respond torneoInstance
    }

    def create() {
        respond new Torneo(params)
    }

    @Transactional
    def save(Torneo torneoInstance) {
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
