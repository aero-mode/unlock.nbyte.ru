<?
session_start();
require_once dirname(__FILE__).'/../config.php';
mysql_connect (DB_HOST, DB_USER, DB_PASS) OR DIE("Извините, сервер перегружен. Попробуйте через несколько минут..");
mysql_select_db (DB_NAME);
mysql_set_charset(CHARSET);
require_once 'admin.php';

header('Content-Type: text/html; charset=utf-8');

/* Login */
if(isset($_POST['login'])){
	$setting = new login();
	$login = $setting->loginA($_POST['user_name'], $_POST['user_pass'], session_id());
	// var_dump($login);
	if($login){
		die(header('Location: '.SITE_PATH.'admin/main/'));
	}else{
		die(header('Location: '.SITE_PATH.'admin/login/'));
	}
}
/* Настройки сайта */
if(isset($_POST['admin_setting_submit'])){
	$setting = new admin_setting;
	$setting->editSetting($_POST['meta_title'], $_POST['meta_description'], $_POST['meta_keywords'], $_POST['status']);
	header('Location: /admin/main/');
}

/* Страницы услуг */
if(isset($_POST['page_edit_submit'])){
	$setting = new admin_page;
	$setting->pageSave($_POST['id'], $_POST['title'], RusToLat($_POST['title']), $_POST['meta_keywords'], $_POST['meta_description'], $_POST['cat_icon'], $_POST['page_slogan'], $_POST['text_price'], $_POST['text'], $_POST['price'], $_POST['price_hard'], $_POST['time_work'], $_POST['advantage'], $_POST['cat'], $_POST['visible']);
	
	header('Location: /admin/page/');
}
if(isset($_POST['page_add_submit'])){
	$setting = new admin_page;
	$setting->pageAdd($_POST['title'], RusToLat($_POST['title']), $_POST['meta_keywords'], $_POST['meta_description'], $_POST['cat_icon'], $_POST['page_slogan'], $_POST['text_price'], $_POST['text'], $_POST['price'], $_POST['price_hard'], $_POST['time_work'], $_POST['advantage'], $_POST['cat'], $_POST['visible']);
	
	header('Location: /admin/page/');
}
if(isset($_POST['action']) && $_POST['action']=='page_delete'){
	$setting = new admin_page;
	$aassd = $setting->pageDelete($_POST['id']);
	echo $aassd;
	// print_r($_POST);
}


/* Преимущества */
if(isset($_POST['advantage_edit_submit'])){
	$setting = new admin_advantage;
	$setting->advantageSave($_POST['id'], $_POST['title'], $_POST['icon'], $_POST['text']);
	
	header('Location: /admin/main/');
}
if(isset($_POST['advantage_add_submit'])){
	$setting = new admin_advantage;
	$setting->advantageAdd($_POST['title'], $_POST['icon'], $_POST['text']);
	
	header('Location: /admin/main/');
}
if(isset($_POST['action']) && $_POST['action']=='advantage_delete'){
	$setting = new admin_advantage;
	$aassd = $setting->advantageDelete($_POST['id']);
	echo $aassd;
	// print_r($_POST);
}

/* Категории */
if(isset($_POST['cat_edit_submit'])){
	$setting = new admin_cat;
	$setting->catSave($_POST['id'], $_POST['cat_text'], $_POST['cat_slogan'], $_POST['name'], RusToLat($_POST['name']));
	
	header('Location: /admin/main/');
}
if(isset($_POST['cat_add_submit'])){
	$setting = new admin_cat;
	$setting->catAdd($_POST['name'], $_POST['cat_text'], $_POST['cat_slogan'], RusToLat($_POST['name']));
	
	header('Location: /admin/main/');
}
if(isset($_POST['action']) && $_POST['action']=='cat_delete'){
	$setting = new admin_cat;
	$aassd = $setting->catDelete($_POST['id']);
	echo $aassd;
	// print_r($_POST);
}

/* Новости */
if(isset($_POST['news_edit_submit'])){
	$setting = new admin_news;
	$setting->newsSave($_POST['id'], $_POST['title'], RusToLat($_POST['title']), $_POST['meta_keywords'], $_POST['meta_description'], $_POST['page_id'], $_POST['short_img'], $_POST['short_text'], $_POST['text'], $_POST['visible']);
	
	header('Location: /admin/main/');
}
if(isset($_POST['news_add_submit'])){
	$setting = new admin_news;
	$setting->newsAdd($_POST['title'], RusToLat($_POST['title']), $_POST['meta_keywords'], $_POST['meta_description'], $_POST['page_id'], $_POST['short_img'], $_POST['short_text'], $_POST['text'], $_POST['visible']);
	
	header('Location: /admin/main/');
}
if(isset($_POST['action']) && $_POST['action']=='news_delete'){
	$setting = new admin_news;
	$aassd = $setting->newsDelete($_POST['id']);
	echo $aassd;
	// print_r($_POST);
}

