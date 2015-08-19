
<%@ page import="torneos.Torneo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'torneo.label', default: 'Torneo')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-torneo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-torneo" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="nombre" title="${message(code: 'torneo.nombre.label', default: 'Nombre')}" />
					
						<g:sortableColumn property="fechaInicio" title="${message(code: 'torneo.fechaInicio.label', default: 'Fecha Inicio')}" />
					
						<g:sortableColumn property="fechaLimite" title="${message(code: 'torneo.fechaLimite.label', default: 'Fecha Limite')}" />
					
						<g:sortableColumn property="nMaxEquipos" title="${message(code: 'torneo.nMaxEquipos.label', default: 'N Max Equipos')}" />
					
						<g:sortableColumn property="nMinJugadorXEquipo" title="${message(code: 'torneo.nMinJugadorXEquipo.label', default: 'N Min Jugador XE quipo')}" />
					
						<g:sortableColumn property="nMaxJugadorXEquipo" title="${message(code: 'torneo.nMaxJugadorXEquipo.label', default: 'N Max Jugador XE quipo')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${torneoInstanceList}" status="i" var="torneoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${torneoInstance.id}">${fieldValue(bean: torneoInstance, field: "nombre")}</g:link></td>
					
						<td><g:formatDate date="${torneoInstance.fechaInicio}" /></td>
					
						<td><g:formatDate date="${torneoInstance.fechaLimite}" /></td>
					
						<td>${fieldValue(bean: torneoInstance, field: "nMaxEquipos")}</td>
					
						<td>${fieldValue(bean: torneoInstance, field: "nMinJugadorXEquipo")}</td>
					
						<td>${fieldValue(bean: torneoInstance, field: "nMaxJugadorXEquipo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${torneoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
