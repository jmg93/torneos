package partidos



import grails.test.mixin.*
import spock.lang.*

@TestFor(PartidoController)
@Mock(Partido)
class PartidoControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.partidoInstanceList
            model.partidoInstanceCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.partidoInstance!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def partido = new Partido()
            partido.validate()
            controller.save(partido)

        then:"The create view is rendered again with the correct model"
            model.partidoInstance!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            partido = new Partido(params)

            controller.save(partido)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/partido/show/1'
            controller.flash.message != null
            Partido.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def partido = new Partido(params)
            controller.show(partido)

        then:"A model is populated containing the domain instance"
            model.partidoInstance == partido
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def partido = new Partido(params)
            controller.edit(partido)

        then:"A model is populated containing the domain instance"
            model.partidoInstance == partido
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/partido/index'
            flash.message != null


        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def partido = new Partido()
            partido.validate()
            controller.update(partido)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.partidoInstance == partido

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            partido = new Partido(params).save(flush: true)
            controller.update(partido)

        then:"A redirect is issues to the show action"
            response.redirectedUrl == "/partido/show/$partido.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/partido/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def partido = new Partido(params).save(flush: true)

        then:"It exists"
            Partido.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(partido)

        then:"The instance is deleted"
            Partido.count() == 0
            response.redirectedUrl == '/partido/index'
            flash.message != null
    }
}
