<?
// �������� �����������
//require "auth.php";
include "connect2db.php";
connect();
?>




<?


if(isset($_POST['prime4_submit'])){
	$prime4_id = $_POST['prime4_id'];
	$q = mysql_query("SELECT * FROM clients WHERE id='".$prime4_id ."'");
	if(mysql_num_rows($q)>0){
		$r = mysql_fetch_array($q);
		$name = $r['name'];
		$address = $r['address'];
		$phone = $r['phone'];
		$prime4_text = $_POST['prime4_text'];
		$problema = "����� �������: ".$prime4_text;
		$date_add = date(Ymd);
		$time_add = date(Hi);
	
		$query = "INSERT INTO clients (show1, status, date_add, time_add, name, address, phone, problema) VALUES ('1', '0', '$date_add', '$time_add', '$name', '$address', '$phone', '$problema')";
		$res = mysql_query($query) or die(mysql_error()); 
		header("location:interface_admin_nb_8.php");
	}
}


if (isset($_POST['submit_oplata'])){
	$date_oplata = date('Ymd');
	$time_oplata = date('Hi');
	$query = "UPDATE clients SET date_oplata='$date_oplata', time_oplata='$time_oplata' WHERE id=".$_GET[id];
	$res = mysql_query($query) or die(mysql_error()); 
	header("location:interface_admin_nb_8.php");
}


if($_GET[a]=='del' AND $_GET[id]!=''){
	$query = "UPDATE clients SET show1='0' WHERE id=".$_GET[id];
	$res = mysql_query($query) or die(mysql_error()); 
	header("location:interface_admin_nb_8.php");
}


// ���������� ���������
if (isset($_POST['submit'])){

	if($_POST['name']!=''){
		$name = $_POST['name'];
	}
	
	if($_POST['address']!=''){
		$address = $_POST['address'];
	}else{
		$error.= "������� �����<br>";
	}
	
	if($_POST['phone']!=''){
		$phone = $_POST['phone'];
	}else{
		$error.= "������� ���������� �������<br>";
	}

	if($_POST['problema']!=''){
		$problema = $_POST['problema'];
	}else{
		$error.= "������� �������� ��������<br>";
	}	

	if($_POST['comment']!=''){
		$comment = $_POST['comment'];
	}	
	
	//  ���� ������ ������
	if($_POST['id_master']!=''){
		$id_master = $_POST['id_master'];
	}else{
		$id_master = "";
	}
	
	$status = $_POST['status'];
	if($status==0 AND $id_master!=''){
		$status=1;
	}

		
	if($status=='2'){
		$date_end = date(Ymd);
	}else{
		$date_end = "";
	}
	
	if($_POST['cena_work']!=''){
		$cena_work = $_POST['cena_work'];
	}

	if($_POST['cena_hard']!=''){
		$cena_hard = $_POST['cena_hard'];
	}	

	
	
	
	
	
	
	// ���� �������������� ������..
	if($_POST['id_master_re']!=''){
		$id_master_re = $_POST['id_master_re'];
		
		$q = mysql_query("SELECT * FROM clients WHERE id='".$_GET['id']."'");
		$r = mysql_fetch_array($q);
	
		$date_add = date(Ymd);
		$time_add = date(Hi);
		
		$q1 = mysql_query("SELECT * FROM masters WHERE id='".$r['id_master']."'");
		$r1 = mysql_fetch_array($q1);
		
		$full_recomend_by_master = $_POST['com'].".����� � ������� �� ������: ".$cena_work." ���. � �� ������:".$cena_hard." ���. (".($cena_work+$cena_hard)." ���.)";

		$query = "INSERT INTO clients (show1, status, id_master, date_add, time_add, name, address, phone, problema, comment) VALUES ('1', '1', '$id_master_re', '$date_add', '$time_add', '$r[name]', '$r[address]', '$r[phone]', '$r[problema]', '$full_recomend_by_master')";
		$res = mysql_query($query) or die(mysql_error()); 

	}
	
	
	
	
	
	
	
	// ���� ���� ������ �� ���� ����������..
	if(strlen($error)==0){
		$query = "UPDATE clients SET cena_work='$cena_work', cena_hard='$cena_hard', status='$status', name='$name', phone='$phone', address='$address', problema='$problema', comment='$comment', id_master='$id_master', date_end='$date_end' WHERE id=".$_GET[id];
		$res = mysql_query($query) or die(mysql_error()); 
		header("location:interface_admin_nb_8.php");
	}
}
?>


