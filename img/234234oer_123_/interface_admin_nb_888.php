<?
include "connect2db.php";
connect();
error_reporting(E_ALL);
header('Content-Type: text/html; charset=windows-1251');
if(isset($_POST['action']) && $_POST['action']=='save'){
	$id = intval($_POST['id']);
	$zvonok = mysql_real_escape_string(iconv("UTF-8", "CP1251", $_POST['zvonok_text']));
	mysql_query("UPDATE `nb`.`clients` SET `zvonok` = '$zvonok' WHERE `clients`.`id` ='$id';");
	die();
}
if(isset($_POST['action']) && $_POST['action']=='save_sms'){
	$id = intval($_POST['id']);
	$zvonok = mysql_real_escape_string(iconv("UTF-8", "CP1251", $_POST['zvonok_text']));
	mysql_query("UPDATE `nb`.`clients` SET `zvonok` = '$zvonok' WHERE `clients`.`id` ='$id';");
	include("../../kernel/smsc_api.php");
	$phone = $_POST['phone'];
	$msg = "Качественный ремонт и настройка ноутбука и компьютера, восстановление данных. Вызов мастера на дом 0990541117, nanobyte.com.ua";
	$msg = iconv("CP1251", "UTF-8", $msg);
	$ans = send_sms($phone, $msg, 0);
	print_r($msg);
	die();
}
?>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251" />
	<title>Управление клиентами. Nanobyte</title>
	<link rel="stylesheet" type="text/css" href="reset.css" />
	<link rel="stylesheet" type="text/css" href="main.css" />
	<script type="text/javascript" src="jquery.js"></script>
	<script type="text/javascript" src="scripts/jquery-ui/jquery-ui.js"></script>
	<link rel="stylesheet" type="text/css" href="scripts/jquery-ui/themes/ui-lightness/jquery-ui.min.css"/>
	<link rel="stylesheet" type="text/css" href="scripts/jquery-ui/themes/ui-lightness/jquery.ui.theme.css"/>
	<script type="text/javascript">
		$(document).ready(function(){
			$(".edit").on("click", function(){
				var elem = $(this);
				var text = elem.parent().parent().find(".zvonok");
				var id = elem.data('id');
				var phone = elem.data('phone');
				$("#zvonok-text").val(text.text());
				$("#zvonok").dialog({
					modal:true,
					height: 250,
					width: 500,
					buttons:{
						"Сохранить": function(){
							$.post(document.location.href, {action: "save", zvonok_text: $("#zvonok-text").val(), id: id})
								.success(function() {
									text.text($("#zvonok-text").val());
								});
							$(this).dialog( "close" );
						},
						"Сохранить и SMS": function(){
							$.post(document.location.href, {action: "save_sms", zvonok_text: $("#zvonok-text").val(), id: id, phone: phone})
								.success(function() {
									text.text($("#zvonok-text").val());
								});
							$(this).dialog( "close" );
						}
					}
				});
			});
		});
	</script>
	<style>
		#list td {
			padding: 6px;
			border-collapse: collapse;
			border: 1px solid #ccc;
			vertical-align: top;

		}
		#tit th {
			background: #eee;
			border: 1px solid #ccc;
			padding: 4px;
			text-align: center;
		}
		.col{
			font-size:8pt;
		}
		#zvonok {
			display:none;
		}
	</style>
