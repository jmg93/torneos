<%@ page import="equipos.Equipo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'equipo.label', default: 'Equipo')}" />
		<title>${torneoInstance} - Administrar </title>
	</head>
	<body>
		<a href="#list-equipo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link controller="equipo" class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-equipo" class="content scaffold-list" role="main">
			<h1>${torneoInstance.toString() }</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="nombre" title="${message(code: 'equipo.nombre.label', default: 'Nombre')}" />
					
						<g:sortableColumn property="contacto" title="${message(code: 'equipo.contacto.label', default: 'Contacto')}" />
					
						<g:sortableColumn property="aceptado" title="${message(code: 'equipo.aceptado.label', default: 'Estado')}" />
						
						<th>Acción</th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${equipos}" status="i" var="equipoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link controller="equipo" action="show" id="${equipoInstance.id}">${fieldValue(bean: equipoInstance, field: "nombre")}</g:link></td>
					
						<td>${fieldValue(bean: equipoInstance, field: "contacto")}</td>
					
						<td><g:formatBoolean boolean="${equipoInstance.aceptado}" true="Inscripto" false="Pendiente" /></td>
						
						<td>
							<g:if test="${equipoInstance.aceptado}">
								<g:link controller="equipo" action="eliminar" resource="${equipoInstance }" >Eliminar</g:link>
							</g:if>
							<g:else>
								<g:link controller="equipo" action="aceptar" resource="${equipoInstance }" >Aceptar</g:link> |
								<g:link controller="equipo" action="eliminar" resource="${equipoInstance }" >Eliminar</g:link>
							</g:else>

						</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${equipoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
