<!DOCTYPE html>
<html>
<head>
	<title>Авторизация</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="{{theme}}/style.css" rel="stylesheet">
	<style>
.login_form{
	text-align:center;
	margin: 150px;
}
.login, .pass, .buttom{
	padding: 5px 5px;
}
</style>
</head>

<body>
	<div id="wrapper">
		<div id="content">
			<div class="login_form">
				<form action="{{site_path}}admin-post/" method="POST">
					<div class="login"><input type="text" pattern="[a-zA-Z0-9_]{3,20}" name="user_name"/></div>
					<div class="pass"><input type="password" pattern="[a-zA-Z0-9_-]{3,20}" name="user_pass"/></div>
					<div class="buttom"><input type="submit" name="login" value="Войти"/></div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>