</head>
<body>

	<!-- HEADER //-->
	<table width="100%" border="0" style="margin-top:20px;border-bottom:2px solid #006699;">
		<tr>
			<td valign="top" height="1" colspan="4">
				<h1 style="margin:0;margin-bottom:20px;margin-left:20px;">База клиентов</h1>
			</td>
			<td align="right" valign="top" height="1">
			</td>
		</tr>
	</table>
	<table border="0">
		<tr>
			<td valign="top">
				<?if(isset($_GET['filter'])){?>
					<h1 style="margin-bottom:25px;">Список задач для телефона: <?=$_GET[filter]?></h1>
					<table width="100%" border="0" style="margin-bottom:15px;">
						<tr>
							<td><img src="legenda.gif"></td>
							<td></td>
						</tr>
					</table>
				<?}else{?>
					<h1 style="margin-bottom:25px;">Список задач для Администратора</h1>
					<table width="100%" border="0" style="margin-bottom:15px;">
						<tr>
							<td><img src="legenda.gif"></td>
							<td></td>
						</tr>
					</table>
				<?}?>
					<table id="list" style="margin-right:5px;margin-left:5px;">
						<thead>
							<tr id="tit">
								<th>ID</th>
								<th>Дата 1</th>
								<th>Дата 2</th>
								<th>Имя</th>
								<th>Адрес</th>
								<th>Телефон</th>
								<th>Проблема</th>
								<th>Для мастера</th>
								<th>Ком. мастера</th>
								<th>Рекоменд.</th>
								<th>Работа</th>
								<th>Железо</th>
								<th>Всего</th>
								<th>Звонок</th>
							</tr>
						</thead>
				<?
				if(isset($_GET['page'])){
					$page=intval($_GET['page']);
					$resText="SELECT * FROM clients WHERE show1=1 ORDER BY id ASC LIMIT 500, 500";
				}elseif(isset($_GET['filter'])){
					$resText="SELECT * FROM clients WHERE show1=1 AND phone=".intval($_GET[filter])." ORDER BY id DESC LIMIT 0, 200";
				}else{
					$resText="SELECT * FROM clients WHERE show1=1 ORDER BY id ASC LIMIT 500, 500";
				}
				$res=mysql_query($resText);
				while($row=mysql_fetch_array($res)){
					$st=$row[status];
					if($st==0){
						$color="#ffbc9b";
					}elseif($st==1){
						$color="#ffff77";
					}else{
						$color="#c0ebc0";
					}
					$d=substr($row['date_add'],6,2);
					$m=substr($row['date_add'],4,2);
					$y=substr($row['date_add'],2,2);
					$date_add=$d.".".$m.".".$y;
					(strlen($row['time_add'])<4)?$time_add2 = '0'.$row['time_add']:$time_add2 = $row['time_add'];
					$h=substr($time_add2,0,2);
					$mm=substr($time_add2,2,2);
					$time_add=$h.":".$mm;
					if($row['date_end']!='0' ){
						$d=substr($row['date_end'],6,2);
						$m=substr($row['date_end'],4,2);
						$y=substr($row['date_end'],2,2);
						$date_end=$d.".".$m.".".$y;
					}else{
						$date_end="";
					}
					if($row['time_end']!='0' ){
						(strlen($row['time_end'])<4)?$time_end2 = '0'.$row['time_end']:$time_end2 = $row['time_end'];
						$h2=substr($time_end2,0,2);
						$mm2=substr($time_end2,2,2);
						$time_end=$h2.":".$mm2;
					}else{
						$time_end="";
					}
					if($row['date_oplata']==0 AND $row[status]==2){
						$date_oplata="2px solid red" ;
					}else{
						$date_oplata="none" ;
					}
				?>
					<tr style="background:<?=$color?>;border:<?=$date_oplata?>">
						<td align="center" class="col"><?=$row[id]?><br><br><a href="javascript:void(0)" class="edit" data-id="<?=$row[id]?>" data-phone="<?=str_replace(" ","",$row[phone])?>"><img src="ico_edit.gif"></a></td>
						<td align="center" class="col"><span style="font-size:8pt;color:#666;"><?=$date_add?></span><br><?=$time_add?></td>
						<td align="center" class="col"><span style="font-size:8pt;color:#666;"><?=$date_end?></span><br><?=$time_end?></td>
						<td class="col"><?=str_replace( " ", "",$row[name])?></td>
						<td class="col"><?=$row[address]?></td>
						<td><a class="col" href="?filter=<?=str_replace(" ","&nbsp; ",$row[phone])?>"><?=str_replace( " ", "&nbsp;",$row[phone])?></a></td>
						<td class="col"><?=$row[problema]?></td>
						<td class="col"><?=$row[comment]?></td>
						<td class="col"><?=$row[comment_by_master]?></td>
						<td class="col"><?=$row[recomend_by_master]?></td>
						<td align="center" class="col"><b><?=$row[cena_work]?></b></td>
						<td align="center" class="col"><b><?=$row[cena_hard]?></b></td>
						<td align="center" class="col"><b><?=$row[cena_hard]+$row[cena_work]?></b></td>
						<td class="zvonok"><?=$row['zvonok']?></td>
					</tr>
				<?}?>
				</table>
			</td>
		</tr>
	</table>
<div id="zvonok">
	<textarea id="zvonok-text" style="width:465px;height:120px;margin:0;"></textarea>
</div>
</body>
</html>