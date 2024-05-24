<?php
session_start();
require_once '../../../config.php';
mysql_connect (DB_HOST, DB_USER, DB_PASS) or die("Извините, сервер перегружен. Попробуйте через несколько минут..");
mysql_select_db (DB_NAME);
mysql_set_charset(CHARSET);
require_once '../../../kernel/admin.php';
$login = new login();
$user = $login -> checkUser(session_id());
if(!$user){
		die(header('Location: '.SITE_PATH.'admin/login/'));
}
define( 'ROOT_DIR', 'http://'.$_SERVER['HTTP_HOST'].'/tpl/' );
define( 'ROOT_DIR2', substr( dirname(  __FILE__ ), 0, -18 ) );
if($_POST['action'] == "load") {
	$file = $_POST['file'];
	$file = ROOT_DIR.$file;
	$type = explode( ".", $file );
	$type = totranslit( end( $type ) );
	
	$url = @parse_url ( $_POST['file'] );
	$file_path = dirname (clear_url_dir($url['path']));
	$file_name = pathinfo($url['path']);
	$file_name = totranslit($file_name['basename'], false, true);

	$content = @htmlspecialchars( file_get_contents( $file ), ENT_QUOTES, 'UTF-8' );
	$script = '';
	if($type === 'tpl'){
		$script = <<<HTML
<script language="JavaScript" type="text/javascript">
	var editor = ace.edit("editor");
	editor.setTheme("ace/theme/merbivore");
	editor.getSession().setMode("ace/mode/html");
</script>
HTML;
	}
	if($type === 'js'){
		$script = <<<HTML
<script language="JavaScript" type="text/javascript">
	var editor = ace.edit("editor");
	editor.setTheme("ace/theme/merbivore");
	editor.getSession().setMode("ace/mode/javascript");
</script>
HTML;
	}
	if($type === 'css'){
		$script = <<<HTML
<script language="JavaScript" type="text/javascript">
	var editor = ace.edit("editor");
	editor.setTheme("ace/theme/merbivore");
	editor.getSession().setMode("ace/mode/css");
</script>
HTML;
	}
	echo <<<HTML
	<pre id="editor" style="margin: 0;position: absolute;top: 0;bottom: 0;left: 0;right: 0;height:560px;">{$content}</pre>
	<div id="msg_ok" style="font-size:16px;text-align:center;">Шаблон успешно сохранён</div>
	<div style="margin: 0;position: absolute;top: 565px;left: 370px;">
		<input onClick="savefile('{$file_path}/{$file_name}')" type="button" value="Сохранить" style="width:100px;text-align:center;">
	</div>
	{$script}
HTML;
} elseif ($_POST['action'] == 'save') {
	$_POST['file'] = trim(str_replace( "..", "", urldecode($_POST['file']) ));
	
	if(!$_POST['file']) { die ("error"); }
	
	$url = @parse_url ( $_POST['file'] );

	$root = ROOT_DIR2.'/tpl/';
	$file_path = dirname (clear_url_dir($url['path']));
	$file_name = pathinfo($url['path']);
	$file_name = totranslit($file_name['basename'], false, true);
	$_POST['content'] = convert_unicode( $_POST['content'], 'utf-8' );
	
	//echo $root.$file_path."/".$file_name;
	$handle = fopen( $root.$file_path."/".$file_name, "w" );
	fwrite( $handle, $_POST['content'] );
	fclose( $handle );
	echo 'ok'; die();
}
function totranslit($var, $lower = true, $punkt = true) {
	global $langtranslit;
	
	if ( is_array($var) ) return "";

	$var = str_replace(chr(0), '', $var);

	if (!is_array ( $langtranslit ) OR !count( $langtranslit ) ) {
		$var = trim( strip_tags( $var ) );

		if ( $punkt ) $var = preg_replace( "/[^a-z0-9\_\-.]+/mi", "", $var );
		else $var = preg_replace( "/[^a-z0-9\_\-]+/mi", "", $var );

		$var = preg_replace( '#[.]+#i', '.', $var );
		$var = str_ireplace( ".php", ".ppp", $var );

		if ( $lower ) $var = strtolower( $var );

		return $var;

	}
	
	$var = trim( strip_tags( $var ) );
	$var = preg_replace( "/\s+/ms", "-", $var );
	$var = str_replace( "/", "-", $var );

	$var = strtr($var, $langtranslit);
	
	if ( $punkt ) $var = preg_replace( "/[^a-z0-9\_\-.]+/mi", "", $var );
	else $var = preg_replace( "/[^a-z0-9\_\-]+/mi", "", $var );

	$var = preg_replace( '#[\-]+#i', '-', $var );
	$var = preg_replace( '#[.]+#i', '.', $var );

	if ( $lower ) $var = strtolower( $var );

	$var = str_ireplace( ".php", "", $var );
	$var = str_ireplace( ".php", ".ppp", $var );
	
	if( strlen( $var ) > 200 ) {
		
		$var = substr( $var, 0, 200 );
		
		if( ($temp_max = strrpos( $var, '-' )) ) $var = substr( $var, 0, $temp_max );
	
	}
	
	return $var;
}
function clear_url_dir($var) {
	if ( is_array($var) ) return "";

	$var = str_replace(chr(0), '', $var);
	$var = str_ireplace( ".php", "", $var );
	$var = str_ireplace( ".php", ".ppp", $var );
	$var = trim( strip_tags( $var ) );
	$var = str_replace( "\\", "/", $var );
	$var = preg_replace( "/[^a-z0-9\/\_\-]+/mi", "", $var );
	return $var;

}
function convert_unicode($t, $to = 'windows-1251') {

	$to = strtolower( $to );

	if( $to == 'utf-8' ) {
		
		return $t;
	
	} else {

		if( function_exists( 'mb_convert_encoding' ) ) {

			$t = mb_convert_encoding( $t, $to, "UTF-8" );

		} elseif( function_exists( 'iconv' ) ) {

			$t = iconv( "UTF-8", $to . "//IGNORE", $t );

		} else $t = "The library iconv AND mbstring is not supported by your server";
	
	}

	return $t;
}
?>