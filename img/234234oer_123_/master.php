<?
include "connect2db.php";
connect();

if(isset($_POST['prime4_submit'])){
	$prime4_id = $_POST['prime4_id'];
	$q = mysql_query("SELECT * FROM clients WHERE id='".$prime4_id ."'");
	if(mysql_num_rows($q)>0){
		$r = mysql_fetch_array($q);
		$future_name = $r['name'];
		$future_address = $r['address'];
		$future_phone = $r['phone'];
		$future_master = $_POST['master'];
		$problema = $_POST['prime4_text'];

		if(isset($_POST['self_variant'])){
			$device_type = $_POST['device_type_1'];
		}else{
			$device_type = $_POST['device_type_2'];
		}
		
		$date_add = $_POST['future_date'];
		$time_add = date(Hi);
		
		$future_date_add = date(Ymd);
	
		$future_query = "INSERT INTO `clients` (`id`, `date_add`, `time_add`, `future_date_add`, `patern_master`, `phone`, `name`, `address`, `problema`, `comment`, `comment_edit_date`, `comment_by_master`, `comment_by_master_edit_date`, `recomend_by_master`, `decisions_status`, `device_type`, `id_master`, `cena_work`, `cena_hard`, `date_end`, `time_end`, `date_oplata`, `time_oplata`, `date_zp`, `status`, `show1`, `archive`) VALUES (NULL , '$date_add', '$time_add', '$future_date_add', '$future_master', '$future_phone', '$future_name', '$future_address', '$problema', '', '0', '', '0', '', NULL , '$device_type', '', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0')";
		// echo $future_query;
		$future_res = mysql_query($future_query) or die(mysql_error()); 
		header("location:master.php?".$_SERVER['QUERY_STRING']);
	}
}

if (isset($_POST['save'])){
	if($_POST['comment_by_master']!=''){
		$comment_by_master = $_POST['comment_by_master'];
	}
	
	if($_POST['recomend_by_master']!=''){
		$recomend_by_master = $_POST['recomend_by_master'];
	}
	
	$date_current = date('ymdHis');
	
	$query = "UPDATE clients SET comment_by_master='$comment_by_master', comment_by_master_edit_date='$date_current', recomend_by_master='$recomend_by_master' WHERE id=".$_GET[id_zad];
	$res = mysql_query($query) or die(mysql_error()); 
	header("location:master.php?id=".$_GET[id]);
}

