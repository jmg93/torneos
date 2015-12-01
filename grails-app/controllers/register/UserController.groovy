package register

import torneos.Torneo;
import usuarios.User

class UserController {

    def index() { }
	
	def show(User userInstance) {
		
		def torneosDelUsuario = Torneo.where{ usuario == userInstance}.list()
		render(view: "show", model: [torneos: torneosDelUsuario, userInstance: userInstance])
		
	}
}
