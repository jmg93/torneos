package equipos

class Equipo {
	String nombre
	String contacto
	//prueba de Pablo
	//prueba de Edu
	
	static hasMany = [jugadores: Jugador]
	static belongsTo = [torneo:torneos.Torneo]
	
	public String toString(){
		return nombre
	}

    static constraints = {
		nombre(size:2..20)
		contacto()
    }
}
