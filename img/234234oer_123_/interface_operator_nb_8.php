<?
// проверка авторизации
//require "auth.php";
include "connect2db.php";
connect();

// добавление примечания к задаче
if(isset($_POST['prime4_submit'])){
	$prime4_id = $_POST['prime4_id'];
	$q = mysql_query("SELECT * FROM clients WHERE id='".$prime4_id ."'");
	if(mysql_num_rows($q)>0){
		$r = mysql_fetch_array($q);
		$name = $r['name'];
		$address = $r['address'];
		$phone = $r['phone'];
		$prime4_text = $_POST['prime4_text'];
		$problema = "Оператор говорит: ".$prime4_text;
		$date_add = date(Ymd);
		$time_add = date(Hi);
	
		$query = "INSERT INTO clients (show1, status, date_add, time_add, name, address, phone, problema) VALUES ('1', '0', '$date_add', '$time_add', '$name', '$address', '$phone', '$problema')";
		$res = mysql_query($query) or die(mysql_error()); 
		header("location:interface_operator_nb_8.php");
	}
}


// если нажали кнопку ДЕНЬГИ ПОЛУЧЕНЫ
if (isset($_POST['submit_oplata'])){
	$date_oplata = date('Ymd');
	$time_oplata = date('Hi');
	
	$cena_work = $_POST['cena_work'];
	$cena_hard = $_POST['cena_hard'];
	
	$query = "UPDATE clients SET date_oplata='$date_oplata', time_oplata='$time_oplata', cena_work='$cena_work', cena_hard='$cena_hard' WHERE id=".$_GET[id];
	$res = mysql_query($query) or die(mysql_error()); 
	header("location:interface_operator_nb_8.php");
}


if($_GET[a]=='del' AND $_GET[id]!=''){
	$query = "UPDATE clients SET show1='0' WHERE id=".$_GET[id];
	$res = mysql_query($query) or die(mysql_error()); 
	header("location:interface_operator_nb_8.php");
}


// сохранение изменений
if (isset($_POST['submit'])){

	if($_POST['name']!=''){
		$name = $_POST['name'];
	}
	
	if($_POST['address']!=''){
		$address = $_POST['address'];
	}
	
	if($_POST['phone']!=''){
		$phone = $_POST['phone'];
	}

	if($_POST['problema']!=''){
		$problema = mysql_real_escape_string($_POST['problema']);
	}

	if($_POST['comment']!=''){
		$comment = str_replace('\r\n',' ', mysql_real_escape_string($_POST['comment']));
	}	
	
	if($_POST['recomend_by_master']!=''){
		$recomend_by_master = $_POST['recomend_by_master'];
	}
	
	//  если МАСТЕР выбран
	if($_POST['id_master']!=''){
		$id_master = $_POST['id_master'];
	}else{
		$id_master = "";
	}

	// прикрепляем к мастеру задачу
	$status = $_POST['status'];
	if($status==0 AND $id_master!=''){
		$status=1;
	}
		
	if($status=='2'){
		$date_end = date(Ymd);
	}else{
		$date_end = "";
	}
	
	if($_POST['cena_work']!=''){
		$cena_work = $_POST['cena_work'];
	}

	if($_POST['cena_hard']!=''){
		$cena_hard = $_POST['cena_hard'];
	}	


	// ====================================
	// если перенаправляем задачу..
	// ====================================
	if($_POST['id_master_re']!=''){
		$id_master_re = $_POST['id_master_re'];
		
		$q = mysql_query("SELECT * FROM clients WHERE id='".$_GET['id']."'");
		$r = mysql_fetch_array($q);
	
		$date_add = date(Ymd);
		$time_add = date(Hi);
		
		$q1 = mysql_query("SELECT * FROM masters WHERE id='".$r['id_master']."'");
		$r1 = mysql_fetch_array($q1);
		
		$full_recomend_by_master = $_POST['com'].".Взять с клиента за работу: ".$cena_work." грн. и за железо:".$cena_hard." грн. (".($cena_work+$cena_hard)." грн.)";

		$query = "INSERT INTO clients (show1, status, id_master, date_add, time_add, name, address, phone, problema, comment) VALUES ('1', '1', '$id_master_re', '$date_add', '$time_add', '$r[name]', '$r[address]', '$r[phone]', '$r[problema]', '$full_recomend_by_master')";
		$res = mysql_query($query) or die(mysql_error()); 

	}
	
	
	// если выше ошибок не было обнаружено..
	if(strlen($error)==0){
		$date_current = date('ymdHis');
		$query = "UPDATE clients SET cena_work='$cena_work', cena_hard='$cena_hard', status='$status', name='$name', phone='$phone', address='$address', problema='$problema', comment='$comment', comment_edit_date='$date_current', recomend_by_master='$recomend_by_master', id_master='$id_master', date_end='$date_end', date_oplata='$date_oplata', time_oplata='$time_oplata' WHERE id=".$_GET[id];
		$res = mysql_query($query) or die(mysql_error()); 
		$xxx = $_SERVER['REQUEST_URI'];
		if(substr_count($xxx, "work")>0){
			$yyy = "?work";
		}
		
		if(substr_count($xxx, "oplata")>0){
			$yyy = "?oplata";
		}
		
		header("location:interface_operator_nb_8.php".$yyy);
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
	<script type='text/javascipt' src='jquery.tablesorter.min.js'></script>
	
	<script language="JavaScript">
	$(document).ready(function() {
		$("#list").tablesorter(); 
	});
	</script>


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

#tit th{
	background:#eee;
	border:1px solid #ccc;
	padding:4px;
	text-align:center;
}
</style>

</head>

<body>


<!-- HEADER //-->


<!-- CONTENT //-->

	<table border="0">
	<tr>
	
	<td>
	<style>
#admin_menu_block b{
	border-bottom:1px solid #ccc;
	font-size:9pt;
	color:#fff;
	background:#006699;
	display:block;
	text-transform:uppercase;
	margin:0;
	padding:1px;
	padding-left:6px;
}

