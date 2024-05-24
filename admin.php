<?
session_start();

require_once dirname(__FILE__).'/config.php';
mysql_connect (DB_HOST, DB_USER, DB_PASS) or die("Извините, сервер перегружен. Попробуйте через несколько минут..");
mysql_select_db (DB_NAME);
mysql_set_charset(CHARSET);

require_once 'kernel/admin.php';
$login = new login();
$user = $login -> checkUser(session_id());
if(!$user){
		die(header('Location: '.SITE_PATH.'admin/login/'));
}
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
if(isset($_GET['act'])){
	switch ($_GET['act']){
		case 'main':
			$template = $twig->loadTemplate('main.tpl');
			break;
		case 'page':
			$template = $twig->loadTemplate('page.tpl');
			$admin = new admin_page();
			$pageList = $admin->pageList();
			$setting_array['pageList'] = $pageList;
			break;
		case 'page_add':
			$template = $twig->loadTemplate('page_add.tpl');
			$cat = new admin_cat();
			$setting_array['catList'] = $cat->catList();
			$advantage = new admin_advantage();
			$setting_array['advantageList'] = $advantage->advantageList();
			break;
		case 'page_edit':
			$template = $twig->loadTemplate('page_edit.tpl');
			$admin = new admin_page();
			$setting_array['page'] = $admin->pageEdit($_GET['id']);
			break;
		case 'cat':
			$template = $twig->loadTemplate('cat.tpl');
			$admin = new admin_cat();
			$catList = $admin->catList();
			$setting_array['catList'] = $catList;
			break;
		case 'cat_add':
			$template = $twig->loadTemplate('cat_add.tpl');
			break;
		case 'cat_edit':
			$template = $twig->loadTemplate('cat_edit.tpl');
			$admin = new admin_cat();
			$catEdit = $admin->catEdit($_GET['id']);
			$setting_array['cat'] = $catEdit;
			break;
		case 'news':
			$template = $twig->loadTemplate('news.tpl');
			$admin = new admin_news();
			$newsList = $admin->newsList();
			$setting_array['newsList'] = $newsList;
			break;
		case 'news_add':
			$template = $twig->loadTemplate('news_add.tpl');
			$page = new admin_page();
			$setting_array['pageList'] = $page->pageList();
			break;
		case 'news_edit':
			$template = $twig->loadTemplate('news_edit.tpl');
			$admin = new admin_news();
			$newsEdit = $admin->newsEdit($_GET['id']);
			$setting_array['news'] = $newsEdit;
			break;
		case 'advantage':
			$template = $twig->loadTemplate('advantage.tpl');
			$admin = new admin_advantage();
			$advantageList = $admin->advantageList();
			$setting_array['advantageList'] = $advantageList;
			break;
		case 'advantage_add':
			$template = $twig->loadTemplate('advantage_add.tpl');
			break;
		case 'advantage_edit':
			$template = $twig->loadTemplate('advantage_edit.tpl');
			$admin = new admin_advantage();
			$advantageEdit = $admin->advantageEdit($_GET['id']);
			$setting_array['advantage'] = $advantageEdit;
			break;
		case 'article':
			$template = $twig->loadTemplate('article.tpl');
			$admin = new admin_article();
			$articleList = $admin->articleList();
			$setting_array['articleList'] = $articleList;
			break;
		case 'article_add':
			$template = $twig->loadTemplate('article_add.tpl');
			break;
		case 'article_edit':
			$template = $twig->loadTemplate('article_edit.tpl');
			$admin = new admin_article();
			$articleEdit = $admin->articleEdit($_GET['id']);
			$setting_array['article'] = $articleEdit;
			break;
		case 'static':
			$template = $twig->loadTemplate('static.tpl');
			$admin = new admin_static();
			$staticList = $admin->staticList();
			$setting_array['staticList'] = $staticList;
			break;
		case 'static_add':
			$template = $twig->loadTemplate('static_add.tpl');
			break;
		case 'static_edit':
			$template = $twig->loadTemplate('static_edit.tpl');
			$admin = new admin_static();
			$staticEdit = $admin->staticEdit($_GET['id']);
			$setting_array['static'] = $staticEdit;
			break;
		case 'setting':
			$template = $twig->loadTemplate('setting.tpl');
			$admin = new admin_setting();
			$settingList = $admin->viewSetting();
			$setting_array['settingList'] = $settingList;
			break;
		case 'opinions':
			$template = $twig->loadTemplate('opinions.tpl');
			$opinion = new opinions();
			if(isset($_GET['page'])){
				$opinionList = $opinion->getOpinions($_GET['page']);
			}else{
				$opinionList = $opinion->getOpinions(1);
			}
			$setting_array['opinionList']['list'] = $opinionList['list'];
			$setting_array['opinionList']['paging'] = $opinionList['paging'];
			break;
		case 'templates':
			$template = $twig->loadTemplate('templates.tpl');
			break;
		case 'login':
			$template = $twig->loadTemplate('login.tpl');
			break;
		default:
			header("Location: /admin/main/");
			break;
	}
}

echo $template->render($setting_array);
?>