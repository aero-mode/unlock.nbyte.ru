<?
include($_SERVER['DOCUMENT_ROOT']."/crm_db_sc/zak/config.php");

$theme = "/crm_db_sc/tpl";

// --------------------------
// СОХРАНИТЬ или ЗАВЕРШИТЬ
// --------------------------
if(isset($_POST['save']) OR isset($_POST['end'])){

	foreach($_POST['act']['name'] AS $i => $act_name){
		
		if($act_name==''){continue;}
		
		$act[$i]['name'] = firstToUp($act_name);	
		$act[$i]['warranty'] = $_POST['act']['warranty'][$i];	
		$act[$i]['price'] = $_POST['act']['price'][$i];			
	}
	
	$id 				= mysql_real_escape_string($_GET['id']);
	$ta_price_all 		= mysql_real_escape_string($_POST['ta_price_all']);
	$ta_price_service 	= mysql_real_escape_string($_POST['ta_price_service']);
	$ta_price_hard 		= mysql_real_escape_string($_POST['ta_price_hard']);
	$ta_price_work 		= mysql_real_escape_string($_POST['ta_price_work']);
	$ta_what_to_do 		= mysql_real_escape_string($_POST['ta_what_to_do']);
	$ta_what_is_done 	= mysql_real_escape_string($_POST['ta_what_is_done']);
	$ta_act 			= mysql_real_escape_string(json_encode($act));
	
	// сохранить
	if(isset($_POST['save'])){
		$ta_st_id			= 2; // статус "в работе"
		$ta_date_end		= "NULL";
		$redirect_to 		= "/crm_db_sc/operator/";
	
	// завершить
	}else{
		$ta_st_id			= 3; // статус "завершена"
		$ta_date_end		= "'".date('Y-m-d H:i:s')."'";
		$redirect_to 		= "/crm_db_sc/operator/";
	}

	mysql_query("
		UPDATE tasks 
		SET ta_price_all = $ta_price_all,
		ta_price_service = $ta_price_service,
		ta_price_hard = $ta_price_hard,
		ta_price_work = $ta_price_work,
		ta_what_to_do = '$ta_what_to_do',
		ta_what_is_done = '$ta_what_is_done',
		ta_act = '$ta_act',
		ta_st_id = '$ta_st_id',
		ta_date_end = $ta_date_end
		WHERE ta_id = $id
	");
	
	header("location:$redirect_to");
	die;
}



$q = mysql_query("
	SELECT ta.*, cl.*, de.*, fi.*, st.* FROM tasks ta
	LEFT JOIN clients cl ON cl.cl_id = ta.ta_cl_id
	LEFT JOIN devices de ON de.de_id = ta.ta_de_id
	LEFT JOIN find_out fi ON fi.fi_id = ta.ta_fi_id
	LEFT JOIN statuses st ON st.st_id = ta.ta_st_id
	WHERE ta.ta_id = ".mysql_real_escape_string($_GET['id'])
);

$task = mysql_fetch_assoc($q);

$task['cl_phone'] = preg_replace ("/(\+7)(\d{3})(\d{3})(\d{2})(\d{2})/i","\$1(\$2) \$3-\$4-\$5",$task['cl_phone']);
$task['ta_equipment'] = json_decode($task['ta_equipment'], true);
$task['ta_act'] = json_decode($task['ta_act'], true);

// старый формат данных (разделялись переносом строки)
if(isset($task['ta_act']['ta_what_is_done'])){						
	$act_name = explode(PHP_EOL, $task['ta_act']['ta_what_is_done']);
	$act_warranty = explode(PHP_EOL, $task['ta_act']['warranty']);
	$act_price = explode(PHP_EOL, $task['ta_act']['price']);
	
	foreach($act_name AS $i=>$a){
		$new_act[$i]['name'] = $a;
		$new_act[$i]['warranty'] = $act_warranty[$i];
		$new_act[$i]['price'] = $act_price[$i];
	}						
	$task['ta_act'] = $new_act;						
}
					
if($task['ta_st_id']==1){
	$status = "Ожидает";
	$status_color = "#cc3300";
}elseif($task['ta_st_id']==2){
	$status = "В работе";
	$status_color = "#03a9f4";
}elseif($task['ta_st_id']==3){
	$status = "Завершена";
	$status_color = "#009688";
}elseif($task['ta_st_id']==4){
	$status = "Деньги получены";
	$status_color = "#60b301";
}
?>

<title>Редактирование задачи</title>

<link rel="stylesheet" href="https://nbyte.ru/crm_db_sc/tpl/old/css/style.css" />
<link href="https://nbyte.ru/crm_db_sc/tpl/old/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/themes/start/jquery-ui.css" />
<!--
<link href="https://nbyte.ru/crm_db_sc/tpl/new/scripts/jtable/themes/lightcolor/gray/jtable.min.css" rel="stylesheet" type="text/css" />
-->
	
<script src="https://nbyte.ru/crm_db_sc/tpl/old/scripts/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
<!--
<script src="https://nbyte.ru/crm_db_sc/tpl/new/scripts/jtable/jquery.jtable.min.js"></script>
<script src="https://nbyte.ru/crm_db_sc/tpl/new/scripts/jtable/jquery.jtable.ru.js"></script>
-->
<script src="https://nbyte.ru/crm_db_sc/tpl/old/scripts/jquery.validationEngine.js"></script>
<script src="https://nbyte.ru/crm_db_sc/tpl/old/scripts/jquery.validationEngine-ru.js"></script>
<script src="//www.jacklmoore.com/js/autosize.min.js"></script>

<script>
function add_row(){
	
	var last_row = $('.act_tr').last();			

	if(last_row.find('.act_row_name').val()!=''){
		last_row.clone().insertAfter(last_row);
	
		// очищаем все textarea
		$('.act_tr').last().find('textarea').each(function(t){				
			$(this).val('');				
		});
		
	}	

}
	
$(document).ready(function(){
	
	$("#form").validationEngine();
	
	autosize($('textarea'));
	
	$('.prices_input').on('blur focus keyup', function(){
		
		if($('.prices_input_vsego').val() !=''){
				
			var vsego = +$('.prices_input_vsego').val();
			var hs = +$('.prices_input_h_s').val();
			var hp = +$('.prices_input_h_p').val();
			var w = +$('.prices_input_w').val();
			
			vsego = vsego - hs - hp - w;		

			$('.prices_ostatok').html(vsego + ' руб.');
			
		}
		
	});
	
	
	
	// добавляем новую строку
	$(document).on('blur', '.act_row_name', function(){		
		if($(this).val() != ''){			
			add_row();	
		}		
	});
	
	// сабмит формы - валидация сумм
	$(document).on('submit', 'form', function(){
		
		var vsego = +$('.prices_input_vsego').val();
		var hs = +$('.prices_input_h_s').val();
		var hp = +$('.prices_input_h_p').val();
		var w = +$('.prices_input_w').val();
		
		if((vsego - hs - hp - w) < 0){
			alert('Ошибка в стоимости!');
			return false;
		}		
		
	});
	
	
	// популярыне услуги
	$('.act_top').on('click', function(){
		
		var t = $(this);		
		var n = t.data('act-n');
		var w = t.data('act-w');
		var p = t.data('act-p');
		
		$('.act_row_name').each(function(t){
			
			var t = $(this);
			
			if(t.val()==''){
				
				var parent_tr = t.closest('.act_tr');
				
				parent_tr.find('.act_row_name').val(n);
				parent_tr.find('.act_row_warranty').val(w);
				parent_tr.find('.act_row_price').val(p);				
				
				 add_row();
				
				return false;
			}
			
		});
		
		return false;
		
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

#act1,
#act2,
#act3 {
	background:#eee !important;
}

.act_row {
	width:100%;
	border:0;
}

.act_row:focus {
	border:none;
}

.act_tr td {
	vertical-align: top;
}

.uslugi_tbl {
	margin-top:15px;
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

.uslugi_tbl textarea {
	font-size:16px;
	line-height:1.48;
	font-family: arial;
	resize:none;
	color:#000;
}

.td_row_name {
	min-width:500px;
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

.prices {
	margin-top:10px;
	padding:5px 5px 8px 5px;
	background:#eee;
	display:flex;    
	justify-content: space-around;
}

.prices input {
	width:70px;
	margin-top:3px;
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

.act_top_wr {
	margin-left:50px;
}

.act_top_wr li {
	margin-bottom:8px;
}

.act_top_wr a {
	font-size:16px;
	text-decoration:none;
	color:#2196f3;
}

.row {
    display: flex;
	align-items: end;
    margin-bottom: 10px;
	font-size: 14px;
	line-height: 1.4;
}

.row .label {
    width: 170px;
}

.row .data {
    flex: 1 auto;
}
</style>


<body>

	<div class="content-header">
		<h1><a href="/crm_db_sc/operator/">Список</a> / Задача <?=$_GET['id']?></h1>
	</div>
	
	<div style="display:flex;">
	
		<div class="form">
			<form id="form" method="POST" action="/crm_db_sc/zak/edit.php?id=<?=$_GET['id']?>">
		
				<div style="display:flex;">

					<div style="width:380px">
					
						<div class="row">
							<div class="label">Статус</div>
							<div class="data" style="font-weight:bold;color:<?=$status_color?>"><?=$status?></div>
						</div>
						
						<div class="row">
							<div class="label">Телефон клиента</div>
							<div class="data"><?=$task['cl_phone']?></div>
						</div>
						
						<div class="row">
							<div class="label">Имя клиента</div>
							<div class="data"><?=$task['cl_name']?></div>
						</div>
						
						<div class="row">
							<div class="label">Модель</div>
							<div class="data"><?=$task['ta_model']?></div>
						</div>
						
						<div class="row">
							<div class="label">Серийный номер</div>
							<div class="data"><?=$task['ta_serial']?></div>
						</div>
						
						<div class="row">
							<div class="label">Тип устройства</div>
							<div class="data"><?=$task['de_name']?></div>
						</div>
						
						<div class="row">
							<div class="label">Комплектация</div>
							<div class="data">
								<?							
								foreach($task['ta_equipment'] AS $eq){
									?><div><?=$eq?></div><?
								}
								?>
							</div>
						</div>
						
						<div class="row">
							<div class="label">Откуда узнали</div>
							<div class="data"><?=$task['fi_name']?></div>
						</div>
						
					</div>
					
					<div style="flex: 1 auto;">
						
						<div style="margin-bottom:15px;"><label class="form-label" for="ta_what_to_do">Переговоры с клиентом</label><textarea readonly style="min-height: 65px;border-color: #ddd;" name="ta_what_to_do" id="ta_what_to_do"><?=$task['ta_what_to_do']?></textarea></div>
						
						<div><label class="form-label" for="ta_what_is_done">Что сделано</label><textarea class="validate[required]" name="ta_what_is_done" style="min-height: 65px;border-color: #ddd;" id="ta_what_is_done"><?=$task['ta_what_is_done'];?></textarea></div>
						
						<div class="prices">
							<div><div style="font-weight:bold;">Всего</div><input maxlength="6" type="text" value="<?=($task['ta_price_all']==''? 0 : $task['ta_price_all'])?>" name="ta_price_all" style="font-weight:bold;" class="prices_input prices_input_vsego validate[required,custom[onlyNumberSp]]"></div>
							<div><div>Ж. сервис</div><input maxlength="6" type="text" value="<?=($task['ta_price_service']==''? 0 : $task['ta_price_service'])?>" name="ta_price_service" class="prices_input prices_input_h_s"></div>
							<div><div>Ж. партнер</div><input maxlength="6" type="text" value="<?=($task['ta_price_hard']==''? 0 : $task['ta_price_hard'])?>" name="ta_price_hard" class="prices_input prices_input_h_p"></div>
							<div><div>Работа</div><input maxlength="6" type="text" value="<?=($task['ta_price_work']==''? 0 : $task['ta_price_work'])?>" name="ta_price_work" class="prices_input prices_input_w"></div>
							<div><div>Касса</div><div class="prices_ostatok" style="margin-top: 7px;color: #999;"><?=($task['ta_price_all'] - $task['ta_price_service'] - $task['ta_price_hard'] - $task['ta_price_work'])?> руб.</div></div>
						</div>
						
					</div>	

				</div>	
				
				<div style="text-align: center;">

					<table class="uslugi_tbl">
						<thead>
							<tr>
								<td>Услуга</td>
								<td>Гарантия, мес.</td>
								<td>Цена</td>
							</tr>
						</thead>
						
						<?									
						foreach($task['ta_act'] AS $i => $act){	
							?>
							<tr class="act_tr">
								<td class="td_row_name"><textarea name="act[name][]" class="act_row act_row_name"><?=htmlspecialchars($act['name'])?></textarea></td>
								<td class="td_row_warranty"><textarea name="act[warranty][]" class="act_row act_row_warranty"><?=$act['warranty']?></textarea></td>
								<td class="td_row_price"><textarea name="act[price][]" class="act_row act_row_price"><?=$act['price']?></textarea></td>
							</tr>
							<?
						}
						?>
						
						<tr class="act_tr">
							<td class="td_row_name"><textarea name="act[name][]" class="act_row act_row_name"></textarea></td>
							<td class="td_row_warranty"><textarea name="act[warranty][]" class="act_row act_row_warranty"></textarea></td>
							<td class="td_row_price"><textarea name="act[price][]" class="act_row act_row_price"></textarea></td>
						</tr>
						
					</table>
					
				</div>
				
				<div style="text-align: center; padding-top:20px;">
					<button type="submit" name="save" style="margin-right:15px;background:#009688;">Сохранить</button>
					<?if($task['ta_st_id'] < 3){?><button type="submit" name="end">Завершить</button><?}?>
				</div>
		
			</form>
		</div>
		
		<!-- популярные услуги -->
		<ul class="act_top_wr">
			
			<?include "edit_uslugi.inc.php";?>
			
			<!--
			<li><a href="" class="act_top" data-act-n="Диагностика" data-act-w="—" data-act-p="бесплатно">Диагностика, —, бесплатно</a>
			<li><a href="" class="act_top" data-act-n="Диагностика аппаратная (частичная разборка)" data-act-w="—" data-act-p="300 руб">Диагностика аппаратная (частичная разборка)</a>
			<li><a href="" class="act_top" data-act-n="Диагностика аппаратная (полная разборка)" data-act-w="—" data-act-p="500 руб">Диагностика аппаратная (полная разборка)</a>
			<li><a href="" class="act_top" data-act-n="Чистка ноутбука от пыли (замена термопасты на Zalman ZM-STG2) (Гарантия на термопасту)" data-act-w="12" data-act-p="1500 руб">Чистка ноутбука от пыли (замена термопасты на Zalman ZM-STG2) (Гарантия на термопасту)</a>
			<li><a href="" class="act_top" data-act-n="Установка SSD диска" data-act-w="" data-act-p="">Установка SSD диска</a>
			<li><a href="" class="act_top" data-act-n="Ремонт зарядного устройства ноутбука" data-act-w="1 мес" data-act-p="300 руб">Ремонт зарядного устройства ноутбука</a>
			<li><a href="" class="act_top" data-act-n="Ремонт, замена системы охлаждения ноутбука" data-act-w="1 мес" data-act-p="">Ремонт, замена системы охлаждения ноутбука</a>
			<li><a href="" class="act_top" data-act-n="Ремонт материнской платы ноутбука" data-act-w="" data-act-p="">Ремонт материнской платы ноутбука</a>
			<li><a href="" class="act_top" data-act-n="Замена экрана" data-act-w="1 мес" data-act-p="">Замена экрана</a>

			<li><a href="" class="act_top" data-act-n="Оптимизация работы (Ноутбук \ ПК)" data-act-w="1 мес" data-act-p="500 руб">Оптимизация работы</a>
			<li><a href="" class="act_top" data-act-n="Пакет услуг (настройка Windows, драйверов, программ, настройка Bios)" data-act-w="1 мес" data-act-p="1500 руб">Пакет услуг</a>
			<li><a href="" class="act_top" data-act-n="Антивирус установка и настройка" data-act-w="1 мес" data-act-p="500 руб">Антивирус установка и настройка</a>
			<li><a href="" class="act_top" data-act-n="Восстановление работоспособности ОС" data-act-w="—" data-act-p="1000 руб">Восстановление работоспособности ОС</a>
			<li><a href="" class="act_top" data-act-n="Чистка системного блока от пыли, БП, контактов, разъемов (полная разборка)" data-act-w="—" data-act-p="500 руб">Чистка системного блока от пыли, БП, контактов, разъемов (полная разборка)</a>
			<li><a href="" class="act_top" data-act-n="Замена термопасты на центральном процессоре (Гарантия на термопасту)" data-act-w="12 мес" data-act-p="300 руб">Замена термопасты на центральном процессоре (Гарантия на термопасту)</a>
			<li><a href="" class="act_top" data-act-n="Замена термопасты на видеокарте на фирменную Zalman ZM-STG2 (Гарантия на термопасту)" data-act-w="12 мес" data-act-p="500 руб">Замена термопасты на видеокарте на фирменную Zalman ZM-STG2 (Гарантия на термопасту)</a>
			<li><a href="" class="act_top" data-act-n="Замена шлейфа SATA на фирменный с металлическими защелками (работа + деталь)" data-act-w="12 мес" data-act-p="300 руб">Замена шлейфа SATA на фирменный с металлическими защелками (работа + деталь)</a>
			<li><a href="" class="act_top" data-act-n="Ремонт материнской платы" data-act-w="1 мес" data-act-p="">Ремонт материнской платы</a>
			
			<li style="font-size: 16px;font-weight: 600;margin-top: 15px;">Смартфон / планшет</li>
			
			<li><a href="" class="act_top" data-act-n="Диагностика аппаратная (с разборкой аппарата)" data-act-w="—" data-act-p="300 руб">Диагностика аппаратная (с разборкой аппарата)</a>
			<li><a href="" class="act_top" data-act-n="Ремонт сенсора" data-act-w="2 недели" data-act-p="">Ремонт сенсора</a>
			<li><a href="" class="act_top" data-act-n="Замена тачскрина" data-act-w="2 недели" data-act-p="">Замена тачскрина</a>
			<li><a href="" class="act_top" data-act-n="Замена дисплея" data-act-w="2 недели" data-act-p="">Замена дисплея</a>
			<li><a href="" class="act_top" data-act-n="Замена АКБ" data-act-w="2 недели" data-act-p="">Замена АКБ</a>
			<li><a href="" class="act_top" data-act-n="Прошивка" data-act-w="—" data-act-p="">Прошивка</a>
			<li><a href="" class="act_top" data-act-n="Настройка" data-act-w="—" data-act-p="">Настройка</a>
			-->
			
		</ul>
		
	</div>

</body>
</html>