{% extends "main.tpl" %}
{% block title %}Добавление статической страницы / {{global_title}}{% endblock %}
{% block scripts %}
<script type="text/javascript" src="{{theme}}/scripts/ckeditor/ckeditor.js" ></script>
	<script type="text/javascript" src="{{theme}}/scripts/AjexFileManager/ajex.js" ></script>
	<script type="text/javascript">AjexFileManager.init({returnTo: 'function'});</script>
{% endblock %}
{% block body %}
	<form action="{{site_path}}admin-post/" method="POST" name="static_add" id="static_add">
		<table>
			<tr><td style="width:170px;vertical-align:top;">Заголовок страницы</td><td><input style="width:450px;" type="text" name="title" value="" placeholder="Заголовок статьи"></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Meta keywords</td><td><textarea style="width:450px;height: 50px;" name="meta_keywords" placeholder="Meta keywords"></textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Meta description</td><td><textarea style="width:450px;height: 50px;" name="meta_description" placeholder="Meta description"></textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Текст страницы</td><td><textarea name="text"></textarea></td></tr>
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
				<option selected value="1">Да</option>
				<option value="0">Нет</option>
			</select>
			</td></tr>
			<tr><td colspan="2" style="text-align:center;"><input type="hidden" name="static_add_submit" value="static_add_submit"><input type="button" onClick="button_preview();form.submit();" value="Предпросмотр"><span style="display:inline-block;width:30px;"></span><input type="button" onClick="button_submit();form.submit();" name="static_add_submit" value="Сохранить"></td></tr>
			<script>
				function button_preview(){
					document.getElementById('static_add').target = 'preview';
					document.getElementById('static_add').action = '/preview/';
					var new_window = window.open("","preview","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=1366,height=768");
					new_window.focus();
				}
				function button_submit(){
					document.getElementById('static_add').target = '_self';
					document.getElementById('static_add').action = '{{site_path}}admin-post/';
				}
			</script>
		</table>
	</form>
{% endblock %}