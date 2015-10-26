package equipos

class Equipo {
	String nombre
	String contacto
	List jugadores
	Boolean aceptado
	
	static hasMany = [jugadores: Jugador]
	static belongsTo = [torneo:torneos.Torneo]
	
	public String toString(){
		return nombre
	}

    static constraints = {
		nombre(size:2..20)
		contacto(email: true)
    }
}
