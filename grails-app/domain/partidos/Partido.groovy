package partidos

class Partido {
	Integer nFecha
	Date fechaPartido
	equipos.Equipo local
	equipos.Equipo visitante
	
	static belongsTo = [torneos.Torneo]
	static hasMany = [goleadores: equipos.Jugador, amonestados: equipos.Jugador, expulsados:equipos.Jugador]
	
    static constraints = {
		fechaPartido()
		nFecha()
		local()
		visitante()
		
    }
}
