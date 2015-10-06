
<%@ page import="partidos.Partido" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'partido.label', default: 'Partido')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-partido" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-partido" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="nFecha" title="${message(code: 'partido.nFecha.label', default: 'Nro Fecha')}" />
					
						<th><g:message code="partido.local.label" default="Local" /></th>
					
						<th><g:message code="partido.visitante.label" default="Visitante" /></th>
					
						<th><g:message code="partido.torneo.label" default="Torneo" /></th>
						
						<g:sortableColumn property="fechaPartido" title="${message(code: 'partido.fechaPartido.label', default: 'Fecha')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${partidoInstanceList}" status="i" var="partidoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${partidoInstance.id}">${fieldValue(bean: partidoInstance, field: "nFecha")}</g:link></td>
					
						<td>${fieldValue(bean: partidoInstance, field: "local")}</td>
					
						<td>${fieldValue(bean: partidoInstance, field: "visitante")}</td>
					
						<td>${fieldValue(bean: partidoInstance, field: "torneo")}</td>
						
						<td>${fieldValue(bean: partidoInstance, field: "fechaPartido")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${partidoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
