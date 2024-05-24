<?php
// проверка авторизации
require "auth.php";
if($_SESSION['user_login']=='operator' or $_SESSION['user_login']=='ghost'){
?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<title>Акт выполненных работ</title>
	<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'></script>
	<link rel="stylesheet" type="text/css" href="main.css" />
</head>

<body style="margin-top:35px;">

	<?
	$res = mysql_query("SELECT * FROM task WHERE id=".mysql_real_escape_string($_GET['id']));
	$row = mysql_fetch_array($res);
	?>


	<table width="800" align="center">
	<tr>
	<td>
		<b>Сервис-центр «Нанобайт»</b><br>
		Крым, г. Симферополь, ул. Павленко, 15/72, оф. 11<br>
		<h1>Тел.: 8 (978) 829 30 50</h1>
	</td>
	</tr>
	<tr>
	<td align="center">
		<h1 style="margin-top:25px;">Акт выполненных работ №<?=$row['id']?>, <?=date('d.m.Y')?></h1>
	</td>
	</tr>	
	<td>
		<table width="800" align="center" border="1">
		<tr>
		<td style="background:#eee;">
		Модель, серийный номер
		</td>
		<td style="background:#eee;">
		Наименование работы
		</td>
		<td style="background:#eee;">
		<input type="text" value="Цена, руб." style="border:0;background:#eee;">
		</td>
		</tr>
		
		<tr>
		<td valign="top">
		<?=$row['model']?><br>
		<?=$row['sn']?>
		</td>
		<td width="500">
		<textarea style="border:none;font-family:Arial;width:100%;"><?=$row['comment_for_client']?></textarea>
		</td>
		<td width="100">
		<textarea style="border:none;font-family:Arial;font-size:12pt;width:100%;"></textarea>
		</td>
		</tr>
		
		</table>
	</td>
	</tr>
	
	<tr>
	<td style="padding-top:15px;">
		<b>Заказчик:</b> <input type="text" style="border:none;font-family:Arial;font-size:12pt;width:400px;" value="<?=$row['client_name']?>, <?=$row['client_phone']?>">
	</td>
	</tr>	
	<tr>
	
	<tr>
	<td style="padding-top:35px;">
		Гарантия на выполненные работы — 1 месяц.<br><b>Данный акт является гарантийным талоном</b>.
	</td>
	</tr>	
	
	<tr>
	<td style="padding-top:35px;">
		Инженер сервис-центра «Нанобайт»
	</td>
	</tr>	
	</table>

</body>
</html>
<?
}else{
	die;
}
?>