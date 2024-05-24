{% extends "main.tpl" %}
{% block title %}Настройки сайта / {{global_title}}{% endblock %}
{% block body %}
<form action="{{site_path}}admin-post/" method="POST" name="admin_setting">
	<table>
		<tr><td style="width:170px;vertical-align:top;">Title сайта</td><td style="width:350px;vertical-align:top;"><input style="width:350px;" type="text" name="meta_title" value="{{settingList.meta_title}}" placeholder="Общее название сайта (не более 5-10 слов)."></td><td style="width:540px;vertical-align:top;">Общее название сайта (не более 5-10 слов).</td></tr>
		<tr><td style="width:170px;vertical-align:top;">Meta description сайта</td><td style="width:350px;vertical-align:top;"><textarea style="width:350px;height: 100px;" placeholder="Краткое описание для всего сайта (не больше 1-2 предложений)." name="meta_description">{{settingList.meta_description}}</textarea></td><td style="width:540px;vertical-align:top;">Краткое описание для всего сайта (не больше 1-2 предложений).</td></tr>
		<tr><td style="width:170px;vertical-align:top;">Meta keywords сайта</td><td style="width:350px;vertical-align:top;"><textarea style="width:350px;height: 100px;" placeholder="Общие ключевые слова для всего сайта (через запятую, не больше 10-15 слов)." name="meta_keywords">{{settingList.meta_keywords}}</textarea></td><td style="width:540px;vertical-align:top;">Общие ключевые слова для всего сайта (через запятую, не больше 10-15 слов).</td></tr>
		<tr><td style="width:170px;vertical-align:top;">Статус сайта</td><td style="width:350px;vertical-align:top;text-align:center;">
			<select name="status">
			{% if settingList.site_status == 'yes' %}
				<option selected="selected" value="yes">Включён</option>
				<option value="no">Выключен</option>
			{% else %}
				<option value="yes">Включён</option>
				<option selected="selected" value="no">Выключен</option>
			{% endif %}
			</select>
		</td><td style="width:540px;vertical-align:top;">Статус сайта.</td></tr>
		<tr><td colspan="3" style="text-align:center;"><input type="submit" name="admin_setting_submit" value="Сохранить" placeholder=""></td></tr>
	</table>
</form>
{% endblock %}