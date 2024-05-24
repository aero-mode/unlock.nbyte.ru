<?
require_once dirname(__FILE__).'/config.php';
mysql_connect (DB_HOST, DB_USER, DB_PASS) OR DIE("Извините, сервер перегружен. Попробуйте через несколько минут..");
mysql_select_db (DB_NAME);
mysql_set_charset(CHARSET);
require_once dirname(__FILE__).'/kernel/kernel.php';
if($_SERVER['REQUEST_URI'] != '/'){
	if(preg_match('|\/404\.html|' , $_SERVER['REQUEST_URI']) || preg_match('|\/([^/]*)\/|' , $_SERVER['REQUEST_URI']) || preg_match('|\/(\d+)-([^/]*)\.html|' , $_SERVER['REQUEST_URI'])){

	}elseif(preg_match('|\/([^/]*)\/(\d+)-([^/]*)\.(?!html)|' , $_SERVER['REQUEST_URI'])){
		$true_link = explode ('.', $_SERVER['REQUEST_URI']);
		header('HTTP/1.1 301 Moved Permanently');
		header ('Location: '.$true_link['0'].'.html');
		die();
	}elseif(preg_match('|\/(\d+)-([^/]*)\.(?!html)|' , $_SERVER['REQUEST_URI'])){
		$true_link = explode ('.', $_SERVER['REQUEST_URI']);
		header('HTTP/1.1 301 Moved Permanently');
		header ('Location: '.$true_link['0'].'.html');
		die();
	}elseif(preg_match('|^\/([^/^.]*)$|' , $_SERVER['REQUEST_URI'])){
		header('HTTP/1.1 301 Moved Permanently');
		header ('Location: '.$_SERVER['REQUEST_URI'].'/');
		die();
	}else{
		header("Location: /404.html");
		die();
	}
}

