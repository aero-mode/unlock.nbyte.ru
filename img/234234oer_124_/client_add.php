<?
// проверка авторизации
include "connect2db.php";
connect();
if (isset($_POST['submit'])){

	if($_POST['name']!=''){
		$name = mysql_real_escape_string($_POST['name']);
	}
	
	if($_POST['device_type']!=''){
		$device_type = mysql_real_escape_string($_POST['device_type']);
	}
	
	if($_POST['model']!=''){
		$model = mysql_real_escape_string($_POST['model']);
	}
	
	if($_POST['sn']!=''){
		$sn = mysql_real_escape_string($_POST['sn']);
	}
	
	if($_POST['find_out']!=''){
		$find_out = mysql_real_escape_string($_POST['find_out']);
	}
	
	if($_POST['phone']!=''){
		$phone = $_POST['phone'];
	}else{
		$error.= "Введите контактный телефон<br>";
	}

	if($_POST['problema']!=''){
		$problema = mysql_real_escape_string($_POST['problema']);
	}else{
		$error.= "Введите описание проблемы<br>";
	}	
	
	if($_POST['problema_opisanie']!=''){
		$problema_opisanie = mysql_real_escape_string($_POST['problema_opisanie']);
	}

	if($_POST['comment']!=''){
		$comment = $_POST['comment'];
	}	
	
	if($_POST['id_client']!=''){
		$id_client = $_POST['id_client'];
	}	
	
	
	$date_add = date(Ymd);
	$time_add = date(Hi);

	// если выше ошибок не было обнаружено..
	if(strlen($error)==0){
		$query = "INSERT INTO clients_sc (show1, id_client, status, date_add, time_add, name, device_type, model, sn, find_out, opinion, opinion_text, phone, problema, problema_opisanie, comment) VALUES ('1', '$id_client', '0', '$date_add', '$time_add', '$name', '$device_type', '$model', '$sn', '$find_out', '0', '', '$phone', '$problema', '$problema_opisanie', '$comment')";
		$res = mysql_query($query) or die(mysql_error()); 
		
		$newid =  mysql_insert_id();
		header("location:add_akt_priem.php?id=$newid");
		//header("location:interface_operator_nb_10.php");
	}
}

?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>NB-СЦ / Новая задача</title>
	<link rel="stylesheet" type="text/css" href="reset.css" />
	<link rel="stylesheet" type="text/css" href="main.css" />
	<script type='text/javascript' src='jquery.js'></script>
	<script type='text/javascript' src='jquery.validate.js'></script>
	<script type='text/javascript' src='jquery.keyfilter-1.7.js'></script>
	
		<script type="text/javascript">

	$(document).ready(function() {

	var validator = $("#add_client").validate({
		rules: {
				name: {
					required: true
				},
				device_type: {
					required: true
				},
				phone: {
					required: true
				},
				problema: {
					required: true
				},
				find_out: {
					required: true
				}
			},
			messages: {
				name: {
					required: "Введите имя"
				},
				device_type: {
					required: "Выберите устройство"
				},
				phone: {
					required: "Введите телефон"
				},
				problema: {
					required: "Текст проблемы"
				},
				find_out: {
					required: "Откуда"
				}
			}
		});
		
		$("#name").focus();
	});
	
	</script>
	
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

</head>

<body>


<!-- HEADER //-->

	<table width="100%" border="0" style="margin-top:20px;border-bottom:2px solid #006699;">
	<tr>
	<td  valign="top" colspan="4">
	<h1 style="margin:0;margin-bottom:20px;margin-left:20px;">NB / Сервис центр</h1>
	</td>
	<td align="right" valign="top" style="padding-right:25px;">
		<a style="font-size:14pt;font-weight:bold;" href="interface_operator_nb_10.php">Список задач</a>
	</td>
	</tr>
	</table>


<!-- CONTENT //-->

	<table border="0" style="margin:20px;">
	<tr>
	<td valign="top">
