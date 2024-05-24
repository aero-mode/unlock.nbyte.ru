{% extends "main.tpl" %}
{% block title %}{{page.title}} / {{page.name}} / {{global_title}}{% endblock %}
{% block keywords %}{{page.meta_keywords}}{% endblock %}
{% block description %}{{page.meta_description}}{% endblock %}
{% block scripts %}
	<script type="text/javascript" src="{{theme}}/script/jquery.min.js"></script>
	<script src="{{theme}}/script/jquery-ui/jquery-ui.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="{{theme}}/script/jquery-ui/themes/hot-sneaks/jquery-ui.css" media="screen" />
	<script type="text/javascript" src="{{theme}}/script/jquery.maskedinput.js"></script>
	<script type="text/javascript" src="{{theme}}/script/jquery.wallform.js"></script>
	<script type="text/javascript" src="{{theme}}/script/jquery.validationEngine.js"></script>
	<script type="text/javascript" src="{{theme}}/script/jquery.validationEngine-ru.js"></script>
	<link rel="stylesheet" type="text/css" href="{{theme}}/script/form.css" media="screen" />
	<script src="{{theme}}/script/jquery.lwtCountdown-1.0.js" type="text/javascript"></script>
	<link href="{{theme}}/script/timer.css" rel="stylesheet">
	
	
	<script type="text/javascript" src="{{theme}}/script/star-rating/jquery.MetaData.js"></script>
	<script type="text/javascript" src="{{theme}}/script/star-rating/jquery.rating.js"></script>
	<link rel="stylesheet" type="text/css" href="{{theme}}/script/star-rating/jquery.rating.css" />
	
	
	<script type="text/javascript">
		$(document).ready(function() {
			$("#client_phone,#client_phone2,#client_phone3").mask("+7(999) 999-99-99");
			$("#client_request,#client_request2,#client_request3").validationEngine();
			$("#client_request").ajaxForm({
				target: '#answer',
				url: $(this).attr("action"),
				data: {
					action: "request_submit"
				},
				success: function(){
					$("#request_submit,#request_submit2,#request_submit3,#client_problem,#client_phone").attr("disabled", true);
					$("#request_submit").attr("value", "Отправлено");
					$('#client_request').trigger( 'reset' );
					ga('send', 'event', 'страница', 'клик', 'форма1');
					yaCounter24071299.reachGoal('form1');
				}
			});
			$("#client_request2").ajaxForm({
				target: '#answer',
				url: $(this).attr("action"),
				data: {
					action: "request_submit"
				},
				success: function(){
					$("#request_submit,#request_submit2,#request_submit3").attr("disabled", true);
					ga('send', 'event', 'страница', 'клик', 'форма2');
					yaCounter24071299.reachGoal('form2');
				}
			});
			$("#client_request3").ajaxForm({
				target: '#answer',
				url: $(this).attr("action"),
				data: {
					action: "request_submit"
				},
				success: function(){
					$("#request_submit,#request_submit2,#request_submit3").attr("disabled", true);
					ga('send', 'event', 'страница', 'клик', 'форма3');
					yaCounter24071299.reachGoal('form3');
				}
			});
			function loading_show(){
				$('#container').html("<img src='{{theme}}/img/loading.gif'/>").fadeIn('fast');
			}
			function loading_hide(){
				$('#container').fadeOut('fast');
			}
			function loadData(page){
				loading_show();		
				$.ajax
				({
					type: "POST",
					url: "/opinions/",
					data: "page="+page+"&id={{page.id}}",
					success: function(data){
						$("#container").html(data);
					}
				});
			}
			loadData(1);  // For first time page load default results
			$('#container').on('click', '.pagination li.active', function(){
				var page = $(this).attr('p');
				loadData(page);
			});
			$('.hover-star').rating({
				focus: function(value, link){
					var tip = $('#hover-test');
					tip[0].data = tip[0].data || tip.html();
					tip.html(link.title || 'value: '+value);
				},
				blur: function(value, link){
					var tip = $('#hover-test');
					$('#hover-test').html(tip[0].data || '');
				}
			});
			$("#add-opinion-box").dialog({
				draggable: false,
				resizable: false,
				autoOpen: false,
				modal: true,
				title: 'Добавить отзыв.',
				width: 400,
				height: 320,
				buttons:{
					Ok: function(){
						var opinion_name = $("#opinion_name").val();
						var rating = $(":radio[name=rating]").filter(":checked").val();
						var opinion_text = $("#opinion_text").val();
						$.post('/add-opinion/', { action: 'add_opinion', page_id: {{page.id}}, opinion_name: opinion_name, rating: rating, opinion_text: opinion_text }, function(data){
							if(data == 'added'){
								$("#add-opinion-answer").text("Ваш отзыв отправлен на модерацию!");
								$('#add-opinion').off('click');
								$('#add-opinion').css({"background-color":"#ffffff","color":"#006699","cursor":"default"});
							}else{
								$("#add-opinion-answer").text("Ошибка!");
							}
							$("#add-opinion-answer").dialog({
								height: 80,
							});
							setInterval(function() { $("#add-opinion-answer").dialog( "close" ); }, 2000);
						});
						$(this).dialog( "close" );
					}
				}
			});
			$("#add-opinion").on('click', '', function(){
				$("#opinion_name").val('');
				$("#opinion_text").val('');
				$('.hover-star').rating('drain');
				$("#add-opinion-box").dialog("open");
			});
			/*=======================*/
	});	
	</script>
