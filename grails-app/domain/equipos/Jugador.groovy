package equipos

class Jugador {
	String nombre
	String apellido
	Integer nCamiseta
	Integer dni
	Boolean capitan
	
	
	static belongsTo = [equipo:Equipo]
	
	public String toString(){
		"$nombre $apellido"
	}

    static constraints = {
		apellido(size:2..20)
		nombre(size:2..20)
		nCamiseta(range: 1..99)
		dni(range: 1000000..99999999)
		capitan()
	}
}
