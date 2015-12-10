package torneos

import equipos.Equipo
import grails.transaction.Transactional

@Transactional
class AdministrarService {
	
	def aceptarEquipo(Equipo equipoInstance){
		equipoInstance.aceptado = true	 		//Cambia el campo aceptado a true (cuando se crea el equipo es false)
		equipoInstance.save(flush: true)		//Guarda el equipo aceptado
	}
	
    def serviceMethod() {

    }
}