<style type="text/css">
			#container .pagination ul li.inactive,
			#container .pagination ul li.inactive:hover{
				background-color:#ededed;
				color:#bababa;
				border:1px solid #bababa;
				cursor: default;
			}
			#container .data ul li{
				list-style: none;
				font-family: Arial,sans-serif;
				margin: 5px 0 5px 0;
				color: #000;
				font-size: 13px;
			}

			#container .pagination{
				width: 100%;
				height: 25px;
			}

			#container .pagination ul li{
				list-style: none;
				float: left;
				border: 1px solid #006699;
				padding: 2px 6px 2px 6px;
				margin: 0 3px 0 3px;
				font-family: Arial,sans-serif;
				font-size: 14px;
				color: #006699;
				font-weight: bold;
				background-color: #f2f2f2;
			}
			#container .pagination ul li:hover{
				color: #fff;
				background-color: #006699;
				cursor: pointer;
			}
			.go_button
			{
			background-color:#f2f2f2;border:1px solid #006699;color:#cc0000;padding:2px 6px 2px 6px;cursor:pointer;position:absolute;margin-top:-1px;
			}
			.total
			{
			float:right;font-family:arial;color:#999;
			}
			#request_submit,#request_submit2,#request_submit3 {
				text-align: center;
				cursor: pointer;
				border-radius: 5px;
				-moz-border-radius: 5px;
				-webkit-border-radius: 5px;
                -khtml-border-radius: 5px;
				background: -moz-linear-gradient(0% 100% 90deg, #ccc, #fff) !important;
				background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#ccc), to(#fff)) !important;
			}
			#request_submit:hover,#request_submit2:hover,#request_submit3:hover{
				border: 5px solid #FF0000;
				background: -moz-linear-gradient(0% 100% 90deg, #fff, #ccc) !important;
				background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#fff), to(#ccc)) !important;
			}
			#request_submit:disabled,#request_submit2:disabled,#request_submit3:disabled{
				background: none repeat scroll 0 0 #FFF !important;
				cursor: default;
			}
