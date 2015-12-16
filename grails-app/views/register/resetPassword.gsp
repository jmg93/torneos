<html>

<head>
<title>Reestablecer contraseña</title>
<meta name='layout' content='main'/>
</head>

<body>

<div class="nav" role="navigation">
	<ul>
		<li><a class="home" href="${createLink(uri: '/')}">Inicio</a></li>
	</ul>
</div>

<div role="main">
	<g:hasErrors>
    	<g:eachError>
    		<div class="message" role="status"><g:message error="${it}"/></div>
    	</g:eachError>
	</g:hasErrors>
</div>	

<p/>
<div style="width: 475px; height: 250px; text-align: center; position: relative; left: 25%;">
	<s2ui:form width='475' height='250' elementId='resetPasswordFormContainer'
	           titleCode='' center='true'>
		<h1>Restablecer contraseña</h1>
		<g:form action='resetPassword' name='resetPasswordForm' autocomplete='off' style="float: right; position: relative; right: 7%;">
		<g:hiddenField name='t' value='${token}'/>
		<div class="sign-in">
	
		<br/>
		<h4>Ingresá tu nueva contraseña</h4>
	
		<table>
			<s2ui:passwordFieldRow name='password' placeholder="Entre 6 y 20 caracteres" labelCode='resetPasswordCommand.password.label' bean="${command}"
	                             labelCodeDefault='Contraseña' value="${command?.password}"/>
	
			<s2ui:passwordFieldRow name='password2' placeholder="Entre 6 y 20 caracteres" labelCode='resetPasswordCommand.password2.label' bean="${command}"
	                             labelCodeDefault='Repetir contraseña' value="${command?.password2}"/>
		</table>
	
		<g:submitButton style="margin-bottom: 2em;" name="reset" value="Restablecer"/>
	
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
