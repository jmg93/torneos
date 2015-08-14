<%@ page import="equipos.Jugador" %>



<div class="fieldcontain ${hasErrors(bean: jugadorInstance, field: 'apellido', 'error')} required">
	<label for="apellido">
		<g:message code="jugador.apellido.label" default="Apellido" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="apellido" required="" value="${jugadorInstance?.apellido}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: jugadorInstance, field: 'capitan', 'error')} ">
	<label for="capitan">
		<g:message code="jugador.capitan.label" default="Capitan" />
		
	</label>
	<g:checkBox name="capitan" value="${jugadorInstance?.capitan}" />

</div>

<div class="fieldcontain ${hasErrors(bean: jugadorInstance, field: 'dni', 'error')} required">
	<label for="dni">
		<g:message code="jugador.dni.label" default="Dni" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="dni" type="number" value="${jugadorInstance.dni}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: jugadorInstance, field: 'nCamiseta', 'error')} required">
	<label for="nCamiseta">
		<g:message code="jugador.nCamiseta.label" default="N Camiseta" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="nCamiseta" type="number" value="${jugadorInstance.nCamiseta}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: jugadorInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="jugador.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" required="" value="${jugadorInstance?.nombre}"/>

</div>

