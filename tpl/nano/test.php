<?
date_default_timezone_set('Europe/Kiev');
$now =date('G');
$time = time();
$hour = date('G', $time);
$min = date('i', $time);
$min = 60-$min;
$sec = date('s', $time);
$sec = 60-$sec;
if($now>=19 || $now<9){
	$limit = 50400;
	$colorLeft = "#008000";
	$colorRight = "#FF0000";
	$dataStart = date("d F Y");
	$dataStart = strtotime($dataStart."19:00:00");
	$current = time()-$dataStart;
	switch($hour){
		case 19:
			$hours = 13;
			$hour_text = 'часов';
			break;
		case 20:
			$hours = 12;
			$hour_text = 'часов';
			break;
		case 21:
			$hours = 11;
			$hour_text = 'часов';
			break;
		case 22:
			$hours = 10;
			$hour_text = 'часов';
			break;
		case 23:
			$hours = 9;
			$hour_text = 'часов';
			break;
		case 0:
			$hours = 8;
			$hour_text = 'часов';
			break;
		case 1:
			$hours = 7;
			$hour_text = 'часов';
			break;
		case 2:
			$hours = 6;
			$hour_text = 'часов';
			break;
		case 3:
			$hours = 5;
			$hour_text = 'часов';
			break;
		case 4:
			$hours = 4;
			$hour_text = 'часа';
			break;
		case 5:
			$hours = 3;
			$hour_text = 'часа';
			break;
		case 6:
			$hours = 2;
			$hour_text = 'часа';
			break;
		case 7:
			$hours = 1;
			$hour_text = 'час';
			break;
		case 8:
			$hours = 0;
			$hour_text = 'часов';
			break;
	}
	$timer_title = "Мы откроемся через:";
}else{
	$limit = 36000;
	$colorLeft = "#FF0000";
	$colorRight = "#008000";
	$dataStart = date("d F Y");
	$dataStart = strtotime($dataStart."09:00:00");
	$current = time()-$dataStart;
	$hours = 18-$hour;
	$timer_title = "До конца рабочего дня осталось:";
}
$hour_text = array("час", "часа", "часов");
$minute_text = array("минута", "минуты", "минут");
$second_text = array("секунда", "секунды", "секунд");
	function getWord($number, $suffix) {
		$keys = array(2, 0, 1, 1, 1, 2);
		$mod = $number % 100;
		$suffix_key = ($mod > 7 && $mod < 20) ? 2: $keys[min($mod % 10, 5)];
		return $suffix[$suffix_key];
	}
$eee = $current;

?><!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<link href="script/timer.css" rel="stylesheet">
	<script type="text/javascript" src="script/jquery.min.js"></script>
	<script src="script/jquery-ui/jquery-ui.js" type="text/javascript"></script>
	<script src="script/jquery.lwtCountdown-1.0.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="script/jquery-ui/themes/hot-sneaks/jquery-ui.bak.css" media="screen" />
<script>
$(document).ready(function(){
	var min = <?=$eee?>;
    $("#slider-range").slider({
      range: "min",
	  disabled: true,
      min: 1,
      max: <?=$limit?>,
	  value: min,
    });
	//$("#amount").text(min);
	setInterval(function(){
			min = min+1;
			$("#slider-range").slider({value: min});
			//$("#amount").text(min);
		},
		1000
	);
	$('#countdown_dashboard').countDown({
		targetOffset: {
			'day'	:	0,
			'month'	:	0,
			'year'	:	0,
			'hour'	:	<?=$hours?>,
			'min'	:	<?=$min?>,
			'sec'	:	<?=$sec?>
		}
	});
});
</script>
<style>
.ui-widget-content {
	background: none repeat-x scroll 50% 50% <?=$colorRight?>;
}
.ui-widget-header {
	background: none repeat-x scroll 50% 50% <?=$colorLeft?>;
}
</style>
</head>
<body>
	<div style="width:950px;margin: 0 auto;margin-top:25%;">
		<div id="slider-range"></div>
		<div style="margin-top:20px;">
			<div style="text-align:center;">
				<div style="color: #555555;font-family: Times;font-size: 27.5pt;font-weight: bold;display:inline-block;"><?=$timer_title?></div>
				<div id="down_dashboard">
					<div id="countdown_dashboard">
						<div class="dash hours_dash">
							<div class="digit">0</div>
							<div class="digit">0</div><span class="fff">:</span>
						</div>	
						<div class="dash minutes_dash">
							<div class="digit">0</div>
							<div class="digit">0</div><span class="fff">:</span>
						</div>
						<div class="dash seconds_dash">
							<div class="digit">0</div>
							<div class="digit">0</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		<script language="javascript" type="text/javascript">
		jQuery(document).ready(function() {
			$('#countdown_dashboard').countDown({
				targetOffset: {
					'day'	:	0,
					'month'	:	0,
					'year'	:	0,
					'hour'	:	<?=$hours?>,
					'min'	:	<?=$min?>,
					'sec'	:	<?=$sec?>
				}
			});
		});
	</script>
</body>
</html>