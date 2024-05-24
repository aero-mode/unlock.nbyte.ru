<?
// проверка авторизации
include "connect2db.php";
connect();

// сохранение изменений
if (isset($_POST['submit'])){

	if($_POST['comment_by_master']!=''){
		$comment_by_master = $_POST['comment_by_master'];
	}

	// если выше ошибок не было обнаружено..
	if(strlen($error)==0){
		$query = "UPDATE clients_sc SET status='1', comment_by_master='$comment_by_master' WHERE id=".mysql_real_escape_string($_GET['id_zad']);
		$res = mysql_query($query); 
		header("location:master.php");
	}
}
?>


<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>Управление клиентами. Nanobyte</title>
	<link rel="stylesheet" type="text/css" href="reset.css" />
	<link rel="stylesheet" type="text/css" href="main.css" />
	<script type='text/javascript' src='jquery.js'></script>

	<script type='text/javascript'> 
	function del(){if(confirm("Удалить?")){return true;}else{return false;}} 
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

<body style="padding:20px;padding-top:0;">
<!-- CONTENT //-->

	<table width="100%" border="0">
	<tr>

	<td valign="top">

		<?
		if($_GET['a'] AND $_GET['a']=='edit'){
		$res = mysql_query("SELECT * FROM clients_sc WHERE id=".mysql_real_escape_string($_GET['id_zad']));
		$row = mysql_fetch_array($res);
		?>
		<h1 style="margin-bottom:25px;"><a href="master.php">Список задач</a> / Редактирование</h1>
				<form name="add_client" id="add_client" method="post" action="">
				<table border="0" style="margin-top:20px;" width="800">

				<tr>
				<td width="180" align="right" style="padding-top:5px;" valign="top">
				<b>ID клиента</b>
				</td>
				<td width="20">
				&nbsp;
				</td>
				<td style="padding-top:5px;">
				<b><?=$row['id_client']?></b>
				</td>
				</tr>
				
				
				<tr>
				<td align="right" style="padding-top:5px;" valign="top">
				Дата старта
				</td>
				<td width="20">
				&nbsp;
				</td>
				<td style="padding-top:5px;">
				<?
				if($row['date_add']!='0'){
					$d = substr($row['date_add'],6,2);
					$m = substr($row['date_add'],4,2);
					$y = substr($row['date_add'],0,4);
					echo $date_add = $d.".".$m.".".$y;
				}else{
					echo $date_add = "";
				}
				
				if($row['time_add']!='0'){
					$h = substr($row['time_add'],0,2);
					$m = substr($row['time_add'],2,2);
					echo $time_add = ", ".$h.":".$m;
				}else{
					echo $time_add = "";
				}
				?>
				</td>
				</tr>

				<tr>
				<td align="right" style="padding-top:5px;">
				Модель
				</td>
				<td width="20">
				&nbsp;
				</td>
				<td style="padding-top:5px;font-size:12pt;">
				<?=$row['model']?>
				</td>
				</tr>
				
				<tr>
				<td align="right" style="padding-top:5px;">
				SN
				</td>
				<td width="20">
				&nbsp;
				</td>
				<td style="padding-top:5px;font-size:12pt;">
				<?=$row['sn']?>
				</td>
				</tr>
				
				<tr>
				<td align="right" style="padding-top:5px;">
				Проблема со слов клиента
				</td>
				<td width="20">
				&nbsp;
				</td>
				<td style="padding-top:5px;font-size:12pt;">
				<?=$row['problema_opisanie']?>
				</td>
				</tr>
				
				<tr>
				<td align="right" style="padding-top:5px;">
				Задача
				</td>
				<td width="20">
				&nbsp;
				</td>
				<td style="padding-top:5px;font-size:12pt;">
				<?=$row['comment']?>
				</td>
				</tr>

				</table>
				
				<table border="0" width="800" style="margin-top:15px;">
				<tr style="background:#eee;">
				<td width="180" align="right" style="padding-top:5px;">
				Что выполнено<BR>
				</td>
				<td width="20">
				&nbsp;
				</td>
				<td style="padding-top:15px;padding-bottom:15px;">
				<textarea style="width:585px;height:80px;padding:2px;" id="comment_by_master" name="comment_by_master"><?=$row[comment_by_master]?></textarea>
				</td>
				</tr>
				
				</table>
			
				
				<table style="margin-top:0px;">
				<tr>
				<td width="180" align="right" style="padding-top:10px;">
				</td>
				<td width="20">
				&nbsp;
				</td>
				<td style="padding-top:20px;">
				
				<table><tr><td>
				<input type="submit" name="submit" id="submit" style="padding:10px;" value="Сохранить">
				</form>
				</td>
				<td style="padding-left:50px;">

				</td>
				</tr>
				</table>
				
				</td>
				</tr>

					
				</table>


		<?}else{
			$curr_date = date(Ym);
			$curr_query = mysql_query("SELECT COUNT(*) FROM clients_sc WHERE show1=1 AND date_oplata!=0 AND date_oplata LIKE '".$curr_date."%'");
			$curr_request = mysql_result($curr_query, 0);
		?>

		<div style="height:80px;"><h1 style="float:left">NB-СЦ / Список задач для мастера</h1><div style="padding:30px;float:right;color:#CC3300;font-family: Georgia,Times;font-size: 15pt;">За текущий месяц работ выполнено: <span style="color:black;"><?=$curr_request?> / 210<div style="width:20px;height:20px;<?if($curr_request>=210){?>background-color:green;<?}else{?>background-color:red;<?}?>border-radius:15px;display:inline-block;margin-left:15px;"></div></span></div>
			<div style="padding:30px;float:right;color:#CC3300;font-family: Georgia,Times;font-size: 15pt;">
				<?
				$curr_date = date(Ymd);
				$curr_query = mysql_query("SELECT COUNT(*) FROM clients_sc WHERE date_end = '".$curr_date."'");
				$curr_request = mysql_result($curr_query, 0);
				echo "Выполнено: ".$curr_request." шт.";
				if($curr_request<=5){
					echo "/6<div style=\"width:20px;height:20px;background-color:red;border-radius:15px;display:inline-block;margin-left:15px;\"></div>";
				}elseif($curr_request>5 && $curr_request<10){
					echo "/10<div style=\"width:20px;height:20px;background-color:yellow;border-radius:15px;display:inline-block;margin-left:15px;\"></div>";
				}else{
					echo "<div style=\"width:20px;height:20px;background-color:green;border-radius:15px;display:inline-block;margin-left:15px;\"></div>";
				}
				?>
			</div>
		</div>

		<table width="100%" id="list" style="width:100%">
		<tr id="tit">
		<td></td>
		<td>ID</td>
		<td>ID клиента</td>
		<td>Дата</td>
		<td>Модель</td>
		<td>SN</td>
		<td>Проблема со слов клиента</td>
		<td>Задача</td>
		<td>Выполнено</td>
		</tr>

		<?
		$cur_date = date(Ymd);
		$res = mysql_query("SELECT * FROM clients_sc WHERE show1=1 AND date_oplata=0 AND date_add<='$cur_date' ORDER BY date_add DESC, id DESC");
		while($row = mysql_fetch_array($res)){
			$st = $row[status];
			if($st==0){
				$color="#ffbc9b";
			}elseif($st==1){
				$color="#ffff77";
			}else{
				$color="#c0ebc0";
			}
			
			$d = substr($row['date_add'],6,2);
			$m = substr($row['date_add'],4,2);
			$y = substr($row['date_add'],0,4);
			$date_add = $d.".".$m.".".$y;
			
			(strlen($row['time_add'])<4)?$time_add2 = '0'.$row['time_add']:$time_add2 = $row['time_add'];
			
			$h = substr($time_add2,0,2);
			$mm = substr($time_add2,2,2);
			$time_add = $h.":".$mm;
			
			
			
			if($row['date_end']!='0'){
				$d = substr($row['date_end'],6,2);
				$m = substr($row['date_end'],4,2);
				$y = substr($row['date_end'],0,4);
				$date_end = $d.".".$m.".".$y;
			}else{
				$date_end = "";
			}
			if($row['time_end']!='0'){
				$h2 = substr($row['time_end'],0,2);
				$mm2 = substr($row['time_end'],2,2);
				$time_end = $h2.":".$mm2;
			}else{
				$time_end = "";
			}
			
			if($row['date_oplata']==0 AND $row[status]==2){
				$date_oplata="2px solid red";
			}else{
				$date_oplata="none";
			}
			
			?>
			<tr style="background:<?=$color?>;border:<?=$date_oplata?>">
			<td>
				<a title="Редактировать" href="?a=edit&id_zad=<?=$row['id']?>"><img width="24" src="ico_edit.gif"></a>
			</td>
			<td><?=$row['id']?></td>
			<td><?=$row['id_client']?></td>
			<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_add?></span><br><?=$time_add?></td>
			<td><?=$row['model']?></td>
			<td style="font-size:9pt;"><?=$row['sn']?></td>
			<td style="font-size:9pt;"><?=$row['problema_opisanie']?></td>	
			<td style="font-size:9pt;"><?=$row['comment']?></td>	
			<td class="comment_by_master" style="font-size:9pt;"><?=str_replace("\r\n","<br>",$row['comment_by_master'])?></td>	
			</tr>
			<?
		}
		?>
		</table>

		<?}?>
	</td>
	</tr>
	</table>

</body>
</html>