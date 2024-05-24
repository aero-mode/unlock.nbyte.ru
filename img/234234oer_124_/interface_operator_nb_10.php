<?
// проверка авторизации
//require "auth.php";
include "connect2db.php";
connect();
header("charset=windows-1251");

// если нажали кнопку ДЕНЬГИ ПОЛУЧЕНЫ
if (isset($_POST['submit_oplata'])){
	$date_oplata = date('Ymd');
	$time_oplata = date('Hi');
	
	$cena_work = $_POST['cena_work'];
	$cena_hard = $_POST['cena_hard'];
	
	$query = "UPDATE clients_sc SET date_oplata='$date_oplata', time_oplata='$time_oplata', cena_work='$cena_work', cena_hard='$cena_hard' WHERE id=".mysql_real_escape_string($_POST['id']);
	$res = mysql_query($query); 
	header("location:interface_operator_nb_10.php");
}
if(isset($_POST['opinion']) && $_POST['opinion'] == 1){
	(isset($_POST['opinionText']))?$opinionText = mysql_real_escape_string(iconv("UTF-8", "CP1251", $_POST['opinionText'])):$opinionText = "";
	$opinion = intval($_POST['opinion']);
	$id = intval($_POST['id']);
	$query = "UPDATE clients_sc SET `opinion` = '".$opinion."', `opinion_text` = '".$opinionText."' WHERE `id` = ".$id;
	$res = mysql_query($query) or die(mysql_error());
	exit();
}
// завершение задачи
if (isset($_POST['submit_end'])){

	if($_POST['cena_work']!=''){
		$cena_work = $_POST['cena_work'];
	}

	if($_POST['cena_hard']!=''){
		$cena_hard = $_POST['cena_hard'];
	}	
	
	if($_POST['problema']!=''){
		$problema = mysql_real_escape_string($_POST['problema']);
	}
	
	$decisions_status = $_POST['decisions_status'];
	
	if(isset($_POST['future_task'])){
		$future_id_client = mysql_real_escape_string($_POST['future_id_client']);
		$future_name = mysql_real_escape_string($_POST['future_name']);
		$future_phone = mysql_real_escape_string($_POST['future_phone']);
		$future_date_add = mysql_real_escape_string($_POST['future_date']);
		$future_time_add = date(Hi);
		$future_model = mysql_real_escape_string($_POST['future_model']);
		$future_sn = mysql_real_escape_string($_POST['future_sn']);
		$future_problema_opisanie = mysql_real_escape_string($_POST['future_problema_opisanie']);
		
		$query = "INSERT INTO `clients_sc` (`id`, `id_client`, `date_add`, `time_add`, `future_date_add`, `phone`, `name`, `model`, `sn`, `problema`, `problema_opisanie`, `comment`, `comment_edit_date`, `comment_by_master`, `comment_by_master_edit_date`, `recomend_by_master`, `decisions_status`, `id_master`, `cena_work`, `cena_hard`, `date_end`, `time_end`, `date_oplata`, `time_oplata`, `date_zp`, `status`, `show1`, `archive`) VALUES (NULL, '$future_id_client', '$future_date_add', '$future_time_add', '20131211', '$future_phone', '$future_name', '$future_model', '$future_sn', '', '$future_problema_opisanie', '', '', '', '', '', NULL, '', '', '', '', '', '', '', '', '0', '1', '0')";
		mysql_query($query) or die(mysql_error());
		//echo $query;

	}

	
	// если выше ошибок не было обнаружено..
	if(strlen($error)==0){
		$date_end = date('Ymd');		
		$time_end = date('Hi');		
		$query = "UPDATE clients_sc SET decisions_status='$decisions_status', cena_work='$cena_work', cena_hard='$cena_hard', status='2', problema='$problema', date_end='$date_end', time_end='$time_end' WHERE id=".mysql_real_escape_string($_GET['id']);
		$res = mysql_query($query); 
		$xxx = $_SERVER['REQUEST_URI'];
		if(substr_count($xxx, "work")>0){
			$yyy = "?work";
		}
		
		if(substr_count($xxx, "oplata")>0){
			$yyy = "?oplata";
		}
		
		header("location:interface_operator_nb_10.php".$yyy);
	}
	
}