<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>���������� ���������. Nanobyte</title>
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
	function del(){if(confirm("�������?")){return true;}else{return false;}} 
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

	<table width="100%" border="0" style="margin-top:20px;border-bottom:2px solid #006699;">
	<tr>
	<td  valign="top" height="1" colspan="4">
	<h1 style="margin:0;margin-bottom:20px;margin-left:20px;">���� ��������</h1>
	</td>
	<td align="right" valign="top" height="1">
	</td>
	</tr>
	</table>


<!-- CONTENT //-->

	<table border="0">
	<tr>
	
	<td>
	<? include "menu.tpl";?>

	</td>
	
	<td width="50">
	&nbsp;
	</td>
	<td valign="top">
<!-- CENTER COLUMN //-->
<?if($_GET[a] AND $_GET[a]=='edit'){
$res = mysql_query("SELECT * FROM clients WHERE id=".$_GET[id]);
$row = mysql_fetch_array($res);
?>
<h1 style="margin-bottom:25px;">�������������� ������</h1>
		<form name="add_client" id="add_client" method="post" action="">
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
		<td width="150" align="right" style="padding-top:5px;">
		<b>������</b>
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		
		<?if($row[status]==2){
			?>
			������ ���������			
			<?
		}elseif($row[status]==1){
			?>������ � ������<?
		}elseif($row[status]==0){
			?>������ �������<?
		}
		?>
		
		<input type="hidden" id="status" name="status" value="<?=$row['status']?>">
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:15px;" valign="top">
		���� ������
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
		��� �������
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<input type="text" class="standart" value="<?=$row[name]?>" style="width:400px;" name="name" maxlength="50">
		</td>
		</tr>
		
		
		<tr>
		<td width="150" align="right" style="padding-top:5px;" valign="top">
		�����
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<input type="text" class="standart" style="width:400px;" value="<?=$row[address]?>" name="address" maxlength="80">
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:5px;" valign="top">
		���������� �������
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<input type="text" class="standart" style="width:400px;" value="<?=$row[phone]?>" name="phone" maxlength="50">
		</td>
		</tr>
		
		
		<tr>
		<td width="150" align="right" style="padding-top:5px;">
		<?if($row['id_master']!=5){?>
			�������� ��������<br> �� ���� �������
		<?}else{?>
			��������� � ��������
		<?}?>
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<textarea style="width:526px;height:100px;padding:2px;" name="problema""><?=$row[problema]?></textarea>
		</td>
		</tr>


		<tr>
		<td width="150" align="right" style="padding-top:5px;">
		<?if($row['id_master']!=5){?>
			����������� ��� ��������
		<?}else{?>
			������ ��� ��������
		<?}?>
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<textarea style="width:526px;height:50px;padding:2px;" name="comment"><?=$row[comment]?></textarea>
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:5px;padding-bottom:15px;">
		������������ ������
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
		<select name="id_master" id="id_master">
		<?
		if($row[id_master]==''){
		?>
		<option value="">����� �������</option>
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
		
		<?if($row[status]=='2' AND $row[id_master]==5){?>		
		<tr>
		<td></td>
		<td></td>
		<td style="padding-bottom:15px;">
		
		<table border="0" style="margin-top:0px;">
		<tr>
		<td  style="padding-top:0px;">
		<a onClick="$('#alert').slideToggle('fast');" style="font-size:12pt;text-decoration:none;border-bottom:1px dotted blue;" href="javascript:void(0)">�������� ������</a>
		</td>
		</tr>
		</table>
		
		<table id="alert" style="display:none;">
		<tr>
		<td style="padding-top:15px;">
		
		<select name="id_master_re" style="width:150px;" id="id_master_re">
		<option selected value="">����� �������</option>
		<?
		$res2 = mysql_query("SELECT * FROM masters");
		while($row2 = mysql_fetch_array($res2)){
			if($row2[id]==$row[id_master]){continue;}
			?><option value="<?=$row2[id]?>"><?=$row2[name]?></option><?				
		}
		?>
		</select>
		</td>
		</tr>
		</table>
		
		</td>
		</tr>
		<?}?>
		
		</table>
		
		<table border="0" width="800" style="<?if($row[status]==0){echo "display:none";}?>">
		<tr style="background:#eee;">
		<td width="150" align="right" valign="top" style="border-top:1px solid #999;padding-top:15px;">
		��� ���������
		</td>
		<td width="20" style="border-top:1px solid #999;">
		&nbsp;
		</td>
		<td valign="top" style="border-top:1px solid #999;padding-top:15px;">
		<span><?=$row[comment_by_master]?></span>
		<input type="hidden" value="<?=$row[comment_by_master]?>" name="com">
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="150" align="right" valign="top" style="padding-top:5px;">
		������������ �� �������
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;" valign="top">
		<span><?=$row[recomend_by_master]?></span>
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="150" align="right" style="padding-top:15px;">
		���� ������
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:15px;">
		<?if($row['id_master']==5 AND $row['status']==2){?>
			<input class="standart" value="<?=$row[cena_work]?>" type="text" name="cena_work"><b> ���.</b>
		<?}else{?>
			<b><?=$row[cena_work]?> ���.</b>
			<input class="standart" type="hidden" value="<?=$row[cena_work]?>" name="cena_work">
		<?}?>
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="150" align="right" style="padding-top:5px;">
		���� ������
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;">
		<?if($row['id_master']==5 AND $row['status']==2){?>
			<input class="standart" type="text" value="<?=$row[cena_hard]?>" name="cena_hard"><b> ���.</b>
		<?}else{?>
			<b><?=$row[cena_hard]?> ���.</b>
			<input class="standart" type="hidden" value="<?=$row[cena_hard]?>" name="cena_hard">
		<?}?>
		</td>
		</tr>
		
		<tr  style="background:#eee;">
		<td width="150" align="right" style="padding-top:5px;padding-bottom:10px;">
		�����
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:5px;padding-bottom:10px;">
		<b><?=$row[cena_hard]+$row[cena_work]?> ���.</b>    
		
		<?if($row[date_oplata]==0 AND $row[date_end]!=0){?><input type="submit" name="submit_oplata" value="������ ��������" style="padding:4px;margin-left:15px;"><?}?>
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:15px;" valign="top">
		���� ����������
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
		}else{
			echo $date_end = "";
		}
		
		if($row['time_end']!='0'){
			$h = substr($row['time_end'],0,2);
			$m = substr($row['time_end'],2,2);
			echo $time_end = ", ".$h.":".$m;
		}else{
			echo $time_end = "";
		}
		?>
		</td>
		</tr>
		
		<tr>
		<td width="150" align="right" style="padding-top:3px;" valign="top">
		���� ����� �����
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
			echo $date_oplata = "";
		}
		
		if($row['time_oplata']!='0'){
			$h = substr($row['time_oplata'],0,2);
			$m = substr($row['time_oplata'],2,2);
			echo $time_oplata = ", ".$h.":".$m;
		}else{
			echo $time_oplata = "";
		}
		?>
		</td>
		</tr>
		</table>
		
		
		<table>
		<tr>
		<td width="150" align="right" style="padding-top:10px;">
		</td>
		<td width="20">
		&nbsp;
		</td>
		<td style="padding-top:30px;">
		
		
		<?if($row['id_master']==5 AND $row['status']==2){?>
			<input type="submit" name="submit" style="padding:7px;" value="���������">
		<?}else{?>
			<input type="submit" name="submit" style="padding:7px;" value="��������� ���������">
		<?}?>
		</td>
		</tr>

			
		</table>

		</form>


