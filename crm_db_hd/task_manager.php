<?php
// проверка авторизации
require "auth.php";

if($_SESSION['user_login']!='ghost'){die;}
/*
// удаление задачи
if($_GET[a]=='del' AND $_GET[id]!=''){
	$query = "UPDATE task SET visible='0' WHERE id=".mysql_real_escape_string($_GET['id']);
	$res = mysql_query($query) or die(mysql_error()); 
	header("location:task.php");
}

// ок
if($_GET[a]=='ok' AND $_GET[id]!=''){
	$query = "UPDATE task SET status='6' WHERE id=".mysql_real_escape_string($_GET['id']);
	$res = mysql_query($query) or die(mysql_error()); 
	header("location:task.php");
}*/
?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<title>Управление задачами. Nanobyte</title>
	<link rel="stylesheet" type="text/css" href="main.css" />
	<script type='text/javascript' src='http://code.jquery.com/jquery-latest.min.js'></script>
	<script type='text/javascript' src='jquery.tablesorter.min.js'></script>
	<script type='text/javascript' src='jquery.metadata.js'></script>
	<style>
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
		font-size: 8pt;
		padding: 2px;
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
		padding: 2px;
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
	function del(){if(confirm("Удалить?")){return true;}else{return false;}} 
	</script> 
	
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

<div class="top_menu">
	<ul>
	<li><a href="task_add.php">Добавить задачу</a></li>
<?if(isset($_GET['filter'])){
	switch ($_GET['filter']){
		case 'type_of_work-1':
			echo '<li><a href="task_manager.php">Назад</a> / <a href="?filter=type_of_work-2">Ремонт</a></li>';
			break;
		case 'type_of_work-2':
			echo '<li><a href="?filter=type_of_work-1">Восстановление</a> / <a href="task_manager.php">Назад</a></li>';
			break;
	}
}else{?>
	<li><a href="?filter=type_of_work-1">Восстановление</a> / <a href="?filter=type_of_work-2">Ремонт</a></li>
<?}?>
<li style="float:right"><a href="?action=logout">Выход</a></li>
<?if(isset($_GET['view']) && $_GET['view']=='vydan'){?>
	<li style="float:right"><a href="task_manager.php">Назад</a></li>
<?}else{?>
	<li style="float:right"><a href="?view=vydan">Показать выданные</a></li>
<?}?>
	</ul>
</div>

<table width="100%" border="1" class="tablesorter">
	<thead>
		<tr>
			<th class="{sorter: false}"></th>
			<th>ID</th>
			<th>Дата</th>
			<th>Имя</th>
			<th>Телефон</th>
			
			<th class="{sorter: false}">S/N</th>
			<th class="{sorter: false}">Модель</th>
			<th>Вид работ</th>
			<th>Времени осталось</th>
			<th class="{sorter: false}">Емкость</th>
			
			<th class="{sorter: false}">Описание</th>
			<th class="{sorter: false}">Коментарий для клиента</th>
			
			<th class="{sorter: false}">Сумма пред-ная</th>
			<th class="{sorter: false}">Куплен</th>
			<th class="{sorter: false}">Сумма финал</th>
			<th>Статус</th>
			<th class="{sorter: false}">Дата выдачи</th>
			<th class="{sorter: false}">Стоимость</th>
			<th class="{sorter: false}">Акт приёма</th>
			<th class="{sorter: false}">Акт выдачи</th>
			<th class="{sorter: false}">смс</th>
		</tr>
	</thead>
	
	<?
	if(isset($_GET[filter])){
		$temp = explode("-",$_GET['filter']);
		$and = $temp[0]."=".$temp[1]." AND ";
	}
	
	
	if(isset($_GET['view']) && $_GET['view']=='vydan'){
		$res = mysql_query("SELECT * FROM task WHERE $and visible=1 AND status=7 ORDER BY id DESC");
	}else{
		$res = mysql_query("SELECT * FROM task WHERE $and visible=1 AND status!=7 ORDER BY id DESC");
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
				$time_left = 'C окончания ремонта прошло: '.$time_left;
				break;
			case 6:
				$time = strtotime($row['date_gotovo'].$row['time_gotovo']);
				$time = time() - $time;
				$time_left = SecondesToTime($time);
				$time_left = 'C окончания ремонта прошло: '.$time_left;
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
		<tr style="<?if($row['status']==10){?>background:#b8e4fa;<?}?><?if($row['prioritet']==1){?>font-weight:bold;;<?}?>">
		<td><a title="править" href="task_edit.php?id=<?=$row['id']?>"><img src="ico_edit.gif"></a></td>
		<td><?=$row['id']?></td>
		<td><?=substr($row['date_add'],6,2)?>.<?=substr($row['date_add'],4,2)?></td>
		<td><?=$row['client_name']?></td>
		<td><a href="?filter=client_phone-<?=$row['client_phone']?>"><?=$row['client_phone']?></a></td>
		<td style="text-align:center;"><?=$row['sn']?></td>
		<td><?=$row['model']?></td>
		<td style="width:100px;text-align:center;"><a href="?filter=type_of_work-<?echo $row['type_of_work'];?>"><?echo $type_of_work;?></a></td>
		<td style="width:130px;text-align:center;"><?=$time_left?></td>
		<td style="text-align:center;"><a href="?filter=size-<?=$row['size']?>"><?=$row['size']?></a></td>
		<td><?=$row['description']?></td>
		<td><?=$row['comment_for_client']?></td>
		<td><?=$row['summa_predvarit']?></td>
		<td><?=$row['buy_number']?></td>
		<td><?=$row['summa_final']?></td>
		<td style="background:<?=$bgcolor?>"><?=$status?></td>
		<td><?=substr($row['date_vida4i'],6,2)?>.<?=substr($row['date_vida4i'],4,2)?></td>
		<td><?=$row['summa_sale']?> грн.</td>
		<td style="text-align:center;"><a target="blank" href="reception_act.php?id=<?=$row['id']?>">Акт приёма</a></td>
		<td style="text-align:center;"><a target="blank" href="release_act.php?id=<?=$row['id']?>">Акт выдачи</a></td>
		<td><a target="blank" href="send_sms.php?phone=<?=$row['client_phone']?>">смс</a></td>
		</tr>
		<?
	}

	?>
	
</table>
</body>
</html>
