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
	<g:textField name="contacto" required="" value="${equipoInstance?.contacto}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: equipoInstance, field: 'jugadores', 'error')} ">
	<label for="jugadores">
		<g:message code="equipo.jugadores.label" default="Jugadores" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${equipoInstance?.jugadores?}" var="j">
    <li><g:link controller="jugador" action="show" id="${j.id}">${j?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="jugador" action="create" params="['equipo.id': equipoInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'jugador.label', default: 'Jugador')])}</g:link>
</li>
</ul>


</div>

<div class="fieldcontain ${hasErrors(bean: equipoInstance, field: 'torneo', 'error')} required">
	<label for="torneo">
		<g:message code="equipo.torneo.label" default="Torneo" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="torneo" name="torneo.id" from="${torneos.Torneo.list()}" optionKey="id" required="" value="${equipoInstance?.torneo?.id}" class="many-to-one"/>

</div>

