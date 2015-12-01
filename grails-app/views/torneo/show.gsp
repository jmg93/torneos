
<%@ page import="torneos.Torneo" %>
<%@ page import="equipos.Equipo" %>
<%@ page import="torneos.TorneoController" %>
<%@ page import="java.text.SimpleDateFormat" %>


<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'torneo.label', default: 'Torneo')}" />
		<title>${torneoInstance} - TorneosYa</title>
		<style type="text/css" media="screen">
			#status {
				background-color: #eee;
				border: .2em solid #fff;
				margin: 2em 2em 1em;
				padding: 1em;
				width: 12em;
				float: left;
				-moz-box-shadow: 0px 0px 1.25em #ccc;
				-webkit-box-shadow: 0px 0px 1.25em #ccc;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;
			}

		</style>
	</head>
	<body>
		<a href="#show-torneo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li><g:link class="admin" action="listaEquipos" resource="${torneoInstance}">Administrar</g:link></li>
				<li><g:link class="boton-tabla" action="verTablaGoleadores" resource="${torneoInstance}">Goleadores</g:link></li>
				<li><g:link class="boton-tabla" action="mostrarTabla" resource="${torneoInstance}">Posiciones</g:link></li>
			</ul>
		</div>
		<div id="show-torneo" class="content scaffold-show" role="main">
			<h1>	${torneoInstance }</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<div id="status">
			Creador: <g:link controller="user" action="show" id="${torneoInstance.usuario.id}"> ${torneoInstance.usuario } </g:link>
			<br/>
			<br/>
			<g:if test="${torneoInstance.fechaInicio > new Date() }">
				<g:if test="${torneoInstance.fechaLimite > new Date() }">
					Inscripción abierta hasta el ${ (new SimpleDateFormat("dd - MMM - yyyy")).format(torneoInstance.fechaLimite) }
					<br/>
					<br/>
					Inicia el ${ (new SimpleDateFormat("dd - MMM - yyyy")).format(torneoInstance.fechaInicio) }
				</g:if>
				<g:else>
					Inscripción cerrada
					<br/>
					<br/>
					Inicia el ${ (new SimpleDateFormat("dd - MMM - yyyy")).format(torneoInstance.fechaInicio) }
				</g:else>
			</g:if>
			<g:else>
				En juego
			</g:else>
			<br/>
			<br/>
			Equipos: ${equiposAceptados} / ${torneoInstance.nMaxEquipos }
			<br/>
			<br/>
			<g:link action="mostrarFixture" resource="${torneoInstance}">Ver Fixture</g:link>
		</div>
		
		
		<table style="width: 65%; position: relative; top: 2.1em;" class="table table-striped table-bordered table-hover table-condensed">
			<thead>
				<th style="text-align:center">Posición</th>
				<th>Equipo</th>
				<th style="text-align:center; width:10%">Puntos</th>
			</thead>
			<tbody>
				<g:each in="${filas}" status="i" var="fila">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td style="width:8%; text-align:center">
							${i+1}
						</td>
						<td> <g:link controller="equipo" action="show" id="${fila[0]}">
							${equipos.Equipo.findById(fila[0])}
						</g:link></td>
						<td style="text-align:center">
							${fila[1]}
						</td>
					</tr>
				</g:each>
			</tbody>
		</table>

			
			
			<!--<ol class="property-list torneo">
			
				<g:if test="${torneoInstance?.nombre}">
				<li class="fieldcontain">
					<span id="nombre-label" class="property-label"><g:message code="torneo.nombre.label" default="Nombre" /></span>
					
						<span class="property-value" aria-labelledby="nombre-label"><g:fieldValue bean="${torneoInstance}" field="nombre"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${torneoInstance?.fechaInicio}">
				<li class="fieldcontain">
					<span id="fechaInicio-label" class="property-label"><g:message code="torneo.fechaInicio.label" default="Fecha Inicio" /></span>
					
						<span class="property-value" aria-labelledby="fechaInicio-label"><g:formatDate date="${torneoInstance?.fechaInicio}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${torneoInstance?.fechaLimite}">
				<li class="fieldcontain">
					<span id="fechaLimite-label" class="property-label"><g:message code="torneo.fechaLimite.label" default="Fecha Limite" /></span>
					
						<span class="property-value" aria-labelledby="fechaLimite-label"><g:formatDate date="${torneoInstance?.fechaLimite}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${torneoInstance?.nMaxEquipos}">
				<li class="fieldcontain">
					<span id="nMaxEquipos-label" class="property-label"><g:message code="torneo.nMaxEquipos.label" default="N Max Equipos" /></span>
					
						<span class="property-value" aria-labelledby="nMaxEquipos-label"><g:fieldValue bean="${torneoInstance}" field="nMaxEquipos"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${torneoInstance?.nMinJugadorXEquipo}">
				<li class="fieldcontain">
					<span id="nMinJugadorXEquipo-label" class="property-label"><g:message code="torneo.nMinJugadorXEquipo.label" default="N Min Jugador XE quipo" /></span>
					
						<span class="property-value" aria-labelledby="nMinJugadorXEquipo-label"><g:fieldValue bean="${torneoInstance}" field="nMinJugadorXEquipo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${torneoInstance?.nMaxJugadorXEquipo}">
				<li class="fieldcontain">
					<span id="nMaxJugadorXEquipo-label" class="property-label"><g:message code="torneo.nMaxJugadorXEquipo.label" default="N Max Jugador XE quipo" /></span>
					
						<span class="property-value" aria-labelledby="nMaxJugadorXEquipo-label"><g:fieldValue bean="${torneoInstance}" field="nMaxJugadorXEquipo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${torneoInstance?.reglamento}">
				<li class="fieldcontain">
					<span id="reglamento-label" class="property-label"><g:message code="torneo.reglamento.label" default="Reglamento" /></span>
					
						<span class="property-value" aria-labelledby="reglamento-label"><g:fieldValue bean="${torneoInstance}" field="reglamento"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${torneoInstance?.equipos}">
				<li class="fieldcontain">
					<span id="equipos-label" class="property-label"><g:message code="torneo.equipos.label" default="Equipos" /></span>
					
						<g:each in="${torneoInstance.equipos}" var="e">
						<span class="property-value" aria-labelledby="equipos-label"><g:link controller="equipo" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${torneoInstance?.partidos}">
				<li class="fieldcontain">
					<span id="partidos-label" class="property-label"><g:message code="torneo.partidos.label" default="Partidos" /></span>
					
						<g:each in="${torneoInstance.partidos}" var="p">
						<span class="property-value" aria-labelledby="partidos-label"><g:link controller="partido" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${torneoInstance?.usuario}">
				<li class="fieldcontain">
					<span id="usuario-label" class="property-label"><g:message code="torneo.usuario.label" default="Usuario" /></span>
					
						<span class="property-value" aria-labelledby="usuario-label"><g:link controller="user" action="show" id="${torneoInstance?.usuario?.id}">${torneoInstance?.usuario?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			
			-->

		<!--  
		<g:form url="[resource:torneoInstance, action:'delete']" method="DELETE">
			<fieldset class="buttons">
				<g:link class="edit" action="edit" resource="${torneoInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
				<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
			</fieldset>
		</g:form>
		-->
	</body>
</html>
