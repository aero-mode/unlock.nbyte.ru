<?
include($_SERVER['DOCUMENT_ROOT']."/crm_db_sc/zak/config.php");

$id = mysql_real_escape_string($_GET['id']);

$q = mysql_query("SELECT * FROM tasks WHERE ta_id = $id");
$task = mysql_fetch_assoc($q);

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
?>


<title>Акт выполненых работ</title>

<link href="/crm_db_sc/tpl/old/css/style.css" rel="stylesheet"/>
<script src="/crm_db_sc/tpl/old/scripts/jquery.min.js"></script>
<script src="//www.jacklmoore.com/js/autosize.min.js"></script>

	<style>
		.wrapper {
			min-width: 800px;
			max-width: 800px;
			margin: 0 auto;
		}
		table, table td {
			border-collapse:collapse !important;
			padding:3px;			
			margin: 0;
		}
		table {
			width: 800px;
			white-space: normal;
			line-height: normal;
			font-weight: normal;
			font-size: medium;
			font-variant: normal;
			font-style: normal;
			color: -webkit-text;
			text-align: start;
		}
		
		.td_row_name {
			border-left:1px solid #000;
			border-right:1px solid #000;
			width:500px;
		}
		
		.td_row_price {
			border-left:1px solid #000;
			border-right:1px solid #000;
			width:150px;
		}
		
		.act_tr td {
			vertical-align: top;
		}
		
		b {
			font-weight: bold;
		}
		.head {
			font-size:18px;
			line-height:30px;
		}
		.h1{
			color:black;
			font-weight:normal;
			margin-top:25px;
			margin-bottom:20px;
			font-family:Arial, sans-serif;
			font-size:22pt;
		}
		.print{
			width:800px;
			margin: 0 auto;
		}
		
		textarea {
			border:none;
			width:100%;
			resize:none;
			font-size:16px;
			font-family:arial;
		}
		
		textarea:focus {
			border:none;
		}
		
		
		@media print{
			
			table {
				width: 275mm;
			}
			
			table, table td {
				border-collapse:collapse !important;
				padding:5mm;				
				margin: 0;
			}
			.print{
				margin: 0;
			}
			.head {
				width:133mm;
				font-size:18px;
				line-height:30px;
			}
			.h1{
				color:black;
				font-weight:normal;
				margin-top:25px;
				margin-bottom:20px;
				font-family:Arial, sans-serif;
				font-size:22pt;
			}
			
			.fontsize {
				font-size:20px;
			}
		}
	</style>
	
	<script>
	$(document).ready(function(){
		autosize($('textarea'));
	});
	</script>

	<div class="print">
		<table align="center">
			<tr>
				<td style="font-size:11pt;display:flex;justify-content: space-between;">
					
					<div class="head" style="">
						<b>Сервис-центр «Нанобайт»</b><br>
						+7 978 745 37 55
					</div>
					
					<div class="head" style="text-align:right;line-height:24px;">
						г. Симферополь, ул. Павленко, 15<br>
						Режим работы: с 9:00 до 19:00, воскресенье выходной<br>
						<b>nbyte.ru</b>
					</div>

				</td>
			</tr>
			<tr>
				<td align="center">
					<h1 class="h1">Акт выполненных работ №0<?=$task['ta_id']?>, <?=date('d.m.Y',strtotime($task['ta_date_end']))?></h1>
				</td>
			</tr>
			<tr>
				<td>
					
					<div class="fontsize"><?=$task['de_name']?> <?=$task['ta_model']?>, SN:  <?=$task['ta_serial']?></div>
					
					<table align="center" border="1" style="margin-top:15px;">
						<thead>
							<tr>
								<td class="fontsize" style="background:#eeeeee;padding:5px;border: 1px solid #000000;">
									Услуга
								</td>
								<td class="fontsize" style="background:#eeeeee;padding:5px;border: 1px solid #000000;">
									Гарантия, мес.
								</td>
								<td class="fontsize" style="background:#eeeeee;padding:5px;border: 1px solid #000000;">
									Цена
								</td>
							</tr>
						</thead>
						
						<?								
						foreach($task['ta_act'] AS $i => $act){	
							?>
							<tr class="act_tr">
								<td class="td_row_name"><textarea name="act[name][]" class="act_row_name fontsize"><?=htmlspecialchars($act['name'])?></textarea></td>
								<td class="td_row_warranty"><textarea name="act[warranty][]" class="act_row_warranty fontsize"><?=$act['warranty']?></textarea></td>
								<td class="td_row_price"><textarea name="act[price][]" class="act_row_price fontsize"><?=$act['price']?></textarea></td>
							</tr>
							<?
						}
						?>
						
						<tr>
							<td class="fontsize" valign="top" colspan="2" style="font-weight:bold;padding:5px;border: 1px solid #000000;">
								Всего:
							</td>
							<td class="fontsize" valign="top" style="padding:5px;font-weight:bold;border: 1px solid #000000;">
								<?=$task['ta_price_all']?> руб.
							</td>
						</tr>

					</table>
				</td>
			</tr>

			<tr>
				<td style="display:flex;justify-content: space-between;padding-top:40px;">
					<div style="">

					</div>
					<div style="text-align:right;line-height:20px;">
						__________________ 	М.П.
					</div>
				</td>
			</tr>
			<tr>
		</table>
	</div>