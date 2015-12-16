package torneos



import equipos.Equipo
import grails.test.mixin.*
import spock.lang.*
import usuarios.User

@TestFor(TorneoController)
@Mock([Torneo, User, Equipo])
class TorneoControllerSpec extends Specification {
	
	    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        params["nombre"] = 'Torneo de 30'
		params["fechaLimite"] = new Date(2016,12,25)
		params["fechaInicio"] = new Date(2016,12,30)
		params["nMaxJugadorXEquipo"] = '12'
		params["nMinJugadorXEquipo"] = '5'
		params["nMaxEquipos"] = '10'
		params["usuario"] = new User(username:"pepe123",password:"123456")
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.torneoInstanceList
            model.torneoInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.torneoInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def torneo = new Torneo()
            torneo.validate()
            controller.save(torneo)

        then:"The create view is rendered again with the correct model"
            model.torneoInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            torneo = new Torneo(params)

            controller.save(torneo)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/torneo/show/1'
            controller.flash.message != null
            Torneo.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def torneo = new Torneo(params)
            controller.show(torneo)

        then:"A model is populated containing the domain instance"
            model.torneoInstance == torneo
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def torneo = new Torneo(params)
            controller.edit(torneo)

        then:"A model is populated containing the domain instance"
            model.torneoInstance == torneo
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/torneo/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def torneo = new Torneo()
            torneo.validate()
            controller.update(torneo)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.torneoInstance == torneo

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            torneo = new Torneo(params).save(flush: true)
            controller.update(torneo)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/torneo/show/$torneo.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/torneo/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def torneo = new Torneo(params).save(flush: true)

        then:"It exists"
            Torneo.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(torneo)

        then:"The instance is deleted"
            Torneo.count() == 0
            response.redirectedUrl == '/torneo/index'
            flash.message != null
    }
	
}
