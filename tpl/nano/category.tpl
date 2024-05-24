{% extends "main.tpl" %}
{% block title %}{{title}}{% endblock %}
{% block scripts %}
	<script type="text/javascript" src="{{theme}}/script/jquery.min.js"></script>
	<script src="{{theme}}/script/jquery-ui/jquery-ui.js" type="text/javascript"></script>
	<script type="text/javascript" src="{{theme}}/script/jquery.maskedinput.js"></script>
	<script type="text/javascript" src="{{theme}}/script/jquery.wallform.js"></script>
	<script type="text/javascript" src="{{theme}}/script/jquery.validationEngine.js"></script>
	<script type="text/javascript" src="{{theme}}/script/jquery.validationEngine-ru.js"></script>
	<link rel="stylesheet" type="text/css" href="{{theme}}/script/form.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="{{theme}}/script/jquery-ui/themes/hot-sneaks/jquery-ui.css" media="screen" />
	<script type="text/javascript">
		$(document).ready(function() {
			$("#client_phone").mask("+7(999) 999-99-99");
			$("#client_request").validationEngine();
			$("#client_request").ajaxForm({
				//target: '#answer',
				url: $(this).attr("action"),
				data: {
					action: "request_submit"
				},
				success: function(){
					$("#request_submit,#client_problem,#client_phone").attr("disabled", true);
					$("#request_submit").attr("value", "Отправлено");
					$('#client_request').trigger( 'reset' );
					ga('send', 'event', 'категория', 'клик', 'форма');
					yaCounter24071299.reachGoal('formCat');
				}
			});
		});	
	</script>
	<style>
		ul.short-page li{
			width: 230px;
			display: inline-block;
			margin: 6px;
			padding: 5px;
			vertical-align: top;
		}
		.cat-content {
			overflow: hidden;
			zoom: 1;
		}
		.cat-text {
			width:50%;
			height:300px;
			float:left;
			text-align: justify;
		}
		.cat-order {
			width:50%;
			float:right;
			height:320px;
		}

		.cat-slogan {
			width:100%;
			padding-top:25px;
			padding-bottom:10px;
			text-align: justify;
			font-family: Tahoma;
			font-size: 11px;
			overflow: hidden;
			zoom: 1; /* for IE */
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
{% endblock %}
{% block body %}
	<main class="content">
	<div style="padding-top:20px;padding-bottom:20px;"></div>
		<div style="margin: 0 auto;">
			{#<h2 style="margin: 15px 0;">Каталог часто заказываемых услуг</h2>#}
    		<ul class="short-page">
    		{% for short_page in short_pages %}
    			<li>
    				<div style="height:50px;text-align:center;"><a href="{{short_page.link}}">{{short_page.title}}</a></div>
    				<div style="text-align:center;"><a href="{{short_page.link}}"><img width="171" height="130" src="{{short_page.cat_icon}}" alt="{{short_page.title}}"></a></div>
    				<div style=""><span style="padding-left:30px;"><a href="{{short_page.link}}#opinions">Отзывов: {{short_page.opinions}}</a></span><!-- <span style="padding-left:40px;">Цена: {{short_page.price}} руб.</span></div> -->
    			</li>
    		{% endfor %}
    		</ul>	
		</div>
		<div class="cat-content" style="margin: 15px 0;">
			{#<div class="cat-text">{{cat.cat_text|raw}}</div>#}
			<div class="cat-order">
				<div class="order-form">
					<form action="/post/" method="POST" name="client_request" id="client_request">
						<div class="order-input"><textarea placeholder="Ваша проблема" name="client_problem" id="client_problem"></textarea></div>
						<div class="order-input"><input type="text" name="client_phone" id="client_phone" value="" placeholder="Ваш телефон" class="validate[required,custom[phone]]" maxlength="10"></div>
						<div class="order-input"><input style="font-size:24px;height:50px;" type="submit" name="request_submit" id="request_submit" value="Передать мастеру"></div>
					</form>
				</div>
			</div>
		</div>
			<div class="cat-slogan">{{cat.cat_slogan|raw}}</div>
	</main>
{% endblock %}
