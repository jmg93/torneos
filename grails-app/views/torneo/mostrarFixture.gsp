
<%@ page import="partidos.Partido" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'partido.label', default: 'Partido')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
			<div id="tablaFixture" class="content scaffold-list">
				<table class="table table-striped table-bordered table-hover table-condensed">
					<thead>
						<g:sortableColumn property="nFecha" defaultOrder="asc" title="Fecha" />
						<g:sortableColumn property="local" title="Local" />
						<g:sortableColumn property="visitante" title="Visitante"/>
					</thead>
					<tbody>
						<g:each in="${todosPartidos}" status="i" var="partido">
							<tr class="${(i % 2) == 0 ? 'info' : ''}">
								<td> <g:link action="show" id="${partido.id}">
									${partido.nFecha}
								</g:link></td>
								<td>
									${partido.local}
								</td>
								<td>
									${partido.visitante}
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
			<div class="nav">
				<g:link class="home" action="show" id="${torneoInstance.id}">Volver al torneo</g:link>
			</div>
	</body>
</html>