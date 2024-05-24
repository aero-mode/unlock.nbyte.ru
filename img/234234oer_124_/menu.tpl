<style>
#admin_menu_block b{
	border-bottom:1px solid #ccc;
	font-size:9pt;
	color:#fff;
	background:#006699;
	display:block;
	text-transform:uppercase;
	margin:0;
	padding:1px;
	padding-left:6px;
}

#admin_menu_block ul{
	margin:0;
	padding:0;
	list-style:none;
	margin-bottom:20px;
	margin-top:3px;
	margin-left:5px;
}

#admin_menu_block ul li  a{
	
}

</style>
<td width="250" valign="top" style="background:#f6f2d9;">

<style>
.admin_count{
	color:#333;
	font-size:9pt;
	position:relative;
	top:-3px;
}
</style>

<!-- MAIN MENU //-->

<div id='admin_menu_block' style="width:150px;margin:20px;">

<b>Наши клиенты</b>
<ul>
<li><a href="admin_nb_interface.php">Список задач</a></li>
<li><a href="client_add.php">Добавить задачу</a></li>
<li><a onClick="$('#prime4').slideToggle();" href="javascript:void(0)">Добавить примечание</a></li>
</ul>


<div id="prime4" style="display:none;margin-bottom:25px;">
<form method="post" action="admin_nb_interface.php" name="form1">
<input type="text" style="width:75px;" value="" name="prime4_id"> - id
<input type="hidden" name="master" value="<?=$r[name]?>">
<br>
<textarea style="width:150px;height:150px;margin-top:10px;" name="prime4_text"></textarea>
<br>
<input type="submit" style="padding:3px;margin-top:10px;" value="Добавить" name="prime4_submit">
</form>
</div>


<b>Мастера</b>
<ul>
<li><a href="master_zp.php">Зарплаты мастеров</a></li>
</ul>

<b>Статистика</b>
<ul>
<li><a href="stat.php">Статистика</a></li>
</ul>
</div>




<div style="padding:10px;padding-left:10px;border:1px solid #ccc;margin:20px;">
	<div style="font-size:10	pt;">Сегодня: <?=Date('d.m.y');?> г.</div>
</div>

