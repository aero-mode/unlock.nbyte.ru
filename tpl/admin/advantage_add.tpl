{% extends "main.tpl" %}
{% block title %}Добавление преимущества / {{global_title}}{% endblock %}
{% block scripts %}
<script type="text/javascript" src="{{theme}}/scripts/AjexFileManager/ajex.js" ></script>
	<script type="text/javascript">AjexFileManager.init({returnTo: 'function'});</script>
{% endblock %}
{% block body %}
	<form action="{{site_path}}admin-post/" method="POST" name="advantage_add">
		<table>
			<tr><td style="width:170px;vertical-align:top;">Заголовок</td><td><input style="width:450px;" type="text" name="title" value="" placeholder="Заголовок"></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Картинка</td><td><input type="hidden" id="srcFile_id" name="icon" value=""/><div style="display:inline-block;padding-top:50px;float:left;margin-right:15px;"><input type="button" value="Изменить" onclick="AjexFileManager.open({returnTo: 'insertValue'});" /></div><div style="display:inline-block;width:150px;height:128px;"><img width="128" height="128" id="img" src=""></div></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Текст</td><td><textarea style="width:450px;height: 100px;" name="text" placeholder="Текст"></textarea></td></tr>
			<tr><td colspan="2" style="text-align:center;"><input type="submit" name="advantage_add_submit" value="Сохранить" placeholder=""></td></tr>
		</table>
	</form>
	<script type="text/javascript">
		function insertValue(filePath) {
			document.getElementById('srcFile_id').value = filePath;
			document.getElementById('img').src = filePath;
			return;
		}
	</script>
{% endblock %}