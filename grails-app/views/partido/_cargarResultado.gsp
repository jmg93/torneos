<%@ page import="partidos.Partido" %>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'goleadoresLocal', 'error')} ">
	<label for="goleadoresLocal">
		<g:message code="partido.goleadoresLocal.label" default="Goleadores Local" />
		
	</label>
	<g:select name="goleadoresLocal" from="${partidoInstance.local.jugadores}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.goleadoresLocal*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'goleadoresVisitante', 'error')} ">
	<label for="goleadoresVisitante">
		<g:message code="partido.goleadoresVisitante.label" default="Goleadores Visitante" />
		
	</label>
	<g:select name="goleadoresVisitante" from="${partidoInstance.visitante.jugadores}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.goleadoresVisitante*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'amonestadosLocal', 'error')} ">
	<label for="amonestadosLocal">
		<g:message code="partido.amonestadosLocal.label" default="Amonestados Local" />
		
	</label>
	<g:select name="amonestadosLocal" from="${partidoInstance.local.jugadores}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.amonestadosLocal*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'amonestadosVisitante', 'error')} ">
	<label for="amonestadosVisitante">
		<g:message code="partido.amonestadosVisitante.label" default="Amonestados Visitante" />
		
	</label>
	<g:select name="amonestadosVisitante" from="${partidoInstance.visitante.jugadores}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.amonestadosVisitante*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'expulsadosLocal', 'error')} ">
	<label for="expulsadosLocal">
		<g:message code="partido.expulsadosLocal.label" default="Expulsados Local" />
		
	</label>
	<g:select name="expulsadosLocal" from="${partidoInstance.local.jugadores}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.expulsadosLocal*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'expulsadosVisitante', 'error')} ">
	<label for="expulsadosVisitante">
		<g:message code="partido.expulsadosVisitante.label" default="Expulsados Visitante" />
		
	</label>
	<g:select name="expulsadosVisitante" from="${partidoInstance.visitante.jugadores}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.expulsadosVisitante*.id}" class="many-to-many"/>

</div>
