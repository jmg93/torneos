<%@ page import="equipos.Jugador" %>
<%@ page import="equipos.Equipo" %>


<div class="fieldcontain ${hasErrors(bean: jugadorInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="jugador.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" placeholder="Entre 2 y 20 caracteres" maxlength="20" required="" value="${jugadorInstance?.nombre}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: jugadorInstance, field: 'apellido', 'error')} required">
	<label for="apellido">
		<g:message code="jugador.apellido.label" default="Apellido" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="apellido" placeholder="Entre 2 y 20 caracteres" maxlength="20" required="" value="${jugadorInstance?.apellido}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: jugadorInstance, field: 'nCamiseta', 'error')} required">
	<label for="nCamiseta">
		<g:message code="jugador.nCamiseta.label" default="N Camiseta" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="nCamiseta" from="${1..99}" class="range" required="" value="${fieldValue(bean: jugadorInstance, field: 'nCamiseta')}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: jugadorInstance, field: 'dni', 'error')} required">
	<label for="dni">
		<g:message code="jugador.dni.label" default="Dni" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="dni" placeholder="Sin puntos, 7-8 dígitos" type="number" min="1000000" max="99999999" value="${jugadorInstance.dni}" required="" style="width: 195px"/>

</div>

<div class="fieldcontain ${hasErrors(bean: jugadorInstance, field: 'capitan', 'error')} ">
	<label for="capitan">
		<g:message code="jugador.capitan.label" default="Capitan" />
		
	</label>
	<g:checkBox name="capitan" value="${jugadorInstance?.capitan}" />

</div>

<div class="fieldcontain ${hasErrors(bean: jugadorInstance, field: 'equipo', 'error')} required">
	<label for="equipo">
		<g:message code="jugador.equipo.label" default="Equipo" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="equipo" name="equipo.id" from="${Equipo.get(params.equipoId)}" optionKey="id" required="" value="${jugadorInstance?.equipo?.id}" class="many-to-one"/>

</div>

