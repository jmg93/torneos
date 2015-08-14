<%@ page import="equipos.Equipo" %>



<div class="fieldcontain ${hasErrors(bean: equipoInstance, field: 'contacto', 'error')} required">
	<label for="contacto">
		<g:message code="equipo.contacto.label" default="Contacto" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="contacto" required="" value="${equipoInstance?.contacto}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: equipoInstance, field: 'jugadores', 'error')} ">
	<label for="jugadores">
		<g:message code="equipo.jugadores.label" default="Jugadores" />
		
	</label>
	<g:select name="jugadores" from="${equipos.Jugador.list()}" multiple="multiple" optionKey="id" size="5" value="${equipoInstance?.jugadores*.id}" class="many-to-many"/>

</div>

<div class="fieldcontain ${hasErrors(bean: equipoInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="equipo.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" required="" value="${equipoInstance?.nombre}"/>

</div>

