package torneos

class Torneo {
	String nombre
	FormatoTorneo formato
	Date fechaInicio
	Date fechaLimite
	Integer nMaxEquipos
	Integer nMinJugadorXEquipo
	Integer nMaxJugadorXEquipo
	Boolean fixture
	String clave
	String reglamento
	
	static hasMany = [equipos: equipos.Equipo]
	
	public String toString(){
		return nombre
	}		

    static constraints = {
		nombre(size:2..20)
		formato()
		fechaInicio()
		fechaLimite()
		nMaxEquipos()
		nMinJugadorXEquipo(min:5)
		nMaxJugadorXEquipo(max:99)
		clave(size:6..16, nullable:true)
		fixture()
		reglamento(maxSize:2000, nullable:true)
    }
}
