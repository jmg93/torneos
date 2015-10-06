<%@ page import="torneos.Torneo" %>



<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="torneo.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" maxlength="20" required="" value="${torneoInstance?.nombre}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'fechaInicio', 'error')} required">
	<label for="fechaInicio">
		<g:message code="torneo.fechaInicio.label" default="Fecha Inicio" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fechaInicio" precision="day"  value="${torneoInstance?.fechaInicio}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'fechaLimite', 'error')} required">
	<label for="fechaLimite">
		<g:message code="torneo.fechaLimite.label" default="Fecha Limite" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="fechaLimite" precision="day"  value="${torneoInstance?.fechaLimite}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'nMaxEquipos', 'error')} required">
	<label for="nMaxEquipos">
		<g:message code="torneo.nMaxEquipos.label" default="N Max Equipos" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="nMaxEquipos" type="number" min="2" value="${torneoInstance.nMaxEquipos}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'nMinJugadorXEquipo', 'error')} required">
	<label for="nMinJugadorXEquipo">
		<g:message code="torneo.nMinJugadorXEquipo.label" default="N Min Jugador XE quipo" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="nMinJugadorXEquipo" type="number" min="5" value="${torneoInstance.nMinJugadorXEquipo}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'nMaxJugadorXEquipo', 'error')} required">
	<label for="nMaxJugadorXEquipo">
		<g:message code="torneo.nMaxJugadorXEquipo.label" default="N Max Jugador XE quipo" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="nMaxJugadorXEquipo" type="number" max="99" value="${torneoInstance.nMaxJugadorXEquipo}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'reglamento', 'error')} ">
	<label for="reglamento">
		<g:message code="torneo.reglamento.label" default="Reglamento" />
		
	</label>
	<g:textArea name="reglamento" cols="40" rows="5" maxlength="2000" value="${torneoInstance?.reglamento}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'equipos', 'error')} ">
	<label for="equipos">
		<g:message code="torneo.equipos.label" default="Equipos" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${torneoInstance?.equipos?}" var="e">
    <li><g:link controller="equipo" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="equipo" action="create" params="['torneo.id': torneoInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'equipo.label', default: 'Equipo')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'partidos', 'error')} ">
	<label for="partidos">
		<g:message code="torneo.partidos.label" default="Partidos" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${torneoInstance?.partidos?}" var="p">
    <li><g:link controller="partido" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="partido" action="create" params="['torneo.id': torneoInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'partido.label', default: 'Partido')])}</g:link>
</li>
</ul>


</div>

