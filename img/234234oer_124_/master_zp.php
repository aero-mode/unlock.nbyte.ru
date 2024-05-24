<?
// проверка авторизации
//require "auth.php";
include "connect2db.php";
connect();


if(isset($_POST[submit])){
	$id = $_GET[id];
	$summa = $_GET[summa];
	$date_zp = date(Ymd);
	$query = "UPDATE clients SET date_zp='$date_zp' WHERE id_master=".$id." AND status=2 AND date_oplata!=0";
	$res = mysql_query($query) or die(mysql_error()); 
	
	$query = "INSERT INTO zp (id_master, date_zp, summa) VALUES ('$id' ,'$date_zp', '$summa')";
	$res = mysql_query($query) or die(mysql_error()); 
	
	
	
	
	header("location:master_zp.php");
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

<h1 style="margin-bottom:25px;">Зарплаты мастеров / <a href="master_zp_history.php">История</a></h1>

<table width="100%" id="list" style="width:100%">
<tr id="tit">
<td>ID</td>
<td>Имя</td>
<td>Коэффицент</td>
<td>Дата старта</td>
<td>Кол-во задач</td>
<td>Зарплата</td>
<td>Выдать</td>
</tr>


<?
	$s = mysql_query("SELECT * FROM masters");
	while($r = mysql_fetch_array($s)){
	
			$zp=0;
			$i=0;
			$y=0;
			$date_s = "";
			$date_e = "";
			$q0 = mysql_query("SELECT * FROM clients WHERE id_master='$r[id]' AND date_oplata!='0' AND date_zp='0' ORDER BY date_end ASC");
			while($r0 = mysql_fetch_array($q0)){
				if($date_s==''){$date_s = $r0['date_end'];}
				$zp = $zp + $r0['cena_work']*0.40;	
				$zp = $zp + $r0['cena_hard']*0.05;			
				$i++;
				if($r0['cena_work']!=0 OR $r0['cena_hard']!=0){
					$y++;
				}
			}
			$x = $zp/$y;

			echo "<form onSubmit='return del()' method='post' action='master_zp.php?id=".$r[id]."&summa=".$zp."'>";
			echo "<tr>";
			echo "<td>";
			echo $r[id];
			echo "</td>";
			echo "<td>";
			echo $r[name];
			echo "</td>";
			echo "<td>";
			echo ceil($x);
			echo "</td>";
			echo "<td>";
			
			if($zp!=0){
				echo date_s($date_s);
				echo " - ";
				echo date_s(date(Ymd));
			}
			
			echo "</td>";
			echo "<td>";
			echo $i;
			echo "</td>";
			echo "<td>";
			echo "<span style='font-weight:bold;'>".ceil($zp)." грн.</span>";
			echo "</td>";
			echo "<td>";
			if($zp!=0){
			echo "<input type='submit' name='submit' style='padding:4px;' value='Заплатить'>";
			}
			echo "</td>";
			echo "</tr>";
			echo "</form>";
	}
?>
	</table>
	
	</td>
	</tr>
	</table>


</body>
</html>