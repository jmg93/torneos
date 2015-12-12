<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'partido.label', default: 'Partido')}" />
		<title>Partidos de ${equipoInstance} en ${equipoInstance.torneo}</title>
	</head>
	<body>
			<div class="nav">
				<g:link class="atras" style="width: 16%;" action="show" id="${equipoInstance.id}">Volver al equipo</g:link>
			</div>
			<g:if test="${flash.message}">
  				<div class="message" style="display: block">${flash.message}</div>
			</g:if>
			<div id="show-torneo" class="content scaffold-show" role="main">
				<h1>Partidos jugados de ${equipoInstance} en ${equipoInstance.torneo}</h1>
			</div>
			<div id="tablaFixture" class="content scaffold-list">
				<table class="table table-striped table-bordered table-hover table-condensed">
					<thead>
						<g:sortableColumn property="nFecha" defaultOrder="asc" title="Fecha" style= "width:16%; text-align: center;" />
						<th style="text-align: right;">Local</th>
						<th>Visitante</th>
					</thead>
					<tbody>
						<g:each in="${partidosEquipo}" status="i" var="partido">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
								<td style="text-align:center"> <g:link controller="partido" action="show" id="${partido.id}">
									${partido.nFecha}
								</g:link></td>
								<td style="text-align: right;">
									<g:if test="${partido.local.id == equipoInstance.id}">	<font style="color: red"> ${partido.local} </font></g:if>
									<g:else>${partido.local}</g:else>
									<g:if test="${partido.fechaPartido == null }">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-
									</g:if>
									<g:else>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${partido.goleadoresLocal.size() }
									</g:else>
								</td>
								<td>
									<g:if test="${partido.fechaPartido == null }">
										-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</g:if>
									<g:else>
										${partido.goleadoresVisitante.size() }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</g:else>
									<g:if test="${partido.visitante.id == equipoInstance.id}">	<font style="color: red"> ${partido.visitante} </font></g:if>
									<g:else>${partido.visitante}</g:else>
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
			
	</body>
</html>