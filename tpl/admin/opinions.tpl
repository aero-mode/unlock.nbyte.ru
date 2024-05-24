{% extends "main.tpl" %}
{% block title %}Отзывы / {{global_title}}{% endblock %}
{% block scripts %}
<script src="{{theme}}/scripts/jquery.min.js" type="text/javascript"></script>
	<script src="{{theme}}/scripts/jquery-ui/jquery-ui.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="{{theme}}/scripts/jquery-ui/themes/hot-sneaks/jquery-ui.css" media="screen" />
<script>
	function add_answer(id, act){
		$('#textarea').attr('p', id);
		$('#textarea').val('');
		$("#msg_answer").dialog({
			closeText: "",
			title: "Ответ модератора",
			draggable: false,
			resizable: false,
			modal:true,
			width: 400,
			height: 250,
			close: function(event, ui){
				$(this).dialog( "close" );
			},
			buttons:{
				'Добавить': function(){
					var text = $(this).children('#textarea').val();
					var id = $(this).children('#textarea').attr('p');
					$.post('/admin-post/', { action: 'add_answer', id: id, text: text }, function(data){
						if(data == 'added'){
							$('tr#'+id).after('	<tr class="answer-text"><td colspan="2" style="text-align:center;vertical-align:middle;font-size:16px;font-weight:bold;background-color:#8B8989;">Ответ</td><td style="background-color:#8B8989;">'+text+'</td></tr>');
							$('[class = "answer"][p = "'+id+'"][act = "add_answer"]').remove();
							$("#msg_answer").dialog( "close" );
						}
					});
					
				},
				'Отмена': function(){
					$(this).dialog( "close" );
				}
			}
		});
	};
	function blaalb(id, act){
		if(act == 'add_opinion'){
			var elem = $("#"+id);
			elem.css("background-color", "#CCCCCC");
			$('#'+id+' > td > [act = add_opinion]').remove();
			var text = $('#'+id+' > td').eq(1).text();
			$('#'+id+' > td').eq(1).html(text+'<br><a class="answer" act="add_answer" p="'+id+'" onclick="return add_answer($(this).attr(\'p\'), $(this).attr(\'act\'));" href="javascript:void(0)">Ответить</a>');
		}else if(act == 'del_opinion'){
			var elem = $("#"+id);
			if(elem.next().hasClass('answer-text')){
				elem.next().remove();
			}
			elem.remove();
		}
	};
	
	function del_apply(opinion_id, opinion_act){
		var answer = '';
		$.post('/admin-post/', { action: opinion_act, id: opinion_id }, function(data){
			if(data == 'added'){
				$("#msg_ok").html('Отзыв добывлен');
				answer = 'ok';
			}else if(data == 'deleted'){
				$("#msg_ok").html('Отзыв удалён');
				answer = 'ok';
			}else{
				$("#msg_ok").html('Ошибка');
				answer = 'error';
			}
			$("#msg_ok").dialog({
				closeText: "",
				draggable: false,
				resizable: false,
				modal:false,
				buttons:{
					Ok: function(){
						blaalb(opinion_id, opinion_act);
						$(this).dialog( "close" );
					}
				}
			});
		});
	}
	function del(opinion_id, opinion_act){
		if(confirm("Удалить?")){
			del_apply(opinion_id, opinion_act);
		}else{
			return false;
		}
	} 
</script>
<style>
.pagging {
	dispay:inline-block;
	padding:2px;
	border:1px solid black;
	margin:5px;
	background-color:#DCDCDC;
}
.pagging a {
	color:black;
	text-decoration:none;
}
.current {
	background-color:grey;
}
</style>
{% endblock %}
{% block body %}
<table width="100%" border="0" style="margin-bottom:7px;margin-top:7px;position:relative;">
{% for opinion in opinionList.list %}
	<tr {% if opinion.moderate == '0' %}style="background-color:#FF8C00;"{% endif %} id="{{opinion.id}}">
		<td style="text-align:center;">
		{% if opinion.moderate == '0' %}
			<a href="javascript:void(0)" class="opinion" p="{{opinion.id}}" act="add_opinion" onclick="return del_apply($(this).attr('p'), $(this).attr('act'));"><img src="{{theme}}/img/ico_ap.gif" alt="Добавить"></a>
			<a href="javascript:void(0)" class="opinion" p="{{opinion.id}}" act="del_opinion" onclick="return del($(this).attr('p'), $(this).attr('act'));"><img src="{{theme}}/img/ico_del.gif" alt="Удалить"></a>
		{% else %}
			<a href="javascript:void(0)" class="opinion" p="{{opinion.id}}" act="del_opinion" onclick="return del($(this).attr('p'), $(this).attr('act'));"><img src="{{theme}}/img/ico_del.gif" alt="Удалить"></a>
		{% endif %}
		</td>
		<td>
			{{opinion.name}}
		{% if opinion.moderator == '0' and opinion.moderate == '1' %}
			<br><a class="answer" href="javascript:void(0)" p="{{opinion.id}}" act="add_answer" onclick="return add_answer($(this).attr('p'), $(this).attr('act'));">Ответить</a>
		{% endif %}
</td>
		<td>{{opinion.text}}</td>
	</tr>
	{% if opinion.moderator == '1' %}
	<tr class="answer-text">
		<td colspan="2" style="text-align:center;vertical-align:middle;font-size:16px;font-weight:bold;background-color:#8B8989;">Ответ</td>
		<td style="background-color:#8B8989;">{{opinion.answer}}</td>
	</tr>
	{% endif %}
{% endfor %}
</table>
{% for paging in opinionList.paging %}
	{% if paging.current == 'yes' %}
		<span class="pagging current">{{paging.num}}</span>
	{% else %}
		<span class="pagging"><a href="/admin/opinions/{{paging.num}}">{{paging.num}}</a></span>
	{% endif %}
	
{% endfor %}
<div style="height:10px;"></div>
<div id="msg_ok"></div>
<div id="msg_answer" style="display:none;">
	<textarea id="textarea" style="width:360px;height:110px"></textarea>
</div>
{% endblock %}