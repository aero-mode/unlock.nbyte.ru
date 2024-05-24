{% extends "main.tpl" %}
{% block title %}Редактирование статической страницы / {{global_title}}{% endblock %}
{% block scripts %}
<script type="text/javascript" src="{{theme}}/scripts/ckeditor/ckeditor.js" ></script>
	<script type="text/javascript" src="{{theme}}/scripts/AjexFileManager/ajex.js" ></script>
	<script type="text/javascript">AjexFileManager.init({returnTo: 'function'});</script>
{% endblock %}
{% block body %}
	<form action="{{site_path}}admin-post/" method="POST" name="static_edit" id="static_edit">
		<table>
			<tr><td style="width:170px;vertical-align:top;">Заголовок статьи</td><td><input style="width:450px;" type="text" name="title" value="{{static.title}}" placeholder=""></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Meta keywords</td><td><textarea style="width:450px;height: 50px;" name="meta_keywords">{{static.meta_keywords}}</textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Meta description</td><td><textarea style="width:450px;height: 50px;" name="meta_description">{{static.meta_description}}</textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Текст страницы</td><td><textarea name="text">{{static.text}}</textarea></td></tr>
			<script type="text/javascript">
				var ckeditor1 = CKEDITOR.replace('text', {
					height: '300'
				});
				AjexFileManager.init({
					returnTo: 'ckeditor',
					editor: ckeditor1
				});
			</script>
			<tr><td style="width:170px;vertical-align:top;">Отображать на сайте</td><td>
			<select name="visible">
				<option{% if news.visible == '1' %} selected{% endif %} value="1">Да</option>
				<option{% if news.visible == '0' %} selected{% endif %} value="0">Нет</option>
			</select>
			</td></tr>
			<tr><td colspan="2" style="text-align:center;"><input type="hidden" name="static_edit_submit" value="static_edit_submit"><input type="hidden" name="id" value="{{static.id}}"><input type="button" onClick="button_preview();form.submit();" value="Предпросмотр"><span style="display:inline-block;width:30px;"></span><input type="button" onClick="button_submit();form.submit();" name="static_add_submit" value="Сохранить"></td></tr>
			<script>
				function button_preview(){
					document.getElementById('static_edit').target = 'preview';
					document.getElementById('static_edit').action = '/preview/';
					var new_window = window.open("","preview","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=1366,height=768");
					new_window.focus();
				}
				function button_submit(){
					document.getElementById('static_edit').target = '_self';
					document.getElementById('static_edit').action = '{{site_path}}admin-post/';
				}
			</script>
		</table>
	</form>
{% endblock %}