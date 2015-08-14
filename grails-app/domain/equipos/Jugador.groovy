package equipos

class Jugador {
	String nombre
	String apellido
	Integer nCamiseta
	Integer dni
	Boolean capitan
	
	//comentario de prueba
	
	static belongsTo = Equipo
	
	public String toString(){
		"$nombre $apellido"
	}

    static constraints = {
	}
}
