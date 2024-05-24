<?
session_start();
require("inc.php");
connect();
date_default_timezone_set('Europe/Kiev');
function SecondesToTime($secondes) {
	if ($secondes <= 0){
		$secondes = $secondes *(-1);
		$day = (int) ($secondes / 86400)."д ";
		if($day == 0){$day = '';}
		$hour = (int) ($secondes / 3600 % 24)."ч ";
		if($hour == 0){$hour = '';}
		$minut = (int) ($secondes / 60 % 60)."м";
		$time = $day.$hour.$minut;
		return "Просрочен на $time";
	}else{
		$day = (int) ($secondes / 86400)."д ";
		if($day == 0){$day = '';}
		$hour = (int) ($secondes / 3600 % 24)."ч ";
		if($hour == 0){$hour = '';}
		$minut = (int) ($secondes / 60 % 60)."м";
		$time = $day.$hour.$minut;
		return $time;
	}
}

// ============= логаут =================
if (isset($_GET['action']) AND $_GET['action']=="logout") {
	
	$user = $_SESSION['user_login'];
	session_destroy();
	
	/*
	print_r($user);
	echo "<hr>";
	print_r($_SERVER['HTTP_HOST']);
	echo "<hr>";
	print_r($_SERVER['HTTP_REFERER']);
	
	die;
	switch($user){
		case 'operator':
			header("Location: http://".$_SERVER['HTTP_HOST']."/task.php");
			break;
		case 'master':
			header("Location: http://".$_SERVER['HTTP_HOST']."/task_master.php");
			break;
		case 'ghost':
			header("Location: http://".$_SERVER['HTTP_HOST']."/task_manager.php");
			break;
	}
	exit;
	*/
}
// =======================================


if (isset($_POST['enter'])) {
  $login = mysql_real_escape_string($_POST['login']);
  $pwd = mysql_real_escape_string($_POST['pwd']);
  
  $query = "SELECT * FROM users WHERE login='$login' AND pwd='$pwd'";
  $res = mysql_query($query) or die(mysql_error().$query);
  if ($row = mysql_fetch_assoc($res)) {	  
    session_start();
    $_SESSION['user_login'] = $row['login'];
    $_SESSION['ip'] = $_SERVER['REMOTE_ADDR'];
  }
  
  header("Location: http://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI']);
  exit;
}

if (isset($_REQUEST[session_name()])) session_start();

//if (!isset($_SESSION['user_login'])) die('Переменная blablabla не найдена в сессии');

if (isset($_SESSION['user_login']) AND $_SESSION['ip'] == $_SERVER['REMOTE_ADDR']) {
	return;
}else{
?>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<title>CRM.hdd</title>
	<link rel="stylesheet" type="text/css" href="main.css" />

	<style>
	#login, #pwd, #submit {
		width:240px !important;
		padding:5px 10px;
		font-size:16px;
		border-radius:8px;
		border:none;
		background:#eee;
		height:38px;
	}
	
	#submit {
		background: #8BC34A;
	}
	</style>

</head>

<body onLoad="document.getElementById('login').focus();">

<table width="100%" height="100%">
	<tr>
	<td width="100%" align="center">
		<div style="width:300px;">
			<h1>CRM.hdd</h1>
			<form action="<?=$_SERVER['PHP_SELF']?>" method="POST">
				<input name="login" id="login" class="standart" type="text"><br>
				<input name="pwd" id="pwd" class="standart" type="password" style="margin-top:10px;"><br>
				<input name="enter" id="submit" type="submit" style="padding:2px; width:160px;margin-top:10px;" value="Вход">
			</form>
		</div>
	</td>
	</tr>
</table>

</body>
</html>

<? 
}
?>