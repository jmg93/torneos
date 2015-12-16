<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'partido.label', default: 'Partido')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
			<div class="nav">
				<g:link class="atras" action="show" style="width: 15%;" id="${torneoInstance.id}">Volver al torneo</g:link>
			</div>
			
			<div style="margin: 2em;">
				<h1>Reglamento de ${torneoInstance }</h1>
				<g:if test="${torneoInstance.reglamento }">
					${torneoInstance.reglamento }
				</g:if>
				<g:else>
					El usuario no especificó un reglamento para el torneo.
				</g:else>
			</div>

	</body>
</html>