<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'partido.label', default: 'Partido')}" />
		<title>Tabla de Goleadores</title>
	</head>
	<body>
			<div class="nav">
				<g:link class="home" action="show" style="width: 15%;" id="${torneoInstance.id}">Volver al torneo</g:link>
			</div>
			<div id="tablaFixture" class="content scaffold-list">
				<table class="table table-striped table-bordered table-hover table-condensed">
					<thead>
						<g:sortableColumn property="posicion" defaultOrder="asc" title="Posición" />
						<g:sortableColumn property="jugador" defaultOrder="asc" title="Jugador" />
						<g:sortableColumn property="goles" title="Goles" />
						<g:sortableColumn property="equipo" title="Equipo"/>
					</thead>
					<tbody>
						<g:each in="${filas}" status="i" var="fila">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
								<td style="width:8%">
									${i+1}
								</td>
								<td> <g:link controller="jugador" action="show" id="${fila[0]}">
									${equipos.Jugador.findById(fila[0])}
								</g:link></td>
								<td>
									${fila[1]}
								</td>
								<td> <g:link controller="equipos" action="show" id="${fila[2]}">
									${equipos.Equipo.findById(fila[3])}
								</g:link></td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>

	</body>
</html>