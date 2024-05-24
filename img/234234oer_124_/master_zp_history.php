<?
// проверка авторизации
require "auth.php";


if(isset($_POST[submit])){
	$id = $_GET[id];
	$date_zp = date(Ymd);
	$query = "UPDATE clients SET date_zp='$date_zp' WHERE id_master=".$id." AND status=2 AND date_oplata!=0";
	$res = mysql_query($query) or die(mysql_error()); 
	//header("location:master_zp.php");
}

?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>Зарплаты мастеров. Nanobyte</title>
	<link rel="stylesheet" type="text/css" href="reset.css" />
	<link rel="stylesheet" type="text/css" href="main.css" />
	<script type='text/javascript' src='jquery.js'></script>

	<script type='text/javascript'> 
	function del(){if(confirm("Точно?")){return true;}else{return false;}} 
	</script> 
	
<style>
#list td{
	padding:6px;
	border-collapse:collapse;
	border:1px solid #ccc;
	vertical-align:top;
}

#tit td{
	background:#eee;
	border:1px solid #ccc;
}
</style>

</head>

<body style="padding:20px;padding-top:0;" onLoad='$("#comment_by_master").focus()'>

	<table width="100%" border="0" style="margin-top:20px;border-bottom:2px solid #006699;">
	<tr>
	<td  valign="top" height="1" colspan="4">
	<h1 style="margin:0;margin-bottom:20px;margin-left:20px;"><a href="admin_nb_interface.php">База клиентов</a></h1>
	</td>
	<td align="right" valign="top" height="1">
	</td>
	</tr>
	</table>
	
<!-- CONTENT //-->

	<table width="100%" border="0">
	<tr>

	<td valign="top">
<!-- CENTER COLUMN //-->

<h1 style="margin-bottom:25px;"><a href="master_zp.php">Зарплаты мастеров</a> / История</h1>

<table width="100%" id="list" style="width:100%">
<tr id="tit">
<td>ID мастера</td>
<td>Имя</td>
<td>Дата выдачи ЗП</td>
<td>Сумма</td>
</tr>


<?
	$s = mysql_query("SELECT * FROM zp");
	while($r = mysql_fetch_array($s)){
		$q0 = mysql_query("SELECT * FROM masters WHERE id=$r[id_master]");
		$r0 = mysql_fetch_array($q0);

			echo "<tr>";
			echo "<td>";
			echo $r[id_master];
			echo "</td>";
			echo "<td>";
			echo $r0[name];
			echo "</td>";
			echo "<td>";
			echo date_s($r[date_zp]);
			echo "</td>";
			echo "<td>";
			echo "<span style='font-size:16pt;'>".$r[summa]."</span>";
			echo "</td>";
			echo "</tr>";
	}
?>
	</table>
	
	</td>
	</tr>
	</table>


</body>
</html>