#admin_menu_block ul{
	margin:0;
	padding:0;
	list-style:none;
	margin-bottom:20px;
	margin-top:3px;
	margin-left:5px;
}

#admin_menu_block ul li  a{
	
}

</style>
<td width="250" valign="top" style="background:#f6f2d9;">

<style>
.admin_count{
	color:#333;
	font-size:9pt;
	position:relative;
	top:-3px;
}
</style>

<!-- MAIN MENU //-->

<div id='admin_menu_block' style="width:150px;margin:20px;">

<b>Наши клиенты</b>
<ul>
<li style="margin-top:10px; margin-bottom:7px;"><a style="font-size:14pt; font-weight:bold;" href="interface_operator_nb_8.php">Список задач</a></li>
<li><a href="client_add.php">Добавить задачу</a></li>
<li><a onClick="$('#prime4').slideToggle();" href="javascript:void(0)">Добавить примечание</a></li>
</ul>

<div id="prime4" style="display:none;margin-bottom:25px;">
<form method="post" action="interface_operator_nb_8.php" name="form1">
<input type="text" style="width:75px;" value="" name="prime4_id"> - id
<input type="hidden" name="master" value="<?=$r[name]?>">
<br>
<textarea style="width:150px;height:150px;margin-top:10px;" name="prime4_text"></textarea>
<br>
<input type="submit" style="padding:3px;margin-top:10px;" value="Добавить" name="prime4_submit">
</form>
</div>



	</td>
	
	<td width="50">
	&nbsp;
	</td>
	<td valign="top">
