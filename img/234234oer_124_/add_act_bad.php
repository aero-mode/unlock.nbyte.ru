<?
// проверка авторизации
include "connect2db.php";
connect();
?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>Акт выполненных работ</title>
	<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'></script>
	<script type='text/javascript' src='http://suntime.com.ua/script/autoresize.jquery.js'></script>
	<link rel="stylesheet" type="text/css" href="main.css" />
	<style>
	table, table td {
		border-collapse:collapse !important;
		padding:3px;
	}
	</style>
	
	<script type="text/javascript">	
	$(document).ready(function() {	
		$('textarea').autoResize();
	});
	</script>
</head>

<body style="margin-top:35px;background:white;">

	<?
	$res = mysql_query("SELECT * FROM clients_sc WHERE id=".mysql_real_escape_string($_GET['id']));
	$row = mysql_fetch_array($res);
	?>


	<table width="800" align="center">
	<tr>
	<td style="font-size:11pt;line-height:22px;">
		<b>ФЛП Пинчук В. А., Сервис-центр «Нанобайт»</b><br>
		Украина, АР Крым, г. Симферополь, ул. Павленко, 15/72, оф. 11<br>
		Тел.: (099) 00-11-808, <b>www.nanobyte.com.ua</b><br>
		Режим работы с 9:00 до 19:00, без выходных
	</td>
	</tr>
	<tr>
	<td align="center">
		<h1 style="color:black;font-weight:normal;margin-top:25px;margin-bottom:20px;font-family:Arial;font-size:22pt;">Акт выполненных работ №<?=$row['id_client']?>, <?=date('d.m.Y')?></h1>
	</td>
	</tr>	
	<td>
	
	<input type="text" style="border:none;font-family:Arial;font-size:12pt;width:500px;" value="Модель: <?=$row['model']?>">
	<input type="text" style="border:none;font-family:Arial;font-size:12pt;width:500px;" value="SN: <?=$row['sn']?>">
	
		<table width="800" align="center" border="1">
		<tr>
		<td style="background:#eee;">
			Наименование работ
		</td>
		<td style="background:#eee;">
		Гарантия, мес.
		</td>
		<td style="background:#eee;">
		Цена, руб.
		</td>
		</tr>
		
		<tr>
		<td width="500" valign="top">
		<textarea style="border:none;font-family:Arial;width:100%;line-height:26px;font-size:14pt;"></textarea>
		</td>
		<td width="100" valign="top">
		<textarea style="border:none;font-family:Arial;font-size:12pt;width:100%;height:100%;line-height:26px;font-size:14pt;"></textarea>
		</td>
		<td width="100" valign="top">
		<textarea style="border:none;font-family:Arial;font-size:12pt;width:100%;height:100%;line-height:26px;font-size:14pt;"></textarea>
		</td>
		</tr>
		
		<tr>
		<td colspan="2" width="500" style="font-size:12pt;font-weight:bold;">
			Итого, к оплате
		</td>
		<td width="100" valign="top">
			<input style="border:none;font-family:Arial;font-size:12pt;width:200px;font-size:14pt;" value="<?=$row['cena_work']+$row['cena_hard']?> руб." />		
		</td>
		</tr>
		
		</table>
	</td>
	</tr>
	
	<tr>
	<td style="padding-top:15px;">
		<b>Клиент:</b> <input type="text" style="border:none;font-family:Arial;font-size:12pt;width:450px;" value="<?=$row['name']?>, тел.: <?=$row['phone']?>, <?=$row['address']?>">
		<span>Подпись клиента _____________</span>
	</td>
	</tr>	
	<tr>
	
	<tr>
	<td style="padding-top:35px;">
		<b>Данный акт является гарантийным талоном</b>.
	</td>
	</tr>	
	
	<tr>
	<td style="padding-top:35px;">
		Инженер сервис-центра «Нанобайт» _____________ 		М.П.
	</td>
	</tr>	
	</table>

</body>
</html>