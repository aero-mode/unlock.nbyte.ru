<?
// проверка авторизации
//require "auth.php";
include "connect2db.php";
connect();

// сохранение изменений
if (isset($_POST['submit'])){

	if($_POST['name']!=''){
		$name = $_POST['name'];
	}
	if($_POST['id']!=''){
		$id = $_POST['id'];
	}
	if($_POST['recomend_by_master']!=''){
		$recomend_by_master = $_POST['recomend_by_master'];
	}
		
	
		$query = "UPDATE clients SET recomend_by_master='$recomend_by_master' WHERE id='$id'";
	
		$res = mysql_query($query) or die(mysql_error()); 
		
		header("location:operator_nb_interface.php");
	
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
	<td width="20">
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
			<input type="text" class="standart" <?if($row[status]!=0){?>readonly<?}?> value='<?=$row[name]?>' style="width:400px;" name="name" maxlength="50" disabled>
			<input type="hidden" name="id" value="<?=$row['id']?>">
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
		<select name="id_master" id="id_master" disabled>
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
		
		
		</table>
		
		
		<?
		if($row[status]==1){
			?>
			<table border="0" width="800">			
			<tr style="background:#eee;">
			<td width="150" align="right" valign="top" style="padding-top:5px;padding-bottom:15px;">
			Задачи мастера
			</td>
			<td width="20">
			&nbsp;
			</td>
			<td style="padding-top:5px;padding-bottom:15px;" valign="top">
			<textarea name="recomend_by_master"><?=$row['recomend_by_master']?></textarea>
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


<?}else{?>
<h1 style="margin-bottom:25px;">Список задач для Оператора NB</h1>


<table id="list" style="margin-right:20px;">
<thead>
	<tr id="tit">
		<th></th>
		<th></th>
		<th>Дата 1</a></th>
		<th>Дата 2</a></th>
		<th>Имя</a></th>
		<th>Для мастера</th>
		<th>Мастер</a></th>
	</tr>
</thead>
<?
	$res = mysql_query("SELECT * FROM clients WHERE show1=1 AND status<2 AND date_oplata=0 AND recomend_by_master!='' ORDER BY id DESC");

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
	
	if($row['date_oplata']==0 AND $row[status]==2){
		$date_oplata="2px solid red";
	}else{
		$date_oplata="none";
	}
	
	?>
	<tr style="background:<?=$color?>;border:<?=$date_oplata?>">
	<td><a href="?a=edit&id=<?=$row[id]?>"><img src="ico_edit.gif"></a></td>
	<td>

	</td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_add?></span><br><?=$time_add?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_end?></span><br><?=$time_end?></td>
	<td style="width:40px;"><?=$row['name']?></td>
	<td style="font-size:9pt;"><?=str_replace("\r\n","<br>",$row['recomend_by_master'])?></td>
	<?
	$s = mysql_query("SELECT * FROM masters WHERE id='$row[id_master]'");
	$r = mysql_fetch_array($s);
	?>
	<td style="font-size:9pt;"><?=$r['name']?></td>
	
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