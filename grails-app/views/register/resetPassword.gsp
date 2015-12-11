<html>

<head>
<title>Restablecer contraseña</title>
<meta name='layout' content='main'/>
</head>

<body>

	<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
	</g:if>
	
	<g:hasErrors>
    	<g:eachError>
    		<div class="error" role="status"><g:message error="${it}"/></div>
        	<li style="position: relative; left: 29%; margin: 1em;"><g:message error="${it}"/></li>
    	</g:eachError>
	</g:hasErrors>

<p/>
<div style="width: 475px; height: 250px; text-align: center; position: relative; left: 25%;">
	<s2ui:form width='475' height='250' elementId='resetPasswordFormContainer'
	           titleCode='' center='true'>
		<h1>Restablecer contraseña</h1>
		<g:form action='resetPassword' name='resetPasswordForm' autocomplete='off'>
		<g:hiddenField name='t' value='${token}'/>
		<div class="sign-in">
	
		<br/>
		<h4>Ingresá tu nueva contraseña</h4>
	
		<table>
			<s2ui:passwordFieldRow name='password' labelCode='resetPasswordCommand.password.label' bean="${command}"
	                             labelCodeDefault='Contraseña' value="${command?.password}"/>
	
			<s2ui:passwordFieldRow name='password2' labelCode='resetPasswordCommand.password2.label' bean="${command}"
	                             labelCodeDefault='Repetir contraseña' value="${command?.password2}"/>
		</table>
	
		<g:submitButton name="reset" value="Restablecer"/>
	
		</div>
		</g:form>
	
	</s2ui:form>
</div>
<script>
$(document).ready(function() {
	$('#password').focus();
});
</script>

</body>
</html>
