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
	<link rel="stylesheet" type="text/css" href="main.css" />
	<style>
	table, table td {
		border-collapse:collapse !important;
		padding:3px;
	}
	</style>
</head>

<body style="margin-top:35px;background:white;">

	<?
	$res = mysql_query("SELECT * FROM clients WHERE id=".mysql_real_escape_string($_GET['id']));
	$row = mysql_fetch_array($res);
	$werwwe = explode("\r\n", $row['comment_by_master']);
	//print_r($werwwe);
	?>


	<table width="800" align="center">
	<tr>
	<td style="font-size:11pt;line-height:22px;">
		<b>Компьютерная помощь «Нанобайт»</b><br>
		Тел.: (099) 054-111-7, (0652) 71-46-91, (093) 69-111-65<b><br>
		Сайт: www.nanobyte.com.ua</b>
	</td>
	</tr>
	<tr>
	<td align="center">
		<h1 style="color:black;font-weight:normal;margin-top:25px;margin-bottom:20px;font-family:Arial;font-size:22pt;">Акт выполненных работ №<?=$row['id']?>, <?=date('d.m.Y')?></h1>
	</td>
	</tr>	
	<td>
	
	<input type="text" style="border:none;font-family:Arial;font-size:12pt;width:500px;" value="Тип устройства: <?=$row['device_type']?>">
	<br>
	<br>
		<table width="800" align="center" border="1">
		<tr>
		<td style="background:#eee;">
			Наименование работ
		</td>
		<td style="background:#eee;">
		Гарантия, мес.
		</td>
		<td style="background:#eee;">
		Цена, грн.
		</td>
		</tr>
		<?foreach($werwwe as $value){
			$dfghdfg = explode("/", $value);
		?>
		<tr>
		<td width="500">
		<textarea style="border:none;font-family:Arial;width:100%;height:40px;"><?=$dfghdfg['0']?></textarea>
		</td>
		<td width="100">
		<textarea style="border:none;font-family:Arial;font-size:12pt;width:100%;height:40px;"><?=$dfghdfg['1']?></textarea>
		</td>
		<td width="100">
		<textarea style="border:none;font-family:Arial;font-size:12pt;width:100%;height:40px;"><?=$dfghdfg['2'];?></textarea>
		</td>
		</tr>
		<?}?>
		
		</table>
	</td>
	</tr>
	
	<tr>
	<td style="padding-top:15px;">
		<b>Заказчик:</b> <input type="text" style="border:none;font-family:Arial;font-size:12pt;width:400px;" value="<?=$row['name']?>, тел.: <?=$row['phone']?>, <?=$row['address']?>">
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
		Инженер сервис-центра «Нанобайт»
	</td>
	</tr>	
	</table>

</body>
</html>