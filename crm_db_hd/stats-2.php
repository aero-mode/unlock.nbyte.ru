<?php
// проверка авторизации
require "auth.php";
if($_SESSION['user_login']!='operator'){die;}
function T1($date_add, $date_go_work){
	if($date_go_work == null){return '-';}
	$date_add = strtotime($date_add);
	$date = $date_go_work - $date_add;
	$date = SecondesToTime($date);
	return $date;
}
function T2($date_go_work, $date_gotovo){
	if($date_gotovo == 0 || $date_go_work == NULL){return '-';}
	$date_gotovo = strtotime($date_gotovo);
	$date = $date_gotovo - $date_go_work;
	$date = SecondesToTime($date);
	return $date;
}
function T3($date_gotovo, $date_vida4i){
	if($date_gotovo == 0 || $date_vida4i == 0){return '-';}
	$date_gotovo = strtotime($date_gotovo);
	$date_vida4i = strtotime($date_vida4i);
	$date = $date_vida4i - $date_gotovo;
	$date = SecondesToTime($date);
	return $date;
}
function allTime($date_add, $date_vida4i){
	if($date_vida4i == 0){return '-';}
	$date_add = strtotime($date_add);
	$date_vida4i = strtotime($date_vida4i);
	$all_date = $date_vida4i - $date_add;
	$date = SecondesToTime($all_date);
	return $date;
}
function allTime2($date_go_work, $date_vida4i){
	if($date_vida4i == 0 || $date_go_work == null){return '-';}
	$date_vida4i = strtotime($date_vida4i);
	$all_date = $date_vida4i - $date_go_work;
	$date = SecondesToTime($all_date);
	return $date;
}
?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<title>Статистика по времени. Nanobyte</title>
	<link rel="stylesheet" type="text/css" href="main.css" />
	<script type='text/javascript' src='http://code.jquery.com/jquery-latest.min.js'></script>
	<script type='text/javascript' src='jquery.tablesorter.min.js'></script>
	<script type='text/javascript' src='jquery.metadata.js'></script>
<style>
	table.tablesorter {
		font-family:arial;
		/*background-color: #CDCDCD;*/
		margin:0 auto;
		font-size: 10pt;
		max-width: 1024px;
		min-width: 800px;
		text-align: left;
	}
	table.tablesorter thead tr th, table.tablesorter tfoot tr th {
		background-color: #e6EEEE;
		font-size: 10pt;
		padding: 5px;
		text-align:center;
	}
	table.tablesorter thead tr .header {
		background-image: url(bg.gif);
		background-repeat: no-repeat;
		background-position: center right;
		cursor: pointer;
	}
	table.tablesorter tbody td {
		color: #3D3D3D;
		padding: 2px 5px;
		/*background-color: #FFF;*/
		vertical-align: top;
	}
	table.tablesorter tbody tr.odd td {
		background-color:#F0F0F6;
	}
	table.tablesorter thead tr .headerSortUp {
		background-image: url(asc.gif);
	}
	table.tablesorter thead tr .headerSortDown {
		background-image: url(desc.gif);
	}
	table.tablesorter thead tr .headerSortDown, table.tablesorter thead tr .headerSortUp {
	background-color: #8dbdd8;
	}
</style>
<script type='text/javascript'> 
$(document).ready(function(){
		$(".tablesorter").tablesorter(); 
});
</script> 

</head>

<body>

<div class="top_menu">
	<ul>
		<li><a href="task_add.php">Добавить задачу</a></li>
		<li><a href="task.php">Список задач</a></li>
	</ul>
</div>

<table width="100%" border="1" class="tablesorter">
	<thead>
		<tr>
			<th style="width:50px;">id</th>
			<th>Добавлен</th>
			<th>T1 (Нулевой->СЦ_принято)</th>
			<th>Дано</th>
			<th>T2 (СЦ_принято->Готово)</th>
			<th>T3 (Готово->Выдан)</th>
			<th>Время от начала работы до выдачи (T2+T3)</th>
			<th>Общее время (T1+T2+T3)</th>
			<th>Статус</th>
		</tr>
	</thead>
	<tbody><?
	$res = mysql_query("SELECT task.id as task_id,task.type_of_work as type_of_work,task.date_add as date_add,task.time_add as time_add,task.date_go_work as date_go_work,task.term_of_work as term_of_work,task.date_gotovo as date_gotovo,task.time_gotovo as time_gotovo,task.date_vida4i as date_vida4i,task.time_vida4i as time_vida4i,status.id as status,status.text as status_text,status.bgcolor as bgcolor FROM task,status WHERE task.visible=1 AND status.id=task.status AND task.date_add>20131029 ORDER BY task.id DESC") or die(mysql_error());
	while($row = mysql_fetch_array($res)){
		$date_add = strtotime($row['date_add'].$row['time_add']);
		$date_add = date('d.m.Y H:i', $date_add);
		

	?>
		<tr>
			<td style="width:50px;text-align:center"><?=$row['task_id'];?></td>
			<td style="width:115px;text-align:center"><?=$date_add;?></td>
			<td><?=T1($row['date_add'].$row['time_add'], $row['date_go_work']);?></td>
			<td style="width:55px;"><?=$row['term_of_work'];?></td>
			<td><?=T2($row['date_go_work'], $row['date_gotovo'].$row['time_gotovo']);?></td>
			<td><?=T3($row['date_gotovo'].$row['time_gotovo'], $row['date_vida4i'].$row['time_vida4i']);?></td>
			<td><?=allTime2($row['date_go_work'], $row['date_vida4i'].$row['time_vida4i']);?></td>
			<td><?=allTime($row['date_add'].$row['time_add'], $row['date_vida4i'].$row['time_vida4i']);?></td>
			<td style="width:80px;text-align:center;background:<?=$row['bgcolor'];?>"><?=$row['status_text'];?></td>
		</tr>
	<?}?></tbody>
</table>

</body>
</html>