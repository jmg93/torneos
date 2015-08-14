package torneos



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class FormatoTorneoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond FormatoTorneo.list(params), model:[formatoTorneoInstanceCount: FormatoTorneo.count()]
    }

    def show(FormatoTorneo formatoTorneoInstance) {
        respond formatoTorneoInstance
    }

    def create() {
        respond new FormatoTorneo(params)
    }

    @Transactional
    def save(FormatoTorneo formatoTorneoInstance) {
        if (formatoTorneoInstance == null) {
            notFound()
            return
        }

        if (formatoTorneoInstance.hasErrors()) {
            respond formatoTorneoInstance.errors, view:'create'
            return
        }

        formatoTorneoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'formatoTorneo.label', default: 'FormatoTorneo'), formatoTorneoInstance.id])
                redirect formatoTorneoInstance
            }
            '*' { respond formatoTorneoInstance, [status: CREATED] }
        }
    }

    def edit(FormatoTorneo formatoTorneoInstance) {
        respond formatoTorneoInstance
    }

    @Transactional
    def update(FormatoTorneo formatoTorneoInstance) {
        if (formatoTorneoInstance == null) {
            notFound()
            return
        }

        if (formatoTorneoInstance.hasErrors()) {
            respond formatoTorneoInstance.errors, view:'edit'
            return
        }

        formatoTorneoInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'FormatoTorneo.label', default: 'FormatoTorneo'), formatoTorneoInstance.id])
                redirect formatoTorneoInstance
            }
            '*'{ respond formatoTorneoInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(FormatoTorneo formatoTorneoInstance) {

        if (formatoTorneoInstance == null) {
            notFound()
            return
        }

        formatoTorneoInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'FormatoTorneo.label', default: 'FormatoTorneo'), formatoTorneoInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'formatoTorneo.label', default: 'FormatoTorneo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