<!-- CENTER COLUMN //-->


<h1 style="margin-bottom:25px;">Новая задача</h1>

		<? 
		if(strlen($error)>0){
			echo "<div style='margin-top:10px;color:#cc3300;padding:2px;padding-left:10px;border-left:2px solid #cc3300;'><b>Ошибка!</b><br>".$error."</div>";
		} 
		?>

		<form name="add_client" id="add_client" method="post" action="<?=$_SERVER['PHP_SELF']?>">
		<table border="0" style="margin-top:20px;">

		<tr>
		<td width="150" align="right" style="padding-top:5px;" valign="top">
		Дата
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<?=date('d.m.Y');?> года, <?=date('H:i');?>
		</td>
		</tr>
		

		<tr>
		<td width="150" align="right" style="padding-top:5px;" valign="top">
		ID клиента
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<input type="text" class="standart" style="width:100px;" name="id_client" id="id_client" maxlength="50">
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
		<input type="text" class="standart mask-pint" style="width:200px;" name="phone" maxlength="10">
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
		<input type="text" class="standart" style="width:400px;" name="name" id="name" maxlength="50">
		</td>
		</tr>
		
		
		<tr>
			<td width="150" align="right" style="padding-top:5px;" valign="top">
				Тип устройства
			</td>
			<td width="20">
				&nbsp;
			</td>
			<td style="padding-top:5px;">
				<select class="standart" name="device_type" id="device_type" style="width:200px;padding:2px;" >
					<option value="" checked></option>
					<option value="Ноутбук">Ноутбук</option>
					<option value="ПК">ПК</option>
					<option value="Планшет">Планшет</option>
					<option value="Монитор">Монитор</option>
					<option value="Смартфон">Смартфон</option>
					<option value="UPS">UPS</option>
					<option value="Фотоаппарат">Фотоаппарат</option>
					<option value="Принтер">Принтер</option>
					<option value="Другое">Другое</option>
				</select>
			</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:25px;" valign="top">
		Модель
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<input type="text" class="standart" style="width:200px;margin-top:15px;" name="model" maxlength="80">
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:5px;" valign="top">
		SN
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<input type="text" class="standart" style="width:200px;" name="sn" maxlength="80">
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:15px;">
		Описание проблемы со слов клиента
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;" valign="middle">
		<textarea style="vertical-align:middle;width:526px;height:50px;padding:2px;margin-top:15px;" name="problema_opisanie"></textarea>
		</td>
		</tr>

		<tr>
		<td width="150" align="right" style="padding-top:5px;">
		Разговор с клиентом
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;" valign="middle">
		<textarea style="vertical-align:middle;width:526px;height:50px;padding:2px;" name="problema"></textarea>
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:0px;">
		Задача для мастера
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<textarea style="width:526px;height:50px;padding:2px;" name="comment"></textarea>
		</td>
		</tr>
		
		<tr>
			<td width="150" align="right" style="padding-top:0px;">
				Откуда клиент узнал
			</td>
			<td width="20">
				&nbsp;
			</td>
			<td style="padding-top:5px;">
				<select class="standart" name="find_out" id="find_out" style="width:200px;padding:2px;" >
					<option value="" checked></option>
					<option value="Интернет">Интернет</option>
					<option value="Порекомендовали">Порекомендовали</option>
					<option value="Постоянный клиент">Постоянный клиент</option>
					<option value="Проходил мимо">Проходил мимо</option>
					<option value="РадиоРынок">РадиоРынок</option>
					<option value="По гарантии">По гарантии</option>
					<option value="Другое">Другое</option>
				</select>
			</td>
		</tr>

		<tr>
		<td width="150" align="right" style="padding-top:10px;">
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:10px;">
		<input type="submit" name="submit" style="padding:7px;" value="Добавить задачу">
		</td>
		</tr>
			
		</table>

		</form>








<??>




	</td>
	</tr>
	</table>

<br><br><br>
</body>
</html>