<?
function connect() {
	$hostname="localhost";
	$user="nanobyte";
	$password="nb1248admin70";
	$db="nb";

	mysql_connect ($hostname,$user,$password) OR DIE("��������, ������ ����������. ���������� ����� ��������� �����..");
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
	
	if($m=='01'){$m2="������";}
	if($m=='02'){$m2="�������";}
	if($m=='03'){$m2="�����";}
	if($m=='04'){$m2="������";}
	if($m=='05'){$m2="���";}
	if($m=='06'){$m2="����";}
	if($m=='07'){$m2="����";}
	if($m=='08'){$m2="�������";}
	if($m=='09'){$m2="��������";}
	if($m=='10'){$m2="�������";}
	if($m=='11'){$m2="������";}
	if($m=='12'){$m2="�������";}
	
	return $d." ".$m2;
}

$decisions_status = array('1' => '���������', '2' => '��������', '3' => '�� ������');

?>