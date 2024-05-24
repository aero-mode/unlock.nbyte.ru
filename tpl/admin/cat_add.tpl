{% extends "main.tpl" %}
{% block title %}Добавление категории / {{global_title}}{% endblock %}
{% block scripts %}
<script type="text/javascript" src="{{theme}}/scripts/ckeditor/ckeditor.js" ></script>
	<script type="text/javascript" src="{{theme}}/scripts/AjexFileManager/ajex.js" ></script>
	<script type="text/javascript">AjexFileManager.init({returnTo: 'function'});</script>
{% endblock %}
{% block body %}
	<form action="{{site_path}}admin-post/" method="POST" name="cat_add">
		<table>
			<tr><td style="width:170px;vertical-align:top;">Заголовок</td><td><input style="width:450px;" type="text" name="name" value="" placeholder="Заголовок"></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Текст категории</td><td><textarea name="cat_text"></textarea></td></tr>
			<script type="text/javascript">
				var ckeditor1 = CKEDITOR.replace('cat_text', {
					height: '300'
				});
				AjexFileManager.init({
					returnTo: 'ckeditor',
					editor: ckeditor1
				});
			</script>
			<tr><td style="width:170px;vertical-align:top;">Слоган</td><td style="vertical-align:top;"><textarea style="width:450px;height: 50px;" placeholder="Слоган категории" name="cat_slogan"></textarea></td></tr>
			<tr><td colspan="2" style="text-align:center;"><input type="submit" name="cat_add_submit" value="Сохранить"></td></tr>
		</table>
	</form>
{% endblock %}