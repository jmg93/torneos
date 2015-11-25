<html>

<head>
	<meta name="layout" content="main">
	<title><g:message code='spring.security.ui.register.title'/></title>
</head>

<body>

<h1 style="margin-left: 2.2%;">Creá tu usuario</h1>

<p/>


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
				<g:textField name="username" maxlength="40" required="" value="${command.username}" style="width:35%"/>
			</div>
			
			<div class="fieldcontain ${hasErrors(bean: command, field: 'email', 'error')} required">
				<label for="email">
					<g:message code="user.email.label" default="Email" />
					<span class="required-indicator">*</span>
				</label>
				<g:textField name="email" maxlength="40" required="" value="${command.email}" style="width:35%"/>
			</div>
			
			<div class="fieldcontain ${hasErrors(bean: command, field: 'password', 'error')} required">
				<label for="password">
					<g:message code="user.password.label" default="Contraseña" />
					<span class="required-indicator">*</span>
				</label>
				<g:field type="password" name="password" maxlength="40" required="" value="${command.password}" style="width:35%"/>
			</div>
						
			<div class="fieldcontain ${hasErrors(bean: command, field: 'password2', 'error')} required">
				<label for="username">
					<g:message code="user.password2.label" default="Repetir contraseña" />
					<span class="required-indicator">*</span>
				</label>
				<g:field type="password" name="password2" maxlength="40" required="" value="${command.password2}" style="width:35%"/>
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
