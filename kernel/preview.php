<?
header('Content-Type: text/html; charset=utf-8');
require_once dirname(__FILE__).'/../config.php';
mysql_connect (DB_HOST, DB_USER, DB_PASS) or die("Извините, сервер перегружен. Попробуйте через несколько минут..");
mysql_select_db (DB_NAME);
mysql_set_charset(CHARSET);
require_once 'kernel.php';
require_once dirname(__FILE__).'/../lib/Twig/Autoloader.php';
Twig_Autoloader::register();
$loader = new Twig_Loader_Filesystem(TEMPLATE_DIR);
$twig = new Twig_Environment($loader, array(
    'cache' => false,
	'debug' => true,
));

$twig -> clearCacheFiles();
$site_settings = new site_setting();
$global_settings = $site_settings->site_settings();
$setting_array = array(
						'site_path' => SITE_PATH,
						'theme' => TEMPLATE,
						'global_title' => $global_settings['meta_title'],
						'global_keywords' => $global_settings['meta_description'],
						'global_description' => $global_settings['meta_keywords'],
						);
if(isset($_POST['static_add_submit']) || isset($_POST['static_edit_submit'])){
	$template = $twig->loadTemplate('static.tpl');
	$setting_array['title'] = $_POST['title'];
	$setting_array['meta_keywords'] = $_POST['meta_keywords'];
	$setting_array['meta_description'] = $_POST['meta_description'];
	$setting_array['text'] = $_POST['text'];
	echo $template->render($setting_array);
}
if(isset($_POST['news_add_submit']) || isset($_POST['news_edit_submit'])){
	$template = $twig->loadTemplate('full_news.tpl');
	$sidebar = new page();
	$setting_array['sidebar'] = $sidebar->getShortPage(5);
	$setting_array['title'] = $_POST['title'];
	$setting_array['keywords'] = $_POST['meta_keywords'];
	$setting_array['description'] = $_POST['meta_description'];
	$setting_array['text'] = $_POST['text'];
	echo $template->render($setting_array);
}
if(isset($_POST['page_add_submit']) || isset($_POST['page_edit_submit'])){
	$template = $twig->loadTemplate('page.tpl');
	$setting_array['page']['title'] = $_POST['title'];
	$setting_array['page']['id'] = $_POST['id'];
	$setting_array['page']['meta_keywords'] = $_POST['meta_keywords'];
	$setting_array['page']['meta_description'] = $_POST['meta_description'];
	$setting_array['page']['page_slogan'] = $_POST['page_slogan'];
	$setting_array['page']['cat_icon'] = $_POST['cat_icon'];
	$setting_array['page']['price'] = $_POST['price'];
	$setting_array['page']['price_hard'] = $_POST['price_hard'];
	$setting_array['page']['time_work'] = $_POST['time_work'];
	$setting_array['page']['text_price'] = $_POST['text_price'];
	$setting_array['page']['text'] = $_POST['text'];
	$news = new news();
	$setting_array['page']['news_short'] = $news->getShortNews(5, $_POST['id']);
	
	$setting_array['page']['opinions'] = $full_page['opinions'];
	$advantages = new advantages();
	$setting_array['page']['advantages'] = $advantages->getAdvantage($_POST['advantage']);
	$setting_array['page']['name'] = $full_page['name'];
	
	echo $template->render($setting_array);
}
if(isset($_POST['article_add_submit']) || isset($_POST['article_edit_submit'])){
	$template = $twig->loadTemplate('full_article.tpl');
	$sidebar = new page();
	$setting_array['sidebar'] = $sidebar->getShortPage(5);
	$setting_array['title'] = $_POST['title'];
	$setting_array['text'] = $_POST['text'];
	$setting_array['keywords'] = $_POST['meta_keywords'];
	$setting_array['description'] = $_POST['meta_description'];

	echo $template->render($setting_array);
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

echo <<<HTML
\r\n<script>

	var links = document.getElementsByTagName("a");
	for (var l = 0; l < links.length; l++){
		links[l].href = 'javascript:void(0)';
	}

</script>
HTML;
?>