if(isset($_POST['future_submit'])){
	$future_id_client = mysql_real_escape_string($_POST['future_id_client']);
	$future_name = mysql_real_escape_string($_POST['future_name']);
	$future_phone = mysql_real_escape_string($_POST['future_phone']);
	$future_date_add = mysql_real_escape_string($_POST['future_date']);
	$future_time_add = date(Hi);
	$future_model = mysql_real_escape_string($_POST['future_model']);
	$future_sn = mysql_real_escape_string($_POST['future_sn']);
	$future_problema_opisanie = mysql_real_escape_string($_POST['future_problema_opisanie']);
	
	$query = "INSERT INTO `clients_sc` (`id`, `id_client`, `date_add`, `time_add`, `future_date_add`, `phone`, `name`, `model`, `sn`, `problema`, `problema_opisanie`, `comment`, `comment_edit_date`, `comment_by_master`, `comment_by_master_edit_date`, `recomend_by_master`, `decisions_status`, `id_master`, `cena_work`, `cena_hard`, `date_end`, `time_end`, `date_oplata`, `time_oplata`, `date_zp`, `status`, `show1`, `archive`) VALUES (NULL, '$future_id_client', '$future_date_add', '$future_time_add', '20131211', '$future_phone', '$future_name', '$future_model', '$future_sn', '', '$future_problema_opisanie', '', '', '', '', '', NULL, '', '', '', '', '', '', '', '', '0', '1', '0')";
	mysql_query($query) or die(mysql_error());
	//echo $query;
	header("location:interface_operator_nb_10.php");
}



