{% extends "main.tpl" %}
{% block title %}Редактирование шаблона / {{global_title}}{% endblock %}
{% block scripts %}
		<script src="{{theme}}/scripts/jquery.min.js" type="text/javascript"></script>
		<script src="{{theme}}/scripts/jquery-ui/jquery-ui.js" type="text/javascript"></script>
		<script src="{{theme}}/scripts/jqueryFileTree/jquery.easing.js" type="text/javascript"></script>
		<script src="{{theme}}/scripts/jqueryFileTree/jqueryFileTree.js" type="text/javascript"></script>
		<script src="{{theme}}/scripts/ace/ace.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="{{theme}}/scripts/jqueryFileTree/jqueryFileTree.css" media="screen" />
		<link rel="stylesheet" type="text/css" href="{{theme}}/scripts/jquery-ui/themes/hot-sneaks/jquery-ui.css" media="screen" />
		<script>
</script>
		<script type="text/javascript">
			
			$(document).ready( function() {
				$('#fileTreeDemo_1').fileTree({ root: 'nano/', script: '/kernel/template.php' }, function(file) {
					//alert(file);
					$.post('{{theme}}/scripts/templates.php', { action: "load", file: file }, function(data){
						RunAjaxJS('do_editor', data);
					});
				});
			});
			function savefile( file ){
				var content = editor.getValue();
	
				$.post('{{theme}}/scripts/templates.php', { action: "save", file: file, content: content }, function(data){
					if(data == "ok"){
						$("#msg_ok").dialog({
							modal:true,
							buttons:{
								Ok: function(){
									$(this).dialog( "close" );
								}
							}
						});
					}
				});
			}
			function RunAjaxJS(insertelement, data) {
				var milisec = new Date;
				var jsfound = false;
				milisec = milisec.getTime();
				var js_reg = /<script.*?>(.|[\r\n])*?<\/script>/ig;
				var js_str = js_reg.exec(data);
				if (js_str != null) {
					var js_arr = new Array(js_str.shift());
					var jsfound = true;
					while (js_str) {
						js_str = js_reg.exec(data);
						if (js_str != null) js_arr.push(js_str.shift());
					}
					for (var i = 0; i < js_arr.length; i++) {
						data = data.replace(js_arr[i], '<span id="' + milisec + i + '" style="display:none;"></span>');
					}
				}
				$("#" + insertelement).html(data);
				if (jsfound) {
					var js_content_reg = /<script.*?>((.|[\r\n])*?)<\/script>/ig;
					for (i = 0; i < js_arr.length; i++) {
						var mark_node = document.getElementById(milisec + '' + i);
						var mark_parent_node = mark_node.parentNode;
						mark_parent_node.removeChild(mark_node);
						js_content_reg.lastIndex = 0;
						var js_content = js_content_reg.exec(js_arr[i]);
						var script_node = mark_parent_node.appendChild(document.createElement('script'));
						script_node.text = js_content[1];
						var script_params_str = js_arr[i].substring(js_arr[i].indexOf(' ', 0), js_arr[i].indexOf('>', 0));
						var params_arr = script_params_str.split(' ');
						if (params_arr.length > 1) {
							for (var j = 0; j < params_arr.length; j++) {
								if (params_arr[j].length > 0) {
									var param_arr = params_arr[j].split('=');
									param_arr[1] = param_arr[1].substr(1, (param_arr[1].length - 2));
									script_node.setAttribute(param_arr[0], param_arr[1]);
								}
							}
						}
					}
				}
			};
		</script>
<style type="text/css" media="screen">
    #editor { 
        margin: 0;
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
		height:600px;
    }
	.demo {
		width: 220px;
		height: 600px;
		background: #FFF;
		overflow: scroll;
	}
</style>
{% endblock %}
{% block body %}
<table>
	<tr>
		<td style="width:220px;height:300px;margin: 0;padding: 0;">		
				<div id="fileTreeDemo_1" class="demo"></div>
		</td>
		<td style="vertical-align:top;margin: 0;padding: 0;"><div id="do_editor" style="position:relative;"></div></td>
	</tr>
</table>
{% endblock %}