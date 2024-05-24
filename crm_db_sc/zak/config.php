<?
define('DB_HOST', 'localhost');
define('DB_USER', 'u0363988_nbyte');
define('DB_PASS', '6C6q4C9j');
define('DB_NAME', 'u0363988_crm_sc');
define('DB_CHAR', 'utf8');

// коннект к базе
mysql_connect(DB_HOST, DB_USER, DB_PASS) OR DIE("Извините, сервер перегружен. Попробуйте обновить страницу через несколько минут..");
mysql_select_db(DB_NAME);

mysql_query ("set character_set_client='utf8'");
mysql_query ("set character_set_results='utf8'");
mysql_query ("set collation_connection='utf8_general_ci'");


function firstToUp($lo){
	$lo = trim($lo);
	$lo_first = mb_substr($lo,0,1,"utf-8");

	$up = array("а" => "А","б" => "Б","в" => "В","г" => "Г","д" => "Д","е" => "Е","ж" => "Ж","з" => "З","и" => "И","й" => "Й","к" => "К","л" => "Л","м" => "М","н" => "Н","о" => "О","п" => "П","р" => "Р","с" => "С","т" => "Т","у" => "У","ф" => "Ф","х" => "Х","ц" => "Ц","ч" => "Ч","ш" => "Ш","щ" => "Щ","ъ" => "Ъ","ы" => "Ы","ь" => "Ь","э" => "Э","ю" => "Ю","я" => "Я", "a" => "A", "b" => "B", "c" => "C","d" => "D","e" => "E","f" => "F","g" => "G","h" => "H","i" => "I","j" => "J","k" => "K","l" => "L","m" => "M","n" => "N","o" => "O","p" => "P","q" => "Q","r" => "R","s" => "S","t" => "T","u" => "U","v" => "V","w" => "W","x" => "X","y" => "Y","z" => "Z");
	$up = strtr($lo_first, $up).mb_substr($lo,1,mb_strlen($lo),"utf-8");
	return $up;	
}

 
?>