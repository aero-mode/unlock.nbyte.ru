{% extends "main.tpl" %}
{% block title %}Редактирование услуги / {{global_title}}{% endblock %}
{% block scripts %}
<script type="text/javascript" src="{{theme}}/scripts/ckeditor/ckeditor.js" ></script>
	<script type="text/javascript" src="{{theme}}/scripts/AjexFileManager/ajex.js" ></script>
	<script type="text/javascript">AjexFileManager.init({returnTo: 'function'});</script>
	<script src="{{theme}}/scripts/jquery.min.js" type="text/javascript"></script>
	<script type="text/javascript">
(function($) {
    $.fn.extend( {
        limiter: function(limit, elem) {
            $(this).on("keyup focus", function() {
                setCount(this, elem);
            });
            function setCount(src, elem) {
                var chars = src.value.length;
                if (chars > limit) {
                    src.value = src.value.substr(0, limit);
                    chars = limit;
                }
                elem.html( limit - chars );
            }
            setCount($(this)[0], elem);
        }
    });
})(jQuery);
</script>
<script>
$(document).ready( function() {
	var elem = $("#limit-1");
	$("#meta_keywords").limiter(254, elem);
	var elem2 = $("#limit-2");
	$("#meta_description").limiter(254, elem2);
});
</script>
{% endblock %}
{% block body %}
	<form action="{{site_path}}admin-post/" method="POST" name="page_edit" id="page_edit">
		<table>
			<tr><td style="width:170px;vertical-align:top;">Заголовок страницы</td><td><input style="width:600px;" type="text" name="title" value="{{page.title}}" placeholder=""></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Meta keywords<br><br>Осталось: <span id="limit-1"></span></td><td style="vertical-align:top;"><textarea style="width:600px;height: 50px;" name="meta_keywords" id="meta_keywords">{{page.meta_keywords}}</textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Meta description<br><br>Осталось: <span id="limit-2"></span></td><td style="vertical-align:top;"><textarea style="width:600px;height: 50px;" name="meta_description" id="meta_description">{{page.meta_description}}</textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Картинка</td><td><input type="hidden" id="srcFile_id" name="cat_icon" value="{{page.cat_icon}}"/><div style="display:inline-block;padding-top:50px;float:left;margin-right:15px;"><input type="button" value="Изменить" onclick="AjexFileManager.open({returnTo: 'insertValue'});" /></div><div style="display:inline-block;width:150px;height:128px;"><img width="128" height="128" id="img" src="{{page.cat_icon}}"></div></td></tr>
			<script type="text/javascript">
				function insertValue(filePath) {
					document.getElementById('srcFile_id').value = filePath;
					document.getElementById('img').src = filePath;
					return;
				}
			</script>
			<tr><td style="width:170px;vertical-align:top;">Категория</td><td>
			<select style="width:610px;" name="cat">
				{% for cat in page.cats %}
					<option {% if cat.in == 1 %}selected {% endif %}value="{{cat.id}}">{{cat.name}}</option>
				{% endfor %}
			</select>
			</td></tr>
			<tr><td style="width:170px;vertical-align:top;">Преимущества</td><td>
			<select style="width:610px;" name="advantage[]" multiple size="6">
				{% for advantage in page.advantages %}
					<option {% if advantage.in == 1 %}selected {% endif %}value="{{advantage.id}}">{{advantage.title}}</option>
				{% endfor %}
			</select>
			</td></tr>
			<tr><td style="width:170px;vertical-align:top;">Цена работы</td><td><input style="width:600px;" type="text" name="price" value="{{page.price}}" placeholder=""></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Цена детали</td><td><input style="width:600px;" type="text" name="price_hard" value="{{page.price_hard}}" placeholder=""></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Время работы</td><td><input style="width:600px;" type="text" name="time_work" value="{{page.time_work}}" placeholder=""></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Слоган</td><td style="vertical-align:top;"><textarea style="width:600px;height: 50px;" name="page_slogan">{{page.page_slogan}}</textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Текст</td><td style="vertical-align:top;"><textarea style="width:600px;height: 100px;" name="text_price">{{page.text_price|raw}}</textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">SEO Текст</td><td><textarea name="text">{{page.text}}</textarea></td></tr>
			<script type="text/javascript">
				var ckeditor1 = CKEDITOR.replace('text', {
					height: '600'
				});
				AjexFileManager.init({
					returnTo: 'ckeditor',
					editor: ckeditor1
				});
			</script>
			<tr><td style="width:170px;vertical-align:top;">Отображать на сайте</td><td>
			<select name="visible">
				<option{% if page.visible == '1' %} selected{% endif %} value="1">Да</option>
				<option{% if page.visible == '0' %} selected{% endif %} value="0">Нет</option>
			</select>
			</td></tr>
			<tr><td colspan="3" style="text-align:center;"><input type="hidden" name="page_edit_submit" value="page_edit_submit"><input type="hidden" name="id" value="{{page.id}}"><input type="button" onClick="button_preview();form.submit();" value="Предпросмотр"><span style="display:inline-block;width:30px;"></span><input type="button" onClick="button_submit();form.submit();" name="page_edit_submit" value="Сохранить"></td></tr>
			<script>
				function button_preview(){
					document.getElementById('page_edit').target = 'preview';
					document.getElementById('page_edit').action = '/preview/';
					var new_window = window.open("","preview","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=1366,height=768");
					new_window.focus();
				}
				function button_submit(){
					document.getElementById('page_edit').target = '_self';
					document.getElementById('page_edit').action = '{{site_path}}admin-post/';
				}
			</script>
		</table>
	</form>
{% endblock %}