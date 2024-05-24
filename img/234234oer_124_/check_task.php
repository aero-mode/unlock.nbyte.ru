<?
include "connect2db.php";
connect();


if(isset($_GET['phone'])){
	$phone = intval($_GET['phone']);
	$phone = '0'.$phone;
	// echo $phone;
	$query = mysql_query("SELECT id,status FROM clients_sc WHERE phone =0660042163 AND date_oplata =0 AND time_oplata =0") or die(mysql_error());
	while($row = mysql_fetch_assoc($query)){
		$array[$row['id']] = $row['status'];
	}
}
print_r(json_encode($array));
?>