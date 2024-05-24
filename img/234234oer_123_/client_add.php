<?
// проверка авторизации
include "connect2db.php";
connect();
?>
<?

// добавление клиента
if (isset($_POST['submit'])){

	if($_POST['name']!=''){
		$name = mysql_real_escape_string($_POST['name']);
	}
	
	if($_POST['address']!=''){
		$address = mysql_real_escape_string($_POST['address']);
	}else{
		$error.= "Введите адрес<br>";
	}
	
	if($_POST['phone']!=''){
		$phone = $_POST['phone'];
	}else{
		$error.= "Введите контактный телефон<br>";
	}
	
	//  если МАСТЕР выбран
	if($_POST['id_master']!=''){
		$id_master = $_POST['id_master'];
		$status = 1;
	}else{
		$id_master = "";
		$status = 0;
	}

	if($_POST['problema']!=''){
		$problema = mysql_real_escape_string($_POST['problema']);
	}else{
		$error.= "Введите описание проблемы<br>";
	}	

	if($_POST['comment']!=''){
		$comment = $_POST['comment'];
	}
	
	if(isset($_POST['self_variant'])){
		$device_type = $_POST['device_type_1'];
	}else{
		$device_type = $_POST['device_type_2'];
	}
	
	
	$date_add = date(Ymd);
	$time_add = date(Hi);

	// если выше ошибок не было обнаружено..
	if(strlen($error)==0){
		$query = "INSERT INTO clients (show1, status, date_add, time_add, name, address, phone, problema, id_master, comment, device_type) VALUES ('1','$status', '$date_add', '$time_add', '$name', '$address', '$phone', '$problema', '$id_master', '$comment', '$device_type')";
		$res = mysql_query($query) or die(mysql_error()); 
		
		header("location:interface_operator_nb_8.php");
	}
}
?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>Добавление клиента. Nanobyte</title>
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
				address: {
					required: true
				},
				phone: {
					required: true
				},
				problema: {
					required: true
				}
			},
			messages: {
				name: {
					required: "Введите имя"
				},
				address: {
					required: "Введите адрес"
				},
				phone: {
					required: "Введите телефон"
				},
				problema: {
					required: "Текст проблемы"
				}
			}
		});
		
		$("#name").focus();
	});
	
	</script>
	<script>
		 $(function() {
			$('#self_variant').click(function(){
				if($(this).attr('checked')){
					$('#device_type').css('display','inline');
					$('#device_type').focus();
					$('.device_type').hide();
				}else{
					$('#device_type').css('display','none');
					$('#device_type').val('');
					$('.device_type').show();
				}
			});
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
	<td  valign="top" height="1" colspan="4">
	<h1 style="margin:0;margin-bottom:20px;margin-left:20px;">База клиентов</h1>
	</td>
	<td align="right" valign="top" height="1">
	</td>
	</tr>
	</table>


<!-- CONTENT //-->

	<table border="0">
	<tr>
	<td width="250" valign="top" style="background:#f6f2d9;">
	<div id='admin_menu_block' style="width:150px;margin:20px;">	
	<b>Наши клиенты</b>
	<ul>
	<li><a href="interface_operator_nb_8.php">Список задач</a></li>
	</ul>

	</div>
	</td>
	<td width="50">
	&nbsp;
	</td>
	<td valign="top">
<!-- CENTER COLUMN //-->



<h1 style="margin-bottom:25px;">Добавление клиента в базу</h1>

		<span class="big_text">
		Заполни, пожалуйста, все поля формы.
		</span>
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
		Адрес
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<input type="text" class="standart" style="width:400px;" name="address" maxlength="80">
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
		<td width="150" align="right" style="padding-top:5px;">
		Разговор с клиентом
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;" valign="middle">
		<textarea style="vertical-align:middle;width:526px;height:100px;padding:2px;" name="problema"></textarea>
		</td>
		</tr>


		<tr>
		<td width="150" align="right" style="padding-top:0px;">
		Комментарий для мастера
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<textarea style="width:526px;height:50px;padding:2px;" name="comment"></textarea>
		<h6>Что с собой взять, к скольки быть у клиента</h6>
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:5px;padding-bottom:15px;">
		Тип устройства
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;padding-bottom:15px;">
		
			<label style="vertical-align:middle;" for="self_variant">Свой вариант?</label> <input type="checkbox" id="self_variant" style="vertical-align:middle;" name="self_variant">
			
			<input class="standart" style="display:none;" type="text" id="device_type" name="device_type_1">
			
			<select name="device_type_2" id="device_type" class="device_type">
				<option value="Компьютер">Компьютер</option>
				<option value="Ноутбук">Ноутбук</option>
			</select>	
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

		<select name="id_master" id="id_master">
		<option value="">выбор мастера</option>
		<?
		$res2 = mysql_query("SELECT * FROM masters");
		while($row2 = mysql_fetch_array($res2)){
			?><option value="<?=$row2[id]?>"><?=$row2[name]?></option><?
		}
		?>
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