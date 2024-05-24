{% extends "main.tpl" %}
{% block title %}Добавление новости / {{global_title}}{% endblock %}
{% block scripts %}
<script type="text/javascript" src="{{theme}}/scripts/ckeditor/ckeditor.js" ></script>
	<script type="text/javascript" src="{{theme}}/scripts/AjexFileManager/ajex.js" ></script>
	<script type="text/javascript">AjexFileManager.init({returnTo: 'function'});</script>
{% endblock %}
{% block body %}
	<form action="{{site_path}}admin-post/" method="POST" name="news_add" id="news_add">
		<table>
			<tr><td style="width:170px;vertical-align:top;">Заголовок новости</td><td><input style="width:450px;" type="text" name="title" value="" placeholder="Заголовок новости"></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Meta keywords</td><td><textarea style="width:450px;height: 50px;" name="meta_keywords" placeholder="Meta keywords"></textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Meta description</td><td><textarea style="width:450px;height: 50px;" name="meta_description" placeholder="Meta description"></textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Услуга</td><td>
			<select style="width:460px;" name="page_id">
				<option selected disabled>Выберите услугу</option>
			{% for page in pageList %}
				<option value="{{page.id}}">{{page.title}}</option>
			{% endfor %}
			</select>
			</td></tr>
			<tr><td style="width:170px;vertical-align:top;">Картинка короткой новости</td><td><input type="hidden" id="srcFile_id" name="short_img" value=""/><div style="display:inline-block;padding-top:50px;float:left;margin-right:15px;"><input type="button" value="Добавить" id="srcFile_button" onclick="AjexFileManager.open({returnTo: 'insertValue'});" /></div><div style="display:inline-block;width:150px;height:128px;"><img width="128" height="128" id="img" src=""></div></td></tr>
			<script type="text/javascript">
				function insertValue(filePath) {
					document.getElementById('srcFile_id').value = filePath;
					document.getElementById('img').src = filePath;
					document.getElementById('srcFile_button').value = 'Изменить';
					return;
				}
			</script>
			<tr><td style="width:170px;vertical-align:top;">Текст короткой новости</td><td><textarea style="width:450px;height: 100px;" name="short_text" placeholder="Текст короткой новости"></textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Текст полной новости</td><td><textarea name="text"></textarea></td></tr>
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
			<tr><td colspan="2" style="text-align:center;"><input type="hidden" name="news_add_submit" value="news_add_submit"><input type="button" onClick="button_preview();form.submit();" value="Предпросмотр"><span style="display:inline-block;width:30px;"></span><input type="button" onClick="button_submit();form.submit();" name="news_add_submit" value="Сохранить"></td></tr>
			<script>
				function button_preview(){
					document.getElementById('news_add').target = 'preview';
					document.getElementById('news_add').action = '/preview/';
					var new_window = window.open("","preview","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=1366,height=768");
					new_window.focus();
				}
				function button_submit(){
					document.getElementById('news_add').target = '_self';
					document.getElementById('news_add').action = '{{site_path}}admin-post/';
				}
			</script>
		</table>
	</form>
{% endblock %}