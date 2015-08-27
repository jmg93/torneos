package equipos

class Jugador {
	String nombre
	String apellido
	Integer nCamiseta
	Integer dni
	Boolean capitan
	
	
	static belongsTo = Equipo
	
	public String toString(){
		"$nombre $apellido"
	}

    static constraints = {
		apellido(size:2..20)
		nombre(size:2..20)
		nCamiseta()
		capitan()
		dni()
	}
}
