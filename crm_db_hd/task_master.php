<?php
// проверка авторизации
require "auth.php";
if($_SESSION['user_login']!='master'){die;}

/*
// принял задачу
if($_GET[a]=='start' AND $_GET[id]!=''){
	$query = "UPDATE task SET status='3' WHERE id=".mysql_real_escape_string($_GET[id]);
	$res = mysql_query($query) or die(mysql_error()); 
	header("location:task_master.php");
}
*/

// сдал задачу (готово)
if($_GET[a]=='end' AND $_GET[id]!=''){
	$query = "UPDATE task SET status='4',date_gotovo='".date('Ymd')."',time_gotovo='".date('Hi')."' WHERE id=".mysql_real_escape_string($_GET[id]);
	$res = mysql_query($query) or die(mysql_error()); 
		
	header("location:task_master.php");
	
	/*
	// формируем и отправляем скриптом смс-скидку на шлюз..	
	include_once "smsc_api.php";
	
	$res = mysql_query("SELECT * FROM task WHERE id='".mysql_real_escape_string($_GET[id])."'");
	$row = mysql_fetch_array($res);
	
	if($row['prioritet']==1){
		$sms_v = " / hot";
	}
	
	$phone = "+380997190622";
	$msg = "hdd: < ".$row['id'].$sms_v;
	send_sms($phone, $msg, 1);
	*/
}
?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<title>Управление задачами. Nanobyte</title>
	<script type='text/javascript' src='http://code.jquery.com/jquery-latest.min.js'></script>
	<script type='text/javascript' src='jquery.tablesorter.min.js'></script>
	<script type='text/javascript' src='jquery.metadata.js'></script>
	<link rel="stylesheet" type="text/css" href="main.css" />

	<style>
	table, table td {
		border-collapse:collapse;
	}
	
	table td {
		padding:3px;
	}

	table.tablesorter {
		font-family:arial;
		/*background-color: #CDCDCD;*/
		margin:10px 0pt 15px;
		font-size: 8pt;
		width: 100%;
		text-align: left;
	}
	table.tablesorter thead tr th, table.tablesorter tfoot tr th {
		background-color: #e6EEEE;
		border: 1px solid #FFF;
		font-size: 8pt;
		padding: 4px;
	}
	table.tablesorter thead tr .header {
		background-image: url(bg.gif);
		background-repeat: no-repeat;
		background-position: center right;
		cursor: pointer;
	}
	table.tablesorter tbody td {
		color: #3D3D3D;
		padding: 4px;
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
		.pagination{
			width: 100%;
			height: 25px;
			margin: 10px 0;
		}
		.pagination ul li{
			list-style: none;
			float: left;
		}
		.active a, .inactive a{
			border: 1px solid #006699;
			padding: 2px 6px 2px 6px;
			margin: 0 3px 0 3px;
			font-family: arial;
			font-size: 14px;
			font-weight: bold;
		}
		.active a{
			color: #fff;
			background-color: #006699;
		}
		.inactive a:hover {
			color: #fff;
			background-color: #006699;
		}
	</style>
	
	<script type='text/javascript'> 
	function v(){if(confirm("Уверены?")){return true;}else{return false;}} 
	</script> 
<script type='text/javascript'> 
$(document).ready(function(){
		$(".tablesorter").tablesorter(); 
});
</script> 
	
</head>

<body>

<table width="100%">
<tr>
<td>
Задачи выделенные жирным шрифтом на сером фоне - высокоприоритетные.
</td>

<td><a href="task_master.php">Совместно</a></td>


<?if(isset($_GET['filter'])){
	switch ($_GET['filter']){
		case 'type_of_work-1':
			echo '<td><a href="task_master.php">Назад</a> / <a href="?filter=type_of_work-2">Ремонт</a></td>';
			break;
		case 'type_of_work-2':
			echo '<td><a href="?filter=type_of_work-1">Восстановление</a> / <a href="task_master.php">Назад</a></td>';
			break;
	}
}else{?>
	<td><a href="?filter=type_of_work-1">Восстановление</a> / <a href="?filter=type_of_work-2">Ремонт</a></td>
<?}?>
<td align="right"><?if($_GET['view']!='all'){?><a href="?view=all">Показать все</a><?}else{?><a href="task_master.php">Назад</a><?}?></td>
<td align="right"><a href="?action=logout">Выход</a></td>
</tr>
</table>
<?
if(isset($_GET['view']) && $_GET['view'] == 'all'){
			if(isset($_GET['page'])){
				$page = intval($_GET['page']);
			}else{
				$page = 1;
			}
			$per_page = 100;
			$cur_page = $page;
			$page -= 1;
			$start = $page * $per_page;
			$query_pag_num = "SELECT COUNT(id) as count FROM task WHERE visible=1 AND status!=0 AND status!=1 AND status!=3 AND status!=4 AND status!=11 ORDER BY id DESC";
			$vydanLink = "&view=all";
			$result_pag_num = mysql_query($query_pag_num);
			$row = mysql_fetch_array($result_pag_num);
			$count = $row['count'];
			$no_of_paginations = ceil($count / $per_page);
				/* ---------------Calculating the starting and ending values for the loop----------------------------------- */
			if ($cur_page >= 30) {
				$start_loop = $cur_page - 12;
				if ($no_of_paginations > $cur_page + 12)
					$end_loop = $cur_page + 12;
				else if ($cur_page <= $no_of_paginations && $cur_page > $no_of_paginations - 24) {
					$start_loop = $no_of_paginations - 24;
					$end_loop = $no_of_paginations;
				} else {
					$end_loop = $no_of_paginations;
				}
			} else {
				$start_loop = 1;
				if ($no_of_paginations > 30)
					$end_loop = 30;
				else
					$end_loop = $no_of_paginations;
			}
			/* ----------------------------------------------------------------------------------------------------------- */
			
			for ($i = $start_loop; $i <= $end_loop; $i++) {
				if ($cur_page == $i){
					$msg[$i]['page'] = $i;
					$msg[$i]['active'] = 1;
				}else{
					$msg[$i]['page'] = $i;
					$msg[$i]['active'] = 0;
				}
			}
			$limittt = "LIMIT  $start, $per_page";
	?>
	<div class="pagination">
		<ul>
		<?
		if(count($msg)!=0){
			foreach($msg as $valll){
				if($valll['active']==1){?>
					<li class="active"><a><?=$valll['page']?></a></li>
				<?}else{?>
					<li class="inactive"><a href="?page=<?=$valll['page']?><?=$vydanLink?>"><?=$valll['page']?></a></li>
				<?}
			}
		}?>
		</ul>
	</div>
<?}?>
<table width="100%" border="1" style="margin-top:10px;" class="tablesorter<?if($_GET['view'] != 'all'){?> {sortlist: [[1,1]]}<?}?>">
	
		<thead>
		<tr>
			<th class="{sorter: false}" style="width:10px;"></th>
			<th style="width:40px;text-align:center;">ID</th>
			<th style="width:100px;text-align:center;">Дата</th>
			<th class="{sorter: false}">S/N</th>
			<th class="{sorter: false}">Модель</th>
			<th style="width:130px;text-align:center;">Вид работ</th>
			<th style="width:130px;text-align:center;">Времени осталось</th>
			<th class="{sorter: false}">Описание</th>
			<th class="{sorter: false}">Мастер сделал</th>
			<th class="{sorter: false}">Сумма-мастер</th>
			<th>Статус</th>
			<th class="{sorter: false}"></th>
		</tr>
	</thead>
	
	
	<?
	if(isset($_GET['filter'])){
		$temp = explode("-",$_GET['filter']);
		$and = $temp[0]."=".$temp[1]." AND ";
	}
	if($_GET['view']=='all'){
		$res = mysql_query("SELECT * FROM task WHERE $and visible=1 AND status!=0 AND status!=1 AND status!=3 AND status!=4 AND status!=11 ORDER BY id DESC $limittt") or die(mysql_error());
	}else{
		$res = mysql_query("SELECT * FROM task WHERE $and visible=1 AND status!=0 AND status!=6 AND status!=7 AND status!=10 AND status!=11 ORDER BY id DESC");
	}
	
	while($row = mysql_fetch_array($res)){
	
		$res2 = mysql_query("SELECT * FROM status WHERE id=".$row['status']);
		$row2 = mysql_fetch_array($res2);
		$status = $row2['text'];
		$bgcolor = $row2['bgcolor'];
		switch ($row['type_of_work']){
			case 0:
				$type_of_work ='';
				break;
			case 1:
				$type_of_work = 'Восстановление';
				break;
			case 2:
				$type_of_work = 'Ремонт';
				break;
		}
				switch ($row['status']){
			case 0:
				$time = strtotime($row['date_add'].$row['time_add']);
				$time = time() - $time;
				$time_left = SecondesToTime($time);
				$time_left = 'Диск добавлен: '.$time_left.' назад';
				break;
			case 1:
				if($row['date_go_work'] == NULL){$time_left = '-';break;}
				$time = $row['date_go_work'] + ($row['term_of_work']*86400);
				$time =  $time - time();
				$time_left = SecondesToTime($time);
				$time_left = '<div style="display:none">'.$time.'</div>'.$time_left;
				break;
			case 3:
				if($row['date_go_work'] == NULL){$time_left = '-';break;}
				$time = $row['date_go_work'] + ($row['term_of_work']*86400);
				$time =  $time - time();
				$time_left = SecondesToTime($time);
				$time_left = '<div style="display:none">'.$time.'</div>'.$time_left;
				break;
			case 4:
				$time = strtotime($row['date_gotovo'].$row['time_gotovo']);
				$time = time() - $time;
				$time_left = SecondesToTime($time);
				$time_left = '<div style="display:none">9999999999</div>Готово';
				break;
			case 6:
				$time = strtotime($row['date_gotovo'].$row['time_gotovo']);
				$time = time() - $time;
				$time_left = SecondesToTime($time);
				$time_left = '<div style="display:none">9999999999</div>Готово';
				break;
			case 7:
				$time_left = 'Диск выдан';
				break;
			case 10:
				$time_left = 'На запчасти';
				break;
			case 11:
				$time_left = 'На продажу';
				break;
		}

		?>
		<tr <?if($row['prioritet']==1){?>style="background:#eee;font-weight:bold;;"<?}?>>
		<td><a title="править" href="task_master_edit.php?id=<?=$row['id']?>"><img src="ico_edit.gif"></a></td>
		<td style="width:40px;text-align:center;"><?=$row['id']?></td>
		<td style="width:100px;text-align:center;"><?=substr($row['date_add'],6,2)?>.<?=substr($row['date_add'],4,2)?> / <?=substr($row['time_add'],0,2)?>:<?=substr($row['time_add'],2,2)?></td>
		<td style="width:70px;text-align:center;"><?=$row['sn']?></td>
		<td style="width:150px;text-align:center;"><?=$row['model']?></td>
		<td style="width:130px;text-align:center;"><a href="?filter=type_of_work-<?echo $row['type_of_work'];?>"><?echo $type_of_work;?></a></td>
		<td style="width:130px;text-align:center;"><?=$time_left;?></td>
		<td><?=$row['description']?></td>
		<td><?=$row['master_sdelal']?></td>
		<td><?=$row['summa_master']?></td>
		<td style="background:<?=$bgcolor?>"><?=$status?></td>
		<td><?if($row[status]==3 AND $row['master_sdelal']!=''){?><a onClick='return v();' href="?a=end&id=<?=$row['id']?>">Готово!</a><?}?></td>
		</tr>
		<?
	}

	?>
	
</table>

</body>
</html>