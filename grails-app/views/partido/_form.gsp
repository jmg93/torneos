<%@ page import="partidos.Partido" %>



<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'fechaPartido', 'error')} required">
	<label for="fechaPartido">
		<g:message code="partido.fechaPartido.label" default="Fecha Partido" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fechaPartido" precision="day"  value="${partidoInstance?.fechaPartido}"  />

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

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'amonestados', 'error')} ">
	<label for="amonestados">
		<g:message code="partido.amonestados.label" default="Amonestados" />
		
	</label>
	<g:select name="amonestados" from="${equipos.Jugador.list()}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.amonestados*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'expulsados', 'error')} ">
	<label for="expulsados">
		<g:message code="partido.expulsados.label" default="Expulsados" />
		
	</label>
	<g:select name="expulsados" from="${equipos.Jugador.list()}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.expulsados*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: partidoInstance, field: 'goleadores', 'error')} ">
	<label for="goleadores">
		<g:message code="partido.goleadores.label" default="Goleadores" />
		
	</label>
	<g:select name="goleadores" from="${equipos.Jugador.list()}" multiple="multiple" optionKey="id" size="5" value="${partidoInstance?.goleadores*.id}" class="many-to-many"/>

</div>

