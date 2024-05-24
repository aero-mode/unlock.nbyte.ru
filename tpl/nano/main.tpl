<!DOCTYPE html>
<html>
<head>
	<title>{% block title %}{{global_title}}{% endblock %}</title>
	<meta charset="utf-8">
	<meta name="keywords" content="{% block keywords %}{{global_keywords}}{% endblock %}">
	<meta name="description" content="{% block description %}{{global_description}}{% endblock %}">
	<meta name="robots" content="index,follow">
	<meta name="yandex-verification" content="4c66597fecd98ee2" />
	<link rel="stylesheet" type="text/css" href="https://nbyte.ru/tpl/nano/css/style.css">
	<link rel="shortcut icon" href="favicon.ico" >
	<!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
{% block scripts %}
	<script type="text/javascript" src="https://nbyte.ru/tpl/nano/script/jquery.min.js"></script>
	<script src="https://nbyte.ru/tpl/nano/script/jquery-ui/jquery-ui.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="https://nbyte.ru/tpl/nano/script/jquery-ui/themes/hot-sneaks/jquery-ui.css" media="screen" />
	<script type="text/javascript" src="https://nbyte.ru/tpl/nano/script/jquery.maskedinput.js"></script>
	<script src="https://nbyte.ru/tpl/nano/script/jquery.lwtCountdown-1.0.js" type="text/javascript"></script>
	<link href="https://nbyte.ru/tpl/nano/script/timer.css" rel="stylesheet">
	<!-- Put this script tag to the <head> of your page -->
<script type="text/javascript" src="//vk.com/js/api/openapi.js?115"></script>

<script type="text/javascript">
  VK.init({apiId: 4471930, onlyWidgets: true});
</script>

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
<script>
$(document).ready(function(){
	$("#phone-bottom").on('click', function(e){
		e.stopPropagation();
		ga('send', 'event', 'кнопка', 'клик', 'позвонить');
		yaCounter24071299.reachGoal('phone');
		$("#send").show("slow");
	});
	$("#send").on('click', function(e){
		e.stopPropagation();
	});
	$('body').on('click', function(){
		$("#send").hide("slow");
	});
});
</script>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-6854363-1', 'auto');
  ga('send', 'pageview');

