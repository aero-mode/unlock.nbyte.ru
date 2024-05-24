{% extends "main.tpl" %}
{% block title %}Добавление услуги / {{global_title}}{% endblock %}
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
	<form action="{{site_path}}admin-post/" method="POST" name="page_add" id="page_add">
		<table>
			<tr><td style="width:170px;vertical-align:top;">Заголовок страницы</td><td><input required style="width:450px;" type="text" name="title" value="" placeholder="Заголовок страницы"></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Meta keywords<br><br>Осталось: <span id="limit-1"></span></td><td style="vertical-align:top;"><textarea required style="width:600px;height: 50px;" name="meta_keywords" id="meta_keywords" placeholder="Meta keywords"></textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Meta description<br><br>Осталось: <span id="limit-2"></span></td><td style="vertical-align:top;"><textarea required style="width:600px;height: 50px;" name="meta_description" id="meta_description" placeholder="Meta description"></textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Картинка</td><td><input type="hidden" id="srcFile_id" required name="cat_icon" value=""><div style="display:inline-block;padding-top:50px;float:left;margin-right:15px;"><input type="button" id="srcFile_button" value="Добавить" onclick="AjexFileManager.open({returnTo: 'insertValue'});" /></div><div style="display:inline-block;width:150px;height:128px;"><img width="128" height="128" id="img" src=""></div></td></tr>
			<script type="text/javascript">
				function insertValue(filePath) {
					document.getElementById('srcFile_id').value = filePath;
					document.getElementById('img').src = filePath;
					document.getElementById('srcFile_button').value = 'Изменить';
					return;
				}
			</script>
			<tr><td style="width:170px;vertical-align:top;">Категория</td><td>
			<select style="width:610px;" name="cat" required>
					<option selected disabled>Выберите категорию</option>
				{% for cat in catList %}
					<option value="{{cat.id}}">{{cat.name}}</option>
				{% endfor %}
			</select>
			</td></tr>
			<tr><td style="width:170px;vertical-align:top;">Преимущества</td><td>
			<select style="width:610px;" name="advantage[]" multiple size="6" required>
				{% for advantage in advantageList %}
					<option value="{{advantage.id}}">{{advantage.title}}</option>
				{% endfor %}
			</select>
			</td></tr>
			<tr><td style="width:170px;vertical-align:top;">Цена работы</td><td><input style="width:600px;" type="text" name="price" value="" required placeholder="Цена работы"></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Цена детали</td><td><input style="width:600px;" type="text" name="price_hard" value="" required placeholder="Цена детали"></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Время ремонта</td><td><input style="width:600px;" type="text" name="time_work" value="" required placeholder="Время ремонта"></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Слоган</td><td style="vertical-align:top;"><textarea style="width:600px;height: 50px;" required placeholder="Слоган услуги" name="page_slogan"></textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">Текст</td><td style="vertical-align:top;"><textarea style="width:600px;height: 100px;" required placeholder="Текст услуги" name="text_price"></textarea></td></tr>
			<tr><td style="width:170px;vertical-align:top;">SEO Текст</td><td><textarea name="text"></textarea></td></tr>
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
			<tr><td colspan="3" style="text-align:center;"><input type="hidden" name="page_add_submit" value="page_add_submit"><input type="hidden" name="id" value="{{page.id}}"><input type="button" onClick="button_preview();form.submit();" value="Предпросмотр"><span style="display:inline-block;width:30px;"></span><input type="button" onClick="button_submit();form.submit();" name="page_add_submit" value="Сохранить"></td></tr>
			<script>
				function button_preview(){
					document.getElementById('page_add').target = 'preview';
					document.getElementById('page_add').action = '/preview/';
					var new_window = window.open("","preview","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=1366,height=768");
					new_window.focus();
				}
				function button_submit(){
					document.getElementById('page_add').target = '_self';
					document.getElementById('page_add').action = '{{site_path}}admin-post/';
				}
			</script>
		</table>
	</form>
{% endblock %}