
<%@ page import="partidos.Partido" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'partido.label', default: 'Partido')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-partido" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-partido" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list partido">
			
				<g:if test="${partidoInstance?.fechaPartido}">
				<li class="fieldcontain">
					<span id="fechaPartido-label" class="property-label"><g:message code="partido.fechaPartido.label" default="Fecha Partido" /></span>
					
						<span class="property-value" aria-labelledby="fechaPartido-label"><g:formatDate date="${partidoInstance?.fechaPartido}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.nFecha}">
				<li class="fieldcontain">
					<span id="nFecha-label" class="property-label"><g:message code="partido.nFecha.label" default="N Fecha" /></span>
					
						<span class="property-value" aria-labelledby="nFecha-label"><g:fieldValue bean="${partidoInstance}" field="nFecha"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.local}">
				<li class="fieldcontain">
					<span id="local-label" class="property-label"><g:message code="partido.local.label" default="Local" /></span>
					
						<span class="property-value" aria-labelledby="local-label"><g:link controller="equipo" action="show" id="${partidoInstance?.local?.id}">${partidoInstance?.local?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.visitante}">
				<li class="fieldcontain">
					<span id="visitante-label" class="property-label"><g:message code="partido.visitante.label" default="Visitante" /></span>
					
						<span class="property-value" aria-labelledby="visitante-label"><g:link controller="equipo" action="show" id="${partidoInstance?.visitante?.id}">${partidoInstance?.visitante?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.amonestados}">
				<li class="fieldcontain">
					<span id="amonestados-label" class="property-label"><g:message code="partido.amonestados.label" default="Amonestados" /></span>
					
						<g:each in="${partidoInstance.amonestados}" var="a">
						<span class="property-value" aria-labelledby="amonestados-label"><g:link controller="jugador" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.expulsados}">
				<li class="fieldcontain">
					<span id="expulsados-label" class="property-label"><g:message code="partido.expulsados.label" default="Expulsados" /></span>
					
						<g:each in="${partidoInstance.expulsados}" var="e">
						<span class="property-value" aria-labelledby="expulsados-label"><g:link controller="jugador" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.goleadores}">
				<li class="fieldcontain">
					<span id="goleadores-label" class="property-label"><g:message code="partido.goleadores.label" default="Goleadores" /></span>
					
						<g:each in="${partidoInstance.goleadores}" var="g">
						<span class="property-value" aria-labelledby="goleadores-label"><g:link controller="jugador" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.torneo}">
				<li class="fieldcontain">
					<span id="torneo-label" class="property-label"><g:message code="partido.torneo.label" default="Torneo" /></span>
					
						<span class="property-value" aria-labelledby="torneo-label"><g:link controller="torneo" action="show" id="${partidoInstance?.torneo?.id}">${partidoInstance?.torneo?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:partidoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${partidoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
