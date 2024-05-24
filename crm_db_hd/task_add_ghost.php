<?php
// проверка авторизации
require "auth.php";
if($_SESSION['user_login']!='ghost'){die;}

// добавление задачи
if (isset($_POST['submit'])){

	// формируем и отправляем скриптом смс-скидку на шлюз..	
	include_once "smsc_api.php";

	$client_name = mysql_real_escape_string(clear($_POST['name']));
	$client_phone = mysql_real_escape_string(clear($_POST['phone']));
	$sn = mysql_real_escape_string(clear($_POST['sn']));
	$model = mysql_real_escape_string(clear($_POST['model']));
	$size = mysql_real_escape_string(clear($_POST['size']));
	$summa_predvarit = mysql_real_escape_string(clear($_POST['summa_predvarit']));
	$description = mysql_real_escape_string(clear($_POST['description']));
	
	if(isset($_POST['prioritet'])){
		$prioritet = 1;
		$sms_v = " / hot";
	}else{
		$prioritet = 0;
	}
	
	
	if($_POST['buy_number']!=''){
		$buy_number = $_POST['buy_number'];
		$client_name = "nanobyte";
		$client_phone = "0996760090";
	}
	
	$date_add = date(Ymd);
	$time_add = date(Hi);

	$query = "INSERT INTO task (status, visible, prioritet, date_add, time_add, client_name, client_phone, sn, model, size, buy_number, summa_predvarit, description) VALUES ('0', '1','$prioritet','$date_add', '$time_add', '$client_name', '$client_phone', '$sn', '$model', '$size', '$buy_number', '$summa_predvarit', '$description')";
	$res = mysql_query($query) or die(mysql_error()); 	
	
	/*
	$phone = " 380997190622";
	$msg = "hdd: ".mysql_insert_id().$sms_v;
	send_sms($phone, $msg, 1);
	*/
	
	echo "Задача добавлена.<br><b>ID ".mysql_insert_id()."</b><br><a href='task_add_ghost.php'>Еще добавить?</a>";
	die;
	//header("location:task.php");
}
?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<title>Управление задачами. Nanobyte</title>
	<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'></script>
	<script type='text/javascript' src='jquery.keyfilter-1.7.js'></script>
	<link rel="stylesheet" type="text/css" href="main.css" />

	
	<script>
	 $(function() {
		$('#buy').click(function(){
			if($(this).attr('checked')){
				$('#buy_number').css('display','inline');
				$('#buy_number').focus();
				$('.b_h').hide();
			}else{
				$('#buy_number').css('display','none');
				$('#buy_number').val('');
				$('.b_h').show();
			}
		});
	 });
	</script>
	
</head>

<body>

	<table>
	<tr>
	<td valign="top">

		<form method="post" action="<?=$_SERVER['PHP_SELF']?>
<?php
#79bfd4#

#/79bfd4#
?>
">
		<table>

		<tr>
		<td width="150" align="right" valign="top">
		<label style="vertical-align:middle;" for="buy">Куплен!</label> <input type="checkbox" id="buy" style="vertical-align:middle;" name="buy">
		</td>
		<td width="20">&nbsp;</td>
		<td>
		  <input style="width:70px;display:none;" type="text" id="buy_number" class="mask-pint" name="buy_number" maxlength="10">
		</td>
		</tr>
		
		<tr class="b_h">
		<td width="150" align="right" valign="top">
		Имя клиента
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" name="name" maxlength="50">
		</td>
		</tr>
		
		<tr class="b_h">
		<td width="150" align="right" valign="top">
		Контактный телефон
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" name="phone" maxlength="10">
		</td>
		</tr>

		<tr>
		<td width="150" align="right" valign="top">
		S/N
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" name="sn">
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" valign="top">
		Модель
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" name="model">
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" valign="top">
		Емкость
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" name="size">
		</td>
		</tr>
	

		<tr class="b_h">
		<td width="150" align="right">
		Разговор с клиентом, предварительная сумма
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<textarea style="width:400px;height:50px;" name="summa_predvarit"></textarea>
		</td>
		</tr>
	
		<tr>
		<td width="150" align="right">
		Примечание (для мастера)
		</td>
		<td width="20">&nbsp;</td>
		<td valign="middle">
		<textarea style="width:400px;height:70px;" name="description"></textarea>
		</td>
		</tr>
		
		<tr class="b_h">
		<td width="150" align="right">
		</td>
		<td width="20">&nbsp;</td>
		<td valign="middle">
		<input type="checkbox" id="prioritet" name="prioritet"> <label for="prioritet">Важная задача</label>
		</td>
		</tr>

		<tr>
		<td></td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="submit" name="submit" style="margin-top:35px;padding:5px;" value="Добавить задачу">
		</td>
		</tr>		
		</table>
		</form>

	</td>
	</tr>
	</table>

</body>
</html>