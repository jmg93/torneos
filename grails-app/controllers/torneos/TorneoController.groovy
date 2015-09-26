package torneos


import partidos.Partido 
import equipos.Equipo
import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TorneoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

	def sortearFixture() { 
		//ATENCION: Lo siguiente no se va a entender nadaa (?)
		def diaManiana = new Date()
		
		def todosTorneos = Torneo.list()
		def cantTorneos = todosTorneos.size()
		def torneoo = todosTorneos.get(cantTorneos - 1)
		
		println torneoo.nombre
		
		def todosPartidos = torneoo.partidos
		def cantPartidos = todosPartidos.size()
		
		println cantPartidos
		
		def todosEquipos = Equipo.where{torneo == torneoo}.list()
		def equipoAuxi = new Equipo()
		def cantEquipos = todosEquipos.size()
		
		def nrandom = Math.abs(new Random().nextInt() % cantEquipos) //genera un num random entre 0 y numero de equipos - 1
		equipoAuxi = todosEquipos.get(0)
		todosEquipos[0] = todosEquipos.get(nrandom)
		todosEquipos[nrandom] = equipoAuxi
		
		if (cantEquipos % 2 != 0)
			todosEquipos.add(new Equipo(nombre: "equipoLibre", contacto:"libre@gmail.com"))
		
		cantEquipos = todosEquipos.size()
		def cantFechas = todosEquipos.size() - 1
		def cantPartidosPorFecha = cantEquipos.intdiv(2)
		
		for (int nLocal = 0; nLocal < cantEquipos; nLocal++) {
			for (int nVisitante = nLocal + 1; nVisitante < cantEquipos; nVisitante++) {
				if ( (todosEquipos.get(nLocal).nombre != "equipoLibre") && (todosEquipos.get(nVisitante).nombre != "equipoLibre") ) {
					def partidoAagregar = new Partido(nFecha: nVisitante, fechaPartido: diaManiana, local: todosEquipos.get(nLocal), visitante: todosEquipos.get(nVisitante) )
					torneoo.addToPartidos(partidoAagregar)
					torneoo.save(flush: true)
				}
			}
		} 
	
		
		todosPartidos = torneoo.partidos
		cantPartidos = todosPartidos.size()
		println cantPartidos
		
		
		for (int i = 0; i < cantPartidos; i++) {
			def partidoAMostrar = todosPartidos.get(i)
			println 'fecha ' +  partidoAMostrar.nFecha + ': ' + partidoAMostrar.local + ' VERSUS ' + partidoAMostrar.visitante
			}
		
		render "<p> hola prueba</p>"
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
