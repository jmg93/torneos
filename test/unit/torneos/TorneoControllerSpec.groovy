package torneos

import grails.plugin.springsecurity.annotation.Secured
import java.util.Date;
import java.util.List;
import grails.test.mixin.TestFor
import grails.test.mixin.Mock
import spock.lang.Specification
import equipos.Equipo
import usuarios.User
import partidos.Partido


@TestFor(TorneoController)
@Mock([Torneo, User, Equipo])
class TorneoControllerSpec extends Specification {
	
	    def populateValidParams(params) {
        assert params != null
		//Populate valid properties like...
    }

		void "Prueba dar de alta torneo en la base de datos"() {
			
			given: "Se crea un nuevo torneo"
				def torneo = new Torneo(nombre: "torneo Prueba", fechaInicio: new Date(2017, 2, 2), fechaLimite: new Date(2017, 1, 1), nMaxEquipos: 20, nMinJugadorXEquipo: 6, nMaxJugadorXEquipo: 20, usuario: new User(username: "pruebausuario", email: "qwe@gmail.com"))
								
			when: "Se intenta guardar el torneo en la base de datos"
				torneo.save(flush: true)
				
			then: "Se comprueba la cantidad de torneos guardados en la base de datos"
				Torneo.count == 1
		}
		
		void "Prueba tratar de dar de alta torneo con datos invalidos en la base de datos"() {
			
			given: "Se crea un nuevo torneo con datos invalidos"
				def torneoConErrores = new Torneo(nombre: "", fechaInicio: new Date(2017, 2, 2), fechaLimite: new Date(2017, 1, 1), nMaxEquipos: 20, nMinJugadorXEquipo: 20, nMaxJugadorXEquipo: 3, usuario: new User(username: "pruebausuario", email: "qwe@gmail.com"))
								
			when: "Se intenta guardar el torneo en la base de datos"
				torneoConErrores.save(flush: true)
				
			then: "Se comprueba la cantidad de torneos guardados en la base de datos"
				Torneo.count == 0
		}
		
    void "Probar que el boton de editar torneo devuelve la vista correcta"() {
        when:"Se ejecuta la accion de editar torneo con una instancia nula"
            controller.edit(null)

        then:"Se devuelve un error 404"
            response.status == 404

        when:"Se ejecuta la accion de editar torneo con una instancia de torneo correcta"
            def torneo = new Torneo(nombre: "torneo Prueba", fechaInicio: new Date(2017, 2, 2), fechaLimite: new Date(2017, 1, 1), nMaxEquipos: 20, nMinJugadorXEquipo: 6, nMaxJugadorXEquipo: 20, usuario: new User(username: "pruebausuario", email: "qwe@gmail.com"))
            controller.edit(torneo)

        then:"Se genera la vista con un modelo de datos identico al torneo que se va a editar"
            model.torneoInstance == torneo
    }

	
}