</style>

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
	<div class="breadcrumb"><a href="/">Главная</a> / <a href="/{{current_cat}}-{{page.name_eng}}/">{{page.name}}</a> / {{page.title}}</div>
		<h1 class="title">{{page.title}}</h1>
		{#<h2 class="page-slogan">{{page.page_slogan|raw}}</h2>#}
		<div class="page-content">
			<div class="page-img"><img src="{{page.cat_icon}}" alt="{{page.title}}" title="{{page.title}}"></div>
			<div class="price">
				<span class="price-time">от {{page.price|raw}} руб. цена работы</span>
				<span class="price-time">от {{page.price_hard|raw}} руб. цена детали</span>
				<span class="price-time">от {{page.time_work|raw}} часов</span>
			</div>
		</div>
		<div style="text-align:center;" id="map">
			<div style="width:100%;overflow:hidden;">
			    {#<div style="float:right;width:50%;">
                    <div style="float:left;width:50%">
                        <img width="120" height="120" src="/upload/equipment/skidka.png" />
                        <div>Скидка за старые детали</div>
                    </div>
                    <div style="float:right;width:50%">
                        <img width="120" height="120" src="/upload/equipment/skidka-2.png" />
                        <div>Дополниельно 30% скидка если не срочно</div>
                    </div>
                    <div style="clear:both;margin-bottom:20px;"></div>
                    <div style="float:left;width:50%">
                        <img width="120" height="120" src="/upload/equipment/obmen.png" />
                        <div>Обмен неисправного на исправный</div>
                    </div>
                    <div style="float:right;width:50%">
                        <img width="120" height="120" src="/upload/equipment/koshel.png" />
                        <div>Рассрочка платежа до 4 недель</div>
                    </div>
		        </div>
		        <div style="float:left; margin-left:80px;">
    	           	<div class="order-form" style="height:350px;">
    					<form action="/post/" method="POST" name="client_request2" id="client_request2">
    				    	<div class="order-input"><span style="font-size:21px;line-height:25px;color:white;">Акция! Действует до сл. четверга.</span></div>
    				    	<div class="order-input"><span style="font-size:21px;line-height:25px;color:white;">Скидка 20% на работу.</span></div>
    						<div class="order-input"><input type="text" name="client_name" id="client_name2" value="" class="validate[required,custom[onlyLetterSp],length[3,50]]" placeholder="Ваше имя*"></div>
    						<div class="order-input"><input type="text" name="client_phone" id="client_phone2" value="" placeholder="Ваш телефон*" class="validate[required,custom[phone]]" maxlength="10"></div>
    						<div class="order-input"><textarea placeholder="Ваша проблема" name="client_problem" id="client_problem2"></textarea></div>
    						<div class="order-input"><input style="font-size:18px;height:40px;" type="submit" name="request_submit" id="request_submit2" value="Получить SMS с промокодом"></div>
    					</form>
    				</div>
				</div>#}
			</div>
		</div>
		<div class="opinions-related_news" id="opinions">
			<div class="opinions">
				<div class="opinion-header"><span style="font-family: Arial,sans-serif;font-weight: bold;font-size: 24px;padding-right: 20px;padding-left: 7px;">Отзывы: {{page.opinions|raw}}</span><img style="padding-right: 130px;" src="{{theme}}/img/stars.jpg" alt="stars" title=""><span id="add-opinion">Добавить отзыв</span></div>

				<div id="container">
					<div class="data"></div>
					<div class="pagination"></div>
				</div>

				<div id="add-opinion-box">
						<div style="height:40px;"><label for="opinion_name">Ваше имя</label><input type="text" name="opinion_name" id="opinion_name" value="" placeholder="Ваше имя"></div>
						<div style="height:40px;">
							<label>Оценка услуги</label>
								 <input class="hover-star required" type="radio" name="rating" value="1" title="Очень плохо"/>
								 <input class="hover-star" type="radio" name="rating" value="2" title="Плохо"/>
								 <input class="hover-star" type="radio" name="rating" value="3" title="Нормально"/>
								 <input class="hover-star" type="radio" name="rating" value="4" title="Хорошо"/>
								 <input class="hover-star" type="radio" name="rating" value="5" title="Очень хорошо"/>
								 <span id="hover-test" style="padding-left:10px;"></span>
						</div>
						<div style=""><textarea style="" placeholder="Текст отзыва" name="opinion_text" id="opinion_text"></textarea></div>
				</div>
				<div id="add-opinion-answer" style="text-align:center;"></div>
			</div>
			<div class="order-price">
				<div class="order-form">
					<form action="/post/" method="POST" name="client_request" id="client_request">
						<div class="order-input"><textarea placeholder="Ваша проблема" name="client_problem" id="client_problem"></textarea></div>
						<div class="order-input"><input type="text" name="client_phone" id="client_phone" value="" placeholder="Ваш телефон" class="validate[required,custom[phone]]" maxlength="10"></div>
						<div class="order-input"><input style="font-size:24px;height:50px;" type="submit" name="request_submit" id="request_submit" value="Передать мастеру"></div>
					</form>
				</div>
				<div class="price-opinions_count">
					<!--<div class="opinions_count"><span><img src="{{theme}}/img/stars.jpg" alt="stars" title=""></span><a href="#opinions">{{page.opinions|raw}} отзывов</a></div>-->
				</div>
			</div>
			<div style="clear:both;margin-bottom:20px;"></div>
			    {#<span style="font-size:18px;"><strong>Симферополь, ул. Павленко 15/72, </strong>тел. +7 (978) 745-37-55<br><br>Время работы: с 9:00 до 18:00, воскресенье выходной</span>#}
		    	<div style="margin-bottom:20px;"></div>
				<script type="text/javascript" charset="utf-8" src="//api-maps.yandex.ru/services/constructor/1.0/js/?sid=HP6HuAjoIACNMKQRB0_G9H8P41im-0Hn&amp;height=450"></script>
		</div>
		
		<div style="overflow: hidden;margin-top:10px;">
			<ul style="position: relative;float: left;left: 50%;list-style: none;margin: 0;padding: 0;">
			{% for advantage in page.advantages %}
				<li style="position: relative;float: left;right: 50%;padding: 10px;margin:10px;text-align:center;max-width:150px;"><img style="width:128px;width:128px;" src="{{advantage.icon}}" alt="{{advantage.title}}" title="{{advantage.text}}"><br>{{advantage.title}}</li>
			{% endfor %}
			</ul>
		</div>
		
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
		{#<div style="border-top: 1px solid black;padding: 10px 0;">
		    <div style="font: 18px Arial,sans-serif;margin-bottom:10px;">5 причин не откладывать проблему на завтра:</div>
			<div style="float:left;width:50%">
    		    <img width="200" style="float:left;" height="200" src="/upload/hr/5-hr.png" />
    		    <ul style="list-style:square">
    		        <li>профилактический ремонт в 5 раз дешевле чем капитальный</li>
    		        <li>экономия 30% на работе, в случае заблоговременного заказа детали</li>
    		        <li>не дожидайтесь пока техника полностью выйдет из строя</li>
    		        <li>не откладывайте на завтра то что можно сделать сегодня</li>
    		        <li>устранение мелкой проблеммы начинается с диагностики и заканчивается профилактикой, а профилактика в 5 раз дешевле чем ремонт</li>
    		    </ul>
		    </div>
		    <div style="float:right; margin-right:80px;">
    	        <div class="order-form" style="height:350px;">
    				<form action="/post/" method="POST" name="client_request3" id="client_request3">
    				   	<div class="order-input"><span style="font-size:21px;line-height:25px;color:white;">Заказать бесплатную</span></div>
    				   	<div class="order-input"><span style="font-size:21px;line-height:25px;color:white;">диагностику, до четверга</span></div>
    					<div class="order-input"><input type="text" name="client_name" id="client_name3" value="" class="validate[required,custom[onlyLetterSp],length[3,50]]" placeholder="Ваше имя*"></div>
    					<div class="order-input"><input type="text" name="client_phone" id="client_phone3" value="" placeholder="Ваш телефон*" class="validate[required,custom[phone]]" maxlength="10"></div>
    					<div class="order-input"><textarea placeholder="Ваша проблема" name="client_problem" id="client_problem3"></textarea></div>
    					<div class="order-input"><input style="font-size:18px;height:40px;" type="submit" name="request_submit" id="request_submit3" value="Получить SMS с промокодом"></div>
    				</form>
    			</div>
			</div>
		</div>#}
		<div style="clear:both;margin-bottom:20px;"></div>
		<div class="related_news">
			<h2>Новости по теме:</h2>
			{% for news_short in page.news_short %}
			<div class="related_new">
				<div class="short_img"><a href="{{news_short.link}}"><img alt="{{news_short.title}}" title="{{news_short.title}}" src="{{news_short.short_img}}"></a></div>
				<div class="other">
					<div class="short_title"><a href="{{news_short.link}}">{{news_short.title}}</a></div>
					<div class="short_text">{{news_short.short_text|raw}}</div>
				</div>
			</div>
			{% endfor %}
		</div>
		<div style="clear:both;margin-bottom:20px;"></div>
		<div class="page-text">{{page.text|raw}}</div>
		<div id="answer" style="text-align:center;"></div>
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
		<div class="text-key">{{page.text_price|raw}}</div>
	</main>
{% endblock %}