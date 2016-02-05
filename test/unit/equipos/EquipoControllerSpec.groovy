package equipos

import grails.plugin.springsecurity.annotation.Secured
import java.util.Date;
import java.util.List;
import grails.test.mixin.TestFor
import grails.test.mixin.Mock
import spock.lang.Specification
import torneos.Torneo
import usuarios.User
import partidos.Partido


@TestFor(EquipoController)
@Mock([Equipo, Torneo, Jugador])
class EquipoControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        //params["name"] = 'someValidName'
		//params["nombre"] = 'EquipoPrueba'
		//params["contacto"] = 'hola@gmail.com'
		//params["aceptado"] = 'true'
    }

    void "Probar que el boton de crear equipo retorna un modelo correcto sin datos"() {
        when:"Se hace click en el boton de crear equipo"
            controller.create()

        then:"El modelo que se devuelve no tiene ningun dato"
            model.equipoInstance!= null
    }

	void "Prueba dar de alta equipo"() {
		
		given: "Se crea un nuevo equipo y ya existe un torneo"
			def torneoExistente = new Torneo(nombre: "torneo Prueba", fechaInicio: new Date(2017, 2, 2), fechaLimite: new Date(2017, 1, 1), nMaxEquipos: 20, nMinJugadorXEquipo: 6, nMaxJugadorXEquipo: 20, usuario: new User(username: "pruebausuario", email: "qwe@gmail.com"))
			def equipo = new Equipo(nombre: "equipoPrueba", contacto: "aasdasdsd@gmail.com", aceptado: false, torneo: torneoExistente)
							
		when: "Se intenta guardar el equipo en la base de datos"
			equipo.save(flush: true)
			
		then: "Se comprueba la cantidad de equipos guardados en la base de datos"
			Equipo.count() == 1
	}
	
	void "Prueba dar de alta equipo con datos invalidos"() {
		
		given: "Se crea un nuevo equipo con datos incorrectos y ya existe un torneo"
			def torneoExistente = new Torneo(nombre: "torneo Prueba", fechaInicio: new Date(2017, 2, 2), fechaLimite: new Date(2017, 1, 1), nMaxEquipos: 20, nMinJugadorXEquipo: 6, nMaxJugadorXEquipo: 20, usuario: new User(username: "pruebausuario", email: "qwe@gmail.com"))
			def equipoConErrores = new Equipo(nombre: "", contacto: "aasdasdsd", aceptado: false, torneo: torneoExistente)
							
		when: "Se intenta guardar el equipo en la base de datos"
			equipoConErrores.save(flush: true)
			
		then: "Se comprueba la cantidad de equipos guardados en la base de datos"
			Equipo.count() == 0
	}
 
    void "Probar que borrar un equipo funciona "() {

        when:"Se crea un equipo valido y luego se lo borra"
            populateValidParams(params)
            def equipoAborrar = new Equipo(params).save(flush: true)
            controller.delete(equipoAborrar)

        then:"No hay ningun equipo grabado"
            Equipo.count() == 0
    }
}