require_once dirname(__FILE__).'/lib/Twig/Autoloader.php';
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
if(isset($_GET['act'])){
	switch ($_GET['act']){
		case 'news':
			$sidebar = new page();
			if(isset($_GET['id'])){
				$template = $twig->loadTemplate('full_news.tpl');
				$news = new news();
				$news_full = $news->getFullNews(intval($_GET['id']), $_GET['tit']);
				if($news_full == NULL){header("HTTP/1.1 404 Not Found");$template = $twig->loadTemplate('404.tpl');break;}
				if(isset($news_full['true_link'])){header('HTTP/1.1 301 Moved Permanently');header ('Location: '.$news_full['link']);die();}
				$setting_array['title'] = $news_full['title'];
				$setting_array['keywords'] = $news_full['meta_keywords'];
				$setting_array['description'] = $news_full['meta_description'];
				$setting_array['text'] = $news_full['text'];
				$setting_array['sidebar'] = $sidebar->getShortPage(5, $news_full['page_id']);
			}else{
				$template = $twig->loadTemplate('short_news.tpl');
				$setting_array['title'] = 'Новости'.' / '.$global_settings['meta_title'];
				$news = new news();
				$news_short = $news->getShortNews();
				$setting_array['news_short'] = $news_short;
				$setting_array['sidebar'] = $sidebar->getShortPage(5);
			}
			break;
		case 'page':
			$template = $twig->loadTemplate('page.tpl');
			if(isset($_GET['id'])){
				session_start();
				$page = new page();
				$full_page = $page->getFullPage($_GET['id'], $_GET['tit']);
				if($full_page == NULL){header("HTTP/1.1 404 Not Found");header("Location: /404.html");$template = $twig->loadTemplate('404.tpl');break;}
				if(isset($full_page['true_link'])){header('HTTP/1.1 301 Moved Permanently');header ('Location: '.$full_page['link']);die();}
				if(!isset($_SESSION['views'])){
					$page ->setViews($_GET['id'], $full_page['views']); 
				}
				$news = new news();
				$news_short = $news->getShortNews(6, $_GET['id']);
				$full_page['news_short'] = $news_short;
				$setting_array['page'] = $full_page;
				$setting_array['current_cat'] = $full_page['cat'];
				$setting_array['main_page'] = 'main';
				$setting_array['current_page'] = 'page';
				$timer = new timer();
				$setting_array['timer'] = $timer->setTimer();
				// print_r($setting_array);
			}else{
				header("HTTP/1.1 404 Not Found");
				$template = $twig->loadTemplate('404.tpl');
				$setting_array['main_page'] = 'main';
				break;
			}
			break;
		case 'cat':
			$template = $twig->loadTemplate('category.tpl');
			if(isset($_GET['id'])){
				$cat = new category();
				$cat_page = $cat -> getCategory(intval($_GET['id']), $_GET['tit']);
				if($cat_page == NULL){header("HTTP/1.1 404 Not Found");$template = $twig->loadTemplate('404.tpl');break;}
				if(isset($cat_page['true_link'])){header('HTTP/1.1 301 Moved Permanently');header ('Location: '.$cat_page['link']);die();}
				$setting_array['title'] = $cat_page['cat_content']['name'].' / '.$global_settings['meta_title'];
				$setting_array['short_pages'] = $cat_page['short_pages'];
				$setting_array['cat'] = $cat_page['cat_content'];
				$setting_array['current_cat'] = $cat_page['cat_content']['id'];
			}else{
				header("HTTP/1.1 404 Not Found");
				$template = $twig->loadTemplate('404.tpl');
				break;
			}
			break;
		case 'static':
			$template = $twig->loadTemplate('static.tpl');
			if(isset($_GET['id'])){
				$static = new statics();
				$static_page = $static -> getStatic(intval($_GET['id']), $_GET['tit']);
				if($static_page == NULL){header("HTTP/1.1 404 Not Found");$template = $twig->loadTemplate('404.tpl');break;}
				if(isset($static_page['true_link'])){header('HTTP/1.1 301 Moved Permanently');header ('Location: '.$static_page['link']);die();}
				$setting_array['title'] = $static_page['title'];
				$setting_array['keywords'] = $static_page['meta_keywords'];
				$setting_array['description'] = $static_page['meta_description'];
				$setting_array['text'] = $static_page['text'];
			}else{
				header("HTTP/1.1 404 Not Found");
				$template = $twig->loadTemplate('404.tpl');
				break;
			}
			break;
		case 'articles':
			$sidebar = new page();
			$setting_array['sidebar'] = $sidebar->getShortPage(5);
			if(isset($_GET['id'])){
				$template = $twig->loadTemplate('full_article.tpl');
				$articles = new articles();
				$full_article = $articles->getFullArticle(intval($_GET['id']), $_GET['tit']);
				if($full_article == NULL){header("HTTP/1.1 404 Not Found");$template = $twig->loadTemplate('404.tpl');break;}
				if(isset($full_article['true_link'])){header('HTTP/1.1 301 Moved Permanently');header ('Location: '.$full_article['link']);die();}
				$setting_array['title'] = $full_article['title'];
				$setting_array['keywords'] = $full_article['meta_keywords'];
				$setting_array['description'] = $full_article['meta_description'];
				$setting_array['text'] = $full_article['text'];
			}else{
				$template = $twig->loadTemplate('short_article.tpl');
				$setting_array['title'] = 'Статьи'.' / '.$global_settings['meta_title'];
				$news = new articles();
				$news_short = $news->getShortArticle();
				$setting_array['news_short'] = $news_short;
			}
			break;
		case 'opinions':
			$template = $twig->loadTemplate('opinion.tpl');
			$opinions = new opinions();
			if(isset($_POST['page'])){
				$opinions_arr = $opinions->getOpinions($_POST['id'], $_POST['page']);
				if(count($opinions_arr['opinions']) == 0){
					$setting_array['opinions'] = 0;
				}else{
					$setting_array['opinions'] = $opinions_arr['opinions'];
					$setting_array['paginations'] = $opinions_arr['paginations'];
					$setting_array['pages'] = $opinions_arr['page'];
				}
				
			}
			break;
		case '404':
			header("HTTP/1.1 404 Not Found");
			$template = $twig->loadTemplate('404.tpl');
			$timer = new timer();
			$setting_array['timer'] = $timer->setTimer();
			break;
	}
}else{
	$template = $twig->loadTemplate('main.tpl');
	$news = new news();
	$setting_array['news_short'] = $news->getShortNews(5);
	$articles = new articles();
	$setting_array['articles_short'] = $articles->getShortArticle(5);
	$setting_array['main_page'] = 'main';
	$timer = new timer();
	$setting_array['timer'] = $timer->setTimer();
}
echo $template->render($setting_array);
?>