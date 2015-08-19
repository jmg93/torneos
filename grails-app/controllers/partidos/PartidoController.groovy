package partidos



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class PartidoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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

    def edit(Partido partidoInstance) {
        respond partidoInstance
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

        partidoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Partido.label', default: 'Partido'), partidoInstance.id])
                redirect partidoInstance
            }
            '*'{ respond partidoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Partido partidoInstance) {

        if (partidoInstance == null) {
            notFound()
            return
        }

        partidoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Partido.label', default: 'Partido'), partidoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
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
