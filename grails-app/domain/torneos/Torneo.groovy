package torneos

class Torneo {
	String nombre
	Date fechaInicio
	Date fechaLimite
	Integer nMaxEquipos
	List partidos
	List equipos
	Integer nMinJugadorXEquipo
	Integer nMaxJugadorXEquipo
	String reglamento
	
	static hasMany = [equipos: equipos.Equipo, partidos: partidos.Partido]
	static belongsTo = [usuario: usuarios.User]
	
	public String toString(){
		return nombre
	}		

    static constraints = {
		nombre(size:2..20, unique:true)
		fechaInicio(min: new Date())
		fechaLimite(min: new Date())
		nMaxEquipos(min:2)
		nMinJugadorXEquipo(min:5)
		nMaxJugadorXEquipo(max:99)
		reglamento(maxSize:2000, nullable:true)
		equipos()
		partidos()
    }
}
