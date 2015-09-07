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
	Boolean fixture
	String clave
	String reglamento
	
	static hasMany = [equipos: equipos.Equipo, partidos: partidos.Partido]
	
	public String toString(){
		return nombre
	}		

    static constraints = {
		nombre(size:2..20)
		fechaInicio()
		fechaLimite()
		nMaxEquipos()
		nMinJugadorXEquipo(min:5)
		nMaxJugadorXEquipo(max:99)
		//equipos.length <= nMaxEquipos
		clave(size:6..16, nullable:true)
		fixture()
		reglamento(maxSize:2000, nullable:true)
    }
}
