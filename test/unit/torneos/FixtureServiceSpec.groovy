package torneos

import java.util.Date;
import java.util.List;

import grails.test.mixin.TestFor
import grails.test.mixin.Mock
import spock.lang.Specification
import equipos.Equipo
import usuarios.User
import partidos.Partido

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(FixtureService)
@Mock([Torneo, Equipo, User, Partido])
class FixtureServiceSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "prueba del metodo de getCantidadEquipos"() {
		
		given: "Un nuevo toneo en la base de datos que tiene equipos inscriptos"
			def torneo = new Torneo(nombre: "torneo Prueba", fechaInicio: new Date(2017, 2, 2), fechaLimite: new Date(2017, 1, 1), nMaxEquipos: 20, nMinJugadorXEquipo: 6, nMaxJugadorXEquipo: 20, usuario: new User(username: "pruebausuario", email: "qwe@gmail.com"))
			torneo.addToEquipos(new Equipo(nombre: "equipoPrueba", contacto: "aasdasdsd@gmail.com", aceptado: true))
			torneo.addToEquipos(new Equipo(nombre: "equipoPruebaa", contacto: "aaasdasdsd@gmail.com", aceptado: true))
			torneo.addToEquipos(new Equipo(nombre: "equipoPruea", contacto: "aasdsd@gmail.com", aceptado: true))
			torneo.addToEquipos(new Equipo(nombre: "epoPrueba", contacto: "aaasdsd@gmail.com", aceptado: false))
			torneo.save(failOnError: true)
			
		when: "Se ejecuta el metodo de buscar cantidad de equipos anotados en el torneo "
			def numero = service.getCantidadEquipos(torneo)
			
		then: "Se comprueba la cantidad de equipos anotados en el torneo"
			numero == 3
    }
	
	void "Prueba del boton Generar Fixture"() {
		
		given: "Un nuevo toneo en la base de datos que tiene 3 equipos inscriptos aceptados"
			def torneo = new Torneo(nombre: "torneo Prueba", fechaInicio: new Date(2017, 2, 2), fechaLimite: new Date(2017, 1, 1), nMaxEquipos: 20, nMinJugadorXEquipo: 6, nMaxJugadorXEquipo: 20, usuario: new User(username: "pruebausuario", email: "qwe@gmail.com"))
			torneo.addToEquipos(new Equipo(nombre: "equipoPrueba", contacto: "aasdasdsd@gmail.com", aceptado: true))
			torneo.addToEquipos(new Equipo(nombre: "equipoPruebaa", contacto: "aaasdasdsd@gmail.com", aceptado: true))
			torneo.addToEquipos(new Equipo(nombre: "equipoPruea", contacto: "aasdsd@gmail.com", aceptado: true))
			torneo.addToEquipos(new Equipo(nombre: "epoPrueba", contacto: "aaasdsd@gmail.com", aceptado: false))
			torneo.save(failOnError: true)
			
		when: "Se hace click en 'Sortear Fixture' (Se ejecuta el metodo sortearFixture)"
			service.sortearFixture(torneo)
			
		then: "Se comprueba la cantidad de partidos que se generaron y guardaron en la base de datos anotados en el torneo"
			Partido.count() != 0
			Partido.count() == 3
				}
	
	void "Prueba que no se puede generar el fixture con un solo equipo aceptado"() {
		
		given: "Un nuevo toneo en la base de datos que tiene 3 equipos inscriptos aceptados"
			def torneo = new Torneo(nombre: "torneo Prueba", fechaInicio: new Date(2017, 2, 2), fechaLimite: new Date(2017, 1, 1), nMaxEquipos: 20, nMinJugadorXEquipo: 6, nMaxJugadorXEquipo: 20, usuario: new User(username: "pruebausuario", email: "qwe@gmail.com"))
			torneo.addToEquipos(new Equipo(nombre: "equipoPrueba", contacto: "aasdasdsd@gmail.com", aceptado: true))
			torneo.addToEquipos(new Equipo(nombre: "equipoPruebaa", contacto: "aaasdasdsd@gmail.com", aceptado: false))
			torneo.addToEquipos(new Equipo(nombre: "equipoPruea", contacto: "aasdsd@gmail.com", aceptado: false))
			torneo.addToEquipos(new Equipo(nombre: "epoPrueba", contacto: "aaasdsd@gmail.com", aceptado: false))
			torneo.save(failOnError: true)
			
		when: "Se hace click en 'Sortear Fixture' (Se ejecuta el metodo sortearFixture)"
			service.sortearFixture(torneo)
			
		then: "Se comprueba la cantidad de partidos que se generaron y guardaron en la base de datos anotados en el torneo"
			Partido.count() == 0
				}
}