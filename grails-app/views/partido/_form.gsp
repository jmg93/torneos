<%@ page import="partidos.Partido" %>



<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'fechaPartido', 'error')} ">
	<label for="fechaPartido">
		<g:message code="partido.fechaPartido.label" default="Fecha Partido" />
		
	</label>
	<g:datePicker name="fechaPartido" precision="day"  value="${partidoInstance?.fechaPartido}" default="none" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'nFecha', 'error')} required">
	<label for="nFecha">
		<g:message code="partido.nFecha.label" default="N Fecha" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="nFecha" type="number" value="${partidoInstance.nFecha}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'local', 'error')} required">
	<label for="local">
		<g:message code="partido.local.label" default="Local" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="local" name="local.id" from="${equipos.Equipo.list()}" optionKey="id" required="" value="${partidoInstance?.local?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'visitante', 'error')} required">
	<label for="visitante">
		<g:message code="partido.visitante.label" default="Visitante" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="visitante" name="visitante.id" from="${equipos.Equipo.list()}" optionKey="id" required="" value="${partidoInstance?.visitante?.id}" class="many-to-one"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'goleadoresLocal', 'error')} ">
	<label for="goleadoresLocal">
		<g:message code="partido.goleadoresLocal.label" default="Goleadores Local" />
		
	</label>
	<g:select name="goleadoresLocal" from="${equipos.Jugador.list()}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.goleadoresLocal*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'goleadoresVisitante', 'error')} ">
	<label for="goleadoresVisitante">
		<g:message code="partido.goleadoresVisitante.label" default="Goleadores Visitante" />
		
	</label>
	<g:select name="goleadoresVisitante" from="${equipos.Jugador.list()}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.goleadoresVisitante*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'amonestadosLocal', 'error')} ">
	<label for="amonestadosLocal">
		<g:message code="partido.amonestadosLocal.label" default="Amonestados Local" />
		
	</label>
	<g:select name="amonestadosLocal" from="${equipos.Jugador.list()}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.amonestadosLocal*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'amonestadosVisitante', 'error')} ">
	<label for="amonestadosVisitante">
		<g:message code="partido.amonestadosVisitante.label" default="Amonestados Visitante" />
		
	</label>
	<g:select name="amonestadosVisitante" from="${equipos.Jugador.list()}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.amonestadosVisitante*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'expulsadosLocal', 'error')} ">
	<label for="expulsadosLocal">
		<g:message code="partido.expulsadosLocal.label" default="Expulsados Local" />
		
	</label>
	<g:select name="expulsadosLocal" from="${equipos.Jugador.list()}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.expulsadosLocal*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'expulsadosVisitante', 'error')} ">
	<label for="expulsadosVisitante">
		<g:message code="partido.expulsadosVisitante.label" default="Expulsados Visitante" />
		
	</label>
	<g:select name="expulsadosVisitante" from="${equipos.Jugador.list()}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.expulsadosVisitante*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'torneo', 'error')} required">
	<label for="torneo">
		<g:message code="partido.torneo.label" default="Torneo" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="torneo" name="torneo.id" from="${torneos.Torneo.list()}" optionKey="id" required="" value="${partidoInstance?.torneo?.id}" class="many-to-one"/>

</div>

