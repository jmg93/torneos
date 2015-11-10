<%@ page import="equipos.Equipo" %>



<div class="fieldcontain ${hasErrors(bean: equipoInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="equipo.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" maxlength="20" required="" value="${equipoInstance?.nombre}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: equipoInstance, field: 'contacto', 'error')} required">
	<label for="contacto">
		<g:message code="equipo.contacto.label" default="Contacto" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="contacto" required="" value="${equipoInstance?.contacto}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: equipoInstance, field: 'torneo', 'error')} required">
	<label for="torneo">
		<g:message code="equipo.torneo.label" default="Torneo" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="torneo" name="torneo.id" from="${torneos.Torneo.list()}" optionKey="id" required="" value="${equipoInstance?.torneo?.id}" class="many-to-one"/>

</div>

