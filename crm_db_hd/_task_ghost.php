<?php
// проверка авторизации
require "auth.php";
if($_SESSION['user_login']!='ghost'){die;}
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

<table width="100%" border="1">
	<thead>
		<tr>
			<th>акт</th>
			<th>смс</th>
			<th>ID</th>
			<th>Дата</th>
			<th>Имя</th>
			<th>Телефон</th>
			
			<th>S/N</th>
			<th>Модель</th>
			<th>Емкость</th>
			
			<th>Описание</th>
			<th>Мастер сделал</th>
			
			<th>Сумма пред-ная</th>
			<th>Статус</th>
		</tr>
	</thead>
	
	<?
	
	$res = mysql_query("SELECT * FROM task WHERE visible=1 ORDER BY id DESC");
	while($row = mysql_fetch_array($res)){
	
		$res2 = mysql_query("SELECT * FROM status WHERE id=".$row['status']);
		$row2 = mysql_fetch_array($res2);
		$status = $row2['text'];
		$bgcolor = $row2['bgcolor'];
		?>
		<tr style="<?if($row['status']==10){?>background:#b8e4fa;<?}?><?if($row['prioritet']==1){?>font-weight:bold;;<?}?>">
		<td><a target="blank" href="add_akt.php?id=<?=$row['id']?>">акт</a></td>
		<td><a target="blank" href="send_sms.php?phone=<?=$row['client_phone']?>">смс</a></td>
		<td><?=$row['id']?></td>
		<td><?=substr($row['date_add'],6,2)?>.<?=substr($row['date_add'],4,2)?></td>
		<td><?=$row['client_name']?></td>
		<td><a href="?filter=client_phone-<?=$row['client_phone']?>"><?=$row['client_phone']?></a></td>
		<td><?=$row['sn']?></td>
		<td><?=$row['model']?></td>
		<td><a href="?filter=size-<?=$row['size']?>"><?=$row['size']?></a></td>
		<td><?=$row['description']?></td>
		<td><?=$row['master_sdelal']?></td>
		<td><?=$row['summa_predvarit']?></td>
		<td style="background:<?=$bgcolor?>"><?=$status?></td>
		</tr>
		<?
	}

	?>
	
</table>
</body>
</html>