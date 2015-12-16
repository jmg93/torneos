
<%@ page import="equipos.Jugador" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'jugador.label', default: 'Jugador')}" />
		<title>${jugadorInstance } - ${jugadorInstance.equipo }</title>
	</head>
	<body>
		<a href="#show-jugador" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><g:link class="atras" controller="equipo" action="show" id="${jugadorInstance.equipo.id}">Volver al equipo</g:link></li>
			</ul>
		</div>
		<div id="show-jugador" class="content scaffold-show" role="main">
			<h1>${jugadorInstance } - ${jugadorInstance.equipo }</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list jugador">
			
				<g:if test="${jugadorInstance?.nombre}">
				<li class="fieldcontain">
					<span id="nombre-label" class="property-label"><g:message code="jugador.nombre.label" default="Nombre" /></span>
					
						<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${jugadorInstance}" field="nombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jugadorInstance?.apellido}">
				<li class="fieldcontain">
					<span id="apellido-label" class="property-label"><g:message code="jugador.apellido.label" default="Apellido" /></span>
					
						<span class="property-value" aria-labelledby="apellido-label"><g:fieldValue bean="${jugadorInstance}" field="apellido"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jugadorInstance?.nCamiseta}">
				<li class="fieldcontain">
					<span id="nCamiseta-label" class="property-label">Camiseta</span>
					
						<span class="property-value" aria-labelledby="nCamiseta-label"><g:fieldValue bean="${jugadorInstance}" field="nCamiseta"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jugadorInstance?.dni}">
				<li class="fieldcontain">
					<span id="dni-label" class="property-label"><g:message code="jugador.dni.label" default="Dni" /></span>
					
						<span class="property-value" aria-labelledby="dni-label"><g:fieldValue bean="${jugadorInstance}" field="dni"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${jugadorInstance?.capitan}">
				<li class="fieldcontain">
					<span id="capitan-label" class="property-label"><g:message code="jugador.capitan.label" default="Capitan" /></span>
					
						<span class="property-value" aria-labelledby="capitan-label">(C)</span>
					
				</li>
				</g:if>
			
				<g:if test="${jugadorInstance?.equipo}">
				<li class="fieldcontain">
					<span id="equipo-label" class="property-label"><g:message code="jugador.equipo.label" default="Equipo" /></span>
					
						<span class="property-value" aria-labelledby="equipo-label"><g:link controller="equipo" action="show" id="${jugadorInstance?.equipo?.id}">${jugadorInstance?.equipo?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:jugadorInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${jugadorInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
