<html>

<head>
	<meta name="layout" content="main">
	<title>Registrate</title>
</head>

<body>

<div class="nav" role="navigation">
	<ul>
		<li><a class="home" href="${createLink(uri: '/')}">Inicio</a></li>
	</ul>
</div>
<h1 style="margin-left: 2.2%;">Creá tu usuario</h1>

<p/>


	<g:hasErrors>
    	<g:eachError>
        	<div class="message" role="status"><g:message error="${it}"/></div>
    	</g:eachError>
	</g:hasErrors>

<g:form action='register' name='registerForm' style="width: 75%; padding-left: 22%; padding-bottom:4%;">

	<g:if test='${emailSent}'>
	<br/>
	<g:message message="Se envió un email a tu casilla de correo, hacé clic en el link para validar tu cuenta"/>
	</g:if>
	<g:else>

	<br/>

		<fieldset class="form">
			
			<div class="fieldcontain ${hasErrors(bean: command, field: 'username', 'error')} required">
				<label for="username">
					<g:message code="user.username.label" default="Username" />
					<span class="required-indicator">*</span>
				</label>
				<g:textField name="username" placeholder="Hasta 20 caracteres" maxlength="20" required="" value="${command.username}" style="width:35%"/>
			</div>
			
			<div class="fieldcontain ${hasErrors(bean: command, field: 'email', 'error')} required">
				<label for="email">
					<g:message code="user.email.label" default="Email" />
					<span class="required-indicator">*</span>
				</label>
				<g:textField name="email" placeholder="E-mail válido" maxlength="40" palceholder="E-mail válido" required="" value="${command.email}" style="width:35%"/>
			</div>
			
			<div class="fieldcontain ${hasErrors(bean: command, field: 'password', 'error')} required">
				<label for="password">
					<g:message code="user.password.label" default="Contraseña" />
					<span class="required-indicator">*</span>
				</label>
				<g:field type="password" name="password" placeholder="Entre 6 y 20 caracteres" maxlength="40" required="" value="${command.password}" style="width:35%"/>
			</div>
						
			<div class="fieldcontain ${hasErrors(bean: command, field: 'password2', 'error')} required">
				<label for="username">
					<g:message code="user.password2.label" default="Repetir contraseña" />
					<span class="required-indicator">*</span>
				</label>
				<g:field type="password" name="password2" placeholder="Entre 6 y 20 caracteres" maxlength="40" required="" value="${command.password2}" style="width:35%"/>
			</div>
			
		</fieldset>
		<fieldset class="buttons" style="width:15%; margin-left:28%" >
			<g:submitButton name="create" class="registerForm" value="Registrate" />
		</fieldset>


	</g:else>

</g:form>

<script>
$(document).ready(function() {
	$('#username').focus();
});
</script>

</body>
</html>
