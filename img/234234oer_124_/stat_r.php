<?
// проверка авторизации
//require "auth.php";
error_reporting(0);
include "connect2db.php";
connect();
	$s = mysql_query("SELECT id FROM clients_sc WHERE status=2 AND show1=1 AND date_add>='20140609'");
	$vsego = mysql_num_rows($s);
	
	$s = mysql_query("SELECT id FROM clients_sc WHERE show1=1 AND date_oplata='' AND date_add>='20140609'");
	$open = mysql_num_rows($s);
	
	$s = mysql_query("SELECT id FROM clients_sc WHERE show1=1 AND status=0 AND date_add>='20140609'");
	$og = mysql_num_rows($s);
	
	$s = mysql_query("SELECT id FROM clients_sc WHERE show1=1 AND status=1 AND date_add>='20140609'");
	$work = mysql_num_rows($s);
	
	$dengi = $open - ($work+$og);

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
$workAll = array();
$hardAll = array();
$countAll = array();
$fullArr = array();
for($i = 1; $i<=$daysNum; $i++){
	(strlen($i)<2)?$i="0".$i:$i=$i;
	$query = mysql_query("SELECT COUNT(id) as count, SUM(cena_hard) as cena_hard, SUM(cena_work) as cena_work FROM clients_sc WHERE status=2 AND show1=1 AND date_oplata='".$year.$month.$i."'");
	$row = mysql_fetch_assoc($query);
	$query2 = mysql_query("SELECT id, device_type, find_out, cena_hard, cena_work FROM clients_sc WHERE status=2 AND show1=1 AND date_oplata='".$year.$month.$i."'");
	while($row2 = mysql_fetch_assoc($query2)){
		$fullArr[$row2['id']] = array("device_type" => $row2['device_type'], "find_out" => $row2['find_out'], "cena_work" => $row2['cena_work'], "cena_hard" => $row2['cena_hard'], "all" => ($row2['cena_hard']+$row2['cena_work']));
	}
	($row['cena_hard'] == "")?$row['cena_hard']=0:$row['cena_hard']=$row['cena_hard'];
	($row['cena_work'] == "")?$row['cena_work']=0:$row['cena_work']=$row['cena_work'];
	$workAll[] = $row['cena_work'];
	$hardAll[] = $row['cena_hard'];
	$countAll[] = $row['count'];
	$table .= "<tr>";
	$table .= "<td style=\"padding:3px;\">".$i." ".$monthName."</td>";
	$table .= "<td style=\"padding:3px;text-align:right;\">".$row['cena_work']." руб."."</td>";
	$table .= "<td style=\"padding:3px;text-align:right;\">".$row['cena_hard']." руб."."</td>";
	$table .= "<td style=\"padding:3px;text-align:right;\">".($row['cena_hard']+$row['cena_work'])." руб."."</td>";
	$table .= "</tr>";
	if($i == date("d") && !isset($_GET['data_stat'])){
		break;
	}
}
foreach($fullArr as $key => $value){
	if($fullArr[$key]['all'] == 0){
		$arr_0[]=$value;
	}elseif($fullArr[$key]['all']>=1 && $fullArr[$key]['all']<=250){
		$arr_1_250[]=$value;
	}elseif($fullArr[$key]['all']>=251 && $fullArr[$key]['all']<=1000){
		$arr_251_1000[]=$value;
	}else{
		$arr_1001[]=$value;
	}
	if($fullArr[$key]['device_type'] == "Ноутбук")
		$dev_1[] = $value;
	elseif($fullArr[$key]['device_type'] == "ПК")
		$dev_2[] = $value;
	elseif($fullArr[$key]['device_type'] == "Планшет")
		$dev_3[] = $value;
	elseif($fullArr[$key]['device_type'] == "Монитор")
		$dev_4[] = $value;
	elseif($fullArr[$key]['device_type'] == "Смартфон")
		$dev_5[] = $value;
	elseif($fullArr[$key]['device_type'] == "UPS")
		$dev_6[] = $value;
	elseif($fullArr[$key]['device_type'] == "Фотоаппарат")
		$dev_7[] = $value;
	elseif($fullArr[$key]['device_type'] == "Принтер")
		$dev_8[] = $value;
	else
		$dev_9[] = $value;
	
	if($fullArr[$key]['find_out'] == "Интернет")
		$fo_1[] = $value;
	elseif($fullArr[$key]['find_out'] == "Порекомендовали")
		$fo_2[] = $value;
	elseif($fullArr[$key]['find_out'] == "Постоянный клиент")
		$fo_3[] = $value;
	elseif($fullArr[$key]['find_out'] == "Проходил мимо")
		$fo_4[] = $value;
	elseif($fullArr[$key]['find_out'] == "РадиоРынок")
		$fo_5[] = $value;
	elseif($fullArr[$key]['find_out'] == "По гарантии")
		$fo_6[] = $value;
	else
		$fo_7[] = $value;
}
function workSr($array){
	$x = 0;
	foreach($array as $key => $value){
		$x += $value['cena_work'];
	}
	return $x;
}
function hardSr($array){
	$x = 0;
	foreach($array as $key => $value){
		$x += $value['cena_hard'];
	}
	return $x;
}
function allSr($array){
	$x = 0;
	foreach($array as $key => $value){
		$x += $value['all'];
	}
	return $x;
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
	<script type="text/javascript"> 
		$(document).ready(function(){
			$('#data_stat').val('<?=$curDate?>');
			$('#data_stat').bind("change", function(){
				var xxx = $("select#data_stat").val();
				location.href="http://nanobyte.com.ua/img/234234oer_124/stat_r.php?data_stat="+xxx;
			});
			$('#shortLink').bind("click", function(){
				$('#short').show();
				$('#full').hide();
				$(this).removeClass();
				$('#fullLink').addClass("dashed");
			});
			$('#fullLink').bind("click", function(){
				$('#full').show();
				$('#short').hide();
				$(this).removeClass();
				$('#shortLink').addClass("dashed");
			});
		});
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
.dashed{
	border-bottom: 1px dashed;
}
#links a:link {text-decoration:none;}
#links a:visited {text-decoration:none;}
#links a:hover {text-decoration:none;}
#links a:active {text-decoration:none;}
.tabb td{
	padding:5px;
	border: 1px solid black;
}
.tabb td.dev{
	font-weight:bold;
}
.tabb th{
	padding:5px;
	font-weight:bold;
	border: 1px solid black;
}
</style>

</head>

<body style="padding:20px;padding-top:0;">

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
			<h1 style="margin-bottom:25px;"><a href="time_stat.php">Статистика бонусов</a> / Статистика по деньгам</h1>
			<table>
				<tr>
					<td valign="top">
						<select id="data_stat" name="data_stat">
							<optgroup label="2014">
								<option value="201406">Июнь 2014</option>
								<option value="201407">Июль 2014</option>
								<option value="201408">Август 2014</option>
								<option value="201409">Сентябрь 2014</option>
								<option value="201410">Октябрь 2014</option>
								<option value="201411">Ноябрь 2014</option>
								<option value="201412">Декабрь 2014</option>
							</optgroup>
						</select>
						<div style="margin:0;">
							<br>
							<b><?=array_sum($countAll)?></b> завершенных задач, из них <b><?=count($arr_0)?></b> нулевых.
							<br>
							Работа: <b><?=array_sum($workAll)?></b> руб., железо: <b><?=array_sum($hardAll)?></b> руб., всего: <b><?=(array_sum($workAll)+array_sum($hardAll))?></b><br><br>							
						</div>
						<table border="1">
							<tr>
								<td style="background:#eee;padding:4px;">дата</td>
								<td style="background:#eee;padding:4px;">работа</td>
								<td style="background:#eee;padding:4px;">железо</td>
								<td style="background:#eee;padding:4px;">всего</td>
							</tr>
							<?=$table?>
						</table>
					</td>
					<td style="padding-left:50px;width:400px;" valign="top">
						<div style="background:#eee;padding:15px;">
							<b>Всего задач: <?=$vsego?><br></b>
							Активные: <?=$open?><br>
							Деньги не сданы за: <?=$dengi?><br><br>

							Ожидает решения: <?=$og?><br>
							В работе: <?=$work?>
						</div>
						<div id="links">
							<a id="shortLink" href="javascript:void(0)">Коротко:</a> или <a class="dashed" id="fullLink" href="javascript:void(0)">Подробно:</a>
						</div>
						<div id="short">
							<b>средний чек:</b> <?=round((array_sum($workAll)+array_sum($hardAll))/array_sum($countAll), 2)?> руб.<br>
							<b>средний чек работа:</b> <?=round(array_sum($hardAll)/array_sum($countAll), 2)?> руб.<br>
							<b>средний чек железо:</b> <?=round(array_sum($workAll)/array_sum($countAll), 2)?> руб.<br>
						</div>
						<div id="full" style="display:none;">
							<b>нулевых: </b><?=count($arr_0)?><br>
							<b>от 1 до 250: </b><?=count($arr_1_250)?>, (ср. р: <?=round(workSr($arr_1_250)/count($arr_1_250), 2)?>, ср. ж.: <?=round(hardSr($arr_1_250)/count($arr_1_250), 2)?>)<br>
							<b>от 251 до 1000: </b><?=count($arr_251_1000)?>, (ср. р: <?=round(workSr($arr_251_1000)/count($arr_251_1000), 2)?>, ср. ж.: <?=round(hardSr($arr_251_1000)/count($arr_251_1000), 2)?>)<br>
							<b>от 1001: </b><?=count($arr_1001)?>, (ср. р: <?=round(workSr($arr_1001)/count($arr_1001), 2)?>, ср. ж.: <?=round(hardSr($arr_1001)/count($arr_1001), 2)?>)<br>
							<br>
							<br>
							<table class="tabb">
								<thead>
									<tr>
										<th>DEV</th>
										<th>Кол-во</th>
										<th>СР.</th>
										<th>СР. Р.</th>
										<th>СР. Ж.</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="dev">Ноутбук</td>
										<td><?=count($dev_1)?></td>
										<td><?=round(allSr($dev_1)/count($dev_1), 2)?></td>
										<td><?=round(workSr($dev_1)/count($dev_1), 2)?></td>
										<td><?=round(hardSr($dev_1)/count($dev_1), 2)?></td>
									</tr>
									<tr>
										<td class="dev">ПК</td>
										<td><?=count($dev_2)?></td>
										<td><?=round(allSr($dev_2)/count($dev_2), 2)?></td>
										<td><?=round(workSr($dev_2)/count($dev_2), 2)?></td>
										<td><?=round(hardSr($dev_2)/count($dev_2), 2)?></td>
									</tr>
									<tr>
										<td class="dev">Планшет</td>
										<td><?=count($dev_3)?></td>
										<td><?=round(allSr($dev_3)/count($dev_3), 2)?></td>
										<td><?=round(workSr($dev_3)/count($dev_3), 2)?></td>
										<td><?=round(hardSr($dev_3)/count($dev_3), 2)?></td>
									</tr>
									<tr>
										<td class="dev">Монитор</td>
										<td><?=count($dev_4)?></td>
										<td><?=round(allSr($dev_4)/count($dev_4), 2)?></td>
										<td><?=round(workSr($dev_4)/count($dev_4), 2)?></td>
										<td><?=round(hardSr($dev_4)/count($dev_4), 2)?></td>
									</tr>
									<tr>
										<td class="dev">Смартфон</td>
										<td><?=count($dev_5)?></td>
										<td><?=round(allSr($dev_5)/count($dev_5), 2)?></td>
										<td><?=round(workSr($dev_5)/count($dev_5), 2)?></td>
										<td><?=round(hardSr($dev_5)/count($dev_5), 2)?></td>
									</tr>
									<tr>
										<td class="dev">UPS</td>
										<td><?=count($dev_6)?></td>
										<td><?=round(allSr($dev_6)/count($dev_6), 2)?></td>
										<td><?=round(workSr($dev_6)/count($dev_6), 2)?></td>
										<td><?=round(hardSr($dev_6)/count($dev_6), 2)?></td>
									</tr>
									<tr>
										<td class="dev">Фотоаппарат</td>
										<td><?=count($dev_7)?></td>
										<td><?=round(allSr($dev_7)/count($dev_7), 2)?></td>
										<td><?=round(workSr($dev_7)/count($dev_7), 2)?></td>
										<td><?=round(hardSr($dev_7)/count($dev_7), 2)?></td>
									</tr>
									<tr>
										<td class="dev">Принтер</td>
										<td><?=count($dev_8)?></td>
										<td><?=round(allSr($dev_8)/count($dev_8), 2)?></td>
										<td><?=round(workSr($dev_8)/count($dev_8), 2)?></td>
										<td><?=round(hardSr($dev_8)/count($dev_8), 2)?></td>
									</tr>
									<tr>
										<td class="dev">Другое</td>
										<td><?=count($dev_9)?></td>
										<td><?=round(allSr($dev_9)/count($dev_9), 2)?></td>
										<td><?=round(workSr($dev_9)/count($dev_9), 2)?></td>
										<td><?=round(hardSr($dev_9)/count($dev_9), 2)?></td>
									</tr>
								</tbody>
							</table>
							<div style="margin-top:15px;"></div>
							<table class="tabb">
								<thead>
									<tr>
										<th>Откуда</th>
										<th>Кол-во</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td class="dev">Интернет</td>
										<td><?=count($fo_1)?></td>
									</tr>
									<tr>
										<td class="dev">Порекомендовали</td>
										<td><?=count($fo_2)?></td>
									</tr>
									<tr>
										<td class="dev">Постоянный клиент</td>
										<td><?=count($fo_3)?></td>
									</tr>
									<tr>
										<td class="dev">Проходил мимо</td>
										<td><?=count($fo_4)?></td>
									</tr>
									<tr>
										<td class="dev">РадиоРынок</td>
										<td><?=count($fo_5)?></td>
									</tr>
									<tr>
										<td class="dev">По гарантии</td>
										<td><?=count($fo_6)?></td>
									</tr>
									<tr>
										<td class="dev">Другое</td>
										<td><?=count($fo_7)?></td>
									</tr>
								</tbody>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>