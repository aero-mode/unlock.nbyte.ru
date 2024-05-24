{% extends "main.tpl" %}
{% block title %}Редактирование новости / {{global_title}}{% endblock %}
{% block scripts %}
<script type="text/javascript" src="{{theme}}/scripts/ckeditor/ckeditor.js" ></script>
	<script type="text/javascript" src="{{theme}}/scripts/AjexFileManager/ajex.js" ></script>
	<script type="text/javascript">AjexFileManager.init({returnTo: 'function'});</script>
{% endblock %}
{% block body %}
	<form action="{{site_path}}admin-post/" method="POST" name="news_edit" id="news_edit">
		<table>
			<tr><td style="width:170px;vertical-align:top;">Заголовок новости</td><td><input style="width:450px;" type="text" name="title" value="{{news.title}}" placeholder=""></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Дата добавления</td><td>{{news.date_add}}</td></tr>
			<tr><td style="width:170px;vertical-align:top;">Meta keywords</td><td><textarea style="width:450px;height: 50px;" name="meta_keywords">{{news.meta_keywords}}</textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Meta description</td><td><textarea style="width:450px;height: 50px;" name="meta_description">{{news.meta_description}}</textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Услуга</td><td>
			<select style="width:460px;" name="page_id">
			{% for page in news.pages_title%}
				<option{% if page.in == '1' %} selected{% endif %} value="{{page.id}}">{{page.title}}</option>
			{% endfor %}
			</select>
			</td></tr>
			<tr><td style="width:170px;vertical-align:top;">Картинка короткой новости</td><td><input type="hidden" id="srcFile_id" name="short_img" value="{{news.short_img}}"/><div style="display:inline-block;padding-top:50px;float:left;margin-right:15px;"><input type="button" value="Изменить" onclick="AjexFileManager.open({returnTo: 'insertValue'});" /></div><div style="display:inline-block;width:150px;height:128px;"><img width="128" height="128" id="img" src="{{news.short_img}}"></div></td></tr>
			<script type="text/javascript">
				function insertValue(filePath) {
					document.getElementById('srcFile_id').value = filePath;
					document.getElementById('img').src = filePath;
					return;
				}
			</script>
			<tr><td style="width:170px;vertical-align:top;">Текст короткой новости</td><td><textarea style="width:450px;height: 100px;" name="short_text">{{news.short_text}}</textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Текст полной новости</td><td><textarea name="text">{{news.text}}</textarea></td></tr>
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
			<tr><td colspan="2" style="text-align:center;"><input type="hidden" name="news_edit_submit" value="news_edit_submit"><input type="hidden" name="id" value="{{news.id}}"><input type="button" onClick="button_preview();form.submit();" value="Предпросмотр"><span style="display:inline-block;width:30px;"></span><input type="button" onClick="button_submit();form.submit();" name="static_add_submit" value="Сохранить"></td></tr>
			<script>
				function button_preview(){
					document.getElementById('news_edit').target = 'preview';
					document.getElementById('news_edit').action = '/preview/';
					var new_window = window.open("","preview","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=1366,height=768");
					new_window.focus();
				}
				function button_submit(){
					document.getElementById('news_edit').target = '_self';
					document.getElementById('news_edit').action = '{{site_path}}admin-post/';
				}
			</script>
		</table>
	</form>
{% endblock %}