<?}elseif(isset($_GET[filter])){
	?><h1 style="margin-bottom:25px;">������ ����� ��� ��������: <?=$_GET[filter]?></h1>
	<table id="list" style="margin-right:20px;">
<thead>
<tr id="tit">
<th></th>
<th></th>
<th><a href="">ID</a></th>
<th><a href="">���� 1</a></th>
<th><a href="">���� 2</a></th>
<th><a href="">���</a></th>
<th><a href="">�����</a></th>
<th><a href="">�������</a></th>
<th>��������</th>
<th>��� �������</th>
<th><a href="">������</a></th>
<!--
<th>���������</th>
<th>������������</th>
//-->
<th><a href="">������</a></th>
<th><a href="">������</a></th>
<th><a href="">�����</a></th>
</tr>
</thead>
<?
$res = mysql_query("SELECT * FROM clients WHERE show1=1 AND phone=".$_GET[filter]." ORDER BY id DESC LIMIT 0, 200");
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
	<a onClick='return del();' href="?a=del&id=<?=$row[id]?>"><img src="ico_del.gif"></a>
	</td>
	<td><?=$row[id]?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_add?></span><br><?=$time_add?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_end?></span><br><?=$time_end?></td>
	<td><?=$row[name]?></td>
	<td><?=$row[address]?></td>
	<td><?=str_replace(" ","&nbsp;",$row[phone])?></td>
	<td style="font-size:9pt;"><?=$row[problema]?></td>
	<td style="font-size:9pt;"><?=$row[comment]?></td>
	<?
	$s = mysql_query("SELECT * FROM masters WHERE id=".$row[id_master]);
	$r = mysql_fetch_array($s);
	?>
	<td style="font-size:9pt;"><?=$r[name]?></td>
	<!--
	<td style="font-size:9pt;"><span title="<?=$row[comment_by_master]?>"><? if($row[comment_by_master]!=''){echo substr($row[comment_by_master],0,100); echo "...";}?></span></td>
	<td style="font-size:9pt;"><span title="<?=$row[recomend_by_master]?>"><? if($row[recomend_by_master]!=''){echo substr($row[recomend_by_master],0,100); echo "...";}?></span></td>
	//-->
	<td><b><?=$row[cena_work]?></b></td>
	<td><b><?=$row[cena_hard]?></b></td>
	<td><b><?=$row[cena_hard]+$row[cena_work]?></b></td>
	
	</tr>
	<?
}
?>
</table>
	
	
	<?
}else{?>
<h1 style="margin-bottom:25px;">������ ����� ��� ��������������</h1>

<table width="100%" border="0" style="margin-bottom:15px;">
<tr>
<td>
<img src="legenda.gif">
</td>

<td>
��������:&nbsp;
<ul class="masters" style="list-style:none;">
<li><a href="?all">���</a></li>
<li><a href="?work">� ������</a></li>
<li><a href="?oplata">�� ��������</a></li>
</ul>
</td>

<td>
�������� ������ �������:&nbsp;
<ul class="masters" style="list-style:none;">
<?
$s = mysql_query("SELECT * FROM masters");
while($r = mysql_fetch_array($s)){
	?><li><a target="_blank" href="master.php?id=<?=md5($r[id])?>"><?=$r[name]?></a></li><?
}
?>
</ul>
</td>
</tr>
</table>

<table id="list" style="margin-right:20px;">
<thead>
<tr id="tit">
<th></th>
<th></th>
<th><a href="">ID</a></th>
<th><a href="">���� 1</a></th>
<th><a href="">���� 2</a></th>
<th><a href="">���</a></th>
<th><a href="">�����</a></th>
<th><a href="">�������</a></th>
<th>��������</th>
<th>��� �������</th>
<th><a href="">������</a></th>
<!--
<th>���������</th>
<th>������������</th>
//-->
<th><a href="">������</a></th>
<th><a href="">������</a></th>
<th><a href="">�����</a></th>
</tr>
</thead>
<?
if(isset($_GET[work])){
	$res = mysql_query("SELECT * FROM clients WHERE show1=1 AND status=1 ORDER BY id DESC LIMIT 0, 200");
}elseif(isset($_GET[oplata])){
	$res = mysql_query("SELECT * FROM clients WHERE show1=1 AND date_end!=0 AND date_oplata=0 ORDER BY id DESC LIMIT 0, 200");
}elseif(isset($_GET[all])){
	$res = mysql_query("SELECT * FROM clients WHERE show1=1 ORDER BY id DESC");
}else{
	$res = mysql_query("SELECT * FROM clients WHERE show1=1 ORDER BY id DESC LIMIT 0, 200");
}
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
	<a onClick='return del();' href="?a=del&id=<?=$row[id]?>"><img src="ico_del.gif"></a>
	</td>
	<td><?=$row[id]?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_add?></span><br><?=$time_add?></td>
	<td align="center"><span style="font-size:8pt;color:#666;"><?=$date_end?></span><br><?=$time_end?></td>
	<td><?=$row[name]?></td>
	<td><?=$row[address]?></td>
	<td><a href="?filter=<?=str_replace(" ","&nbsp;",$row[phone])?>"><?=str_replace(" ","&nbsp;",$row[phone])?></a></td>
	<td style="font-size:9pt;"><?=$row[problema]?></td>
	<td style="font-size:9pt;"><?=$row[comment]?></td>
	<?
	$s = mysql_query("SELECT * FROM masters WHERE id=".$row[id_master]);
	$r = mysql_fetch_array($s);
	?>
	<td style="font-size:9pt;"><?=$r[name]?></td>
	<!--
	<td style="font-size:9pt;"><span title="<?=$row[comment_by_master]?>"><? if($row[comment_by_master]!=''){echo substr($row[comment_by_master],0,100); echo "...";}?></span></td>
	<td style="font-size:9pt;"><span title="<?=$row[recomend_by_master]?>"><? if($row[recomend_by_master]!=''){echo substr($row[recomend_by_master],0,100); echo "...";}?></span></td>
	//-->
	<td><b><?=$row[cena_work]?></b></td>
	<td><b><?=$row[cena_hard]?></b></td>
	<td><b><?=$row[cena_hard]+$row[cena_work]?></b></td>
	
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