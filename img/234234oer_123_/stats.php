<?
include "connect2db.php";
connect();
$masters_query = mysql_query("SELECT `id`, `name` FROM `masters`");
	if(isset($_POST['from'])){
		$from = $_POST['from']-1;
		$to = $_POST['to']+1;
		$renge = "AND `date_oplata` > '".$from."' AND `date_oplata` < '".$to."'";
		$renge2 = "AND `future_date_add` > '".$from."' AND `future_date_add` < '".$to."'";
	}else{
		$renge = '';
		$renge2 = '';
	}
	
function all_request($id, $renge){
	$master_query = mysql_query("SELECT `id` FROM `clients` WHERE `id_master`='$id' $renge AND `show1`=1");
	while($master_row = mysql_fetch_assoc($master_query)){
		$request[] =  $master_row['id'];
	}
	$all_request = count($request);
	return $all_request;
}
// function request_in_work($id, $renge){
	// $master_query = mysql_query("SELECT `id` FROM `clients` WHERE `id_master`='$id' $renge AND `status`=1 AND `show1`=1");
	// while($master_row = mysql_fetch_assoc($master_query)){
		// $request[] =  $master_row['id'];
	// }
	// $all_request = count($request);
	// return $all_request;
// }
// function request_not_cost($id, $renge){
	// $master_query = mysql_query("SELECT `id` FROM `clients` WHERE `id_master`='$id' $renge AND `status`='2' AND `date_oplata`='0' AND `show1`=1");
	// while($master_row = mysql_fetch_assoc($master_query)){
		// $request[] =  $master_row['id'];
	// }
	// $all_request = count($request);
	// return $all_request;
// }
function cost_all_work($id, $renge){
	$master_query = mysql_query("SELECT `cena_work` FROM `clients` WHERE `id_master`='$id' $renge AND `status`='2' AND `date_oplata`!='0' AND `show1`=1");
	while($master_row = mysql_fetch_assoc($master_query)){
		$request +=  $master_row['cena_work'];
	}
	return $request;
}
function cost_all_hard($id, $renge){
	$master_query = mysql_query("SELECT `cena_hard` FROM `clients` WHERE `id_master`='$id' $renge AND `status`='2' AND `date_oplata`!='0' AND `show1`=1");
	while($master_row = mysql_fetch_assoc($master_query)){
		$request +=  $master_row['cena_hard'];
	}
	return $request;
}
function average_bill_work($id, $renge){
	$master_query = mysql_query("SELECT `cena_work` FROM `clients` WHERE `id_master`='$id' $renge AND `status`='2' AND `date_oplata`!='0' AND `show1`=1");
	while($master_row = mysql_fetch_assoc($master_query)){
		$count[] =  $master_row['cena_work'];
		$request +=  $master_row['cena_work'];
	}
	@$all = $request/count($count);
	return number_format($all, 2);
}
function average_bill_hard($id, $renge){
	$master_query = mysql_query("SELECT `cena_hard` FROM `clients` WHERE `id_master`='$id' $renge AND `status`='2' AND `date_oplata`!='0' AND `show1`=1");
	while($master_row = mysql_fetch_assoc($master_query)){
		$count[] =  $master_row['cena_hard'];
		$request +=  $master_row['cena_hard'];
	}
	@$all = $request/count($count);
	return number_format($all, 2);
}
function future_request($id, $renge2){
	$master_query = mysql_query("SELECT COUNT(id) FROM `clients` WHERE `patern_master`='$id' $renge2 AND `show1`=1");
	$all_request = mysql_result($master_query,0);
	return $all_request;
}
if(isset($_GET['asd'])){?>
<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>Статистика по мастерам</title>
</head>
<body>
	<?
	$lex = explode('-', $_GET['asd']);
		$from = $_GET['from']-1;
		$to = $_GET['to']+1;
		$renge = "AND `date_oplata` > '".$from."' AND `date_oplata` < '".$to."'";
		$renge2 = "AND `future_date_add` > '".$from."' AND `future_date_add` < '".$to."'";
	?>
	<table id="table">
		<thead>
			<tr>
				<th>Name</th>
			<?foreach($lex as $num=>$row){?>
				<th><?
				$master_query = mysql_query("SELECT `name` FROM `masters` WHERE `id`='$row'");
				echo mysql_result($master_query,0);
				?></th>
			<?}?>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>all_request</td>
			<?foreach($lex as $num=>$row){?>
				<td><?=all_request($row, $renge)?></td>
			<?}?>
			</tr>
			<tr>
				<td>cost_all_work</td>
			<?foreach($lex as $num=>$row){?>
				<td><?=cost_all_work($row, $renge)?></td>
			<?}?>
			</tr>
			<tr>
				<td>cost_all_hard</td>
			<?foreach($lex as $num=>$row){?>
				<td><?=cost_all_hard($row, $renge)?></td>
			<?}?>
			</tr>
			<tr>
				<td>average_bill_work</td>
			<?foreach($lex as $num=>$row){?>
				<td><?=average_bill_work($row, $renge)?></td>
			<?}?>
			</tr>
			<tr>
				<td>average_bill_hard</td>
			<?foreach($lex as $num=>$row){?>
				<td><?=average_bill_hard($row, $renge)?></td>
			<?}?>
			</tr>
			<tr>
				<td>future_request</td>
			<?foreach($lex as $num=>$row){?>
				<td><?=future_request($row, $renge2)?></td>
			<?}?>
			</tr>
		</tbody>
	</table>

</body>
</html>
<?}else{?>
<!DOCTYPE html "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="content-type" content="text/html; charset=windows-1251"/>
	<title>Статистика по мастерам</title>
	<link rel="stylesheet" type="text/css" href="scripts/ui-lightness/jquery-ui-1.10.3.custom.min.css" media="screen" />
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script type="text/javascript" src="scripts/jquery-ui-1.10.3.custom.min.js"></script>
	<link rel="stylesheet" type="text/css" href="scripts/fancybox/jquery.fancybox.css" media="screen" />
	<script type='text/javascript' src='scripts/fancybox/jquery.fancybox.pack.js'></script>
	<script>
		$(document).ready(function() {
			var dates = $("#from, #to").datepicker({
				monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
				monthNamesShort: ['Янв','Фев','Мар','Апр','Май','Июн','Июл','Авг','Сен','Окт','Ноя','Дек'],
				dayNames: ['воскресенье','понедельник','вторник','среда','четверг','пятница','суббота'],
				dayNamesShort: ['вск','пнд','втр','срд','чтв','птн','сбт'],
				dayNamesMin: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
				firstDay: 1,
				minDate: "-3M",
				maxDate: 0,
				defaultDate: "+1w",
				changeMonth: false,
				numberOfMonths: 2,
				dateFormat: "yymmdd",
				onSelect: function(selectedDate){
					var option = this.id == "from" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat || $.datepicker._defaults.dateFormat,
						selectedDate, instance.settings);
					dates.not(this).datepicker("option", option, date);
				}
			});
			
			$('input[name="var"]').change(function (){
				setValue();
			});
			function setValue(){
				var dlm='';
				var val='';
				$('input[name="var"]').each(function (){
					if (!this.checked) return;
					val=val+dlm+this.value;
					dlm='-';
				});
				var minRenge='';
				var maxRenge='';
				if($('#from').val()!=''){
					from='&from='+$('#from').val();
				}else{
					from='';
				}
				if($('#to').val()!=''){
					to='&to='+$('#to').val();
				}else{
					to='';
				}
				$('#desk').attr('href', 'stats.php?asd='+val+from+to);
			};
			$('a.iframe').fancybox({
				'autoScale'     :	false,
				'type'			:	'ajax',
				'width'			:	600,
				'height'		:	600
			});


		});
	</script>
	<style>
		body{
			width: 100%;
			margin: 0;
			padding: 0;
		}
		#header{
			width:95%;
			margin:10px auto;
			padding:10px;
		}
		
		#title h1 {
			color: #CC3300;
			font-family: Times,Georgia;
			font-size: 27pt;
			margin-bottom: 25px;
			margin-top: 25px;
			text-align:center;
		}
		
		#main{
			width:96%;
			margin:10px auto;
		}
		#table{
			width:100%;
			border-collapse: collapse;
			border:1px solid black;
		}
		#table table, #table th, #table tr, #table td{
			border:1px solid black;
			padding:5px;
		}
	</style>
