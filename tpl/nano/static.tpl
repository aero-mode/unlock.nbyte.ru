{% extends "main.tpl" %}
{% block title %}{{title}} / {{global_title}}{% endblock %}
{% block keywords %}{{keywords}}{% endblock %}
{% block description %}{{description}}{% endblock %}
{% block scripts %}
	<script type="text/javascript" src="{{theme}}/script/jquery.min.js"></script>
	<script src="{{theme}}/script/jquery-ui/jquery-ui.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="{{theme}}/script/jquery-ui/themes/hot-sneaks/jquery-ui.css" media="screen" />
	<script type="text/javascript" src="{{theme}}/script/jquery.maskedinput.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#client_phone").mask("+38(099) 999-99-99");
			$("#request_submit").on('click', function(){
				if(($("#client_name").val()!='')&&($("#client_phone").val()!='')){
					$.post('/post/', { action: 'kp_submit', client_name: $("#client_name").val(), client_phone: $("#client_phone").val(), client_problem: $("#client_problem").val()}, function(data){
						if(data == 'ok'){
							$("#answer").text("Ожидайте, менеджер вам перезвонит.");
						}else{
							$("#answer").text("Ошибка!");
						}
						$("#answer").dialog({
							draggable: false,
							resizable: false,
							height: 80,
						});
						setInterval(function() { $("#answer").dialog( "close" ); }, 4000);
						$("#request_submit").attr('disabled', true);
					});
				}else{
					if(($("#client_name").val()=='')&&($("#client_phone").val()==''))
						alert("Заполните необходимые поля!");
					else if($("#client_name").val()=='')
						alert("Заполните поле имя!");
					else if($("#client_phone").val()=='')
						alert("Заполните поле телефон!");
				}
			});
		});	
	</script>
	<style type="text/css">
			#request_submit {
				text-align: center;
				cursor: pointer;
				border-radius: 5px;
				-moz-border-radius: 5px;
				-webkit-border-radius: 5px;
				background: -moz-linear-gradient(0% 100% 90deg, #ccc, #fff) !important;
				background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#ccc), to(#fff)) !important;
			}
			#request_submit:hover{
				border: solid 1px #fff !important;
				background: -moz-linear-gradient(0% 100% 90deg, #fff, #ccc) !important;
				background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#fff), to(#ccc)) !important;
			}
			#request_submit:disabled{
				background: none repeat scroll 0 0 #FFFFFF !important;
				cursor: default;
			}
</style>
{% endblock %}
{% block body %}
	<main class="content">
		<h1 class="title">{{title}}</h1>
		<div class="static-text">{{text|raw}}</div>
		<div id="answer" style="text-align:center;"></div>
	</main>
{% endblock %}