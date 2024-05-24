<?
require_once dirname(__FILE__).'/../config.php';
mysql_connect (DB_HOST, DB_USER, DB_PASS) OR DIE("Извините, сервер перегружен. Попробуйте через несколько минут..");
mysql_select_db (DB_NAME);
mysql_set_charset(CHARSET);
require_once 'kernel.php';
header('Content-Type: text/html; charset=utf-8');
if(isset($_POST['action']) && $_POST['action'] == 'add_opinion'){
	$add = new opinions();
	$aassd = $add->addOpinion($_POST['page_id'], $_POST['opinion_name'], $_POST['rating'], $_POST['opinion_text']);
	echo $aassd;
}
if(isset($_POST['action']) && $_POST['action'] == 'request_submit'){
	include_once dirname(__FILE__)."/smsc_api.php";
	$user_phone = $_POST['client_phone'];
	$user_phone = preg_replace ("/[^0-9]/","",$user_phone);
	$user_name = $_POST['client_name'];
	send_sms($user_phone, "СЦ \"Нанобайт\", ул. Павленко 15, время работы с 9 до 19, тел. +7(978)745-37-55.\r\nВаш промокод KRYM2014", 0);
	$msg = "Письмо на почте, в спаме.\r\n$user_name $user_phone\r\nС сайта nbyte.ru";
	$phone = "+79787453755";
	send_sms($phone, $msg, 0);
	mail("nanobytecenter@gmail.com", "Новый заказ на сайте nbyte.ru", "Имя клиента: $user_name\nТелефон клиента: $user_phone\nТекст проблемы: $_POST[client_problem]", "From: Заказ с сайта <sender@nbyte.ru>\r\n");
	$user_phone = intval($user_phone);
	$user_name = mysql_real_escape_string($user_name);
	$client_problem = mysql_real_escape_string($_POST['client_problem']);
	mysql_query("INSERT INTO `nb_new`.`form_send` (`id`, `name`, `phone`, `messege`, `date_add`) VALUES (NULL, '".$user_name."', '".$user_phone."', '".$client_problem."', CURRENT_TIMESTAMP)");
	echo 'ok';
}
if(isset($_POST['action']) && $_POST['action'] == 'kp_submit'){
	include_once dirname(__FILE__)."/smsc_api.php";
	$user_phone = $_POST['client_phone'];
	$user_phone = preg_replace ("/[^0-9]/","",$user_phone);
	$user_name = $_POST['client_name'];
	$msg = "Заказ компьютерная помощь.\r\n$user_name $user_phone";
	$phone = "+79787453755";
	$answer = send_sms($phone, $msg, 0);
	mail("nanobytebox@gmail.com", "Новый заказ на сайте nbyte.ru", "Имя клиента: $user_name\nТелефон клиента: $user_phone\nТекст проблемы: $_POST[client_problem]", "From: Заказ с сайта <sender@nbyte.ru>\r\n");
	echo 'ok';
}
if(isset($_POST['action']) && $_POST['action'] == 'call_me_submit'){
	include_once dirname(__FILE__)."/smsc_api.php";
	$user_phone = $_POST['client_phone'];
	$user_phone = preg_replace ("/[^0-9]/","",$user_phone);
	$msg = "Прошу перезвонить на номер $user_phone. С сайта nbyte.ru";
	$phone = "+79787453755";
	$answer = send_sms($phone, $msg, 0);
	echo 'ok';
}
?>