<?
session_start();

require_once dirname(__FILE__).'/config.php';
mysql_connect (DB_HOST, DB_USER, DB_PASS) or die("Извините, сервер перегружен. Попробуйте через несколько минут..");
mysql_select_db (DB_NAME);
mysql_set_charset(CHARSET);

if($_SERVER['REQUEST_URI'] == '/admin/' || $_SERVER['REQUEST_URI'] == '/admin.php'){
	header("Location: /admin/main/");
}elseif(preg_match('|^/admin\/([^/^.]*)$|' , $_SERVER['REQUEST_URI'])){
	header('HTTP/1.1 301 Moved Permanently');
	header ('Location: '.$_SERVER['REQUEST_URI'].'/');
	die();
}
require_once dirname(__FILE__).'/lib/Twig/Autoloader.php';
Twig_Autoloader::register();
$loader = new Twig_Loader_Filesystem(ADMIN_TEMPLATE_DIR);
$twig = new Twig_Environment($loader, array(
    'cache' => false,
	'debug' => true,
));

$twig -> clearCacheFiles();
$setting_array = array(
	'site_path' => SITE_PATH,
	'theme' => ADMIN_TEMPLATE,
	'global_title' => 'Панель администрирования',
);
$template = $twig->loadTemplate('login.tpl');
echo $template->render($setting_array);
?>