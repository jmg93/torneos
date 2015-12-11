<html>

<head>
<title><g:message code='spring.security.ui.forgotPassword.title'/></title>
<meta name='layout' content='main'/>
</head>

<body>

	<g:if test="${flash.error}">
		<div class="message" role="status">${flash.error}</div>
	</g:if>

<p/>
<div style="width: 400px; position: relative; left: 27%;">
	<s2ui:form width='400' height='220' elementId='forgotPasswordFormContainer' titleCode="" center='true' >
	          
	    <h1>Restablecer contraseña</h1>
	
		<g:form action='forgotPassword' name="forgotPasswordForm" autocomplete='off'>
	
		<g:if test='${emailSent}'>
		<br/>
		eMail enviado
		</g:if>
	
		<g:else>
	
		<br/>
		Ingresá tu nombre de usuario y te enviaremos un eMail con un link para restablecer tu contraseña
	
		<table>
			<tr>
				<td><label for="username">Usuario</label></td>
				<td><g:textField name="username" size="25" /></td>
			</tr>
		</table>
		<g:submitButton name="reset" value="Enviar"/>
		
		</g:else>
	
		</g:form>
	</s2ui:form>
</div>

<script>
$(document).ready(function() {
	$('#username').focus();
});
</script>

</body>
</html>
