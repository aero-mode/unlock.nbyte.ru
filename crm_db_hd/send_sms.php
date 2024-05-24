<?php
if(isset($_POST['submit'])){
	if($_POST['text']!='' AND $_POST['number']!=''){
		$phone = $_POST['number'];
		$msg = substr($_POST['text'], 0, 500);
		
		if($_POST['translit']){
			$translit = 1;
		}else{
			$translit = 0;
		}
		include_once "smsc_api.php";
		$msg = stripslashes($msg);
		send_sms($phone, $msg, $translit);
		$status = "Сообщение отправлено";
	}else{
		die;
	}	
}
?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>

	<meta name="description" content="">
	<meta name="keywords" content="">

	<title>Отправка смс</title>


	<script>
	function textarea_count(count_number, dom_model, sp){
		a=dom_model.value.length;
		//if(a > count_number)dom_model.value=dom_model.value.substring(0,count_number);
		//a=dom_model.value.length;
		document.getElementById(sp).innerHTML = '' + (a) + '';
		a = a + 1;
	}
	</script>
<script>
	function Text_1(){
		var content = document.getElementById("sms_1").value;
		a=document.getElementById("sms_1").value.length;
		document.getElementById("text").innerHTML = content;
		document.getElementById("sp").innerHTML = '' + (a) + '';
		a = a + 1;
	}
	function Text_2(){
		var content = document.getElementById("sms_2").value;
		a=document.getElementById("sms_2").value.length;
		document.getElementById("text").innerHTML = content;
		document.getElementById("sp").innerHTML = '' + (a) + '';
		a = a + 1;
	}
	function Text_3(){
		var content = document.getElementById("sms_3").value;
		a=document.getElementById("sms_3").value.length;
		document.getElementById("text").innerHTML = content;
		document.getElementById("sp").innerHTML = '' + (a) + '';
		a = a + 1;
	}
</script>
	
</head>

<body>

<!-- CONTENT //-->

	<table width="100%" align="center">
	<tr>


	<td width="35">&nbsp;</td>
	<td valign="top" style="padding-right:35px">
		
		<div class="vrezka" style="margin-bottom:15px;">
			<h1 style="margin-top:10px;color:black;margin-bottom:18px;">Отправка смс</h1>
		</div>

		<?if($status!=''){?><div style="color:red;"><?=$status?></div><?}?>
		<form method="post" action="">
		<table width="100%" style="margin-bottom:40px;" border="0">
		
		<tr>
		<td width="100" align="right" style="padding-top:16px;" valign="top">
			<label for="number">Номер</label>
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:10px;">
		<input type="text" class="standart" name="number" id="number" style="padding:4px;width:400px;font-size:14pt;" value="<?=$_GET['phone']?>" maxlength="13">
		</td>
		
		<td rowspan="3" valign="top">
		<input type="button" id="button_1" onClick='Text_1();' value="Вставить" /> <input type="text" id="sms_1" disabled value='"Новая Почта" г.Симферополь,склад №8,Суятинов Александр,тел 0660707222' style="width:670px;"/>
		<br><br>
		<input type="button" id="button_2" onClick="Text_2()" value="Вставить" /> <input type="text" id="sms_2" disabled value='6762-4682-0260-3134, Журавлев Иван Викторович, карта Приватбанка, сумма к оплате ___ ГРН' style="width:670px;"/>
		<br><br>
		<input type="button" id="button_3" onClick="Text_3()" value="Вставить" /> <input type="text" id="sms_3" disabled value='№ ТТН - . Спасибо за то, что воспользовались нашими услугами, сайт remonthdd.com тел. 0660707222' style="width:670px;"/>
		</td>
		</tr>
		
		<tr>
		<td width="100" align="right" style="padding-top:28px;" valign="top">
			<label for="text">Текст</label>
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:20px;">
			<textarea onKeyUp="textarea_count(300, this, 'sp');" type="text" class="standart" name="text" id="text" style="width:400px;height:70px;"></textarea>
			<h4 style="margin-top:0;color:#333;">Набрано символов: <span id="sp">0</span></h4>
			до 70 символов - 1 смс., до 135 символов - 2 смс.
		</td>
		</tr>
		
		<tr>
		<td width="110" align="right" style="padding-top:10px;">
		&nbsp;
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:20px;">		
			<button class="button" name="submit" type="submit"><span><span>Отправить</span></span></button>	
		</td>
		</tr>
		</table>
		</form>
	
	</td>
	</tr>
	</table>
	
</body>
</html>