<!-- CENTER COLUMN //-->
<?if($_GET[a] AND $_GET[a]=='edit'){
$res = mysql_query("SELECT * FROM clients WHERE id=".$_GET[id]);
$row = mysql_fetch_array($res);
?>
<h1 style="margin-bottom:25px;">Редактирование задачи</h1>
		<form name="add_client" id="add_client" method="post" action="">
		<table border="0" style="margin-top:20px;" width="800">

		<tr>
		<td width="150" align="right" style="padding-top:5px;" valign="top">
		<b>id</b>
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<b><?=$row[id]?></b>
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:5px;">
		<b>Статус</b>
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		
		<?if($row[status]==2){
			?>
			Задача выполнена			
			<?
		}elseif($row[status]==1){
			?>Задача в работе<?
		}elseif($row[status]==0){
			?>Задача ожидает<?
		}
		?>
		
		<input type="hidden" id="status" name="status" value="<?=$row['status']?>">
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:15px;" valign="top">
		Дата старта
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:15px;">
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
		<td width="150" align="right" style="padding-top:5px;" valign="top">
		Имя клиента
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
			<input type="text" class="standart" <?if($row[status]!=0){?>readonly<?}?> value='<?=$row[name]?>' style="width:400px;" name="name" maxlength="50">
		</td>
		</tr>
		
		
		<tr>
		<td width="150" align="right" style="padding-top:5px;" valign="top">
		Адрес
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
			<input type="text" <?if($row[status]!=0){?>readonly<?}?> class="standart" style="width:400px;" value='<?=$row[address]?>' name="address" maxlength="80">
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:5px;" valign="top">
		Контактный телефон
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
			<input type="text" class="standart" <?if($row[status]!=0){?>readonly<?}?> style="width:400px;" value="<?=$row[phone]?>" name="phone" maxlength="11">
		</td>
		</tr>
		
		
		<tr>
		<td width="150" align="right" style="padding-top:5px;">
		<?if($row['id_master']!=5){?>
			Описание проблемы<br> со слов клиента (время, новая или по гарантии, детали, инструмент)
		<?}else{?>
			Переписка с клиентом
		<?}?>
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<textarea style="width:526px;height:100px;padding:2px;" name="problema"><?=$row[problema]?></textarea>
		</td>
		</tr>


		<tr>
		<td width="150" align="right" style="padding-top:5px;">
		<?if($row['id_master']!=5){?>
			Комментарий для инженера
		<?}else{?>
			Задачи для инженера
		<?}?>
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<textarea style="width:526px;height:50px;padding:2px;" name="comment"><?=$row[comment]?></textarea>
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:5px;padding-bottom:15px;">
		Закрепленный мастер
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;padding-bottom:15px;">
		
		<?if($row[status]==2){
			$res2 = mysql_query("SELECT * FROM masters WHERE id=".$row[id_master]);
			$row2 = mysql_fetch_array($res2);
			echo $row2[name];
			echo "<input type='hidden' name='id_master' id='id_master' value='".$row2[id]."'>";
		}else{
		?>
		<select name="id_master" id="id_master">
		<?
		if($row[id_master]==''){
		?>
		<option value="">выбор мастера</option>
		<?
		}
		?>
		
		<?
		$res2 = mysql_query("SELECT * FROM masters");
		while($row2 = mysql_fetch_array($res2)){
			?><option value="<?=$row2[id]?>"><?=$row2[name]?></option><?
		}
		?>
		</select>
		<script>$('#id_master option[value=<?=$row[id_master]?>]').attr('selected','selected');</script>
		
		<?}?>
		
		</td>
		</tr>
		
		<?
		/*
		if($row[status]=='2' AND $row[id_master]==5){?>		
		<tr>
		<td></td>
		<td></td>
		<td style="padding-bottom:15px;">
		
		<table border="0" style="margin-top:0px;">
		<tr>
		<td  style="padding-top:0px;">
		<a onClick="$('#alert').slideToggle('fast');" style="font-size:12pt;text-decoration:none;border-bottom:1px dotted blue;" href="javascript:void(0)">Передать задачу</a>
		</td>
		</tr>
		</table>
		
		<table id="alert" style="display:none;">
		<tr>
		<td style="padding-top:15px;">
		
		<select name="id_master_re" style="width:150px;" id="id_master_re">
		<option selected value="">выбор мастера</option>
		<?
		$res2 = mysql_query("SELECT * FROM masters");
		while($row2 = mysql_fetch_array($res2)){
			if($row2[id]==$row[id_master]){continue;}
			?><option value="<?=$row2[id]?>"><?=$row2[name]?></option><?				
		}
		?>
		</select>
		</td>
		</tr>
		</table>
		
		</td>
		</tr>
		<?}
		*/?>
		
		</table>
		
		
		<?
		if($row[status]==1){
			?>
			<table border="0" width="800">
			<tr style="background:#eee;">
			<td width="150" align="right" valign="top" style="border-top:1px solid #999;padding-top:15px;">
			Что выполнено
			</td>
			<td width="20" style="border-top:1px solid #999;">
			&nbsp;
			</td>
			<td valign="top" style="border-top:1px solid #999;padding-top:15px;padding-bottom:35px;">
			<span><?=$row[comment_by_master]?></span>
			<input type="hidden" value="<?=$row[comment_by_master]?>" name="com">
			</td>
			</tr>
			
			<tr style="background:#eee;">
			<td width="150" align="right" valign="top" style="padding-top:5px;padding-bottom:35px;">
			Что нужно сделать мастеру в СЦ
			</td>
			<td width="20">
			&nbsp;
			</td>
			<td style="padding-top:5px;padding-bottom:15px;" valign="top">
			<textarea style="width:526px;height:150px;padding:2px;" name="recomend_by_master"><?=$row[recomend_by_master]?></textarea>
			</td>
			</tr>
			</table>
			<?
		}
		?>
		
<?
if($row[status]==2){
		?>
		<table border="0" width="800">
		<tr style="background:#eee;">
		<td width="150" align="right" valign="top" style="border-top:1px solid #999;padding-top:15px;">
		Что выполнено
		</td>
		<td width="20" style="border-top:1px solid #999;">
		&nbsp;
		</td>
		<td valign="top" style="border-top:1px solid #999;padding-top:15px;">
		<span><?=$row[comment_by_master]?></span>
		<input type="hidden" value="<?=$row[comment_by_master]?>" name="com">
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="150" align="right" valign="top" style="padding-top:5px;">
		Рекомендации от мастера
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;" valign="top">
		<span><?=$row[recomend_by_master]?></span>
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="150" align="right" style="padding-top:15px;">
		Цена работы
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:15px;">
		<?if($row['id_master']==5){?>
			<input class="standart" value="<?=$row[cena_work]?>" type="text" name="cena_work"><b> грн.</b>
		<?}else{?>
			<b><?=$row[cena_work]?> грн.</b>
			<input class="standart" type="hidden" value="<?=$row[cena_work]?>" name="cena_work">
		<?}?>
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="150" align="right" style="padding-top:5px;">
		Цена железа
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<?if($row['id_master']==5){?>
			<input class="standart" type="text" value="<?=$row[cena_hard]?>" name="cena_hard"><b> грн.</b>
		<?}else{?>
			<b><?=$row[cena_hard]?> грн.</b>
			<input class="standart" type="hidden" value="<?=$row[cena_hard]?>" name="cena_hard">
		<?}?>
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="150" align="right" style="padding-top:5px;padding-bottom:10px;">
		Всего
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;padding-bottom:10px;">
		<b><?=$row[cena_hard]+$row[cena_work]?> грн.</b>    
		
		<?/*if($row[date_oplata]==0 AND $row[date_end]!=0){?><input type="submit" name="submit_oplata" value="Деньги получены" style="padding:4px;margin-left:15px;"><?}*/?>
		</td>
		</tr>
		
		<tr  style="background:#eee;">
			<td width="150" align="right" style="padding-top:5px;padding-bottom:10px;">
				Проблемма решена
			</td>
			<td width="20">
				&nbsp;
			</td>
			<td style="padding-top:5px;padding-bottom:10px;">
				<b><?=$decisions_status[$row['decisions_status']]?></b>
			</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:15px;" valign="top">
		Дата выполнения
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:15px;">
		<?
		if($row['date_end']!='0'){
			$d = substr($row['date_end'],6,2);
			$m = substr($row['date_end'],4,2);
			$y = substr($row['date_end'],0,4);
			echo $date_end = $d.".".$m.".".$y;
		}
		
		if($row['time_end']!='0'){
			$h = substr($row['time_end'],0,2);
			$m = substr($row['time_end'],2,2);
			echo $time_end = ", ".$h.":".$m;
		}
		?>
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:3px;" valign="top">
		Дата сдачи денег
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:3px;">
		<?
		if($row['date_oplata']!='0'){
			$d = substr($row['date_oplata'],6,2);
			$m = substr($row['date_oplata'],4,2);
			$y = substr($row['date_oplata'],0,4);
			echo $date_oplata = $d.".".$m.".".$y;
		}else{
			echo $date_oplata = "деньги не сданы";
		}
		
		if($row['time_oplata']!='0'){
			$h = substr($row['time_oplata'],0,2);
			$m = substr($row['time_oplata'],2,2);
			echo $time_oplata = ", ".$h.":".$m;
		}
		?>
		</td>
		</tr>
		</table>
<?
}
?>
		
		<table>
		<tr>
		<td width="150" align="right" style="padding-top:10px;">
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:30px;">
		
		<input type="submit" name="submit" style="padding:7px;" value="Сохранить изменения">

		</td>
		</tr>

			
		</table>

		</form>


<?}elseif(isset($_GET[filter])){
	?><h1 style="margin-bottom:25px;">Список задач для телефона: <?=$_GET[filter]?></h1>
	<table id="list" style="margin-right:20px;">
<thead>
<tr id="tit">
<th></th>
<th><a href="">ID</a></th>
<th><a href="">Дата 1</a></th>
<th><a href="">Дата 2</a></th>
<th><a href="">Имя</a></th>
<th><a href="">Адрес</a></th>
<th><a href="">Телефон</a></th>
<th>Проблема</th>
<th>Для мастера</th>
<th><a href="">Мастер</a></th>

<th><a href="">Работа</a></th>
<th><a href="">Железо</a></th>
<th><a href="">Всего</a></th>
</tr>
</thead>
<?
$res = mysql_query("SELECT * FROM clients WHERE show1=1 AND phone=".$_GET[filter]." ORDER BY id DESC");
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
	$y = substr($row['date_add'],2,2);
	$date_add = $d.".".$m.".".$y;
	
	$h = substr($row['time_add'],0,2);
	$mm = substr($row['time_add'],2,2);
	$time_add = $h.":".$mm;
	
	$h = substr($row['time_add'],0,2);
	$mm = substr($row['time_add'],2,2);
	$time_add = $h.":".$mm;
	
	if($row['date_end']!='0'){
		$d = substr($row['date_end'],6,2);
		$m = substr($row['date_end'],4,2);
		$y = substr($row['date_end'],2,2);
		$date_end = $d.".".$m.".".$y;
	}else{
		$date_end = "";
	}
	if($row['time_end']!='0'){
		$h2 = substr($row['time_end'],0,2);
		$mm2 = substr($row['time_end'],2,2);
		$time_end = $h2.":".$mm2;
	}else{
		$time_end="";
	}
	
	if($row['date_oplata']==0 AND $row[status]==2){
		$date_oplata="2px solid red";
	}else{
		$date_oplata="none";
	}
	
	?>
	<tr style="background:<?=$color?>;border:<?=$date_oplata?>">
	<td><a href="?a=edit&id=<?=$row[id]?>"><img src="ico_edit.gif"></a></td>
	<td><?=$row[id]?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_add?></span><br><?=$time_add?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_end?></span><br><?=$time_end?></td>
	<td><?=$row[name]?></td>
	<td><?=$row[address]?></td>
	<td><?=str_replace(" ","&nbsp;",$row[phone])?></td>
	<td style="font-size:9pt;"><?=$row[problema]?></td>
	<td style="font-size:9pt;"><?=$row[comment]?></td>
	<?
	$s = mysql_query("SELECT * FROM masters WHERE id=".$row[id_master]);
	$r = mysql_fetch_array($s);
	?>
	<td style="font-size:9pt;"><?=$r[name]?></td>

	<td><b><?=$row[cena_work]?></b></td>
	<td><b><?=$row[cena_hard]?></b></td>
	<td><b><?=$row[cena_hard]+$row[cena_work]?></b></td>
	
	</tr>
	<?
}
?>
</table>
	
	
	<?
}else{?>
<h1 style="margin-bottom:25px;">Список задач для Оператора 
<!--<?//if(isset($_GET[view_all])){?>
	/ <a href="interface_operator_nb_8.php">последние 500</a>
<?//}else{?>
	/ <a href="?view_all">все</a>
<?//}?>-->

</h1>

<table width="100%" border="0" style="margin-bottom:15px;">
<tr>
<td>
<img src="legenda.gif">
</td>

<td>
Показать:&nbsp;
<ul class="masters" style="list-style:none;">
<li><a href="interface_operator_nb_8.php">Все</a></li>
<li><a href="?work">В работе</a></li>
<li><a href="?oplata">Не закрытые</a></li>
</ul>
</td>

<!--<td>
Показать работы мастера:&nbsp;
<ul class="masters" style="list-style:none;">
<?/*
$s = mysql_query("SELECT * FROM masters WHERE id=5");
while($r = mysql_fetch_array($s)){
	?><li><a target="_blank" href="master.php?id=<?=md5($r[id])?>"><?=$r[name]?></a></li><?
}
*/?>
</ul>
</td>-->
</tr>
</table>

<table id="list" style="margin-right:20px;">
<thead>
<tr id="tit">
<th></th>
<th></th>
<th><a href="">ID</a></th>
<th><a href="">Дата 1</a></th>
<th><a href="">Дата 2</a></th>
<th><a href="">Имя</a></th>
<th><a href="">Адрес</a></th>
<th><a href="">Телефон</a></th>
<th>Проблема</th>
<th>Для мастера</th>
<th>Комментарий</th>
<th><a href="">Мастер</a></th>

</tr>
</thead>
<?
$date_add_for_query = date(Ymd)+2;
if(isset($_GET[work])){
	$res = mysql_query("SELECT * FROM clients WHERE show1=1 AND date_add<='$date_add_for_query' AND status<2 ORDER BY date_add DESC");
}elseif(isset($_GET[oplata])){
	$res = mysql_query("SELECT * FROM clients WHERE show1=1 AND date_add<='$date_add_for_query' AND date_end!=0 AND date_oplata=0 ORDER BY date_add DESC");
}else{
	if(!isset($_GET[view_all])){
		$page="LIMIT 0,500";
	}else{
		$page="";
	}
	$res = mysql_query("SELECT * FROM clients WHERE show1=1 AND date_add<='$date_add_for_query' AND status <= 2 AND date_oplata=0 ORDER BY date_add DESC $page");
}
while($row = mysql_fetch_array($res)){
	$st = $row[status];
	$background_by_master = "";
	$background_by_operator = "";
	if($st==0){
		$color="#ffbc9b";
	}elseif($st==1){
		$color="#ffff77";
		
		if($row[comment_edit_date]!=0 OR $row[comment_by_master_edit_date]!=0){
			if($row[comment_edit_date]<$row[comment_by_master_edit_date]){
				$background_by_master = "background:#ffd642;";
				$background_by_operator = "";
			}else{
				$background_by_master = "";
				$background_by_operator = "background:#ffd642;";
			}
		}
		
	}else{
		$color="#c0ebc0";
	}
	
	$d = substr($row['date_add'],6,2);
	$m = substr($row['date_add'],4,2);
	$y = substr($row['date_add'],2,2);
	$date_add = $d.".".$m.".".$y;
	
	$h = substr($row['time_add'],0,2);
	$mm = substr($row['time_add'],2,2);
	$time_add = $h.":".$mm;
	
	$h = substr($row['time_add'],0,2);
	$mm = substr($row['time_add'],2,2);
	$time_add = $h.":".$mm;
	
	if($row['date_end']!='0'){
		$d = substr($row['date_end'],6,2);
		$m = substr($row['date_end'],4,2);
		$y = substr($row['date_end'],2,2);
		$date_end = $d.".".$m.".".$y;
	}else{
		$date_end = "";
	}
	if($row['time_end']!='0'){
		$h2 = substr($row['time_end'],0,2);
		$mm2 = substr($row['time_end'],2,2);
		$time_end = $h2.":".$mm2;
	}else{
		$time_end="";
	}
	
	if(($row['date_oplata']==0 && $row[status]==2) || (isset($row['patern_master']) && $row['date_add']>date(Ymd))){
		$date_oplata="2px solid red";
	}else{
		$date_oplata="none";
	}
	
	// if(isset($row['patern_master']) && $row['date_add']>date(Ymd)){
		// $date_oplata="2px solid green";
	// }
	
	?>
	<tr style="background:<?=$color?>;border:<?=$date_oplata?>">
	<td><a href="<?if(isset($_GET[oplata])){echo "?oplata&";}elseif(isset($_GET[work])){echo "?work&";}else{echo "?";}?>a=edit&id=<?=$row[id]?>"><img src="ico_edit.gif"></a></td>
	<td>

	</td>
	<td><?=$row[id]?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_add?></span><br><?=$time_add?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_end?></span><br><?=$time_end?></td>
	<td><?=$row[name]?></td>
	<td><?=$row[address]?></td>
	<td><a href="?filter=<?=str_replace(" ","&nbsp;",$row[phone])?>"><?=str_replace(" ","&nbsp;",$row[phone])?></a></td>
	<td style="font-size:9pt;"><?=$row[problema]?></td>
	<td style="<?=$background_by_operator?>font-size:9pt;"><?=$row[comment]?></td>
	<td style="<?=$background_by_master?>font-size:9pt;"><?=$row[comment_by_master]?></td>
	<?
	$s = mysql_query("SELECT * FROM masters WHERE id='$row[id_master]'");
	$r = mysql_fetch_array($s);
	?>
	<td style="font-size:9pt;"><?=$r[name]?></td>
	
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