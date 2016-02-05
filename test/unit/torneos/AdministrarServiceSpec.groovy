package torneos

import java.util.Date;
import java.util.List;

import grails.test.mixin.TestFor
import grails.test.mixin.Mock
import spock.lang.Specification
import equipos.Equipo


/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(AdministrarService)
@Mock(Equipo)
class AdministrarServiceSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "Prueba que funciona el boton de aceptar equipo inscripto"() {
		given: "Un nuevo toneo en la base de datos al cual se le inscriben equipos que todavia no estan aceptados"
			def equipoSinAceptar = new Equipo(nombre: "equipoPrueba", contacto: "aasdasdsd@gmail.com", aceptado: false)
			
		when: "Se ejecuta el metodo de aceptar equipo al torneo"
			service.aceptarEquipo(equipoSinAceptar)
			
		then: "Se comprueba la cantidad de equipos anotados en el torneo"
			equipoSinAceptar.aceptado == true
    }
}
