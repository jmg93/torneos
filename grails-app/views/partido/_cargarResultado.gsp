<%@ page import="partidos.Partido" %>

<div id="fechaPartido">
	<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'fechaPartido', 'error')}">
		<label for="fechaPartido">
			<g:message code="partido.fechaPartido.label" default="Fecha" />
			
		</label>
		<g:datePicker name="fechaPartido" precision="day"  value="${partidoInstance?.fechaPartido}" relativeYears="[-4..0]" default="none" noSelection="['': '']" />
			
	</div>
</div>

<div id="colIzq">

			<h1>${partidoInstance.local}</h1>		
			<div class="content scaffold-list">
				<table class="table table-striped table-bordered table-hover table-condensed">
					<thead>
						<g:sortableColumn property="nCamiseta" defaultOrder="desc" title="N°" />
						<th>Jugador</th>
						<th style="text-align: center"><asset:image src="amarilla.png" width="15" height="20" alt="Amonestado"/></th>
						<th style="text-align: center"><asset:image src="roja.png" width="15" height="20" alt="Expulsado"/></th>
						<th style="text-align: center"><asset:image src="goles.png" width="20" height="20" alt="Goles"/></th>
					</thead>
					<tbody>
						<g:each in="${partidoInstance.local.jugadores}" status="i" var="jugador">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
								<td>
									${jugador.nCamiseta}
								</td>
								<td> <g:link action="show" id="${jugador.id}">
									${jugador}
								</g:link></td>
								<td>
									<g:checkBox name="jugador[${jugador.id}].amonestado"/>
								</td>
								<td>
									<g:checkBox name="jugador[${jugador.id}].expulsado"/>
								</td>
								<td>
									<g:field type="number" class="nGoles" min="0" name="jugador[${jugador.id}].goles" value="0"/>
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>
		
		
<%--		
		<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'goleadoresLocal', 'error')}">
			<label class="listajugadores" for="goleadoresLocal">
				<g:message code="partido.goleadoresLocal.label" default="Goleadores Local" />
					
			</label>
			<g:select name="goleadoresLocal" from="${partidoInstance.local.jugadores}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.goleadoresLocal*.id}" class="many-to-many"/>
			
		</div>
		
		<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'amonestadosLocal', 'error')} ">
			<label class="listajugadores" for="amonestadosLocal">
				<g:message code="partido.amonestadosLocal.label" default="Amonestados Local" />
				
			</label>
			<g:select name="amonestadosLocal" from="${partidoInstance.local.jugadores}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.amonestadosLocal*.id}" class="many-to-many"/>
		
		</div>
		
		<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'expulsadosLocal', 'error')} ">
			<label class="listajugadores" for="expulsadosLocal">
				<g:message code="partido.expulsadosLocal.label" default="Expulsados Local" />
				
			</label>
			<g:select name="expulsadosLocal" from="${partidoInstance.local.jugadores}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.expulsadosLocal*.id}" class="many-to-many"/>
		
		</div>
--%>
</div>

<div id="colDer">

			<h1>${partidoInstance.visitante}</h1>
			<div class="content scaffold-list">
				<table class="table table-striped table-bordered table-hover table-condensed">
					<thead>
						<g:sortableColumn property="nCamiseta" defaultOrder="desc" title="N°" />
						<th>Jugador</th>
						<th style="text-align: center"><asset:image src="amarilla.png" width="15" height="20" alt="Amonestado"/></th>
						<th style="text-align: center"><asset:image src="roja.png" width="15" height="20" alt="Expulsado"/></th>
						<th style="text-align: center"><asset:image src="goles.png" width="20" height="20" alt="Goles"/></th>
					</thead>
					<tbody>
						<g:each in="${partidoInstance.visitante.jugadores}" status="i" var="jugador">
							<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
								<td>
									${jugador.nCamiseta}
								</td>
								<td> <g:link action="show" id="${jugador.id}">
									${jugador}
								</g:link></td>
								<td>
									<g:checkBox name="jugador[${jugador.id}].amonestado"/>
								</td>
								<td>
									<g:checkBox name="jugador[${jugador.id}].expulsado"/>
								</td>
								<td>
									<g:field type="number" class="nGoles" min="0" name="jugador[${jugador.id}].goles" value="0"/>
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</div>


<%--
		<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'goleadoresVisitante', 'error')} ">
			<label class="listajugadores" for="goleadoresVisitante">
				<g:message code="partido.goleadoresVisitante.label" default="Goleadores Visitante" />
				
			</label>
			<g:select name="goleadoresVisitante" from="${partidoInstance.visitante.jugadores}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.goleadoresVisitante*.id}" class="many-to-many"/>
		
		</div>
		
		<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'amonestadosVisitante', 'error')} ">
			<label class="listajugadores" for="amonestadosVisitante">
				<g:message code="partido.amonestadosVisitante.label" default="Amonestados Visitante" />
				
			</label>
			<g:select name="amonestadosVisitante" from="${partidoInstance.visitante.jugadores}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.amonestadosVisitante*.id}" class="many-to-many"/>
		
		</div>
		
		<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'expulsadosVisitante', 'error')} ">
			<label class="listajugadores" for="expulsadosVisitante">
				<g:message code="partido.expulsadosVisitante.label" default="Expulsados Visitante" />
				
			</label>
			<g:select name="expulsadosVisitante" from="${partidoInstance.visitante.jugadores}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.expulsadosVisitante*.id}" class="many-to-many"/>
		
		</div>
--%>
</div>