<?
// �������� �����������
include "connect2db.php";
connect();
?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>��� ����������� �����</title>
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
		<b>��� ������ �. �., ������-����� ���������</b><br>
		�������, �� ����, �. �����������, ��. ��������, 15/72, ��. 11<br>
		���.: (099) 00-11-808, <b>www.nanobyte.com.ua</b><br>
		����� ������ � 9:00 �� 19:00, ��� ��������	
	</td>
	</tr>
	<tr>
	<td align="center">
		<h1 style="color:black;font-weight:normal;margin-top:25px;margin-bottom:20px;font-family:Arial;font-size:22pt;">��� ������ ������������ �<?=$row['id_client']?>, <?=date('d.m.Y')?></h1>
	</td>
	</tr>	
	<td>
	
	<input type="text" style="border:none;font-family:Arial;font-size:12pt;width:500px;" value="������: <?=$row['model']?>">
	<input type="text" style="border:none;font-family:Arial;font-size:12pt;width:500px;" value="SN: <?=$row['sn']?>">
	
		<table width="800" align="center" border="1" style="margin-top:15px;">
		<tr>
		<td style="background:#eee;">
			�������� ������������� �� ���� �������
		</td>
		</tr>
		
		<tr>
		<td width="500" valign="top">
		<textarea style="border:none;font-family:Arial;width:100%;line-height:26px;font-size:14pt;"><?=$row['problema_opisanie']?></textarea>
		</td>
		</tr>
				
		</table>
	</td>
	</tr>
	
	<tr>
	<td style="padding-top:15px;">
		<b>������:</b> <input type="text" style="border:none;font-family:Arial;font-size:12pt;width:450px;" value="<?=$row['name']?>, ���.: <?=$row['phone']?>, <?=$row['address']?>">
		<br>c ��������� �������\����������� ���������� � �������� <span>   _______________ ������ </span>
	</td>
	</tr>	
	<tr>
	
	<tr>
	<td style="padding-top:35px;">
		�������� _____________ 		�.�.
	</td>
	</tr>	
	</table>

</body>
</html>