// сохранение изменений
if (isset($_POST['submit'])){

	if($_POST['recomend_by_master']!=''){
		$recomend_by_master = $_POST['recomend_by_master'];
	}
	
	// если перенаправляем задачу..
	if($_POST['id_master_re']!=''){
		$id_master_re = $_POST['id_master_re'];
		
		$q = mysql_query("SELECT * FROM clients WHERE id='".$_GET['id_zad']."'");
		$r = mysql_fetch_array($q);
	
		$date_add = date(Ymd);
		$time_add = date(Hi);
		
		$q1 = mysql_query("SELECT * FROM masters WHERE id='".$r['id_master']."'");
		$r1 = mysql_fetch_array($q1);
		
		//$full_recomend_by_master = $r['comment']."<br> ".$recomend_by_master." (".$r1['name'].")<br>";
		$full_recomend_by_master = $r1['name'].": ".$recomend_by_master;

		$query = "INSERT INTO clients (show1, status, id_master, date_add, time_add, name, address, phone, problema, comment) VALUES ('1', '1', '$id_master_re', '$date_add', '$time_add', '$r[name]', '$r[address]', '$r[phone]', '$r[problema]', '$full_recomend_by_master')";
		$res = mysql_query($query) or die(mysql_error()); 

	}

	if($_POST['comment_by_master']!=''){
		$comment_by_master = $_POST['comment_by_master'];
	}
	
	if($_POST['cena_work']!=''){
		$cena_work = $_POST['cena_work'];
	}

	if($_POST['cena_hard']!=''){
		$cena_hard = $_POST['cena_hard'];
	}
	
	$decisions_status = $_POST['decisions_status'];
	
	$date_end = date('Ymd');
	$time_end = date('Hi');
	
	// если выше ошибок не было обнаружено..
	if(strlen($error)==0){
		$query = "UPDATE clients SET status='2', date_end='$date_end', time_end='$time_end', comment_by_master='$comment_by_master', recomend_by_master='$recomend_by_master', decisions_status='$decisions_status', cena_work='$cena_work', cena_hard='$cena_hard' WHERE id=".$_GET[id_zad];
		$res = mysql_query($query) or die(mysql_error()); 
	}
	
	if(isset($_POST['future_task'])){
		//$future_id = $_POST['future_id'];
		$future_name = $_POST['future_name'];
		$future_phone = $_POST['future_phone'];
		$future_master = $_POST['future_master'];
		$future_address = $_POST['future_address'];
		$future_comment = $_POST['future_comment'];
		if(isset($_POST['self_variant'])){
			$device_type = $_POST['device_type_1'];
		}else{
			$device_type = $_POST['device_type_2'];
		}
		$date_add = $_POST['future_date'];
		$time_add = date('Hi');
		$future_date_add = date(Ymd);
		$future_query = "INSERT INTO `clients` (`id`, `date_add`, `time_add`, `future_date_add`, `patern_master`, `phone`, `name`, `address`, `problema`, `comment`, `comment_edit_date`, `comment_by_master`, `comment_by_master_edit_date`, `recomend_by_master`, `decisions_status`, `device_type`, `id_master`, `cena_work`, `cena_hard`, `date_end`, `time_end`, `date_oplata`, `time_oplata`, `date_zp`, `status`, `show1`, `archive`) VALUES (NULL , '$date_add', '$time_add', '$future_date_add', '$future_master', '$future_phone', '$future_name', '$future_address', '$future_comment', '', '0', '', '0', '', NULL , '$device_type', '', '0', '0', '0', '0', '0', '0', '0', '0', '1', '0')";
		$future_res = mysql_query($future_query) or die(mysql_error()); 
	}
	header("location:master.php?id=".$_GET[id]);
}
?>


<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>Управление клиентами. Nanobyte</title>
	<link rel="stylesheet" type="text/css" href="reset.css" />
	<link rel="stylesheet" type="text/css" href="main.css" />
	<link rel="stylesheet" type="text/css" href="scripts/ui-lightness/jquery-ui-1.10.3.custom.min.css" media="screen" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
	<script type="text/javascript" src="scripts/jquery-ui-1.10.3.custom.min.js"></script>

<script type='text/javascript'> 
	function del(){if(confirm("Удалить?")){return true;}else{return false;}} 
	function confirmDelete(){if (confirm("Точно завершить?")){return true;}else{return false;}}
