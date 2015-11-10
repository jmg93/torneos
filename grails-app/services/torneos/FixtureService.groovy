package torneos

import equipos.Equipo
import grails.transaction.Transactional
import partidos.Partido

@Transactional
class FixtureService {
	
	//todos los println estan para testear algunas cosas
	
	def sortearFixture(Torneo torneoInstance) {
				
		def torneoo = torneoInstance	
		println torneoo.nombre
		
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
		
		if (cantEquipos % 2 != 0) //se agrega equipo para que haya una cantidad par de equipos
			todosEquipos.add(new Equipo(nombre: "equipoLibre", contacto:"libre@gmail.com"))	
		
		cantEquipos = todosEquipos.size()
		def cantFechas = todosEquipos.size() - 1
		def cantPartidosPorFecha = cantEquipos.intdiv(2)
		
		def equiposLocal = new int[cantPartidosPorFecha]
		def equiposVisitante = new int[cantPartidosPorFecha]
		
		for (int i = 0; i < cantPartidosPorFecha; i++){ //se indexan los equipos
			equiposLocal[i] = i
			equiposVisitante[i] = i + cantPartidosPorFecha
		}
	
		def partidoAagregar
		
		for (int numFecha = 1; numFecha <= cantFechas; numFecha++){//emparejamiento de los equipos
			for (int j = 0; j < cantPartidosPorFecha; j++){
				if ( (todosEquipos.get(equiposLocal[j]).nombre != "equipoLibre") && (todosEquipos.get(equiposVisitante[j]).nombre != "equipoLibre") ) {
					if (numFecha % 2 ) //para que al mismo equipo no le toque siempre de local/visitante
						partidoAagregar = new Partido(nFecha: numFecha, local: todosEquipos.get(equiposLocal[j]), visitante: todosEquipos.get(equiposVisitante[j]) )
					else
						partidoAagregar = new Partido(nFecha: numFecha, local: todosEquipos.get(equiposVisitante[j]), visitante: todosEquipos.get(equiposLocal[j]) )
					torneoo.addToPartidos(partidoAagregar) //se agrega el nuevo partido a lista de partidos del torneo
					torneoo.save(flush: true) //se guarda el torneo cno el partido nuevo					
				}				
			}
			
			//movimiento de los equipos
			int nAuxi = 0
			for (int i = cantPartidosPorFecha - 1 ; i > 0; i--) {
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
					
		def todosPartidos = torneoo.partidos
		return todosPartidos
		
	}
	
	def calcularTabla(Torneo torneoInstance) {
		
		def torneoo = torneoInstance
		println torneoo.nombre
		
		def todosEquipos = Equipo.where{torneo == torneoo}.list()
		def todosPartidos = torneoo.partidos
		def cantPartidos = todosPartidos.size()
		def cantEquipos = todosEquipos.size()
		int puntosDelEquipo = 0
		int ganados = 0
		int empatados = 0
		int perdidos = 0
		def filas = []
		
		println cantEquipos
		println cantPartidos
		
		for (equipo in todosEquipos) {
			def partidosDelEquipo = Partido.where{ ( (local == equipo) || (visitante == equipo) ) && (fechaPartido != null)  }				
			
			puntosDelEquipo = 0
			ganados = 0
			empatados = 0
			perdidos = 0
			int[] fila = new int[5]
			fila[0] = equipo.id
			
			for (partido in partidosDelEquipo) { //todos los partidos jugados por el equipo
				if (partido.local.nombre == equipo.nombre) 
					{ //el equipo jugo de local
						if (partido.goleadoresLocal.size() > partido.goleadoresVisitante.size() ){ //si gano
							puntosDelEquipo = puntosDelEquipo + 3
							ganados++
						}
						if ( partido.goleadoresLocal.size() == partido.goleadoresVisitante.size() ){ //si empato
							puntosDelEquipo = puntosDelEquipo + 1
							empatados++
						}
					}
				else
					{ //el equipo jugo de visitante
						if (partido.goleadoresLocal.size() < partido.goleadoresVisitante.size() ){ //si gano
							puntosDelEquipo = puntosDelEquipo + 3
							ganados++
						}
						if ( partido.goleadoresLocal.size() == partido.goleadoresVisitante.size() ){ //si empato
							puntosDelEquipo = puntosDelEquipo + 1
							empatados++
						}
					}				
			}
			perdidos = partidosDelEquipo.size() - (ganados + empatados)
			fila[1] = puntosDelEquipo
			fila[2] = ganados
			fila[3] = empatados
			fila[4] = perdidos
			
			filas.add(fila)
						
			print equipo.toString()
			print fila[1]
			print fila[2]
			print fila[3]
			print fila[4]
			println " "
			
			
		}
		println filas
		filas.sort( {a, b -> b[1] <=> a[1] })
		return filas
	}
	
    def serviceMethod() {

    }
}
