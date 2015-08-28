
<%@ page import="equipos.Jugador" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jugador.label', default: 'Jugador')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-jugador" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-jugador" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="apellido" title="${message(code: 'jugador.apellido.label', default: 'Apellido')}" />
					
						<g:sortableColumn property="nombre" title="${message(code: 'jugador.nombre.label', default: 'Nombre')}" />
					
						<g:sortableColumn property="nCamiseta" title="${message(code: 'jugador.nCamiseta.label', default: 'N Camiseta')}" />
					
						<g:sortableColumn property="capitan" title="${message(code: 'jugador.capitan.label', default: 'Capitan')}" />
					
						<g:sortableColumn property="dni" title="${message(code: 'jugador.dni.label', default: 'Dni')}" />
					
						<th><g:message code="jugador.equipo.label" default="Equipo" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${jugadorInstanceList}" status="i" var="jugadorInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${jugadorInstance.id}">${fieldValue(bean: jugadorInstance, field: "apellido")}</g:link></td>
					
						<td>${fieldValue(bean: jugadorInstance, field: "nombre")}</td>
					
						<td>${fieldValue(bean: jugadorInstance, field: "nCamiseta")}</td>
					
						<td><g:formatBoolean boolean="${jugadorInstance.capitan}" /></td>
					
						<td>${fieldValue(bean: jugadorInstance, field: "dni")}</td>
					
						<td>${fieldValue(bean: jugadorInstance, field: "equipo")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${jugadorInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
