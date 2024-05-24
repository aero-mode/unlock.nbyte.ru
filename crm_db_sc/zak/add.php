<?
include($_SERVER['DOCUMENT_ROOT']."/crm_db_sc/zak/config.php");

$theme = "/crm_db_sc/tpl";

// --------------------------
// ДОБАВИТЬ
// --------------------------
if(isset($_POST['add'])){
	
	$ta_st_id			= 1; // статус
	$cl_phone 			= mysql_real_escape_string(preg_replace ("/[^0-9\+]/","",$_POST['cl_phone']));
	$cl_name 			= mysql_real_escape_string($_POST['cl_name']);
	$ta_de_id 			= mysql_real_escape_string($_POST['ta_de_id']);
	$ta_model 			= mysql_real_escape_string($_POST['ta_model']);
	
	//$ta_serial 		= mysql_real_escape_string(strtoupper($_POST['ta_serial']));
	$ta_serial 			= $_POST['ta_serial']=='' ? 'б.н.' : mysql_real_escape_string(strtoupper($_POST['ta_serial']));;
	
	$ta_what_to_do 		= mysql_real_escape_string($_POST['ta_what_to_do']);
	$ta_what_is_done 	= mysql_real_escape_string($_POST['ta_what_is_done']);
	$ta_fi_id 			= mysql_real_escape_string($_POST['ta_fi_id']);
	$ta_date_add		= date('Y-m-d H:i:s'); 	
	
	$_POST['ta_equipment'] = array_filter($_POST['ta_equipment'], function($el){ 
		return !empty($el);
	});

	$ta_equipment		= mysql_real_escape_string(json_encode($_POST['ta_equipment']));

	if($_POST['cl_id']!=''){
		
		$ta_cl_id = mysql_real_escape_string($_POST['cl_id']);
		
	}else{
		
		// добавляем клиента
		mysql_query("INSERT INTO clients (cl_name, cl_phone) VALUES ('$cl_name', '$cl_phone')");

		// id клиента
		$ta_cl_id = mysql_insert_id();
		
	}	
	
	mysql_query("
		INSERT INTO tasks (
			ta_cl_id, 
			ta_date_add, 
			ta_de_id, 
			ta_model, 
			ta_serial, 
			ta_equipment, 
			ta_fi_id,
			ta_what_to_do, 
			ta_what_is_done, 
			ta_st_id
		) VALUES (
			'$ta_cl_id',
			'$ta_date_add',
			'$ta_de_id ',
			'$ta_model',
			'$ta_serial',
			'$ta_equipment',
			'$ta_fi_id',
			'$ta_what_to_do',
			'$ta_what_is_done',
			'$ta_st_id'
		)
	");

	$data['result'] = 'ok';
	$data['id'] = mysql_insert_id();

	echo json_encode($data);
	die;
}


if(isset($_GET['for_cl_id'])){
	$q = mysql_query("SELECT * FROM clients WHERE cl_id = ".mysql_real_escape_string($_GET['for_cl_id']));
	$client = mysql_fetch_assoc($q);
	
	$cl_phone = $client['cl_phone'];
	$cl_name = $client['cl_name'];
	$cl_id = $client['cl_id'];
}

?>

<title>Добавление задачи</title>

<link rel="stylesheet" href="https://nbyte.ru/crm_db_sc/tpl/old/css/style.css" />
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/themes/start/jquery-ui.css" />
<link href="https://nbyte.ru/crm_db_sc/tpl/new/scripts/jtable/themes/lightcolor/gray/jtable.min.css" rel="stylesheet" type="text/css" />
<link href="https://nbyte.ru/crm_db_sc/tpl/old/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />

<script src="https://nbyte.ru/crm_db_sc/tpl/old/scripts/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
<script src="https://nbyte.ru/crm_db_sc/tpl/new/scripts/jtable/jquery.jtable.min.js"></script>
<script src="https://nbyte.ru/crm_db_sc/tpl/new/scripts/jtable/jquery.jtable.ru.js"></script>
<script src="https://nbyte.ru/crm_db_sc/tpl/old/scripts/jquery.form.min.js"></script>
<script src="https://nbyte.ru/crm_db_sc/tpl/old/scripts/jquery.maskedinput.js"></script>
<script src="https://nbyte.ru/crm_db_sc/tpl/old/scripts/jquery.validationEngine.js"></script>
<script src="https://nbyte.ru/crm_db_sc/tpl/old/scripts/jquery.validationEngine-ru.js"></script>
<script src="//www.jacklmoore.com/js/autosize.min.js"></script>

<script>
$(document).ready(function(){
	
	$("#cl_phone").mask("+7(999) 999-99-99");
	
	$("#form").validationEngine();
	
	autosize($('textarea'));
	
	// сабмит формы
	$("#form").ajaxForm({
		success: function(data){
			data = JSON.parse(data);
			if(data.result == 'ok'){
				window.open('/crm_db_sc/act/reception/?id='+data.id, '_blank', 'width=850,height=600,left=50,top=50,location=no,menubar=no,scrollbars=no,status=no,toolbar=no');
				location.href = '/crm_db_sc/operator/';				
			}
		}
	});
	
});	
</script>

<style>
	table, table td {
		border-collapse:collapse !important;
		padding:3px;
		width: 800px;
		margin: 0;
	}
</style>

<style>
body {
	background: #607d8b24;
	padding: 0px 30px 30px 30px;
}

.form {
	width: 800px;
    background: white;
    padding: 20px 20px 25px 20px;
	border-radius:4px;
	margin-top: -15px;
	box-shadow: 0px 13px 21px -17px #607d8b;
}

td {
	border:1px solid #ddd;
	font-size:16px;
}

thead tr td {
	background:#eee;
	text-align:center;
	padding:5px 0;
}


button {
    border-radius: 6px;
    padding: 12px 25px;
    background: #607D8B;
    color: white;
    box-shadow: none;
    border: none;
    font-size: 18px;
}


#ta_what_to_do {
	width:100%;
}

