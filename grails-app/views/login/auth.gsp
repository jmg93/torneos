<html>

<head>
<title>Ingresá a TorneosYa</title>
<meta name='layout' content='main'/>
</head>

<body>

<p/>

<div class="login s2ui_center ui-corner-all" style='text-align:center;'>
	<div class="login-inner">
	<form action='${postUrl}' method='POST' id="loginForm" name="loginForm" autocomplete='off'>
	<div class="sign-in">

	<h1>Ingresá</h1>

	<table style="width: 35%; position: relative; left: 31%;">
		<tr>
			<td><label for="username">Usuario</label></td>
			<td><input name="j_username" id="username" size="20" /></td>
		</tr>
		<tr>
			<td><label for="password">Contraseña</label></td>
			<td><input type="password" name="j_password" id="password" size="20" /></td>
		</tr>
		<tr>
			<td colspan='2'>
				<input type="checkbox" class="checkbox" name="${rememberMeParameter}" id="remember_me" checked="checked" />
				<label for='remember_me'>Recuérdame</label> |
				<span class="forgot-link">
					<g:link controller='register' action='forgotPassword'>¿Olvidaste la contraseña?</g:link>
				</span>
			</td>
		</tr>
		<tr>
			<td colspan='2'>
				<g:submitButton name="loginButton" value="Ingresá" style="position: relative; left: 42%;"/>
			</td>
		</tr>
	</table>

	</div>
	</form>
	</div>
</div>

<script>
$(document).ready(function() {
	$('#username').focus();
});

<s2ui:initCheckboxes/>

</script>

</body>
</html>
