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

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'torneo', 'error')} required">
	<label for="torneo">
		<g:message code="partido.torneo.label" default="Torneo" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="torneo" name="torneo.id" from="${torneos.Torneo.list()}" optionKey="id" required="" value="${partidoInstance?.torneo?.id}" class="many-to-one"/>

</div>

