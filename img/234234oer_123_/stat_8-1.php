<?
// проверка авторизации
//require "auth.php";
include "connect2db.php";
connect();
?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>Статистика. Nanobyte</title>
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
	<h1 style="margin:0;margin-bottom:20px;margin-left:20px;"><a href="interface_admin_nb_8.php">База клиентов</a></h1>
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

<h1 style="margin-bottom:25px;">Статистика</h1>


<?
	$s = mysql_query("SELECT id FROM clients WHERE show1=1");
	$vsego = mysql_num_rows($s);
	
	$s = mysql_query("SELECT id FROM clients WHERE show1=1 AND date_oplata=''");
	$open = mysql_num_rows($s);
	
	$s = mysql_query("SELECT id FROM clients WHERE show1=1 AND status=0");
	$og = mysql_num_rows($s);
	
	$s = mysql_query("SELECT id FROM clients WHERE show1=1 AND status=1");
	$work = mysql_num_rows($s);
	
	$dengi = $open - ($work+$og);
	
	if(isset($_GET[data_stat])){
		$xxx = $_GET[data_stat];
	}else{
		$xxx = date('Ym');
	}
	$s01 = mysql_query("SELECT id FROM clients WHERE show1=1 AND date_oplata!=0 AND date_oplata LIKE '".$xxx."%'");
	$s0 = mysql_query("SELECT date_oplata, SUM(cena_work), SUM(cena_hard) FROM clients WHERE show1=1 AND date_oplata!=0 AND date_oplata LIKE '".$xxx."%' GROUP BY date_oplata");

	$count_curr_m = mysql_num_rows($s0);
	
		$alltable.= "<table border='1'>";
		$alltable.= "<tr><td style='background:#eee;padding:4px;'>дата</td><td style='background:#eee;padding:4px;'>работа</td><td style='background:#eee;padding:4px;'>железо</td><td style='background:#eee;padding:4px;'>всего</td></tr>";

	
	while($r0 = mysql_fetch_array($s0)){
	
		$all_work+=$r0[1];
		$all_hard+=$r0[2];

		$alltable.= "<tr>";
		$alltable.= "<td style='padding:3px;'>";
		$alltable.= date_s($r0[0]);
		$alltable.= "</td><td style='padding:3px;'>";
		$alltable.= $r0[1]." грн.";
		$alltable.= "</td><td style='padding:3px;'>";
		$alltable.= $r0[2]." грн.";
		$alltable.= "</td><td style='font-weight:bold;padding:3px;'>";
		$alltable.= ($r0[1]+$r0[2])." грн.";
		$alltable.= "</td>";
		$alltable.= "</tr>";
	}
	$alltable.= "</table>";
?>
<table>
<tr>
<td>

<select id="data_stat" name="data_stat">
<option value="201201">Январь 2012</option>
<option value="201202">Февраль 2012</option>
<option value="201203">Март 2012</option>
<option value="201204">Апрель 2012</option>
<option value="201205">Май 2012</option>
<option value="201206">Июнь 2012</option>
<option value="201207">Июль 2012</option>
<option value="201208">Август 2012</option>
<option value="201209">Сентябрь 2012</option>
<option value="201210">Октябрь 2012</option>
<option value="201211">Ноябрь 2012</option>
<option value="201212">Декабрь 2012</option>

<option value=""></option>

<option value="201301">Январь 2013</option>
<option value="201302">Февраль 2013</option>
<option value="201303">Март 2013</option>
<option value="201304">Апрель 2013</option>
<option value="201305">Май 2013</option>
<option value="201306">Июнь 2013</option>
<option value="201307">Июль 2013</option>
<option value="201308">Август 2013</option>
<option value="201309">Сентябрь 2013</option>
<option value="201310">Октябрь 2013</option>
<option value="201311">Ноябрь 2013</option>
<option value="201312">Декабрь 2013</option>


</select>

<br>
<b><?=mysql_num_rows($s01)?></b> завершенных задач.
<br>
Работа: <b><?=$all_work?></b> грн., железо: <b><?=$all_hard?></b> грн.<br><br>

<script>
$('#data_stat').val('<?=$_GET[data_stat]?>');
$('#data_stat').bind("change", function(){
	var xxx = $("select#data_stat").val();
	location.href="http://nanobyte.com.ua/img/234234oer_123/stat_8.php?data_stat="+xxx;
});
</script>

<?=$alltable?>
<br><br>



</td>
<td valign="top" style="padding-left:50px;">
<div style="background:#eee;padding:15px;">
<b>Всего задач: <?=$vsego?><br></b>
Активные: <?=$open?><br>
Деньги не сданы за: <?=$dengi?><br><br>

Ожидает решения: <?=$og?><br>
В работе: <?=$work?>
</div>
</td>
</tr>
</table>

	
	</td>
	</tr>
	</table>


</body>
</html>