</head>
<body>
	<div id="header">
		<div id="title"><h1>Какая-то статистика</h1></div>
		<div id="range">
			<form method="POST" action="">
				<p>
				  <label for="from">с:</label> <input type="text" id="from" name="from" value="<?=$_POST['from']?>" /> 
				  <label for="to">до:</label> <input type="text" id="to" name="to" value="<?=$_POST['to']?>" />
				  <input type="submit" name="submit" value="Выбрать" />
				</p>
			</form>
		</div>
	</div>
	<div id="main">
		<table id="table">
			<thead>
				<tr>
					<th></th>
					<th>Имя</th>
					<th>Всего заявок</th>
					<!--<th>Заявок в процессе</th>
					<th>Заявок не оплаченных</th>-->
					<th>Сумма всех работа</th>
					<th>Сумма всех железо</th>
					<th>Ср. чек работа</th>
					<th>Ср. чек железо</th>
					<th>Создал заявок на будущее</th>
				</tr>
			</thead>
			<tbody>
				<?while($masters_row = mysql_fetch_assoc($masters_query)){?>
					<tr>
						<td><input type="checkbox" name="var" id="chek<?=$masters_row['id']?>" onclick="checkCheck(this)" value="<?=$masters_row['id']?>" /></td>
						<td><?=$masters_row['name']?></td>
						<td><?=all_request($masters_row['id'], $renge)?></td>
						<!--<td><?//=request_in_work($masters_row['id'], $renge)?></td>
						<td><?//=request_not_cost($masters_row['id'], $renge)?></td>-->
						<td><?=cost_all_work($masters_row['id'], $renge)?></td>
						<td><?=cost_all_hard($masters_row['id'], $renge)?></td>
						<td><?=average_bill_work($masters_row['id'], $renge)?></td>
						<td><?=average_bill_hard($masters_row['id'], $renge)?></td>
						<td><?=future_request($masters_row['id'], $renge2)?></td>
					</tr>
				<?}?>
			</tbody>
		</table>
		<a class="iframe" id="desk">Сравнить</a>
	</div>
</body>
</html>
<?}?>