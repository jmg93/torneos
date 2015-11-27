package torneos

import equipos.Equipo
import grails.transaction.Transactional
import groovy.sql.Sql
import partidos.Partido

@Transactional
class FixtureService {
	
	//todos los println estan para testear algunas cosas
	
	def dataSource // the Spring-Bean "dataSource" is auto-injected
	
	def sortearFixture(Torneo torneoInstance) {
				
		def torneoo = torneoInstance	
		println torneoo.nombre
		
		def todosEquipos = Equipo.where{ (torneo == torneoo) && (aceptado == true) }.list() //seleccionar todos los equipos aceptados del torneo a sortear
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
	
	def int getCantidadEquipos(Torneo torneoInstance) { //devuelve la cantidad de equipos aceptados cargados en el torneo 
		def todosEquipos = Equipo.where{ (torneo == torneoInstance) && (aceptado == true) }.list() //seleccionar todos los equipos aceptados del torneo a sortear
		return todosEquipos.size()
	}
	
	def int getCantidadPartidos(Torneo torneoInstance) { //devuelve la cantidad de partidos cargados (jugados y no jugados) del torneo
		return torneoInstance.partidos.size()
	}
	
	def boolean torneoEmpezado(torneoInstance) { //devuelve true si el torneo esta empezado (si se sorteo el fixture o si hay algun partido cargado)
		return (getCantidadPartidos(torneoInstance) > 0)
	}
	
	def calcularTablaPosiciones(Torneo torneoInstance) {
		
		def torneoo = torneoInstance
		println torneoo.nombre
		
		def todosEquipos = Equipo.where{ (torneo == torneoo) && (aceptado == true) }.list() //seleccionar todos los equipos aceptados del torneo
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
	
	def calcularTablaGoleadores(Torneo torneoInstance){
		def db = new Sql(dataSource)
		def result = db.rows("SELECT * FROM TABLA_GOLEADORES where TID= ${torneoInstance.id}")
		
		return result
	}
	
    def serviceMethod() {

    }
}