/* Статьи */
if(isset($_POST['article_edit_submit'])){
	$setting = new admin_article;
	$setting->articleSave($_POST['id'], $_POST['title'], $_POST['meta_keywords'], $_POST['meta_description'], $_POST['short_img'], $_POST['short_text'], $_POST['text'], $_POST['visible']);
	
	header('Location: /admin/main/');
}
if(isset($_POST['article_add_submit'])){
	$setting = new admin_article;
	$setting->articleAdd($_POST['title'], RusToLat($_POST['title']), $_POST['meta_keywords'], $_POST['meta_description'], $_POST['short_img'], $_POST['short_text'], $_POST['text'], $_POST['visible']);
	
	header('Location: /admin/main/');
}
if(isset($_POST['action']) && $_POST['action']=='article_delete'){
	$setting = new admin_article;
	$aassd = $setting->articleDelete($_POST['id']);
	echo $aassd;
	// print_r($_POST);
}

/* Статические страницы */
if(isset($_POST['static_edit_submit'])){
	$setting = new admin_static;
	$setting->staticSave($_POST['id'], $_POST['title'], RusToLat($_POST['title']), $_POST['meta_keywords'], $_POST['meta_description'], $_POST['text'], $_POST['visible']);
	
	header('Location: /admin/static/');
}
if(isset($_POST['static_add_submit'])){
	$setting = new admin_static;
	$setting->staticAdd($_POST['title'], RusToLat($_POST['title']), $_POST['meta_keywords'], $_POST['meta_description'], $_POST['text'], $_POST['visible']);
	
	header('Location: /admin/static/');
}
if(isset($_POST['action']) && $_POST['action']=='static_delete'){
	$setting = new admin_static;
	$aassd = $setting->staticDelete($_POST['id']);
	echo $aassd;
	// print_r($_POST);
}

/* Отзывы */
if(isset($_POST['action']) && $_POST['action'] === 'add_opinion'){
	$setting = new opinions;
	$aassd = $setting->addOpinion($_POST['id']);
	echo $aassd;
}
if(isset($_POST['action']) && $_POST['action'] === 'del_opinion'){
	$setting = new opinions;
	$aassd = $setting->delOpinion($_POST['id']);
	echo $aassd;
}
if(isset($_POST['action']) && $_POST['action'] === 'add_answer'){
	$setting = new opinions;
	$aassd = $setting->addOpinionAnswer($_POST['id'], $_POST['text']);
	echo $aassd;
	// print_r($_POST);
}


function RusToLat($str) {
	$lit = array(
		"а" => "a", "б" => "b", "в" => "v", "г" => "g", "д" => "d", "е" => "e", "ё" => "yo", "ж" => "g", "з" => "z", "и" => "i", "й" => "y", "к" => "k", "л" => "l", "м" => "m", "н" => "n","о" => "o", "п" => "p",
		"р" => "r", "с" => "s", "т" => "t", "у" => "u", "ф" => "f", "х" => "h", "ц" => "ts", "ч" => "ch", "ш" => "sh", "щ" => "shch", "ъ" => "", "ы" => "i", "ь" => "", "э" => "e", "ю" => "yu", "я" => "ya",
		"А" => "A", "Б" => "B", "В" => "V", "Г" => "G", "Д" => "D", "Е" => "E", "Ё" => "Yo", "Ж" => "G", "З" => "Z", "И" => "I", "Й" => "Y", "К" => "K", "Л" => "L", "М" => "M", "Н" => "N", "О" => "O", "П" => "P",
		"Р" => "R", "С" => "S", "Т" => "T", "У" => "U", "Ф" => "F", "Х" => "H", "Ц" => "Ts", "Ч" => "Ch", "Ш" => "Sh", "Щ" => "Shch", "Ъ" => "", "Ы" => "I", "Ь" => "", "Э" => "E", "Ю" => "Yu", "Я" => "Ya",
		"." => "", "," => "", ";" => "", ":" => "", "/" => "", "\\" => "", "!" => "-", "@" => "", "#" => "", "$" => "", "%" => "", "^" => "", "&" => "", "*" => "", ")" => "", "(" => "", "{" => "", "}" => "",
		"]" => "", "[" => "", "+" => "", "'" => "", "\"" => "", "=" => "", "?" => "-", "_" => "-", "№" => "", "~" => "", "`" => "", ">" => "", "<" => "", "|" => "", " " => "-",
	);
	$str = strtr($str, $lit);
	$lit2 = array(
		"----" => "-",
		"---" => "-",
		"--" => "-",
	);
	$str = strtr($str, $lit2);
	$str = trim(trim($str), "-");
	return strtolower($str);
}