#ta_what_is_done {
	width:100%;
}

.form-label {
	width: 158px;
	padding:0;
}

input[type=text], select {
	border-radius:2px;
	height:34px;
	width:100%;
	margin:0;
	padding:0;
}

input[type=text] {
	padding: 0 0 0 10px;
}

input[type=checkbox] {
	width:16px;
	height:16px;
	vertical-align: middle;
	margin-right:5px;
}

textarea {
	padding:5px !important;
}

input[readonly] {
	pointer-events: none;
    background: #e8ecee !important;
    color: #999;
    border-color: #00669945;
}
</style>

<style>
.row {
	display:flex;
	align-items: center;
	margin-bottom: 10px;
}

.row .label {
	width:170px;
}

.row .data {
	flex: 1 auto;
}
</style>


<body>
<div class="wrapper">
	<main class="content">
		
	<div class="content-header">
		<h1><a href="/crm_db_sc/operator/">Список</a> / Новая задача</h1>
	</div>
	
	<div class="form">

		<form id="form" method="POST" action="/crm_db_sc/zak/add.php">
	
			<input type="hidden" name="cl_id" value="<?=$cl_id?>">
	
			<div style="display:flex;">

				<div style="width: 400px;padding-right: 40px;">						
					
					<div class="row">
						<div class="label">Телефон клиента</div>
						<div class="data">
							<input name="cl_phone" <?if(isset($_GET['for_cl_id'])){?>readonly<?}?> class="validate[required,custom[phone]] ui-autocomplete-input" value="<?=$cl_phone?>" type="text" id="cl_phone" autocomplete="off">
						</div>
					</div>
					
					<div class="row">
						<div class="label">Имя клиента</div>
						<div class="data">
							<input name="cl_name" <?if(isset($_GET['for_cl_id'])){?>readonly<?}?> class="validate[required,custom[onlyLetterSp]]" value="<?=$cl_name?>" type="text" id="cl_name">
						</div>
					</div>
					
					<div class="row">
						<div class="label">Тип устройства</div>
						<div class="data">
							<select id="ta_de_id" name="ta_de_id" class="validate[required]">
								<option selected=""></option>
								<?
								$q = mysql_query("SELECT * FROM devices WHERE de_enabled = 1");
								while($r = mysql_fetch_array($q)){
									?><option value="<?=$r['de_id']?>"><?=$r['de_name']?></option><?
								}
								?>
							</select>
						</div>
					</div>
					
					<div class="row">
						<div class="label">Модель</div>
						<div class="data">
							<input class="validate[required,minSize[2]]" name="ta_model" type="text" id="ta_model">
						</div>
					</div>
					
					<div class="row">
						<div class="label">Серийный номер</div>
						<div class="data">
							<input name="ta_serial" type="text" id="ta_serial" placeholder="б.н.">
						</div>
					</div>
					
					<div class="row">
						<div class="label">Комплектация</div>
						<div class="data">							
							<div><label><input id="eq_1" type="checkbox" name="ta_equipment[]" value="Зарядка"> Зарядка</label></div>
							<div><label><input id="eq_2" type="checkbox" name="ta_equipment[]" value="Сумка"> Сумка</label></div>
							<div><label><input id="eq_3" type="checkbox" name="ta_equipment[]" value="Мышка"> Мышка</label></div>							
							<input style="margin-top:5px;height: 26px;" placeholder="другое.." id="eq_4" type="text" name="ta_equipment[]"><br>
						</div>
					</div>
					
				</div>
				
				<div style="flex: 1 auto;">
					
					<div class="form-str"><label class="form-label" for="ta_what_to_do">Переговоры с клиентом</label><textarea class="validate[required]" name="ta_what_to_do" id="ta_what_to_do"></textarea></div>
					<div class="form-str"><label class="form-label" for="ta_what_is_done">Что сделано</label><textarea class="validate[required]" name="ta_what_is_done" id="ta_what_is_done"></textarea></div>
					<div class="form-str"><label class="form-label" for="ta_fi_id">Откуда узнали</label>
						<select id="ta_fi_id" name="ta_fi_id" class="validate[required]">
							<option selected=""></option>
							<?
							$q = mysql_query("SELECT * FROM find_out WHERE fi_enabled = 1");
							while($r = mysql_fetch_array($q)){
								?><option value="<?=$r['fi_id']?>"><?=$r['fi_name']?></option><?
							}
							?>
						</select>
					</div>
					
				</div>	

			</div>	
			
			
			
			<div style="text-align: center; padding-top:40px;">
				<button type="submit" name="add">Добавить</button>
			</div>
	
		</form>
	</div>
		
	</main>
</div>
</body>
</html>