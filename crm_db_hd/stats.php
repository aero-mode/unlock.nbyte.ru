<?php
// проверка авторизации
require "auth.php";
if($_SESSION['user_login']!='operator'){die;}
?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<title>Статистика. Nanobyte</title>
	<link rel="stylesheet" type="text/css" href="main.css" />
</head>

<body>

<div class="top_menu">
	<ul>
	<li><a href="task_add.php">Добавить задачу</a></li>
	<li><a href="task.php">Список задач</a></li>
	</ul>
</div>


	<div style="padding:5px;background:#eee;margin-bottom:1px;">
	<?
	$ii=1;
	$yy = date('Y')-1;
	while($ii<=12){
		if(strlen($ii)==1){$iii="0".$ii;}else{$iii=$ii;}
		?>
		<a style="margin-right:7px;" href="?data_stat=<?=$yy.$iii?>"><?=$iii.".".$yy?></a>
		<?
		$ii++;
	}
	?>
	</div>
	
	<div style="padding:5px;background:#eee;margin-bottom:20px;">
	<?
	$ii=1;
	$yy = date('Y');
	while($ii<=12){
		if(strlen($ii)==1){$iii="0".$ii;}else{$iii=$ii;}
		?>
		<a style="margin-right:7px;" href="?data_stat=<?=$yy.$iii?>"><?=$iii.".".$yy?></a>
		<?
		$ii++;
	}
	?>
	</div>
	
<table width="100%">
<tr>
<td>
	<?
	
	if(isset($_GET[data_stat])){
		$xxx = $_GET[data_stat];
	}else{
		$xxx = date('Ym');
	}
	
	$s = mysql_query("SELECT id FROM task WHERE visible=1 AND summa_final!=0 AND date_vida4i LIKE '".$xxx."%'");
	$vsego = mysql_num_rows($s);
	?>
	
	<table width="1000">
	<tr>
	<td valign="top" width="450">
	
	
	<h1 style="margin-bottom:25px;">Статистика по деньгам</h1>
	
	Всего заявок: <?=$vsego?>
	
	<?
	$s = mysql_query("SELECT * FROM task WHERE visible=1 AND status=7");
	while($r = mysql_fetch_array($s)){
		$summa_final+=$r['summa_final'];
		$summa_master+=$r['summa_master'];
	}
	

	
	$s0 = mysql_query("SELECT date_vida4i, SUM(summa_final), SUM(summa_master) FROM task WHERE summa_final!=0 AND visible=1 AND date_vida4i!=0 AND date_vida4i LIKE '".$xxx."%' GROUP BY date_vida4i");
	
	$alltable.= "<table border='1'>";
	$alltable.= "<tr><td style='background:#eee;padding:4px;'>дата</td><td style='background:#eee;padding:4px;'>клиент</td><td style='background:#eee;padding:4px;'>мастер</td><td style='background:#eee;padding:4px;'>доход</td></tr>";
	
	while($r0 = mysql_fetch_array($s0)){
	
		$all_work+=$r0[1];
		$all_hard+=$r0[2];

		$alltable.= "<tr>";
		$alltable.= "<td style='width:120px;padding:3px;'>";
		$alltable.= date_s($r0[0]);
		$alltable.= "</td><td align='right' style='width:90px;padding:3px;'>";
		$x = $x+$r0[1];
		$alltable.= $r0[1]." руб.";
		$alltable.= "</td><td align='right' style='width:90px;padding:3px;'>";
		$alltable.= $r0[2]." руб.";
		$y = $y+$r0[2];
		$alltable.= "</td><td align='right' style='width:90px;font-weight:bold;padding:3px;'>";
		$alltable.= ($r0[1]-$r0[2])." руб.";
		$z = $z+($r0[1]-$r0[2]);
		$alltable.= "</td>";
		$alltable.= "</tr>";
	}
	
	$alltable.= "
		<tr>
		<td>Итого</td>
		<td align='right'>$x руб.</td>
		<td align='right'>$y руб.</td>
		<td align='right'><b>$z руб.</b></td>
		</tr>";
	
	echo $alltable.= "</table>";
	?>
	
	</td>
	<td width="100"></td>
	<td width="450" valign="top">
	
		<h1 style="margin-bottom:25px;">Статистика по задачам</h1>
		
		<?
		$alltable="";
		$s = mysql_query("SELECT id FROM task WHERE visible=1 AND date_add LIKE '".$xxx."%'");
		$vsego = mysql_num_rows($s);
		?>
		Всего заявок: <?=$vsego?>
		
		<?		
		if(isset($_GET[data_stat])){
			$xxx = $_GET[data_stat];
		}else{
			$xxx = date('Ym');
		}
		
		$s0 = mysql_query("SELECT date_add, COUNT(id) FROM task WHERE visible=1 AND date_add LIKE '".$xxx."%' GROUP BY date_add ORDER by date_add");
		
		$alltable.= "<table border='1'>";
		$alltable.= "<tr><td style='background:#eee;padding:4px;'>дата</td><td style='background:#eee;padding:4px;'>принято заявок</td><td style='background:#eee;padding:4px;'>выдано</td><td style='background:#eee;padding:4px;'>коэф.</td></tr>";
		
		while($r0 = mysql_fetch_array($s0)){

			$s1 = mysql_query("SELECT COUNT(id) FROM task WHERE date_vida4i=".$r0[0]);
			$r1 = mysql_fetch_array($s1);
			$vidan = $r1[0];
		
			$alltable.= "<tr>";
			$alltable.= "<td style='width:120px;padding:3px;'>";
			$alltable.= date_s($r0[0]);
			$alltable.= "</td><td style='width:90px;padding:3px;'>";
			$alltable.= $r0[1];
			$alltable.= "</td><td style='width:90px;padding:3px;'>";
			$alltable.= $vidan;
			$alltable.= "</td>";
			$alltable.= "</td><td style='font-weight:bold;width:90px;padding:3px;'>";
			$alltable.= $vidan+$r0[1];
			$alltable.= "</td>";
			$alltable.= "</tr>";
		}
		
		echo $alltable.= "</table>";
		?>
	</td>
	</tr></table>
	
	</td>
	</tr>
	</table>

</body>
</html>