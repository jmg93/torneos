
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
				<li><g:link class="list" controller="torneo" action="show" id="${partidoInstance.local.torneo.id }">Volver al torneo</g:link></li>
			</ul>
		</div>
	<div id="show-partido" class="content scaffold-show" role="main">
			<h1>${partidoInstance.local.torneo }   -   Fecha ${partidoInstance.nFecha }</h1>
			
			<g:if test="${partidoInstance.fechaPartido }">
				<h1>${partidoInstance.local} ${partidoInstance.goleadoresLocal.size() }  -  ${partidoInstance.visitante} ${partidoInstance.goleadoresVisitante.size() }</h1>
			</g:if>
			<g:else>
				<h1>${partidoInstance.local}  -  ${partidoInstance.visitante}</h1>
			</g:else>
			
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			
			<ol class="property-list partido">
			
				<g:if test="${partidoInstance.fechaPartido}">
				<li class="fieldcontain" style="position: relative; left: 32%; width: 60%;">
					<span id="fechaPartido-label" class="property-label">Partido jugado el</span>
					
						<span class="property-value" aria-labelledby="fechaPartido-label"><g:formatDate date="${partidoInstance.fechaPartido}" format="dd - MMM - yyyy" /></span>
					
				</li>
				</g:if>
				<g:else>
				<li class="fieldcontain" style="position: relative; left: 44%; width: 60%;">
					Partido a jugar
				</li>
				</g:else>
			
				
				
				<!-- 
				<g:if test="${partidoInstance?.goleadoresLocal}">
				<li class="fieldcontain">
					<span id="goleadoresLocal-label" class="property-label"><g:message code="partido.goleadoresLocal.label" default="Goleadores Local" /></span>
					
						<g:each in="${partidoInstance.goleadoresLocal}" var="g">
						<span class="property-value" aria-labelledby="goleadoresLocal-label"><g:link controller="jugador" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.goleadoresVisitante}">
				<li class="fieldcontain">
					<span id="goleadoresVisitante-label" class="property-label"><g:message code="partido.goleadoresVisitante.label" default="Goleadores Visitante" /></span>
					
						<g:each in="${partidoInstance.goleadoresVisitante}" var="g">
						<span class="property-value" aria-labelledby="goleadoresVisitante-label"><g:link controller="jugador" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.amonestadosLocal}">
				<li class="fieldcontain">
					<span id="amonestadosLocal-label" class="property-label"><g:message code="partido.amonestadosLocal.label" default="Amonestados Local" /></span>
					
						<g:each in="${partidoInstance.amonestadosLocal}" var="a">
						<span class="property-value" aria-labelledby="amonestadosLocal-label"><g:link controller="jugador" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.amonestadosVisitante}">
				<li class="fieldcontain">
					<span id="amonestadosVisitante-label" class="property-label"><g:message code="partido.amonestadosVisitante.label" default="Amonestados Visitante" /></span>
					
						<g:each in="${partidoInstance.amonestadosVisitante}" var="a">
						<span class="property-value" aria-labelledby="amonestadosVisitante-label"><g:link controller="jugador" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.expulsadosLocal}">
				<li class="fieldcontain">
					<span id="expulsadosLocal-label" class="property-label"><g:message code="partido.expulsadosLocal.label" default="Expulsados Local" /></span>
					
						<g:each in="${partidoInstance.expulsadosLocal}" var="e">
						<span class="property-value" aria-labelledby="expulsadosLocal-label"><g:link controller="jugador" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.expulsadosVisitante}">
				<li class="fieldcontain">
					<span id="expulsadosVisitante-label" class="property-label"><g:message code="partido.expulsadosVisitante.label" default="Expulsados Visitante" /></span>
					
						<g:each in="${partidoInstance.expulsadosVisitante}" var="e">
						<span class="property-value" aria-labelledby="expulsadosVisitante-label"><g:link controller="jugador" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${partidoInstance?.torneo}">
				<li class="fieldcontain">
					<span id="torneo-label" class="property-label"><g:message code="partido.torneo.label" default="Torneo" /></span>
					
						<span class="property-value" aria-labelledby="torneo-label"><g:link controller="torneo" action="show" id="${partidoInstance?.torneo?.id}">${partidoInstance?.torneo?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			 -->
			
		<div id="colIzq">

			<h1>${partidoInstance.local}</h1>		
			<div class="content scaffold-list">
					<table class="table table-striped table-bordered table-hover table-condensed">
						<thead>
							<th style="text-align:center">N°</th>
							<th>Nombre</th>
							<th style="text-align: center"></th>
							<th style="text-align: center"></th>
							<th style="text-align: center"><asset:image src="goles.png" width="20" height="20" alt="Goles"/></th>
						</thead>
						<tbody>
							<g:each in="${partidoInstance.local.jugadores.sort{it.nCamiseta}}" status="i" var="jugador">
								<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
									<td style="text-align:center">
										${jugador.nCamiseta}
									</td>
									<td> <g:link action="show" id="${jugador.id}">
										${jugador}
									</g:link></td>
									<td>
										<g:if test="${partidoInstance.amonestadosLocal.count(jugador)}">
											<asset:image src="amarilla.png" width="15" height="20" alt="Amonestado"/>
										</g:if>
									</td>
									<td>
										<g:if test="${partidoInstance.expulsadosLocal.count(jugador)}">
											<asset:image src="roja.png" width="15" height="20" alt="Expulsado"/>
										</g:if>
									</td>
									<td style="text-align:center">
										<g:if test="${partidoInstance.goleadoresLocal.count(jugador) != 0}">
											${partidoInstance.goleadoresLocal.count(jugador) }
										</g:if>
										<g:else>
											-
										</g:else>
									</td>
								</tr>
							</g:each>
						</tbody>
					</table>
				</div>
		</div>
		
		<div id="colDer">

			<h1>${partidoInstance.visitante}</h1>		
			<div class="content scaffold-list">
					<table class="table table-striped table-bordered table-hover table-condensed">
						<thead>
							<th style="text-align:center">N°</th>
							<th>Nombre</th>
							<th style="text-align: center"></th>
							<th style="text-align: center"></th>
							<th style="text-align: center"><asset:image src="goles.png" width="20" height="20" alt="Goles"/></th>
						</thead>
						<tbody>
							<g:each in="${partidoInstance.visitante.jugadores.sort{it.nCamiseta}}" status="i" var="jugador">
								<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
									<td style="text-align:center">
										${jugador.nCamiseta}
									</td>
									<td> <g:link action="show" id="${jugador.id}">
										${jugador}
									</g:link></td>
									<td>
										<g:if test="${partidoInstance.amonestadosVisitante.count(jugador)}">
											<asset:image src="amarilla.png" width="15" height="20" alt="Amonestado"/>
										</g:if>
									</td>
									<td>
										<g:if test="${partidoInstance.expulsadosVisitante.count(jugador)}">
											<asset:image src="roja.png" width="15" height="20" alt="Expulsado"/>
										</g:if>
									</td>
									<td style="text-align:center">
										<g:if test="${partidoInstance.goleadoresVisitante.count(jugador) != 0}">
											${partidoInstance.goleadoresVisitante.count(jugador) }
										</g:if>
										<g:else>
											-
										</g:else>
									</td>
								</tr>
							</g:each>
						</tbody>
					</table>
				</div>
		</div>
	
		</ol>
	</div>	
		<g:form url="[resource:partidoInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons" style="width: 950px; position: relative; top: 1.2em;">
					<g:link class="edit" action="edit" resource="${partidoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
		</g:form>
	
	
	</body>
</html>
