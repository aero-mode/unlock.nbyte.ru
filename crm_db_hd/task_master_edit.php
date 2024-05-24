<?php
// проверка авторизации
require "auth.php";
if($_SESSION['user_login']!='master'){die;}

	
$res = mysql_query("SELECT * FROM task WHERE id=".intval($_GET['id']));
$row = mysql_fetch_array($res);

// сохранение задачи
if (isset($_POST['submit'])){

	$summa = mysql_real_escape_string(clear($_POST['summa_master']));
	$sdelal = mysql_real_escape_string(clear($_POST['master_sdelal']));

	$query = "UPDATE task SET summa_master='$summa', status='3', master_sdelal='$sdelal' WHERE id=".intval($_GET['id']);
	$res = mysql_query($query) or die(mysql_error()); 	
	header("location:task_master.php");
}
?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<title>Управление задачами. Nanobyte</title>
	<link rel="stylesheet" type="text/css" href="main.css" />
</head>

<body>

<div class="top_menu" style="background:#eee;padding:5px;margin-bottom:10px;">
<ul>
<li><a href="task_master.php">Список задач</a></li>
</ul>
</div>

	<table>
	<tr>
	<td valign="top">

		<form method="post" action="<?=$_SERVER['PHP_SELF']?>?<?=$_SERVER['QUERY_STRING']?>">
		<table>

		<? if($row[prioritet]==1){echo "<tr><td></td><td></td><td><b>Срочная задача!</b></td></tr>";}?>
	
	
		<tr>
		<td width="150" align="right" valign="top">
		ID задачи
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<?=$row[id]?>
		</td>
		</tr>
	
		<tr>
		<td width="150" align="right" valign="top">
		S/N
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<?=$row[sn]?>
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" valign="top">
		Модель
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<?=$row[model]?>
		</td>
		</tr>	
		
		<tr>
		<td width="150" align="right">
		Для мастера
		</td>
		<td width="20">&nbsp;</td>
		<td valign="middle">
		<?=$row[description]?>
		</td>
		</tr>

		<tr>
		<td width="150" align="right">
		Мастер сделал
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<textarea style="width:400px;height:100px;" name="master_sdelal"><?=$row[master_sdelal]?></textarea>
		</td>
		</tr>

		<tr>
		<td width="150" align="right" valign="top">
		Сумма
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" value="<?=$row[summa_master]?>" name="summa_master">
		</td>
		</tr>
		
		<tr>
		<td></td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="submit" name="submit" style="margin-top:35px;padding:5px;" value="Сохранить">
		</td>
		</tr>		
		</table>
		</form>

	</td>
	</tr>
	</table>

</body>
</html>