<?
// проверка авторизации
//require "auth.php";
error_reporting(E_ALL);
include "connect2db.php";
connect();
	$s = mysql_query("SELECT COUNT(id) FROM clients WHERE show1=1");
	$vsego = mysql_result($s, 0);
	
	$s = mysql_query("SELECT COUNT(id) FROM clients WHERE show1=1 AND date_oplata=''");
	$open = mysql_result($s, 0);
	
	$s = mysql_query("SELECT COUNT(id) FROM clients WHERE show1=1 AND status=0");
	$og = mysql_result($s, 0);
	
	$s = mysql_query("SELECT COUNT(id) FROM clients WHERE show1=1 AND status=1");
	$work = mysql_result($s, 0);
	
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
	$query = mysql_query("SELECT COUNT(id) as count, SUM(cena_hard) as cena_hard, SUM(cena_work) as cena_work FROM clients WHERE status=2 AND show1=1 AND date_oplata!=0 AND date_oplata='".$year.$month.$i."'");
	$row = mysql_fetch_assoc($query);
	$query2 = mysql_query("SELECT id, cena_hard, cena_work FROM clients WHERE status=2 AND show1=1 AND date_oplata!=0 AND date_oplata='".$year.$month.$i."'");
	while($row2 = mysql_fetch_assoc($query2)){
		$fullArr[$row2['id']] = array("cena_work" => $row2['cena_work'], "cena_hard" => $row2['cena_hard'], "all" => ($row2['cena_hard']+$row2['cena_work']));
	}
	($row['cena_hard'] == "")?$row['cena_hard']=0:$row['cena_hard']=$row['cena_hard'];
	($row['cena_work'] == "")?$row['cena_work']=0:$row['cena_work']=$row['cena_work'];
	$workAll[] = $row['cena_work'];
	$hardAll[] = $row['cena_hard'];
	$countAll[] = $row['count'];
	// $fullArr[] = ($row['cena_hard']+$row['cena_work']);
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
				location.href="http://nanobyte.com.ua/img/234234oer_123/stat_8.php?data_stat="+xxx;
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
			<h1 style="margin-bottom:25px;">Статистика</h1>
			<table>
				<tr>
					<td valign="top">
						<select id="data_stat" name="data_stat">
							<optgroup label="2012">
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
							</optgroup>
							<optgroup label="2013">
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
							</optgroup>
							<optgroup label="2014">
								<option value="201401">Январь 2014</option>
								<option value="201402">Февраль 2014</option>
								<option value="201403">Март 2014</option>
								<option value="201404">Апрель 2014</option>
								<option value="201405">Май 2014</option>
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
					<td style="padding-left:50px;width:300px;" valign="top">
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
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>