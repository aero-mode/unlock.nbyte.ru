<?php
require "inc.php";
connect();
header('Content-type: text/html; charset=utf-8');
$csv = '';
$repl = array("\r", "\n", "\t");
$query = mysql_query("SELECT id, model, size, summa_predvarit FROM task WHERE status = 10");
while($row = mysql_fetch_assoc($query)){
	$row['summa_predvarit'] = str_replace($repl, " ", $row['summa_predvarit']);
	$csv .= $row['id']."\t".$row['model']."\t".$row['size']."\t".$row['summa_predvarit']."\n";
}
header('Content-Description: File Transfer');
header('Content-Type: application/octet-stream');
header('Content-Disposition: attachment; filename=hdd.csv');
header('Content-Transfer-Encoding: binary');
header('Expires: 0');
header('Cache-Control: must-revalidate');
header('Pragma: public');
print_r($csv);
exit();