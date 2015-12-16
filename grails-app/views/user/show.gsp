<%@ page import="torneos.TorneoController" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="torneos.Torneo" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'partido.label', default: 'Partido')}" />
		<title>${userInstance.username} - Torneos Ya</title>
	</head>
	<body>
			<div class="nav">
				 <ul>
				 	<li><a class="home" href="${createLink(uri: '/')}">Inicio</a></li>
				 	<li><g:link class="create" controller="torneo" action="create">Torneo nuevo</g:link></li>
				 </ul>
			</div>
			<div id="show-torneo" class="content scaffold-show" role="main">

			<h1>Torneos de ${userInstance}</h1>
				<g:if test="${flash.message}">
					<div class="message" role="status">${flash.message}</div>
				</g:if>
			
				<div id="tablaFixture" class="content scaffold-list">
					<table style="width: 100%; position: relative; margin: auto; top: 1.1em;" class="table table-striped table-bordered table-hover table-condensed">
						<thead>
							<g:sortableColumn property="jugador" defaultOrder="asc" title="Torneos Creados" />
							<g:sortableColumn property="goles" title="Fecha de inicio" />
							<g:sortableColumn property="equipo" title="Limite de inscripción"/>
						</thead>
						<tbody>
							<g:each in="${torneos}" status="i" var="t">
								<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
									<td> <g:link controller="torneo" action="show" id="${t.id}">
										${t}	
									</g:link></td>
									<td>
										<g:formatDate format="dd - MMM - yyyy" date="${t.fechaInicio}" />
									</td>
									<td>
										<g:formatDate format="dd - MMM - yyyy" date="${t.fechaLimite}" />
									</td>
								</tr>
							</g:each>
						</tbody>
					</table>
					<div class="pagination">
					</div>
				</div>
			</div>

	</body>
</html>