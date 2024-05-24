<?
// проверка авторизации
require "auth.php";

?>

<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>Управление клиентами. Nanobyte</title>
	<link rel="stylesheet" type="text/css" href="reset.css" />
	<link rel="stylesheet" type="text/css" href="main.css" />
	<script type='text/javascript' src='jquery.js'></script>
	
<script type='text/javascript'> 
<!-- 
function del(){ 
	if(confirm("Удалить запись?")){ 
		return true; 
	}else{ 
		return false; 
	} 
} 
--> 
</script> 

</head>

<body>


<!-- HEADER //-->

	<table align="center" border="0" style="margin-top:20px;width:1250px;border-bottom:2px solid #006699;">
	<tr>
	<td  valign="top" height="1" colspan="4">
	<h1 style="margin:0;margin-bottom:20px;">База клиентов</h1>
	</td>
	<td align="right" valign="top" height="1">
	</td>
	</tr>
	</table>


<!-- CONTENT //-->

	<table width="1250" align="center" border="0">
	<tr>
	
	<? include "menu.tpl";?>

	<td width="50">
	&nbsp;
	</td>
	<td width="1000" valign="top">
<!-- CENTER COLUMN //-->

<h1 style="margin-bottom:25px;">Клиенты</h1>

	</td>
	</tr>
	</table>

<br><br><br>
</body>
</html>