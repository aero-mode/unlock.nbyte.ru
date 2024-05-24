{% extends "main.tpl" %}
{% block title %}{{title}} Ошибка, страница не найдена / {{global_title}}{% endblock %}
{% block scripts %}
	<script type="text/javascript" src="{{theme}}/script/jquery.min.js"></script>
	<script src="{{theme}}/script/jquery-ui/jquery-ui.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="{{theme}}/script/jquery-ui/themes/hot-sneaks/jquery-ui.css" media="screen" />
	<script type="text/javascript" src="{{theme}}/script/jquery.maskedinput.js"></script>
	<script src="{{theme}}/script/jquery.lwtCountdown-1.0.js" type="text/javascript"></script>
	<link href="{{theme}}/script/timer.css" rel="stylesheet">
<style>
#slider-range {
	background: none repeat-x scroll 50% 50% {{timer.colorRight}};
	opacity: 1;
}
.ui-slider .ui-widget-header {
	background: none repeat-x scroll 50% 50% {{timer.colorLeft}};
}
</style>
{% endblock %}
{% block body %}
	<main class="content">
		<div style="margin: 20px 0;"><h1 style="font-size: 28px;padding-top: 5px;text-align: center;">Страница не найдена</h1></div>
		<div id="slider-range"></div>
		<div style="margin-top:20px;margin-bottom:20px;">
			<div style="text-align:center;">
				<div style="color: #555555;font-family: Arial, sans-serif;font-size: 27.5pt;font-weight: bold;display:inline-block;">{{timer.timer_title}}</div>
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
		<div style="text-align:center;" id="map">
			<script type="text/javascript" charset="utf-8" src="//api-maps.yandex.ru/services/constructor/1.0/js/?sid=HP6HuAjoIACNMKQRB0_G9H8P41im-0Hn&amp;width=1024&amp;height=450"></script>
		</div>
	<script language="javascript" type="text/javascript">
		jQuery(document).ready(function() {
			var min = {{timer.eee}};
			$("#slider-range").slider({
			  range: "min",
			  disabled: true,
			  min: 1,
			  max: {{timer.limit}},
			  value: min,
			});
			//$("#amount").text(min);
			setInterval(function(){
					min = min+1;
					$("#slider-range").slider({value: min});
					//$("#amount").text(min);
				},
				1
			);
			$('#countdown_dashboard').countDown({
				targetOffset: {
					'day'	:	0,
					'month'	:	0,
					'year'	:	0,
					'hour'	:	{{timer.hours}},
					'min'	:	{{timer.min}},
					'sec'	:	{{timer.sec}}
				}
			});
		});
	</script>
	</main>
{% endblock %}