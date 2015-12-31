<%@ page import="torneos.Torneo" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'equipo.label', default: 'Equipo')}" />
		<title>Inscribir equipo a ${Torneo.get(params.torneoId) }</title>
	</head>
	<body>
		<a href="#create-equipo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<g:link class="atras" controller="torneo" action="show" style="width: 15%;" id="${params.torneoId}">Volver al torneo</g:link>
			</ul>
		</div>
		<div id="create-equipo" class="content scaffold-create" role="main">
			<h1>Inscribir equipo a ${Torneo.get(params.torneoId) }</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${equipoInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${equipoInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:equipoInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
