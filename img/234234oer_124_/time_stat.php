<?
include "connect2db.php";
connect();
if(!isset($_GET['data_stat'])){
	$curDate = date("Ym");
}else{
	$curDate = $_GET['data_stat'];
}
$daysNum = date("t", strtotime($curDate."01"));
$year = substr($curDate, 0, 4);
$month = substr($curDate, 4, 6);
$monthName = date_s($curDate);
$table = "";
$countAll = array();
$countAll2 = array();
$bonusAll = array();
for($i = 1; $i<=$daysNum; $i++){
	(strlen($i)<2)?$i2="0".$i:$i2=$i;
	$queryText = "SELECT COUNT(id) as count FROM clients_sc WHERE date_add = '".$year.$month.$i2."'";
	$query = mysql_query($queryText);
	$row = mysql_fetch_assoc($query);
	$queryText2 = "SELECT COUNT(id) as count FROM clients_sc WHERE date_end = '".$year.$month.$i2."'";
	$query2 = mysql_query($queryText2);
	$row2 = mysql_fetch_assoc($query2);
	if($row['count']<=5){
		$bonus = "0";
	}elseif($row['count']>5 && $row['count']<10){
		$bonus = "50";
	}elseif($row['count']>=10 && $row['count']<=15){
		$bonus = "100";
	}else{
		$bonus = "300";
	}
	if($row2['count']<=5){
		$bonus2 = "0";
	}elseif($row2['count']>5 && $row2['count']<10){
		$bonus2 = "50";
	}else{
		$bonus2 = "100";
	}
	$countAll[] = $row['count'];
	$countAll2[] = $row2['count'];
	$bonusAll[] = $bonus;
	$bonusAll2[] = $bonus2;
	$table .= "<tr>";
	$table .= "<td style=\"padding:3px;\">".$i." ".$monthName."</td>";
	$table .= "<td style=\"padding:3px;text-align:right;\">".$row['count']."</td>";
	$table .= "<td style=\"padding:3px;text-align:right;\">".$bonus."</td>";
	$table .= "<td style=\"padding:3px;text-align:right;\"></td>";
	$table .= "<td style=\"padding:3px;text-align:right;\">".$row2['count']."</td>";
	$table .= "<td style=\"padding:3px;text-align:right;\">".$bonus2."</td>";
	$table .= "</tr>";
	if($i2 == date("d") && !isset($_GET['data_stat'])){
		break;
	}

}
?>
<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>Статистика. Nanobyte</title>
	<link rel="stylesheet" type="text/css" href="reset.css" />
	<link rel="stylesheet" type="text/css" href="main.css" />
	<script type="text/javascript" src="jquery.js"></script>
<style>
.tab table, .tab tr, .tab td, .tab th {
	border: 1px solid black;
	padding:5px;
}
.tab th {
	background-color:#eee;
	text-align:center;
	font-weight:bold;
}
</style>
</head>
<body style="padding:20px;padding-top:0;">
	<table width="100%" border="0" style="margin-top:20px;border-bottom:2px solid #006699;">
		<tr>
			<td  valign="top" height="1" colspan="4">
				<h1 style="margin:0;margin-bottom:20px;margin-left:20px;">База клиентов</h1>
			</td>
			<td align="right" valign="top" height="1"></td>
		</tr>
	</table>
	<table width="100%" border="0">
		<tr>
			<td valign="top">
				<h1 style="margin-bottom:25px;">Статистика бонусов / <a href="stat_r.php">Статистика по деньгам</a></h1>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<table class="tab">
					<tr>
						<th>День</th>
						<th>Кол-во принятых</th>
						<th>Бонус</th>
						<th style="width:50px;"></th>
						<th>Кол-во выполненых</th>
						<th>Бонус</th>
					<tr>
					<?=$table?>
					<tr>
						<th>Итого</th>
						<th><?=array_sum($countAll)?></th>
						<th><?=array_sum($bonusAll)?></th>
						<th></th>
						<th><?=array_sum($countAll2)?></th>
						<th><?=array_sum($bonusAll2)?></th>
					<tr>
				</table>
			</td>
			<td valign="top">
				<div style=""><a href="?data_stat=201401">январь 2014</a></div>
				<div style=""><a href="?data_stat=201402">февраль 2014</a></div>
				<div style=""><a href="?data_stat=201403">март 2014</a></div>
				<div style=""><a href="?data_stat=201404">апрель 2014</a></div>
				<div style=""><a href="?data_stat=201405">май 2014</a></div>
				<div style=""><a href="?data_stat=201406">июнь 2014</a></div>
				<div style=""><a href="?data_stat=201407">июль 2014</a></div>
				<div style=""><a href="?data_stat=201408">август 2014</a></div>
				<div style=""><a href="?data_stat=201409">сентябрь 2014</a></div>
				<div style=""><a href="?data_stat=201410">октябрь 2014</a></div>
				<div style=""><a href="?data_stat=201411">ноябрь 2014</a></div>
				<div style=""><a href="?data_stat=201412">декабрь 2014</a></div>
			</td>
		</tr>
	</table>
</body>
</html>