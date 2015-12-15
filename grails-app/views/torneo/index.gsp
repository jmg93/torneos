<%@ page import="torneos.Torneo" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'torneo.label', default: 'Torneo')}" />
		<title>Buscar torneos</title>
		<style type="text/css" media="screen">
			#busqueda {
				background-color: #eee;
				border: .2em solid #fff;
				margin: 2em 2em 1em;
				padding: 1em;
				width:90%;
				float: left;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;
			}

		</style>
	</head>
	<body>
		<a href="#list-torneo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}">Inicio</a></li>
				<li><g:link class="create" action="create">Creá un torneo</g:link></li>
				<g:if test="${params.parametro}"><li><g:link class="list" action="index">Listar todos</g:link></li></g:if>
			</ul>
		</div>
		<div id="list-torneo" class="content scaffold-list" role="main">
			<h1>Torneos</h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<g:form action="busquedaTorneo" method="GET" style="padding: 1em; border-radius: 0.6em; margin: 2em 2em 1em; width: 90%; border: 0.2em solid rgb(238, 238, 238); height: 2em;">
				<fieldset class="form" style="left: 7em; top: -0.75em;">
					<div>
						<g:textField name="parametro" placeholder="Buscá un torneo..." maxlength="30" value="${params.parametro }" style="width: 52%;"/>
					</div>
				</fieldset>
				<g:submitButton name="buscar" class="save" value="Buscar" style="position: relative; left: 37em; top: -3.65em;" />
				
			</g:form>
			
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="nombre" title="${message(code: 'torneo.nombre.label', default: 'Torneo')}" />
					
						<g:sortableColumn property="fechaInicio" title="${message(code: 'torneo.fechaInicio.label', default: 'Fecha de inicio')}" />
					
						<g:sortableColumn property="fechaLimite" title="${message(code: 'torneo.fechaLimite.label', default: 'Límite de inscripción')}" />
					
						<g:sortableColumn property="nMaxEquipos" title="${message(code: 'torneo.usuario.label', default: 'Creador')}" />
									
					</tr>
				</thead>
				<tbody>
				<g:if test="${!listaFiltrada }">
					<g:set var="listaFiltrada" value="${Torneo.list()}"></g:set>
				</g:if>
				<g:each in="${listaFiltrada}" status="i" var="torneoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${torneoInstance.id}">${fieldValue(bean: torneoInstance, field: "nombre")}</g:link></td>
					
						<td><g:formatDate format="dd - MMM - yyyy" date="${torneoInstance.fechaInicio}" /></td>
					
						<td><g:formatDate format="dd - MMM - yyyy" date="${torneoInstance.fechaLimite}" /></td>
					
						<td>${fieldValue(bean: torneoInstance, field: "usuario")}</td>

					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${torneoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
