<?
include "connect2db.php";
connect();

if (isset($_POST['login']) AND isset($_POST['pwd'])) {
	$login = mysql_real_escape_string($_POST['login']);
	$pwd = mysql_real_escape_string($_POST['pwd']);

	$query = "SELECT * FROM admin WHERE login='$login' AND pwd='$pwd'";
	$res = mysql_query($query) or trigger_error(mysql_error().$query);

	if ($row = mysql_fetch_assoc($res)) {
		session_start();
		$_SESSION['login'] = $row['login'];
		$_SESSION['ip'] = $_SERVER['REMOTE_ADDR'];
	}
	
	header("Location: http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']);
	exit;
}

// выходим
if (isset($_GET['action']) AND $_GET['action']=="logout") {
  session_start();
  session_destroy();
  header("Location: http://".$_SERVER['HTTP_HOST']."/");
  exit;
}

if(isset($_REQUEST[session_name()])){ 
	session_start();
}

if (isset($_SESSION['login']) AND $_SESSION['ip'] == $_SERVER['REMOTE_ADDR']) {
	return;
}else{
	?>
	<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
		<title>Панель управления</title>
	</head>

	<body onLoad="document.getElementById('login').focus();">
		<table width="100%" height="100%">
		<tr>
		<td width="100%" align="center">
			<div style="width:400px;margin-bottom:0px;padding:15px;padding-bottom:0;">
				<form action="<?php echo $_SERVER["PHP_SELF"];?>" method="post">
					<input name="login" id="login" class="standart" style="width:250px;padding:5px;font-size:20pt;" type="text"><br>
					<input name="pwd" class="standart" type="password" style="width:250px;padding:5px;font-size:20pt;margin-top:20px;"><br>
					<input type="submit" value="Вход в панель" style="width:250px;margin-top:12px;font-size:16pt;padding:12px;">
				</form>
			</div>
		</td>
		</tr>
		</table>
	</body>
	</html>
	<? 
}
exit;
?>