</script>
<style>
#call_me {
	text-align: center;
	border: solid 1px #ccc !important;
	height: 30px;
	cursor: pointer;
	border-radius: 5px;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	background: -moz-linear-gradient(0% 100% 90deg, #ccc, #fff) !important;
	background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#ccc), to(#fff)) !important;
}
#call_me:hover{
	background: -moz-linear-gradient(0% 100% 90deg, #fff, #ccc) !important;
	background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#fff), to(#ccc)) !important;
}
#call_me:disabled{
	background: none repeat scroll 0 0 #FFFFFF !important;
	cursor: default;
}
.input {
	display:block;
}
.input input {
    background: none repeat scroll 0 0 #FFFFFF !important;
    border: 1px solid #CCCCCC;
    border-radius: 3px;
    color: #000000;
    font-family: Arial,sans-serif;
    font-size: 12px;
    height: 20px;
	margin: 0 auto;
    margin-top: 10px;
    outline: medium none;
    padding: 2px;
    width: 120px;
}
</style>
</head>
<body>
<div class="wrapper">
	{% include "header.tpl" %}
	{% block body %}
	<main class="content">
    <!--<div style="margin-top:30px;" id="slider-range"></div>
		<div style="margin-top:30px;margin-bottom:40px;">
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
		</div>-->
		<div style="text-align:center;margin-top: 80px;" id="map">
			<div style="width:100%;overflow:hidden;">
			    <!--<span style="font-size:18px;"><strong>Симферополь, ул. Павленко 15/72, </strong>+7 (978) 745-37-55<br><br>Время работы: с 9:00 до 18:00, воскресенье выходной  </span>
		    	<div style="margin-bottom:20px;"></div>-->
		    	<script type="text/javascript" charset="utf-8" src="//api-maps.yandex.ru/services/constructor/1.0/js/?sid=HP6HuAjoIACNMKQRB0_G9H8P41im-0Hn&amp;height=450"></script>
			</div>
		</div>
		<!--<div class="" style="text-align: center;"><img src="{{theme}}/img/advantage.png" alt="Преимущества"></div>-->
		<div style="margin-top: 80px;">
			<!-- Put this div tag to the place, where the Comments block will be -->
			<div style="text-align:center;color: #003366;font-family: Arial, sans-serif;font-size: 22pt;font-weight: normal;line-height: 30px;line-height: 30px;margin-bottom:40px;">Наши отзвывы</div>
            <div style="margin: 0 auto;width:560px;height:800px;overflow:hidden;position:relative;"><iframe style="width:100%;height:100%;border:1px solid #e6e6e6;border-radius:8px;box-sizing:border-box" src="https://yandex.ru/maps-reviews-widget/1002483414?comments"></iframe><a href="https://yandex.ru/maps/org/nanobayt/1002483414/" target="_blank" style="box-sizing:border-box;text-decoration:none;color:#b3b3b3;font-size:10px;font-family:YS Text,sans-serif;padding:0 20px;position:absolute;bottom:8px;width:100%;text-align:center;left:0;overflow:hidden;text-overflow:ellipsis;display:block;max-height:14px;white-space:nowrap;padding:0 16px;box-sizing:border-box">Нанобайт на карте Симферополя — Яндекс Карты</a></div>
		</div>
	<!--	<div style="padding-bottom:10px;background:#ccc">
			<div style="width:510px;display:inline-block;">
				<div style="text-align:center;color: #003366;font-family: Georgia,Times;font-size: 22pt;font-weight: normal;line-height: 30px;line-height: 30px;">Последние новости</div>
				{% for news in news_short %}
				<div class="news" style="position:relative;margin:0 auto; width:450px;height:90px;border:1px solid black;border-radius:15px;background-color:#fff;margin-top:10px">
					<div class="news-foto"><a href="{{news.link}}"><img src="{{news.short_img}}" alt="{{news.title}}" title="{{news.title}}"></a></div>
					<div class="news-title" style="position:absolute;width:355px;height:20px;top:5px;right:5px;border-radius:15px;background-color:#ccc;"><div style="padding-left:10px;overflow:hidden;width:335px;height:20px;"><a href="{{news.link}}">{{news.title}}</a></div></div>
					<div class="news-text" style="position:absolute;width:355px;height:55px;top:30px;right:5px;border-radius:15px;background-color:#ccc;"><div style="padding-left:10px;overflow:hidden;width:335px;height:55px;">{{news.short_text|raw}}</div></div>
				</div>
				{% endfor %}
			</div>
			
			<div style="width:510px;display:inline-block;">
				<div style="text-align:center;color: #003366;font-family: Georgia,Times;font-size: 22pt;font-weight: normal;line-height: 30px;line-height: 30px;">Последние статьи</div>
				{% for articles in articles_short %}
				<div class="articles" style="position:relative;margin:0 auto; width:450px;height:90px;border:1px solid black;border-radius:15px;background-color:#fff;margin-top:10px">
					<div class="articles-title" style="position:absolute;width:355px;height:20px;top:5px;left:5px;border-radius:15px;background-color:#ccc;"><div style="padding-left:10px;overflow:hidden;width:335px;height:20px;"><a href="{{articles.link}}">{{articles.title}}</a></div></div>
					<div class="articles-text" style="position:absolute;width:355px;height:55px;top:30px;left:5px;border-radius:15px;background-color:#ccc;"><div style="padding-left:10px;overflow:hidden;width:335px;height:55px;">{{articles.short_text|raw}}</div></div>
					<div class="articles-foto"><a href="{{articles.link}}"><img src="{{articles.short_img}}" alt="{{articles.title}}" title="{{articles.title}}"></a></div>
				</div>
				{% endfor %}
			</div>
		</div> -->
		<div id="answer" style="text-align:center;"></div>
		<!--<div style="text-align:center;color: #003366;font-family: Georgia,Times;font-size: 22pt;font-weight: normal;line-height: 30px;line-height: 30px;padding:20px;">Наши клиенты</div>
		<table style="width:100%;">
			<tr style="width:341px;height:100px;text-align:center;">
				<td style="vertical-align:middle;border:1px solid black;"><a href="/6-yuridicheskoe-predpriyatie-polakr.html"><img src="/upload/partners/partner_1.jpg" alt="Полакр" title="Полакр"></a></td>
				<td style="vertical-align:middle;border:1px solid black;"><a href="/7-firma-krim-medmarket.html"><img src="/upload/partners/partner_2.jpg" alt="Крым-Медмаркет" title="Крым-Медмаркет"></a></td>
				<td style="vertical-align:middle;border:1px solid black;"><a href="/8-ooo-obedinenie-trans-kontinental.html"><img src="/upload/partners/partner_3.jpg" alt="Объединение Транс-Континенталь" title="Объединение Транс-Континенталь"></a></td>
			</tr>
			<tr style="width:100%;height:100px;text-align:center;">
				<td style="width:341px;border:1px solid black;padding:5px;">
					<h3 style="font-weight: bold;"><a href="/6-yuridicheskoe-predpriyatie-polakr.html">Юридическое предприятие «Полакр»</a></h3>
					Высокая скорость работы компьютеров — комфортная и продуктивная работа в офисе
				</td>
				<td style="width:341px;border:1px solid black;padding:5px;">
					<h3 style="font-weight: bold;"><a href="/7-firma-krim-medmarket.html">Фирма «Крым-Медмаркет»</a></h3>
					Исправная работа UPS — надежная работа офисной техники, оптимизация работы персонала
				</td>
				<td style="width:341px;border:1px solid black;padding:5px;">
					<h3 style="font-weight: bold;"><a href="/8-ooo-obedinenie-trans-kontinental.html">ООО "Объединение Транс-Континенталь"</a></h3>
					Стабильная работа коммутатора — качественная внутриорганизационная коммуникация и надежная передача данных внутри организации
				</td>
			</tr>
			<tr style="width:100%;height:100px;text-align:center;">
				<td style="vertical-align:middle;border:1px solid black;"><a href="/9-ooo-dveri-belorussii.html"><img src="/upload/partners/partner_4.jpg" alt="Двери Белоруссии" title="Двери Белоруссии"></a></td>
				<td style="vertical-align:middle;border:1px solid black;"><a href="/10-ooo-pts-novaya-era.html"><img src="/upload/partners/partner_5.jpg" alt="Новая Эра" title="Новая Эра"></a></td>
				<td style="vertical-align:middle;border:1px solid black;"><a href="/11-yuridicheskoe-predpriyatie-polakr.html"><img src="/upload/partners/partner_6.jpg" alt="Спецземлепроект" title="Спецземлепроект"></a></td>
			</tr>
			<tr style="width:100%;height:100px;text-align:center;">
				<td style="width:341px;border:1px solid black;padding:5px;">
					<h3 style="font-weight: bold;"><a href="/9-ooo-dveri-belorussii.html">ООО «Двери Белоруссии»</a></h3>
					Исправный источник бесперебойного питания – надежная служба офисной техники, стабильная и организованная работа персонала
				</td>
				<td style="width:341px;border:1px solid black;padding:5px;">
					<h3 style="font-weight: bold;"><a href="/10-ooo-pts-novaya-era.html">ООО ПЦ «Новая Эра»</a></h3>
					Успешное восстановление информации — заказ выполнен в срок, сохранена репутация полиграфического центра как изготовляющего все виды полиграфии в самые короткие сроки
				</td>
				<td style="width:341px;border:1px solid black;padding:5px;">
					<h3 style="font-weight: bold;"><a href="/11-yuridicheskoe-predpriyatie-polakr.html">ООО «Спецземлепроект»</a></h3>
					Восстановлена прежняя работоспособность компьютера — персонал обеспечен исправным офисным оборудованием, а значит готов для достижения новых высот в своей профессиональной деятельности
				</td>
			</tr>
		</table>-->
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
				1000
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
	<div style="margin: 60px 0px 40px 0px;" id="slider-range"></div>
		<div style="margin-bottom:60px;">
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
	</main>
	{% endblock %}
	{% include "footer.tpl" %}
</div>
<!--LiveInternet counter--><script type="text/javascript"><!--
new Image().src = "//counter.yadro.ru/hit?r"+
escape(document.referrer)+((typeof(screen)=="undefined")?"":
";s"+screen.width+"*"+screen.height+"*"+(screen.colorDepth?
screen.colorDepth:screen.pixelDepth))+";u"+escape(document.URL)+
";"+Math.random();//--></script><!--/LiveInternet-->
<!-- Yandex.Metrika counter -->
<script type="text/javascript">
(function (d, w, c) {
    (w[c] = w[c] || []).push(function() {
        try {
            w.yaCounter24071299 = new Ya.Metrika({id:24071299,
                    webvisor:true,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true});
        } catch(e) { }
    });

    var n = d.getElementsByTagName("script")[0],
        s = d.createElement("script"),
        f = function () { n.parentNode.insertBefore(s, n); };
    s.type = "text/javascript";
    s.async = true;
    s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

    if (w.opera == "[object Opera]") {
        d.addEventListener("DOMContentLoaded", f, false);
    } else { f(); }
})(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="//mc.yandex.ru/watch/24071299" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->
	<script src="//code.jivo.ru/widget/iZmH167X5J" async></script>

</body>
</html>