</script> 
<script type='text/javascript'> 
	$(document).ready(function() {
		$('#save').click(function(){
			$('#decisions-3').attr("checked", true);
			$('#date_future').attr('required', false);
			$('#future_comment').attr('required', false);
		});
		$('#future_task').click(function(){
			if($(this).attr('checked')){
				$('#future').show(500);
				$('#date_future').attr('required', true);
				$('#future_comment').attr('required', true);
			}else{
				$('#future').hide(500);
				$('#date_future').attr('required', false);
				$('#future_comment').attr('required', false);
			}
		});
		$('#self_variant').click(function(){
			if($(this).attr('checked')){
				$('#device_type').css('display','inline');
				$('#device_type').focus();
				$('.device_type').hide(100);
			}else{
				$('#device_type').css('display','none');
				$('#device_type').val('');
				$('.device_type').show(100);
			}
		});
		$( "#date_future" ).datepicker({
			monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
			monthNamesShort: ['Янв','Фев','Мар','Апр','Май','Июн','Июл','Авг','Сен','Окт','Ноя','Дек'],
			dayNames: ['воскресенье','понедельник','вторник','среда','четверг','пятница','суббота'],
			dayNamesShort: ['вск','пнд','втр','срд','чтв','птн','сбт'],
			dayNamesMin: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
			firstDay: 1,
			minDate: 0,
			dateFormat: "yymmdd",
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
</style>

</head>

<body style="padding:20px;padding-top:0;" onLoad='$("#comment_by_master").focus()'>


<!-- HEADER //-->



<!-- CONTENT //-->

	<table width="100%" border="0">
	<tr>

	<td valign="top">
<!-- CENTER COLUMN //-->
<?
	if(md5('1')==$_GET[id]){
		$xxx = 1;
	}elseif(md5('2')==$_GET[id]){
		$xxx = 2;
	}/*elseif(md5('3')==$_GET[id]){
		$xxx = 3;
	}elseif(md5('4')==$_GET[id]){
		$xxx = 4;
	}elseif(md5('5')==$_GET[id]){
		$xxx = 5;
	}elseif(md5('6')==$_GET['id']){
		$xxx = 6;
	}elseif(md5('8')==$_GET['id']){
		$xxx = 8;
	}*/elseif(md5('7')==$_GET['id']){
		$xxx = 7;
	}else{
		echo "";
		die();
	}

if($_GET[a] AND $_GET[a]=='edit'){
$res = mysql_query("SELECT * FROM clients WHERE id=".$_GET[id_zad]);
$row = mysql_fetch_array($res);
?>
<h1 style="margin-bottom:25px;">Редактирование задачи</h1>
		<form name="add_client" id="add_client" method="post" action="">		
		<table width="100%">
		<tr>
		<td width="50%">

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
		<td width="150" align="right" style="padding-top:5px;" valign="top">
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
		<td width="150" align="right" style="padding-top:5px;" valign="top">
		Имя клиента
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<span style="font-size:16pt;"><b><?=$row[name]?></b></span>
		</td>
		</tr>
		
		<?if($row['id_master']!=5){?>	
		<tr>
		<td width="150" align="right" style="padding-top:5px;" valign="top">
		Адрес
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<?=$row[address]?>
		</td>
		</tr>
		
		<?}?>

		<tr>
		<td width="150" align="right" style="padding-top:5px;">
		Комментарий для мастера
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;font-size:12pt;">
		<?=$row[comment]?>
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:5px;">
		Устройство
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;font-size:12pt;">
		<?=$row[device_type]?>
		</td>
		</tr>

		</table>
		
		<table border="0" width="800" style="margin-top:15px;<?if($row[status]==0){echo "display:none";}?>">
		

		<tr  style="background:#eee;border-top:1px solid #999;padding-top:15px;">
			<td width="150" align="right" style="padding-top:15px;">
				Проблемма
			</td>
			<td width="20">
				&nbsp;
			</td>
			<td style="padding-top:5px;padding-bottom:15px;">
			<?foreach ($decisions_status as $num=>$row2){
				echo '<label for="decisions-'.$num.'">'.$row2.'</label>&nbsp;<input type="radio" value="'.$num.'" name="decisions_status" id="decisions-'.$num.'" required="required" '.$checked.'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			}?>
			</td>
		</tr>		


		<tr style="background:#eee;">
		<td width="150" align="right" style="padding-top:15px;">
		Что выполнено<BR>
		<div style="background:green; padding:4px;margin-top:7px;width:89px;">
		<input type="submit" name="save" id="save" style="padding:10px;" value="Сохранить">
		</div>
		</td>
		<td width="20" style="">
		&nbsp;
		</td>
		<td style="padding-top:15px;">
		<textarea style="width:526px;height:80px;padding:2px;" id="comment_by_master" name="comment_by_master"><?=$row[comment_by_master]?></textarea>
		</td>
		</tr>

		<tr style="background:#eee;">
		<td width="150" align="right" style="padding-top:5px;padding-bottom:5px;">
		Задачи для мастера СЦ<br>
		Реком. от мастера КП
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;padding-bottom:15px;">
		<textarea style="width:526px;height:50px;padding:2px;" name="recomend_by_master"><?=$row[recomend_by_master]?></textarea>
		</td>
		</tr>
		
		<?if($row['id_master']!=5){?>	
		<tr  style="background:#eee;">
		<td width="150" align="right" style="padding-top:15px;">
		Цена работы
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:15px;">
		<input type="text" class="standart" style="width:100px;" value="<?=$row[cena_work]?>" name="cena_work" maxlength="50"> грн.
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="150" align="right" style="padding-top:5px;padding-bottom:15px;">
		Цена железа
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;padding-bottom:15px;">
		<input type="text" class="standart" style="width:100px;" value="<?=$row[cena_hard]?>" name="cena_hard" maxlength="50"> грн.
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="150" align="right" style="padding-top:5px;padding-bottom:15px;">
		<label style="vertical-align:middle;" for="future_task">Заявка на будущее?</label>
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;padding-bottom:15px;">
		<input type="checkbox" id="future_task" name="future_task">
		</td>
		</tr>		
		<?}?>
		
		</table>
	
		
		<table style="margin-top:15px;">
			<tr>
				<td width="150" align="right" style="padding-top:10px;">
				</td>
				<td width="20">
					&nbsp;
				</td>
				<td style="padding-top:20px;">
					<div style="background:#ccc; padding:4px;"><input type="submit" onClick="return confirmDelete();" name="submit" id="submit" style="padding:10px;" value="Завершить задачу"></div>		
				</td>
			</tr>
		</table>
		

		</td>
		<td valign="top" width="50%">
			<div id="future" style="padding:10px;display: none;">
				<div class="client_id"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">id</span><input type="text" readonly name="future_id" value="<?=$row[id]?>" /></div>
				<div class="client_name"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Имя клиента</span><input type="text" readonly name="future_name" value="<?=$row[name]?>" /></div>
				<div class="client_date"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Дата прозвона</span><input type="text" name="future_date" id="date_future" value="" /></div>
				<div class="client_address"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Адрес</span><input type="text" readonly name="future_address" value="<?=$row[address]?>" /></div>
				<div class="client_comment"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Комментарий для мастера</span><textarea style="width:300px;height:100px;padding:2px;" name="future_comment" id="future_comment"></textarea></div>
				<div class="client_device_type">
					<span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Тип устройства</span>
					<label style="vertical-align:middle;" for="self_variant">Свой вариант?</label> <input type="checkbox" id="self_variant" style="vertical-align:middle;" name="self_variant">
					<input class="standart" style="display:none;" type="text" id="device_type" name="device_type_1">
					<select name="device_type_2" id="device_type" class="device_type">
						<option value="Компьютер">Компьютер</option>
						<option value="Ноутбук">Ноутбук</option>
					</select>
				</div>
				<input type="hidden" name="future_phone" value="<?=$row['phone']?>" />
				<input type="hidden" name="future_master" value="<?=$row['id_master']?>" />
			</div>
		</td>
		</tr>
		</table>
		</form>

<?}else{
		
	$s = mysql_query("SELECT * FROM masters WHERE id=".$xxx);
	$r = mysql_fetch_array($s);
	


?>

<?if($xxx==1){?>
<div style="border:1px solid #ccc;color:#333;padding:10px;float:right; position:relative;margin-top:10px;font-size:12pt;font-weight:bold;">
<?
$zp=0;
$i=0;
$y=0;
$date_s = "";
$date_e = "";
$q0 = mysql_query("SELECT * FROM clients WHERE id_master='$xxx' AND date_oplata!='0' AND date_zp='0' ORDER BY date_end ASC");
while($r0 = mysql_fetch_array($q0)){
	if($date_s==''){$date_s = $r0['date_end'];}
	$zp = $zp + $r0['cena_work']*0.40;	
	$zp = $zp + $r0['cena_hard']*0.05;
	
	$i++;
	if($r0['cena_work']!=0 OR $r0['cena_hard']!=0){
		$y++;
	}
}
echo $zp;
$x = $zp/$y;
?> грн. к выплате <span style="color:#999;">(за <?=$i?> задач)</span>
с <?=date_s($date_s);?> <span style="position:relative;top:-7px;color:#999;font-size:10pt;font-weight:normal;">коэфф.: <?=ceil($x)?></span>
</div>
<?}?>

<h1 style="margin-bottom:20px;">Список задач для <?=$r[name]?></h1>

<div style="margin-bottom:15px;"><a onClick="$('#prime4').slideToggle();" class="big" href="javascript:void(0)">Добавить на будущее</a></div>
<div id="prime4" style="display:none;margin-bottom:15px;background:#eee;width:600px;padding:10px;">
	<form method="post" action="master.php?<?=$_SERVER['QUERY_STRING']?>" name="form1">
		<div class="client_id"><label style="padding:10px;width:150px;display:inline-block;font-weight:bold;">id задачи</label><input type="text" value="" name="prime4_id"></div>
		<div class="client_date"><label style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Дата прозвона</label><input type="text" name="future_date" id="date_future" value="" /></div>
		<div class="client_device_type">
			<span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Тип устройства</span>
			<label style="vertical-align:middle;" for="self_variant">Свой вариант?</label> <input type="checkbox" id="self_variant" style="vertical-align:middle;" name="self_variant">
			<input class="standart" style="display:none;" type="text" id="device_type" name="device_type_1" />
			<select name="device_type_2" id="device_type" class="device_type">
				<option value="Компьютер">Компьютер</option>
				<option value="Ноутбук">Ноутбук</option>
			</select>
		</div>
		<div class="client_comment"><label style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Комментарий для мастера</label><textarea style="width:400px;height:50px;padding:2px;" name="prime4_text"></textarea></div>
		<input type="hidden" name="master" value="<?=$xxx?>">
		<input type="submit" style="padding:3px;margin-top:10px;" value="Отправить" name="prime4_submit" />
	</form>
</div>

<table width="100%" id="list" style="width:100%">
<tr id="tit">
<td></td>
<td>ID</td>
<td>Дата</td>
<td style="width:40px">Имя</td>
<?if($xxx!=5){?><td>Адрес</td><?}?>
<td>Устройство</td>
<td>Для мастера</td>
<td>Выполнено</td>
<td>Рекомендации</td>
<?if($xxx!=5){?>
<td>Ц. работа</td>
<td>Ц. железо</td>
<td>Ц. общ.</td>
<?}?>
<td>Дата заверш.</td>
</tr>

<?
$cur_date = date(Ymd) - 2;
$res = mysql_query("SELECT * FROM clients WHERE show1=1 AND id_master=".$xxx." AND date_oplata=0 ORDER BY id DESC");
//$res = mysql_query("SELECT * FROM clients WHERE show1=1 AND id_master=".$xxx." ORDER BY id DESC");
while($row = mysql_fetch_array($res)){
	$st = $row[status];
	if($st==0){
		$color="#ffbc9b";
	}elseif($st==1){
		$color="#ffff77";
	}else{
		$color="#c0ebc0";
	}
	
	$background_by_master = "";
	$background_by_operator = "";
	
	if($st==1){
		if($row[comment_edit_date]!=0 OR $row[comment_by_master_edit_date]!=0){
			if($row[comment_edit_date]<$row[comment_by_master_edit_date]){
				$background_by_master = "background:#ffd642;";
				$background_by_operator = "";
			}else{
				$background_by_master = "";
				$background_by_operator = "background:#ffd642;";
			}
		}
	}
	
	
	$d = substr($row['date_add'],6,2);
	$m = substr($row['date_add'],4,2);
	$y = substr($row['date_add'],0,4);
	$date_add = $d.".".$m.".".$y;
	
	$h = substr($row['time_add'],0,2);
	$mm = substr($row['time_add'],2,2);
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
	<?if($row['status']!=2 OR $row['id_master']==5){?>
	<a title="Редактировать" href="?id=<?=$_GET[id]?>&a=edit&id_zad=<?=$row[id]?>"><img src="ico_edit.gif"></a>
	<?}?>
	</td>
	<td><?=$row[id]?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_add?></span><br><?=$time_add?></td>
	<td><?=$row[name]?></td>
	<?if($xxx!=5){?><td><?=$row[address]?></td><?}?>
	<td><?=$row[device_type]?></td>
	<td style="<?=$background_by_operator?>font-size:9pt;"><?=$row[comment]?></td>
	<?
	$s = mysql_query("SELECT * FROM masters WHERE id=".$row[id_master]);
	$r = mysql_fetch_array($s);
	?>
	<td style="<?=$background_by_master?>font-size:9pt;"><?=$row[comment_by_master]?></td>
	<td style="font-size:9pt;"><?=str_replace("\r\n","<br>",$row['recomend_by_master'])?></td>
	
	<?if($xxx!=5){?>
	<td><b><?=$row[cena_work]?></b></td>
	<td><b><?=$row[cena_hard]?></b></td>
	<td><b><?=$row[cena_hard]+$row[cena_work]?></b></td>
	<?}?>
		
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_end?></span><br><?=$time_end?></td>
	
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