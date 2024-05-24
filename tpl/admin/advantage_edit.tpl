{% extends "main.tpl" %}
{% block title %}Радектирование преимущества / {{global_title}}{% endblock %}
{% block scripts %}
<script type="text/javascript" src="{{theme}}/scripts/AjexFileManager/ajex.js" ></script>
	<script type="text/javascript">AjexFileManager.init({returnTo: 'function'});</script>
{% endblock %}
{% block body %}
	<form action="{{site_path}}admin-post/" method="POST" name="advantage_edit">
		<table>
			<tr><td style="width:170px;vertical-align:top;">Заголовок</td><td><input style="width:450px;" type="text" name="title" value="{{advantage.title}}" placeholder=""></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Картинка</td><td><input type="hidden" id="srcFile_id" name="icon" value="{{advantage.icon}}"/><div style="display:inline-block;padding-top:50px;float:left;margin-right:15px;"><input type="button" value="Изменить" onclick="AjexFileManager.open({returnTo: 'insertValue'});" /></div><div style="display:inline-block;width:150px;height:128px;"><img width="128" height="128" id="img" src="{{advantage.icon}}"></div></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Текст</td><td><textarea style="width:450px;height: 100px;" name="text">{{advantage.text}}</textarea></td></tr>
			<tr><td colspan="2" style="text-align:center;"><input type="hidden" name="id" value="{{advantage.id}}"><input type="submit" name="advantage_edit_submit" value="Сохранить" placeholder=""></td></tr>
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