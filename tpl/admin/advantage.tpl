{% extends "main.tpl" %}
{% block title %}Преимущества / {{global_title}}{% endblock %}
{% block scripts %}
<script src="{{theme}}/scripts/jquery.min.js" type="text/javascript"></script>
	<script src="{{theme}}/scripts/jquery-ui/jquery-ui.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="{{theme}}/scripts/jquery-ui/themes/hot-sneaks/jquery-ui.css" media="screen" />
<script>
	function del(id){
		if(confirm("Удалить?")){
			var answer = '';
			$.post('/admin-post/', { action: 'advantage_delete', id: id }, function(data){
				if(data == 'deleted'){
					$("#msg_ok").text("Удалено");
					$("#"+id).remove();
				}else{
					$("#msg_ok").text("Ошибка");
				}
				$("#msg_ok").dialog({
					draggable: false,
					resizable: false,
					modal:false,
					buttons:{
						Ok: function(){
							$(this).dialog( "close" );
						}
					}
				});
				setInterval(function() { $("#msg_ok").dialog( "close" ); }, 3000)
			});
		}else{
			return false;
		}
	}
</script>
{% endblock %}
{% block body %}
<table>
	<thead>
		<tr>
			<th>Ред.</th>
			<th>Преимущество</th>
		</tr>
	</thead>
	{% for advantage in advantageList %}
	<tr id="{{advantage.id}}">
		<td style="text-align:center;">
			<a href="{{advantage.edit_link}}"><img src="{{theme}}/img/ico_edit.gif" alt="Редактировать" title="Редактировать"></a>
			<a href="javascript:void(0)" onclick="return del({{advantage.id}});"><img src="{{theme}}/img/ico_del.gif" alt="Удалить" title="Удалить"></a>
		</td>
		<td>{{advantage.title}}</td>
	</tr>
	{% endfor %}
</table>
<div id="msg_ok"></div>
{% endblock %}