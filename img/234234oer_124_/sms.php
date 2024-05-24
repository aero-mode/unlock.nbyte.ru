<?
include("../../kernel/smsc_api.php");
if(isset($_POST['smsText']) && isset($_POST['phone'])){
	$phone = $_POST['phone'];
	$msg = $_POST['smsText'];
	$ans = send_sms($phone, $msg, 0);
	print_r($ans);
}