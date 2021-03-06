<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'partido.label', default: 'Partido')}" />
		<title>Tabla Posiciones - ${torneoInstance.nombre}</title>
	</head>
	<body>
			<div class="nav">
				<g:link class="atras" action="show" style="width: 15%;" id="${torneoInstance.id}">Volver al torneo</g:link>
			</div>
			<div id="tablaFixture" class="content scaffold-list">
				<table class="table table-striped table-bordered table-hover table-condensed">
					<thead>
						<g:sortableColumn property="posicion" defaultOrder="asc" title="Posición" />
						<g:sortableColumn property="equipo" defaultOrder="asc" title="Equipo" />
						<g:sortableColumn property="ganados" title="Ganados (+3)" />
						<g:sortableColumn property="empatados" title="Empatados (+1)"/>
						<g:sortableColumn property="perdidos" title="Perdidos (+0)"/>
						<g:sortableColumn property="puntos" title="Puntos"/>
					</thead>
					<tbody>
						<g:each in="${filas}" status="i" var="fila">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
								<td style="width:8%">
									${i+1}
								</td>
								<td> <g:link controller="equipo" action="show" id="${fila[0]}">
									${equipos.Equipo.findById(fila[0])}
								</g:link></td>
								<td>
									${fila[2]}
								</td>
								<td>
									${fila[3]}
								</td>
								<td>
									${fila[4]}
								</td>
								<td>
									${fila[1]}
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>

	</body>
</html>