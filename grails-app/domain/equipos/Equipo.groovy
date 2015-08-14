package equipos

class Equipo {
	String nombre
	String contacto
	
	static hasMany = [jugadores: Jugador]
	static belongsTo = torneos.Torneo
	
	public String toString(){
		return nombre
	}

    static constraints = {
    }
}
