package torneos

import equipos.Equipo
import grails.transaction.Transactional
import partidos.Partido

@Transactional
class FixtureService {

	
	def sortearFixture(Torneo torneoInstance) {
		//ATENCION: Lo siguiente no se va a entender nadaa (?)
		def diaManiana = new Date()
		
		def todosTorneos = Torneo.list()
		def cantTorneos = todosTorneos.size()
		//def torneoo = todosTorneos.get(cantTorneos - 1)
		def torneoo = torneoInstance
		
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
					def partidoAagregar = new Partido(nFecha: nVisitante, local: todosEquipos.get(nLocal), visitante: todosEquipos.get(nVisitante) )
					torneoo.addToPartidos(partidoAagregar)
					torneoo.save(flush: true)
				}
			}
		}
	
		
		todosPartidos = torneoo.partidos
		cantPartidos = todosPartidos.size()
		println cantPartidos
		
		return todosPartidos
		
		//render "Fixture del torneo ${torneoo.nombre} generado con éxito"
		//render "<br/>"
		//render "<br/>"
		
		//for (int i = 0; i < cantPartidos; i++) {
			//def partidoAMostrar = todosPartidos.get(i)
			//render partidoAMostrar
			//render "<br/>"
			//render 'Fecha ' +  partidoAMostrar.nFecha + ': ' + partidoAMostrar.local + ' vs ' + partidoAMostrar.visitante
			//}
		
		//render "<p>Fixture creado con éxito</p>"
		//render torneoo.partidos.list()
	}
	
    def serviceMethod() {

    }
}
