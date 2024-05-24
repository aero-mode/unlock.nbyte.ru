<?
function connect() {
	$hostname="localhost";
	$user="nanobyte";
	$password="nb1248admin70";
	$db="nb";

	mysql_connect ($hostname,$user,$password) OR DIE("Извините, сервер перегружен. Попробуйте через несколько минут..");
	mysql_select_db ($db);

	mysql_query ("set character_set_client='cp1251'");
	mysql_query ("set character_set_results='cp1251'");
	mysql_query ("set collation_connection='cp1251_general_ci'");
}

function date_s($a){
	$d = substr($a,6,2);
	$m = substr($a,4,2);
	$y = substr($a,0,4);
	
	if(substr($d,0,1)=='0'){$d=substr($d,1,1);}
	
	if($m=='01'){$m2="января";}
	if($m=='02'){$m2="февраля";}
	if($m=='03'){$m2="марта";}
	if($m=='04'){$m2="апреля";}
	if($m=='05'){$m2="мая";}
	if($m=='06'){$m2="июня";}
	if($m=='07'){$m2="июля";}
	if($m=='08'){$m2="августа";}
	if($m=='09'){$m2="сентября";}
	if($m=='10'){$m2="октября";}
	if($m=='11'){$m2="ноября";}
	if($m=='12'){$m2="декабря";}
	
	return $d." ".$m2;
}

$decisions_status = array('1' => 'Полностью', '2' => 'Частично', '3' => 'Не решена');

?>