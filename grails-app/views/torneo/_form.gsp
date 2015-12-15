<%@ page import="torneos.Torneo" %>




<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'nombre', 'error')} required">
	<label for="nombre" style="width: 250px;">
		<g:message code="torneo.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField placeholder="Entre 2 y 20 caracteres" name="nombre" maxlength="20" required="" value="${torneoInstance?.nombre}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'fechaLimite', 'error')} required">
	<label for="fechaLimite" style="width: 250px;">
		<g:message code="torneo.fechaLimite.label" default="Fecha límite de inscripción" />
		<span class="required-indicator">*</span>
	</label>
	<g:datepickerUI name="fechaLimite" locale="es" required="true" value="${torneoInstance?.fechaLimite}" options="{minDate:'0', maxDate:'+1Y'}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'fechaInicio', 'error')} required">
	<label for="fechaInicio" style="width: 250px;">
		<g:message code="torneo.fechaInicio.label" default="Fecha de inicio" />
		<span class="required-indicator">*</span>
	</label>
	<g:datepickerUI name="fechaInicio" locale="es" required="true" value="${torneoInstance?.fechaInicio}" options="{minDate:'0', maxDate:'+1Y'}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'nMaxEquipos', 'error')} required">
	<label for="nMaxEquipos" style="width: 250px;">
		<g:message code="torneo.nMaxEquipos.label" default="Límite de equipos" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="nMaxEquipos" placeholder="Mínimo 2" type="number" min="2" value="${torneoInstance.nMaxEquipos}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'nMinJugadorXEquipo', 'error')} required">
	<label for="nMinJugadorXEquipo" style="width: 250px;">
		<g:message code="torneo.nMinJugadorXEquipo.label" default="Mínimo de jugadores por equipo" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="nMinJugadorXEquipo" placeholder="Mínimo 5" type="number" min="5" value="${torneoInstance.nMinJugadorXEquipo}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'nMaxJugadorXEquipo', 'error')} required">
	<label for="nMaxJugadorXEquipo" style="width: 250px;">
		<g:message code="torneo.nMaxJugadorXEquipo.label" default="Máximo de jugadores por equipo" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="nMaxJugadorXEquipo" placeholder="Máximo 99" type="number" min="5" max="99" value="${torneoInstance.nMaxJugadorXEquipo}" required="" style="width:195px"/>

</div>

<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'reglamento', 'error')} ">
	<label for="reglamento" style="width: 250px;">
		<g:message code="torneo.reglamento.label" default="Reglamento" />
		
	</label>
	<g:textArea name="reglamento" placeholder="Opcional" cols="500" rows="500" maxlength="2000" value="${torneoInstance?.reglamento}"/>

</div>




<div class="fieldcontain ${hasErrors(bean: torneoInstance, field: 'usuario', 'error')} required">
	<g:hiddenField name="usuario.id" value="${applicationContext.springSecurityService.currentUser.id}" />
	
</div>

