package partidos

class Partido {
	Integer nFecha
	Date fechaPartido
	equipos.Equipo local
	equipos.Equipo visitante
	
	static belongsTo = [torneo:torneos.Torneo]
	static hasMany = [goleadores: equipos.Jugador, amonestados: equipos.Jugador, expulsados:equipos.Jugador]
	
	public String toString(){
		"$local - $visitante"
	}
	
    static constraints = {
		fechaPartido()
		nFecha()
		local()
		visitante()
		
    }
}