// сохранение изменений
if (isset($_POST['submit'])){

	if($_POST['name']!=''){
		$name = $_POST['name'];
	}
	
	// if($_POST['device_type']!=''){
		// $device_type = mysql_real_escape_string($_POST['device_type']);
	// }
	
	if($_POST['model']!=''){
		$model = $_POST['model'];
	}
	
	if($_POST['sn']!=''){
		$sn = $_POST['sn'];
	}
	
	if($_POST['id_client']!=''){
		$id_client = $_POST['id_client'];
	}
	
	if($_POST['phone']!=''){
		$phone = $_POST['phone'];
	}

	if($_POST['problema']!=''){
		$problema = mysql_real_escape_string($_POST['problema']);
	}
	
	if($_POST['problema_opisanie']!=''){
		$problema_opisanie = mysql_real_escape_string($_POST['problema_opisanie']);
	}

	if($_POST['comment']!=''){
		if(strlen($_POST['comment'])==$_POST['comment_length']){
			$status = 1 ;
		}else{
			$status = 0;
		}
		$comment = str_replace('\r\n',' ', mysql_real_escape_string($_POST['comment']));
	}	
		
	//$status='1';
		
	// если выше ошибок не было обнаружено..
	if(strlen($error)==0){
		// $date_current = date('ymdHis');
		$query = "UPDATE clients_sc SET cena_work='$cena_work', cena_hard='$cena_hard', status='$status', name='$name', phone='$phone', model='$model', sn='$sn', id_client='$id_client', problema='$problema', comment='$comment' WHERE id=".mysql_real_escape_string($_GET['id']);
		$res = mysql_query($query); 
		$xxx = $_SERVER['REQUEST_URI'];
		if(substr_count($xxx, "work")>0){
			$yyy = "?work";
		}
		
		if(substr_count($xxx, "oplata")>0){
			$yyy = "?oplata";
		}
		
		header("location:interface_operator_nb_10.php".$yyy);
	}
}
?>
<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>NB - сервис центр</title>
	<link rel="stylesheet" type="text/css" href="reset.css" />
	<link rel="stylesheet" type="text/css" href="main.css" />
	<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
	<script type="text/javascript" src="http://yandex.st/json2/2011-10-19/json2.min.js"></script>
	
	<script language="JavaScript">
	$(document).ready(function() {
		$('#save').click(function(){
			$('#decisions-3').attr("checked", true);
			$('#date_future').attr('required', false);
			$('#future_problema_opisanie').attr('required', false);
		});
		$('#future_task').click(function(){
			if($(this).attr('checked')){
				$('#future').show(500);
				$('#date_future').attr('required', true);
				$('#future_problema_opisanie').attr('required', true);
			}else{
				$('#future').hide(500);
				$('#date_future').attr('required', false);
				$('#future_problema_opisanie').attr('required', false);
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
		$("#smsWind").dialog({
			modal:true,
			autoOpen: false,
			position: 'top',
			width: 320,
			buttons:
			[{
				text: "Отправить",
				click: function(e){
					$("#smsF").submit();
					$(this).dialog("close");
				}
			},
			{
				text: "Закрыть",
				click: function(e){
					$(this).dialog("close");
				}
			}]
		});
		$("#smsF").submit(function(e){
			e.preventDefault();
			var s = $("#smsF").serialize();
			console.log(s);
			$.ajax({
				type: $(this).attr('method'),
				url: $(this).attr('action'),
				data: s
			});
		});

		$(".sms").click(function(){
			var phone = $(this).data("phone");
			$("#smsPh").val(phone);
			$("#smsText").val('');
			$("#smsWind").dialog("open");
		});
		$.fn.serializeObject = function(){
   var o = {};
   var a = this.serializeArray();
   $.each(a, function() {
      if (o[this.name]) {
         if (!o[this.name].push) {
            o[this.name] = [o[this.name]];
         }
         o[this.name].push(this.value || '');
      } else {
         o[this.name] = this.value || '';
      }
   });
   return o;
};
		$(".opinion").click(function(){
			$("#opinionName").val($(this).data("name"));
			$("#opinionPhone").val($(this).data("phone"));
			$("#opinionId").val($(this).data("id"));
			var id = $("#opinionId").val();
			$("#opinionWind").dialog({
				modal: true,
				position: 'top',
				width: 500,
				buttons:
				[{
					text: "Отправить",
					click: function(e){
						var s = $("#opinionForm").serializeObject();
						//console.log(JSON.stringify(s));
						$.post(location.href, {opinion: 1, opinionText: JSON.stringify(s), id: id});
						$("#opinionForm")[0].reset();
						$(this).dialog("close");
						$(this).dialog("destroy");
					}
				},
				{
					text: "Без отзыва",
					click: function(e){
						$.post(location.href, {opinion: 1, id: id});
						$("#opinionForm")[0].reset();
						$(this).dialog("close");
						$(this).dialog("destroy");
					}
				},
				{
					text: "Закрыть",
					click: function(e){
						$(this).dialog("close");
						$(this).dialog("destroy");
					}
				}]
			});
		});
	});
	</script>


	<script type='text/javascript'> 
		function del(){
			if(confirm("Удалить?")){
				return true;
			}else{
				return false;
			}
		}
		function oplata(cena_work, cena_hard, cena_all){
			if(confirm("\t\t\tДеньги получены?\r\n\r\nЦена работы: " + cena_work + " / Цена железа: " + cena_hard + " / Всего: " + cena_all)){
				return true;
			}else{
				return false;
			}
		}
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
.sms{
	border-bottom:1px solid #006699;
	color:#006699;
	cursor:pointer;
}
.sms:hover{
	border-bottom:0;
}
</style>

</head>

<body>

<div style="display:none" id="smsWind">
	<form action="sms.php" method="POST" id="smsF">
		<input type="text" name="phone" value="" id="smsPh" placeholder="Телефон..." style="margin-bottom:10px;width:300px;">
		<textarea id="smsText" name="smsText" style="margin-bottom:10px;width:300px;height:100px;"></textarea>
	</form>
</div>

<!-- HEADER //-->

	<table width="100%" border="0" style="margin-top:20px;border-bottom:2px solid #006699;">
	<tr>
	<td  valign="top" height="1" colspan="4">
	<h1 style="margin:0;margin-bottom:20px;margin-left:20px;">NB / Сервис центр</h1>
	</td>
	<td align="right" valign="top" height="1" style="padding-right:25px;">	
	<div class=""><a style="font-size:14pt; font-weight:bold;" href="client_add.php">Добавить задачу</a></div>
	<?if($_GET[a]!='edit'){?><div style="padding:15px;"><a onClick="$('#future').slideToggle();" style="text-decoration:none;border-bottom: 1px dotted red;" href="javascript:void(0)">Добавить на будущее</a></div><?}?>
	</td>
	</tr>
	<?if($_GET[a]!='edit'){?>
	<tr>
		<td>
			<div id="future" style="padding:10px;display: none;">
				<form name="add_future" id="add_future" method="post" action="">
					<div class="client_id"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">ID клиента</span><input type="text" name="future_id_client" value="<?=$row['id_client']?>" /></div>
					<div class="client_name"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Имя клиента</span><input type="text" name="future_name" value="<?=$row['name']?>" /></div>
					<div class="client_name"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Контактный телефон</span><input type="text" name="future_phone" value="<?=$row['phone']?>" /></div>
					<div class="client_date"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Дата прозвона</span><input type="text" required="required" name="future_date" id="date_future" value="" /></div>
					<div class="client_address"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Модель</span><input type="text" name="future_model" value="<?=$row['model']?>" /></div>
					<div class="client_address"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">SN</span><input type="text" name="future_sn" value="<?=$row['sn']?>" /></div>
					<div class="client_comment"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Проблема</span><textarea required="required" style="width:300px;height:100px;padding:2px;" name="future_problema_opisanie" id="future_problema_opisanie"></textarea></div>
					<div class="client_comment"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;"></span><input type="submit" name="future_submit" value="Добавить" /></div>
				</form>
			</div>
		</td>
	</tr>
	<?}?>
	</table>


<!-- CONTENT //-->

	<table border="0" width="100%">
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


<td valign="top">
<!-- CENTER COLUMN //-->
<?if($_GET[a] AND $_GET[a]=='edit'){
$res = mysql_query("SELECT * FROM clients_sc WHERE id=".$_GET[id]);
$row = mysql_fetch_array($res);

if($row['status']=='2' AND $row['date_oplata']!=0){
	?>Редактирование невозможно - заявка закрыта.<?
	die;
}
?>
<h1 style="margin-bottom:25px;"><a href="interface_operator_nb_10.php">Список задач</a> / Редактирование задачи</h1>
		<form name="add_client" id="add_client" method="post" action="">
		<table width="100%">
		<tr>
		<td width="50%">

		<table border="0" style="margin-top:20px;" width="650">

		<tr>
		<td width="140" align="right" style="padding-top:5px;" valign="top">
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
		<td width="140" align="right" style="padding-top:5px;">
		<b>Статус</b>
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		
		<?if($row['status']==2){
			?>Задача выполнена<?
		}elseif($row['status']==1){
			?>Задача в работе<?
		}elseif($row['status']==0){
			?>Задача ожидает<?
		}
		?> - <a href="add_akt_priem.php?id=<?=$row['id']?>">Акт приема оборудования</a>; <a href="add_act_bad.php?id=<?=$row['id']?>">Акт без рекомендаций</a>
		</td>
		</tr>
		
		<tr>
		<td width="140" align="right" style="padding-top:5px;" valign="top">
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
		<td width="140" align="right" style="padding-top:5px;" valign="top">
		ID клиента
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
			<input type="text" class="standart" value='<?=$row['id_client']?>' style="width:100px;" name="id_client" maxlength="50">
		</td>
		</tr>
		
		<tr>
		<td width="140" align="right" style="padding-top:5px;" valign="top">
		Имя клиента
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
			<input type="text" class="standart" value='<?=$row['name']?>' style="width:200px;" name="name" maxlength="50">
		</td>
		</tr>
		
		<tr>
		<td width="140" align="right" style="padding-top:5px;" valign="top">
		Тип устройства
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
			<?=$row['device_type']?>
		</td>
		</tr>
		
		<tr>
		<td width="140" align="right" style="padding-top:5px;" valign="top">
		Контактный телефон
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
			<input type="text" class="standart" style="width:200px;" value="<?=$row['phone']?>" name="phone" maxlength="11">
		</td>
		</tr>
		
		<tr>
		<td width="140" align="right" style="padding-top:15px;" valign="top">
		Модель
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:15px;">
			<input type="text" class="standart" style="width:200px;" value='<?=$row['model']?>' name="model" maxlength="80">
		</td>
		</tr>
		
		<tr>
		<td width="140" align="right" style="padding-top:5px;" valign="top">
		SN
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
			<input type="text" class="standart" style="width:200px;" value='<?=$row['sn']?>' name="sn" maxlength="80">
		</td>
		</tr>		
		
		<tr>
		<td width="140" align="right" style="padding-top:15px;">
			Описание проблемы<br> со слов клиента
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:15px;">
		<textarea style="width:400px;height:50px;padding:2px;" name="problema_opisanie"><?=$row['problema_opisanie']?></textarea>
		</td>
		</tr>

		<tr>
		<td width="140" align="right" style="padding-top:5px;">
		Разговор с клиентом
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;" valign="middle">
		<textarea style="vertical-align:middle;width:400px;height:100px;padding:2px;" name="problema"><?=$row['problema']?></textarea>
		</td>
		</tr>
		
		<tr>
		<td width="140" align="right" style="padding-top:5px;">
			Задача для мастера	
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;vertical-align:middle;">
			<textarea style="vertical-align:top;width:400px;height:50px;padding:2px;" name="comment"><?=$row['comment']?></textarea>
			<?
				$comment_length = strlen($row['comment']);
			?>
			<input type="hidden" name="comment_length" value="<?=$comment_length?>">
			<input type="submit" name="submit" style="vertical-align:top;padding:2px;" id="save" value="Сохранить">
		</td>
		</tr>
		
		</table>
		
		
		<table border="0" width="650" style="margin-top:20px;">
		<?if($row['status']=='1'){?>
		<tr  style="background:#eee;">
			<td width="140" align="right" style="padding-top:15px;">
				Проблемма
			</td>
			<td width="20">
				&nbsp;
			</td>
			<td style="padding-top:15px;">
			<?foreach ($decisions_status as $num=>$row2){
				echo '<label for="decisions-'.$num.'">'.$row2.'</label>&nbsp;<input type="radio" value="'.$num.'" name="decisions_status" id="decisions-'.$num.'" required="required" '.$checked.'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;';
			}?>
			</td>
		</tr>		
		<?}?>
		<?if($row['date_oplata']==0 AND $row['date_end']!=0 AND $row['status']=='2'){?>
		<tr  style="background:#eee;">
			<td width="140" align="right" style="padding-top:5px;padding-bottom:10px;">
				Проблемма решена
			</td>
			<td width="20">
				&nbsp;
			</td>
			<td style="padding-top:5px;padding-bottom:10px;">
				<b><?=$decisions_status[$row['decisions_status']]?></b>
			</td>
		</tr>
		<?}?>
		<tr style="background:#eee;">
		<td width="140" align="right" valign="top" style="padding-top:15px;">
		Что выполнено
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td valign="top" style="padding-top:15px;padding-bottom:15px;">
		<span><?=$row['comment_by_master']?></span>
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="140" align="right" style="padding-top:15px;">
		Цена работы
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:15px;">
			<input class="standart" value="<?=$row['cena_work']?>" style="width:50px;" type="text" name="cena_work"><b> руб.</b>
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="140" align="right" style="padding-top:5px;">
		Цена железа
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
			<input class="standart" type="text" value="<?=$row['cena_hard']?>" style="width:50px;" name="cena_hard"><b> руб.</b>
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="140" align="right" style="padding-top:5px;padding-bottom:10px;">
		Всего
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;padding-bottom:10px;">
		<b><?=$row['cena_hard']+$row['cena_work']?> руб.</b>    
		
		<?if($row['date_oplata']==0 AND $row['date_end']!=0 AND $row['status']=='2'){?>
			<input type="hidden" name="id" value="<?=$row['id']?>" style="padding:4px;margin-left:15px;">
			<input type="submit" name="submit_oplata" value="Деньги получены" style="padding:4px;margin-left:15px;">
		<?}?>
		</td>
		</tr>
		
		<tr>
		<td width="140" align="right" style="padding-top:15px;" valign="top">
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
		<td width="140" align="right" style="padding-top:3px;" valign="top">
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
		
		<table width="650">
		<tr>
		<td width="140" align="right" style="padding-top:10px;">
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:30px;">		
			<input type="submit" name="submit_end" style="background:#b2d8aa;padding:7px;margin-left:25px;" value="Завершить">
		</td>
		</tr>
		</table>
		
		</td>
		<?if($row['status']=='1'){?>
		<td valign="top" width="50%">
		<label style="vertical-align:middle;" for="future_task">Заявка на будущее?</label>
		<input type="checkbox" id="future_task" name="future_task">

			<div id="future" style="display:none" style="padding:10px;display: block;">
				<div class="client_id"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">id</span><input type="text" readonly name="future_id" value="<?=$row['id']?>" /></div>
				<div class="client_id"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">ID клиента</span><input type="text" readonly name="future_id_client" value="<?=$row['id_client']?>" /></div>
				<div class="client_name"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Имя клиента</span><input type="text" readonly name="future_name" value="<?=$row['name']?>" /></div>
				<div class="client_name"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Контактный телефон</span><input type="text" readonly name="future_phone" value="<?=$row['phone']?>" /></div>
				<div class="client_date"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Дата прозвона</span><input type="text" name="future_date" id="date_future" value="" /></div>
				<div class="client_address"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Модель</span><input type="text" readonly name="future_model" value="<?=$row['model']?>" /></div>
				<div class="client_address"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">SN</span><input type="text" readonly name="future_sn" value="<?=$row['sn']?>" /></div>
				<div class="client_comment"><span style="padding:10px;width:150px;display:inline-block;font-weight:bold;">Описание проблемы со слов клиента</span><textarea style="width:300px;height:100px;padding:2px;" name="future_problema_opisanie" id="future_problema_opisanie"></textarea></div>
			</div>
		</td>
		<?}?>
		</tr>
		</table>
		
		</form>


<?}elseif(isset($_GET['filter'])){
	?><h1 style="margin-bottom:25px;"><a href="interface_operator_nb_10.php">Список задач</a> для телефона: <?=$_GET[filter]?></h1>
	<table id="list" style="margin-right:20px;">
<thead>
<tr id="tit">
<th></th>
<th><a href="">ID</a></th>
<th><a href="">ID клиента</a></th>
<th><a href="">Дата 1</a></th>
<th><a href="">Дата 2</a></th>
<th><a href="">Имя</a></th>
<th><a href="">Модель</a></th>
<th><a href="">SN</a></th>
<th><a href="">Телефон</a></th>
<th>Проблема</th>
<th>Разговор с клиентом</th>
<th>Задача</th>
<th><a href="">Работа</a></th>
<th><a href="">Железо</a></th>
<th><a href="">Всего</a></th>
</tr>
</thead>
<?
$res = mysql_query("SELECT * FROM clients_sc WHERE show1=1 AND phone=".$_GET[filter]." ORDER BY date_add DESC, id DESC");
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
	
	(strlen($row['time_add'])<4)?$row['time_add']="0".$row['time_add']:$row['time_add']=$row['time_add'];
	
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
	<td align="center"><?=$row[id]?></td>
	<td align="center"><?=$row['id_client']?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_add?></span><br><?=$time_add?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_end?></span><br><?=$time_end?></td>
	<td><?=$row[name]?></td>
	<td><?=$row[model]?></td>
	<td><?=$row[sn]?></td>
	<td><?=str_replace(" ","&nbsp;",$row[phone])?></td>
	<td style="font-size:9pt;"><?=$row[problema_opisanie]?></td>
	<td style="font-size:9pt;"><?=$row[problema]?></td>
	<td style="font-size:9pt;"><?=$row[comment]?></td>

	<td><b><?=$row[cena_work]?></b></td>
	<td><b><?=$row[cena_hard]?></b></td>
	<td><b><?=$row[cena_hard]+$row[cena_work]?></b></td>
	
	</tr>
	<?
}
?>
</table>
	
	
	<?
}else{
			$curr_date = date('Ym');
			$curr_query = mysql_query("SELECT COUNT(*) FROM clients_sc WHERE status=2 AND show1=1 AND date_oplata!=0 AND date_oplata LIKE '".$curr_date."%'");
			$curr_request = mysql_result($curr_query, 0);
?>
<div style="height:80px;"><h1 style="float:left">Список задач для Оператора 
<!--<?//if(isset($_GET[view_all])){?>
	/ <a href="interface_operator_nb_10.php">последние 500</a>
<?//}else{?>
	/ <a href="?view_all">все</a>
<?//}?>-->

</h1>
<div style="padding:30px;float:right;color:#CC3300;font-family: Georgia,Times;font-size: 15pt;">За текущий месяц работ выполнено: <span style="color:black;"><?=$curr_request?> / 210<div style="width:20px;height:20px;<?if($curr_request>=210){?>background-color:green;<?}else{?>background-color:red;<?}?>border-radius:15px;display:inline-block;margin-left:15px;"></div></span></div>
	<div style="padding:30px;float:right;color:#CC3300;font-family: Georgia,Times;font-size: 15pt;">
		<?
		$curr_date = date(Ymd);
		$curr_query = mysql_query("SELECT COUNT(*) FROM clients_sc WHERE date_add = '".$curr_date."'");
		$curr_request = mysql_result($curr_query, 0);
		echo "Выполнено: ".$curr_request." шт.";
		if($curr_request<=5){
			echo "/6<div style=\"width:20px;height:20px;background-color:red;border-radius:15px;display:inline-block;margin-left:15px;\"></div>";
		}elseif($curr_request>=6 && $curr_request<10){
			echo "/10<div style=\"width:20px;height:20px;background-color:yellow;border-radius:15px;display:inline-block;margin-left:15px;\"></div>";
		}elseif($curr_request>=10 && $curr_request<=15){
			echo "/15<div style=\"width:20px;height:20px;background-color:green;border-radius:15px;display:inline-block;margin-left:15px;\"></div>";
		}else{
			echo "<div style=\"width:20px;height:20px;background-color:orange;border-radius:15px;display:inline-block;margin-left:15px;\"></div>";
		}
		?>
	</div>
</div>

<table width="100%" border="0" style="margin-bottom:15px;">
<tr>
<td>
<img src="legenda.gif">
</td>

<td>
Показать:&nbsp;
<ul class="masters" style="list-style:none;">
<li><a href="interface_operator_nb_10.php">Все</a></li>
<li><a href="?work">В работе</a></li>
<li><a href="?oplata">Не закрытые</a></li>
<li><a href="?future">Будущие</a></li>
</ul>
</td>

<td>
<form name="filter_get" method="get" action="" id="filter_get">
<input type="text" name="filter" style="background:#b2d8aa;padding:7px;margin-left:25px;" value="" placeholder="Номер телефона"  pattern="[0-9]{10,10}">
<input type="submit" name="submit_end" style="background:#b2d8aa;padding:7px;margin-left:25px;" value="Поиск">
</form>
</td>

</tr>
</table>

<table id="list" style="margin-right:20px;" width="100%">
<thead>
<tr id="tit">
<th></th>
<th></th>
<th><a href="">ID</a></th>
<th><a href="">ID клиента</a></th>
<th><a href="">Дата 1</a></th>
<th><a href="">Дата 2</a></th>
<th><a href="">Имя</a></th>
<th><a href="">Тип</a></th>
<th><a href="">Модель</a></th>
<th><a href="">SN</a></th>
<th><a href="">Телефон</a></th>
<th>Проблема</th>
<th>Разговор с клиентом	</th>
<th>Задача</th>
<th>Решение</th>
<th>Дата оплаты</th>

</tr>
</thead>
<?
$date_add_for_query = date(Ymd)+2;
if(isset($_GET[work])){
	$res = mysql_query("SELECT * FROM clients_sc WHERE show1=1 AND status=1 ORDER BY date_add DESC, id DESC");
}elseif(isset($_GET[oplata])){
	$res = mysql_query("SELECT * FROM clients_sc WHERE show1=1 AND date_end!=0 AND date_oplata=0 ORDER BY date_add DESC, id DESC");
}elseif(isset($_GET[future])){
	$res = mysql_query("SELECT * FROM clients_sc WHERE show1=1 AND status=0 AND date_add>='date(Ymd) ORDER BY date_add DESC, id DESC");
}else{
	if(!isset($_GET[view_all])){
		$page="LIMIT 0,500";
	}else{
		$page="";
	}
	$res = mysql_query("SELECT * FROM clients_sc WHERE show1=1 AND date_add<='$date_add_for_query' AND opinion=0 ORDER BY date_add DESC, id DESC $page");
}
while($row = mysql_fetch_array($res)){
	$st = $row[status];
	$background_by_master = "";
	$background_by_operator = "";
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
	
	(strlen($row['time_add'])<4)?$row['time_add']="0".$row['time_add']:$row['time_add']=$row['time_add'];
	
	$h = substr($row['time_add'],0,2);
	$mm = substr($row['time_add'],2,2);
	$time_add = $h.":".$mm;
	
	$do = substr($row['date_oplata'],6,2);
	$mo = substr($row['date_oplata'],4,2);
	$yo = substr($row['date_oplata'],2,2);
	$date_oplata3 = $do.".".$mo.".".$yo;
	
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
	
	if(($row['date_oplata']==0 AND $row[status]==2) || $row['date_add']>date(Ymd)){
		$date_oplata="2px solid red";
	}else{
		$date_oplata="none";
	}
	
	?>
	<tr style="background:<?=$color?>;border:<?=$date_oplata?>">
	<td align="center"><a href="add_akt.php?id=<?=$row[id]?>">акт</a><br><span class="sms" data-phone="<?=str_replace(" ","",$row['phone'])?>">смс</span></td>
	<td align="center"><a href="<?if(isset($_GET[oplata])){echo "?oplata&";}elseif(isset($_GET[work])){echo "?work&";}else{echo "?";}?>a=edit&id=<?=$row[id]?>"><img src="ico_edit.gif"></a><br>
		<?if($row['date_oplata']==0 AND $row[status]==2){?>
			<form method="POST" action="" name="submit_oplata_<?=$row['id']?>" id="submit_oplata_<?=$row['id']?>" >
				<input type="hidden" name="id" value="<?=$row['id']?>" />
				<input type="hidden" name="cena_work" value="<?=$row['cena_work']?>" />
				<input type="hidden" name="cena_hard" value="<?=$row['cena_hard']?>" />
				<input type="submit" onClick="return oplata('<?=$row['cena_work']?>', '<?=$row['cena_hard']?>', '<?=($row['cena_work']+$row['cena_hard'])?>');" name="submit_oplata" value="Оплата" title="<?="За работу: ".$row['cena_work']." руб / За железо: ".$row['cena_hard']." руб / Всего: ".($row['cena_work']+$row['cena_hard'])?>" />
			</form>
		<?}elseif($row['date_oplata']!=0 AND $row['opinion']==0){?>
				<button class="opinion" data-phone="<?=str_replace(" ","&nbsp;",$row['phone'])?>" data-name="<?=$row['name']?>" data-id="<?=$row['id']?>">Отзыв</button>
		<?}?>
	</td>
	<td style="text-align:center;"><?=$row['id']?></td>
	<td align="center"><?=$row['id_client']?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_add?></span><br><?=$time_add?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_end?></span><br><?=$time_end?></td>
	<td><?=$row['name']?></td>
	<td><?=$row['device_type']?></td>
	<td><?=$row['model']?></td>
	<td><?=$row['sn']?></td>
	<td><a href="?filter=<?=str_replace(" ","&nbsp;",$row['phone'])?>"><?=str_replace(" ","&nbsp;",$row['phone'])?></a></td>
	<td style="font-size:9pt;"><?=$row['problema_opisanie']?></td>
	<td style="font-size:9pt;"><?=$row['problema']?></td>
	<td style="font-size:9pt;"><?=$row['comment']?></td>
	<td style="font-size:9pt;"><?=$row['comment_by_master']?></td>
	<td><span style="font-size:8pt;color:#666;"><?=$date_oplata3?></span></td>
	
	</tr>
	<?
}
?>
</table>

<?}?>
	</td>
	</tr>
	</table>
	<div id="opinionWind"style="display:none">
		<form id="opinionForm">
			<div style="width:100%">
				<div style="float:left"><label><span style="padding-right:15px;">Имя</span><input class="standart" type="text" name="name" value="" id="opinionName"></label></div>
				<div style="float:right"><label><span style="padding-right:15px;">Телефон</span><input class="standart" type="text" name="phone" value="" id="opinionPhone"></label></div>
			</div>
			<div style="clear:both;margin-bottom:10px;"></div>
			<div style="width:100%;">
				<div style="float:left;width:200px;">Решили ли Вашу проблему?</div>
				<div style="float:right;">
					<textarea style="width:270px;height:70px;" name="opinionAnswer_1"></textarea>
					<input type="hidden" name="opinionId" id="opinionId">
				</div>
			</div>
			<div style="clear:both;margin-bottom:10px;"></div>
			<div style="width:100%;">
				<div style="float:left;width:200px;">Какие были сомнения?</div>
				<div style="float:right;">
					<textarea style="width:270px;height:70px;" name="opinionAnswer_2"></textarea>
				</div>
			</div>
			<div style="clear:both;margin-bottom:10px;"></div>
			<div style="width:100%;">
				<div style="float:left;width:200px;">Будите ли рекомендовать нас?</div>
				<div style="float:right;">
					<textarea style="width:270px;height:70px;" name="opinionAnswer_3"></textarea>
				</div>
			</div>
			<div style="clear:both;margin-bottom:10px;"></div>
			<div style="width:100%;">
				<div style="float:left;width:200px;">Какие данные можно опубликовать?</div>
				<div style="float:right;">
					<label style="padding-right:15px;"><span style="padding-right:15px;">Имя</span><input type="checkbox" name="opinionPubName"></label>
					<label style="padding-right:15px;"><span style="padding-right:15px;">Телефон</span><input type="checkbox" name="opinionPubPhone"></label>
					<label style="padding-right:15px;"><span style="padding-right:15px;">Фото</span><input type="checkbox" name="opinionPubPhoto"></label>
				</div>
			</div>
			<div style="clear:both"></div>
		</form>
	</div>
</body>
</html>