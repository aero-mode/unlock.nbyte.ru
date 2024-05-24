<?php 
// проверка авторизации
require "auth.php";
if($_SESSION['user_login']=='operator' or $_SESSION['user_login']=='ghost'){

$curent_time = time();
// сохранение задачи
if (isset($_POST['submit'])){

	$status = mysql_real_escape_string(clear($_POST['status']));

	$client_name = mysql_real_escape_string(clear($_POST['name']));
	$client_phone = mysql_real_escape_string(clear($_POST['phone']));
	$sn = mysql_real_escape_string(clear($_POST['sn']));
	$model = mysql_real_escape_string(clear($_POST['model']));
	$size = mysql_real_escape_string(clear($_POST['size']));
	$summa_predvarit = mysql_real_escape_string(clear($_POST['summa_predvarit']));
	$summa_final = mysql_real_escape_string(clear($_POST['summa_final']));
	$summa_sale = mysql_real_escape_string(clear($_POST['summa_sale']));
	
	if(isset($_POST['term_of_work']) && $_POST['status'] == 1){
		$date_go_work = time();
		$term_of_work = mysql_real_escape_string(clear($_POST['term_of_work']));
		$term_of_work = "date_go_work='$date_go_work', term_of_work='$term_of_work', ";
	}else{
		$term_of_work = '';
	}
	
	if(isset($_POST['type_of_work'])){
		$type_of_work = mysql_real_escape_string(clear($_POST['type_of_work']));
		$type_of_work = "type_of_work='$type_of_work', ";
	}else{
		$type_of_work = '';
	}
	
	if(isset($_POST['comment_for_client'])){
		$comment_for_client = mysql_real_escape_string(clear($_POST['comment_for_client']));
		$comment_for_client = "comment_for_client='$comment_for_client',";
	}else{
		$comment_for_client = '';
	}
	
	$description = mysql_real_escape_string(clear($_POST['description']));
	
	if(isset($_POST['prioritet'])){
		$prioritet = 1;
	}
	
	if(isset($_POST['send_sms']) && $status==1){
		require "smsc_api.php";
		$id = $_GET['id'];
		$msg = "Проверка статуса заказа онлайн на сайте remonthdd.com. Введите свой id $id.";
		send_sms($client_phone, $msg, 0);
	}

	if($summa_final!=0 || $status==7){
		$status = 7;
		$date_vida4i = date('Ymd');
		$time_vida4i = date('Hi');
	}
	
	if(isset($_POST['buy']) && $_POST['buy_number']!=''){
		$buy_number = mysql_real_escape_string(clear($_POST['buy_number']));
		$client_name = "nanobyte";
		$client_phone = "0996760090";
	}

	
	$query = "UPDATE task SET status='$status', prioritet='$prioritet', $type_of_work $term_of_work date_vida4i='$date_vida4i', time_vida4i='$time_vida4i', $comment_for_client client_name='$client_name', client_phone='$client_phone', sn='$sn', model='$model', size='$size', buy_number='$buy_number', summa_predvarit='$summa_predvarit', summa_final='$summa_final', summa_sale='$summa_sale', description='$description' WHERE id=".mysql_real_escape_string($_GET['id']);
	$res = mysql_query($query) or die(mysql_error()); 	
	
	if($_SESSION['user_login']=='operator'){
		header("location:task.php");
	}else{
		header("location:task_manager.php");
	}
}


?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<link rel="stylesheet" type="text/css" href="main.css" />
	<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'></script>
	<script type='text/javascript' src='jquery.keyfilter-1.7.js'></script>
	<title>Управление задачами. Nanobyte</title>
	<script>
	 $(document).ready(function (){
		if($('#buy').attr('checked')){
			$('#buy_number').css('display','inline');
			$('#buy_number').attr('required','required');
			$('#buy_number').focus();
			$('.b_h').hide();
		};
		$('#buy').change(function(){
			if($(this).attr('checked')){
				$('#buy_number').css('display','inline');
				$('#buy_number').attr('required','required');
				$('#buy_number').focus();
				$('.b_h').hide();
			}else{
				$('#buy_number').css('display','none');
				$('#buy_number').removeAttr('required');
				$('#buy_number').val('');
				$('.b_h').show();
			}
		});
	 });
	</script>
</head>

	<?
	$res = mysql_query("SELECT * FROM task WHERE id=".mysql_real_escape_string($_GET['id']));
	$row = mysql_fetch_array($res);	
	?>
<body>

<div class="top_menu" style="background:#eee;padding:5px;margin-bottom:10px;">
<ul>
<li><a href="task_add.php">Добавить задачу</a></li>
	<?if($_SESSION['user_login']=='operator'){?>
		<li><a href="task.php">Список задач</a></li>
	<?}else{?>
		<li><a href="task_manager.php">Список задач</a></li>
	<?}?>
</ul>
</div>

	<table>
	<tr>
	<td valign="top">

		<form method="post" action="<?=$_SERVER['PHP_SELF']?>?<?=$_SERVER['QUERY_STRING']?>">
		<table>
		
		<tr>
		<td width="150" align="right" valign="top">
		<?if($row[buy_number] != '' && $row[buy_number] > 0) $check = 'checked';?>
		<label style="vertical-align:middle;" for="buy">Куплен!</label> <input type="checkbox" <?=$check?> id="buy" style="vertical-align:middle;" name="buy">
		</td>
		<td width="20">&nbsp;</td>
		<td>
		  <input style="width:70px;display:none;" type="text" id="buy_number" class="mask-pint" name="buy_number" maxlength="10" value="<?=$row['buy_number']?>">
		</td>
		</tr>


		<tr>
		<td width="150" align="right" valign="top">
		Статус
		</td>
		<td width="20">&nbsp;</td>
		<td>
			<select name="status" style="padding:2px;width:160px;">
				<?
				$res2 = mysql_query("SELECT * FROM status ORDER BY id ASC");
				while($row2 = mysql_fetch_array($res2)){
					if($row2)
					?><option <?if($row2['id']==$row['status']){?>selected<?}?> value="<?=$row2['id']?>"><?=$row2['text']?></option><?
				}
				?>
			</select>
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" valign="top">
		ID задачи
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<?=$row[id]?>
		</td>
		</tr>
		
		<tr class="b_h">
		<td width="150" align="right" valign="top">
		Имя клиента
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" name="name" value="<?=$row['client_name']?>" maxlength="50">
		</td>
		</tr>
		
		<tr class="b_h">
		<td width="150" align="right" valign="top">
		Контактный телефон
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" name="phone" value="<?=$row['client_phone']?>" maxlength="10">
		</td>
		</tr>

		<tr>
		<td width="150" align="right" valign="top">
		S/N
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" value="<?=$row['sn']?>" name="sn">
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" valign="top">
		Модель
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" value="<?=$row['model']?>" name="model">
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" valign="top">
		Емкость
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" value="<?=$row['size']?>" name="size">
		</td>
		</tr>
		
		<?if($row['status']==0){?>
		<tr class="b_h">
		<td width="150" align="right" valign="top">
		Приоритет по времени
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<select name="term_of_work">
			<option value="7">стандартный (7 дней)</option>
			<option value="2">приорететный (2 дня)</option>
			<option value="1">срочный (в течении 24 часов)</option>
		</select>
		</td>
		</tr>
		
		<tr class="b_h">
		<td width="150" align="right" valign="top">
		Вид работы
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<select name="type_of_work">
			<option <?if($row['type_of_work'] == 0){echo 'selected';}?> value="0"></option>
			<option <?if($row['type_of_work'] == 1){echo 'selected';}?> value="1">Восстановение</option>
			<option <?if($row['type_of_work'] == 2){echo 'selected';}?> value="2">Ремонт</option>
		</select>
		</td>
		</tr>
		
		<?}?>
		
		<tr>
		<td width="150" align="right">
		Разговор с клиентом, предварительная сумма
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<textarea style="width:400px;height:50px;" name="summa_predvarit"><?=$row['summa_predvarit']?></textarea>
		</td>
		</tr>
	
		<tr>
		<td width="150" align="right">
		Примечание (для мастера)
		</td>
		<td width="20">&nbsp;</td>
		<td valign="middle">
		<textarea style="width:400px;height:70px;" name="description"><?=$row['description']?></textarea>
		</td>
		</tr>
		
		<tr class="b_h">
		<td width="150" align="right">
		</td>
		<td width="20">&nbsp;</td>
		<td valign="middle">
		<input type="checkbox" id="prioritet" <? if($row['prioritet']==1){echo "checked";}?> name="prioritet"> <label for="prioritet">Важная задача</label>
		</td>
		</tr>
	
		<tr>
		<td width="150" align="right">
		Цена на продажу
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" value="<?=$row['summa_sale']?>" name="summa_sale"> грн.
		</td>
		</tr>
		
		
		</table>
		
		<div style='margin-top:30px; background:#eee;'>
		<table>
		<tr class="b_h">
		<td width="150" align="right">
		Мастер сделал
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<?=$row['master_sdelal']?>
		</td>
		</tr>
		
		<?if($row['status']==4){?>
		<tr class="b_h">
		<td width="150" align="right">
		Коментарий для клиента
		</td>
		<td width="20">&nbsp;</td>
		<td valign="middle">
		<textarea style="width:400px;height:70px;" name="comment_for_client"><?=$row['comment_for_client']?></textarea>
		</td>
		</tr>
		<?}?>
		
		<?if($_SESSION['user_login']=='operator'){?>
		<tr class="b_h">
		<td width="150" align="right">
		Сумма от мастера
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<?=$row['summa_master']?>
		</td>
		</tr>
		<?}?>
		
		
		<tr>
		<td width="150" align="right">
		<b>Сумма-финал</b>
		</td>
		<td width="20">&nbsp;</td>
		<td>
		<input type="text" value="<?=$row['summa_final']?>" name="summa_final">
		</td>
		</tr>
		
		<tr class="b_h">
		<td width="20">&nbsp;</td>
		</tr>
		
		<?if($row['status']==0){?>
		<tr class="b_h">
		<td width="150" align="right">
		</td>
		<td width="20">&nbsp;</td>
		<td valign="middle">
		<input type="checkbox" id="send_sms" name="send_sms"> <label for="send_sms">Отправить сообщение?</label>
		</td>
		</tr>
		<?}?>
		
		<tr>
		<td></td>
		<td width="20">&nbsp;</td>
		<td>		
		<input type="submit" name="submit" style="margin-top:25px;padding:5px;" value="Сохранить">	
		</td>
		</tr>


		</table>
		</div>
	
		</form>

	</td>
	</tr>
	</table>

</body>
</html>
<?}else{
	die;
}?>