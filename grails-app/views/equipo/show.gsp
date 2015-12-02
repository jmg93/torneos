<%@ page import="equipos.Equipo" %>


<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'equipo.label', default: 'Equipo')}" />
		<title>${equipoInstance } - ${equipoInstance.torneo }</title>
	</head>
	<body>
		<a href="#show-equipo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" controller="torneo" action="show" id="${equipoInstance.torneo.id }">Volver al torneo</g:link></li>
				<li><g:link class="create" action="agregarJugador" resource="${equipoInstance }">Agregar jugador</g:link></li>
			</ul>
		</div>
		<div id="show-equipo" class="content scaffold-show" role="main">
			<h1>${equipoInstance }</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list equipo">
			
				<g:if test="${equipoInstance?.nombre}">
				<li class="fieldcontain">
					<span id="nombre-label" class="property-label"><g:message code="equipo.nombre.label" default="Nombre" /></span>
					
						<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${equipoInstance}" field="nombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${equipoInstance?.contacto}">
				<li class="fieldcontain">
					<span id="contacto-label" class="property-label"><g:message code="equipo.contacto.label" default="Contacto" /></span>
					
						<span class="property-value" aria-labelledby="contacto-label"><g:fieldValue bean="${equipoInstance}" field="contacto"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${equipoInstance?.aceptado}">
					<li class="fieldcontain">
						<span id="aceptado-label" class="property-label">Estado</span>
						<span class="property-value" aria-labelledby="aceptado-label">Aceptado</span>
					</li>
				</g:if>
				<g:else>
					<li class="fieldcontain">
						<span id="aceptado-label" class="property-label">Estado</span>
						<span class="property-value" aria-labelledby="aceptado-label">Pendiente</span>
					</li>
					
				</g:else>
			
				<g:if test="${equipoInstance?.torneo}">
				<li class="fieldcontain">
					<span id="torneo-label" class="property-label"><g:message code="equipo.torneo.label" default="Torneo" /></span>
					
						<span class="property-value" aria-labelledby="torneo-label"><g:link controller="torneo" action="show" id="${equipoInstance?.torneo?.id}">${equipoInstance?.torneo?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
				
				<h1 style="width: 65%; position: relative; left: 14%; margin-top: 2em;">Plantel</h1>
				<table class="table table-striped table-bordered table-hover table-condensed" style="width: 65%; position: relative; left: 17%;">
					<thead>
						<th style="width:8%">Camiseta</th>
						<th>Nombre</th>
						<th style="width:8%">Capitan</th>
					</thead>
					<tbody>
						<g:each in="${equipoInstance.jugadores.sort{it.nCamiseta}}" status="i" var="jugador">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
								<td style="text-align:center">
									${jugador.nCamiseta }
								</td>
								<td> <g:link controller="jugador" action="show" id="${jugador.id}">
									${jugador}
								</g:link></td>
								<td style="text-align:center">
									<g:if test="${jugador.capitan}">
										(C)
									</g:if>
									<g:else>
										-
									</g:else>
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
				
			
			</ol>
			<g:form url="[resource:equipoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${equipoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
