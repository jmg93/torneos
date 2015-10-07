package torneos

import equipos.Equipo
import grails.transaction.Transactional
import partidos.Partido

@Transactional
class FixtureService {

	
	def sortearFixture(Torneo torneoInstance) {
				
		def torneoo = torneoInstance
		
		println torneoo.nombre
		
		def todosPartidos = torneoo.partidos
		
		def todosEquipos = Equipo.where{torneo == torneoo}.list()
		def equipoAuxi = new Equipo()
		def cantEquipos = todosEquipos.size()
		
		//ordenamiento random de todos los equipos
		for (int i = cantEquipos - 1; i > 1; i--) {
			def nrandom = Math.abs(new Random().nextInt() % (i+1)) //genera un num random entre 0 y i
			equipoAuxi = todosEquipos.get(nrandom)
			todosEquipos[nrandom] = todosEquipos.get(i)
			todosEquipos[i] = equipoAuxi
		}
		
		if (cantEquipos % 2 != 0)
			todosEquipos.add(new Equipo(nombre: "equipoLibre", contacto:"libre@gmail.com"))	
		
		cantEquipos = todosEquipos.size()
		def cantFechas = todosEquipos.size() - 1
		def cantPartidosPorFecha = cantEquipos.intdiv(2)
		
		def equiposLocal = new int[cantPartidosPorFecha]
		def equiposVisitante = new int[cantPartidosPorFecha]
		
		for (int i = 0; i < cantPartidosPorFecha; i++){
			equiposLocal[i] = i
			equiposVisitante[i] = i + cantPartidosPorFecha
		}
		
		for (int numFecha = 1; numFecha <= cantFechas; numFecha++){
			for (int j = 0; j < cantPartidosPorFecha; j++){
				if ( (todosEquipos.get(equiposLocal[j]).nombre != "equipoLibre") && (todosEquipos.get(equiposVisitante[j]).nombre != "equipoLibre") ) {
					println numFecha
					def partidoAagregar = new Partido(nFecha: numFecha, local: todosEquipos.get(equiposLocal[j]), visitante: todosEquipos.get(equiposVisitante[j]) )
					torneoo.addToPartidos(partidoAagregar)
					torneoo.save(flush: true)					
				}				
			}
			
			//movimiento de los equipos
			int nAuxi = 0
			for (int i = cantPartidosPorFecha - 1 ; i > 0; i--){
				nAuxi = equiposVisitante[i - 1]
				equiposVisitante[i-1] = equiposVisitante[cantPartidosPorFecha - 1]
				equiposVisitante[cantPartidosPorFecha - 1] = nAuxi	
			}
			for (int i = 1; i < cantPartidosPorFecha; i++) {
				nAuxi = equiposLocal[i]
				equiposLocal[i] = equiposVisitante[cantPartidosPorFecha - 1]
				equiposVisitante[cantPartidosPorFecha - 1] = nAuxi
			}
			
		}
					
		todosPartidos = torneoo.partidos
		
		return todosPartidos
		
	}
	
    def serviceMethod() {

    }
}
