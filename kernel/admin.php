<? 
/* Login */

class login{
		public function checkUser($sid){
			$checkQueryText = "SELECT `sid` FROM `admin_login` WHERE `sid`='".$sid."'";
			$checkQuery = mysql_query($checkQueryText) or die(mysql_error());
			$s_id = mysql_fetch_array($checkQuery);
			if($s_id['sid'] === $sid){
				$return = true;
			}else{
				$return = false;
			}
			return $return;
		}
		
		public function loginA($userName, $userPwd, $sid){
			$userName = trim(mysql_real_escape_string($userName));
			$userPwd = trim(mysql_real_escape_string($userPwd));
			$userPwd = md5($userPwd);
			$loginQuery = mysql_query("SELECT `id`, `login`, `sid` FROM `admin_login` WHERE `login` = '$userName' AND `pwd` = '$userPwd'") or die(mysql_error());
			$user = mysql_fetch_array($loginQuery);
			if(!empty($user)){ //Если массив не пустой (это значит, что пара имя/пароль верная)
				$_SESSION = array_merge($_SESSION, $user); //Добавляем массив с пользователем к массиву сессии
				mysql_query("UPDATE `admin_login` SET `sid`='$sid' WHERE `id`='{$user['id']}'") or die(mysql_error());
				@setcookie('PHPSESSID', $sid, time()+3600);
				$return = true;
			}else{
				$return = false;
			}
			return $return;
		}
}
/* Страницы услуг */
class admin_page{
	public function pageList($catId = NULL){
		($catId != NULL)?$where = "WHERE `cat`=$catId":$where = "";
		$pageListQuery = mysql_query("SELECT `page`.`id` as `id`,`page`.`title` as `title`,`page`.`title_translit` as `link`,`page`.`views` as `views`,`page`.`visible` as `visible`,`cat`.`id` as `cat_id`,`cat`.`name` as `cat_name`,`cat`.`name_eng` as `cat_name_eng` FROM `page`,`cat` WHERE `cat`.`id`=`page`.`cat` $where ORDER BY `page`.`cat` ASC, `page`.`id` ASC") or die(mysql_error());
		while($pageListRow = mysql_fetch_assoc($pageListQuery)){
			$pageListRow['edit_link'] = SITE_PATH.'admin/page_edit/'.$pageListRow['id'];
			$pageListRow['link'] = SITE_PATH.$pageListRow['cat_id'].'-'.$pageListRow['cat_name_eng'].'/'.$pageListRow['id'].'-'.$pageListRow['link'].'.html';
			$array[] = $pageListRow;
		}
		return $array;
	}
	public function pageAdd($title, $title_translit, $meta_keywords, $meta_description, $cat_icon, $page_slogan, $text_price, $text, $price, $price_hard, $time_work, $advantage, $cat, $visible){
		$title = mysql_real_escape_string($title);
		$title_translit = mysql_real_escape_string($title_translit);
		$meta_keywords = mysql_real_escape_string($meta_keywords);
		$meta_description = mysql_real_escape_string($meta_description);
		$cat_icon = mysql_real_escape_string($cat_icon);
		$page_slogan = mysql_real_escape_string($page_slogan);
		$text_price = mysql_real_escape_string($text_price);
		$text = mysql_real_escape_string($text);
		$price = mysql_real_escape_string($price);
		$price_hard = mysql_real_escape_string($price_hard);
		$time_work = mysql_real_escape_string($time_work);
		$advantage = implode(';', $advantage);
		$cat = intval($cat);
		$visible = intval($visible);
		mysql_query("INSERT INTO `page` (`id`, `title`, `title_translit`, `meta_keywords`, `meta_description`, `cat_icon`, `page_slogan`, `text_price`, `text`, `price`, `price_hard`, `time_work`, `advantage`, `cat`, `views`, `visible`) VALUES (NULL, '$title', '$title_translit', '$meta_keywords', '$meta_description', '$cat_icon', '$page_slogan', '$text_price', '$text', '$price', '$price_hard', '$time_work', '$advantage', '$cat', NULL, '$visible');") or die(mysql_error());
	}
	public function pageEdit($id){
		$id = intval($id);
		$pageQuery = mysql_query("SELECT * FROM `page` WHERE `id`='$id'") or die(mysql_error());
		$pageRow = mysql_fetch_assoc($pageQuery);

		$pageRow['advantage'] = explode(';', $pageRow['advantage']);
		$advantagesQuery = mysql_query("SELECT `id`,`title` FROM `advantage`") or die(mysql_error());
		while($advantagesRow = mysql_fetch_assoc($advantagesQuery)){
			if(in_array($advantagesRow['id'], $pageRow['advantage'])){$advantagesRow['in'] = 1;}else{$advantagesRow['in'] = 0;}
			$pageRow['advantages'][] = $advantagesRow;
		}
		$categoryQuery = mysql_query("SELECT `id`,`name` FROM `cat`") or die(mysql_error());
		while($categoryRow = mysql_fetch_assoc($categoryQuery)){
			if($categoryRow['id']==$pageRow['cat']){$categoryRow['in'] = 1;}else{$categoryRow['in'] = 0;}
			$pageRow['cats'][] = $categoryRow;
		}
		return $pageRow;
	}
	public function pageSave($id, $title, $title_translit, $meta_keywords, $meta_description, $cat_icon, $page_slogan, $text_price, $text, $price, $price_hard, $time_work, $advantage, $cat, $visible){
		$id = intval($id);
		$price = mysql_real_escape_string($price);
		$price_hard = mysql_real_escape_string($price_hard);
		$time_work = mysql_real_escape_string($time_work);
		$cat = intval($cat);
		$visible = intval($visible);
		$title = mysql_real_escape_string($title);
		$title_translit = mysql_real_escape_string($title_translit);
		$meta_keywords = mysql_real_escape_string($meta_keywords);
		$meta_description = mysql_real_escape_string($meta_description);
		$cat_icon = mysql_real_escape_string($cat_icon);
		$page_slogan = mysql_real_escape_string($page_slogan);
		$text_price = mysql_real_escape_string($text_price);
		$text = mysql_real_escape_string($text);
		$advantage = implode(';', $advantage);
		mysql_query("UPDATE `page` SET `title`='$title', `title_translit`='$title_translit', `meta_keywords`='$meta_keywords', `meta_description`='$meta_description', `cat_icon`='$cat_icon', `page_slogan`='$page_slogan', `text_price`='$text_price', `text`='$text', `price`='$price', `price_hard`='$price_hard', `time_work`='$time_work', `advantage`='$advantage', `cat`='$cat', `visible`='$visible' WHERE `id`='$id'") or die(mysql_error());
	}
	public function pageDelete($id){
		mysql_query("DELETE FROM `page` WHERE `id` ='$id'") or die(mysql_error());
		if(mysql_affected_rows() > 0){
			return 'deleted';
		}else{
			return 'error';
		}
	}
}

/* Категории */
class admin_cat{
	public function catList(){
		$catListQuery = mysql_query("SELECT * FROM `cat` ORDER BY `id` ASC") or die(mysql_error());
		while($catListRow = mysql_fetch_assoc($catListQuery)){
			$catListRow['edit_link'] = SITE_PATH.'admin/cat_edit/'.$catListRow['id'];
			$array[] = $catListRow;
		}
		return $array;
	}
	public function catAdd($name, $cat_text, $cat_slogan, $name_eng){
		$name = mysql_real_escape_string($name);
		$cat_text = mysql_real_escape_string($cat_text);
		$cat_slogan = mysql_real_escape_string($cat_slogan);
		$name_eng = mysql_real_escape_string($name_eng);
		mysql_query("INSERT INTO `cat` (`id`, `cat_text`, `cat_slogan`, `name_eng`, `name`) VALUES (NULL, '$cat_text', '$cat_slogan', '$name_eng', '$name')") or die(mysql_error());
	}
	public function catEdit($id){
		$id = intval($id);
		$catEditQuery = mysql_query("SELECT * FROM `cat` WHERE `id`=$id") or die(mysql_error());
		$catEditRow = mysql_fetch_assoc($catEditQuery);
		return $catEditRow;
	}
	public function catSave($id, $cat_text, $cat_slogan, $name, $name_eng){
		$id = intval($id);
		$cat_text = mysql_real_escape_string($cat_text);
		$cat_slogan = mysql_real_escape_string($cat_slogan);
		$name = mysql_real_escape_string($name);
		$name_eng = mysql_real_escape_string($name_eng);
		mysql_query("UPDATE `cat` SET `name`='$name', `cat_text`='$cat_text', `cat_slogan`='$cat_slogan', `name_eng`='$name_eng' WHERE `id`=$id") or die(mysql_error());
	}
	public function catDelete($id){
		$id = intval($id);
		mysql_query("DELETE FROM `cat` WHERE `id` ='$id'") or die(mysql_error());
		if(mysql_affected_rows() > 0){
			return 'deleted';
		}else{
			return 'error';
		}
	}
}

/* Новости */
class admin_news{
	public function newsList(){
		$newsListQuery = mysql_query("SELECT news.id,news.date_add,news.title,news.visible,page.title as page_title FROM `news`,`page` WHERE `page`.`id`=`news`.`page_id` ORDER BY `id` DESC") or die(mysql_error());
		while($newsListRow = mysql_fetch_assoc($newsListQuery)){
			$newsListRow['edit_link'] = SITE_PATH.'admin/news_edit/'.$newsListRow['id'];
			$newsListRow['date_add'] = date('d.m.Y H:i', $newsListRow['date_add']);
			$array[] = $newsListRow;
		}
		return $array;
	}
	public function newsAdd($title, $title_translit, $meta_keywords, $meta_description, $page_id, $short_img, $short_text, $text, $visible){
		$title = mysql_real_escape_string($title);
		$title_translit = mysql_real_escape_string($title_translit);
		$meta_keywords = mysql_real_escape_string($meta_keywords);
		$meta_description = mysql_real_escape_string($meta_description);
		$page_id = intval($page_id);
		$short_img = mysql_real_escape_string($short_img);
		$short_text = mysql_real_escape_string($short_text);
		$text = mysql_real_escape_string($text);
		$visible = intval($visible);
		$date_add = time();
		mysql_query("INSERT INTO `news` (`id`, `date_add`, `title`, `title_translit`, `meta_keywords`, `meta_description`, `short_img`, `short_text`, `text`, `page_id`, `visible`) VALUES (NULL, '$date_add', '$title', '$title_translit', '$meta_keywords', '$meta_description', '$short_img', '$short_text', '$text', '$page_id', '$visible');") or die(mysql_error());
	}
	public function newsEdit($id){
		$id=intval($id);
		$newsEditQuery = mysql_query("SELECT `news`.`id`,`news`.`date_add`,`news`.`title`,`news`.`meta_keywords`,`news`.`meta_description`,`news`.`short_img`,`news`.`short_text`,`news`.`text`,`news`.`page_id`,`news`.`visible`,`page`.`title` as `page_title`,`page`.`id` as `page_id` FROM `news`,`page` WHERE `news`.`id`=$id AND `page`.`id`=`news`.`page_id`") or die(mysql_error());
		$newsEditRow = mysql_fetch_assoc($newsEditQuery);
		$pageQuery = mysql_query("SELECT id,title FROM `page`") or die(mysql_error());
		while($pageRow = mysql_fetch_assoc($pageQuery)){
			if($pageRow['id']==$newsEditRow['page_id']){$pageRow['in'] = 1;}else{$pageRow['in'] = 0;}
			$newsEditRow['pages_title'][]= $pageRow;
		}
		$newsEditRow['date_add'] = date('d.m.Y H:i', $newsEditRow['date_add']);
		return $newsEditRow;
	}
	public function newsSave($id, $title, $title_translit, $meta_keywords, $meta_description, $page_id, $short_img, $short_text, $text, $visible){
		$id = intval($id);
		$title = mysql_real_escape_string($title);
		$title_translit = mysql_real_escape_string($title_translit);
		$meta_keywords = mysql_real_escape_string($meta_keywords);
		$meta_description = mysql_real_escape_string($meta_description);
		$page_id = intval($page_id);
		$short_img = mysql_real_escape_string($short_img);
		$short_text = mysql_real_escape_string($short_text);
		$text = mysql_real_escape_string($text);
		$visible = intval($visible);
		mysql_query("UPDATE `news` SET `title`='$title', `title_translit`='$title_translit', `meta_keywords`='$meta_keywords', `meta_description`='$meta_description', `page_id`='$page_id', `short_img`='$short_img', `short_text`='$short_text', `text`='$text', `visible`='$visible' WHERE `id`=$id") or die(mysql_error());
	}
	public function newsDelete($id){
		$id = intval($id);
		mysql_query("DELETE FROM `news` WHERE `id` ='$id'") or die(mysql_error());
		if(mysql_affected_rows() > 0){
			return 'deleted';
		}else{
			return 'error';
		}
	}
}

/* Преимущества */
class admin_advantage{
	public function advantageList(){
		$advantageListQuery = mysql_query("SELECT * FROM `advantage`") or die(mysql_error());
		while($advantageListRow = mysql_fetch_assoc($advantageListQuery)){
			$advantageListRow['edit_link'] = SITE_PATH.'admin/advantage_edit/'.$advantageListRow['id'];
			$array[] = $advantageListRow;
		}
		return $array;
	}
	public function advantageAdd($title, $icon, $text){
		$title = mysql_real_escape_string($title);
		$icon = mysql_real_escape_string($icon);
		$text = mysql_real_escape_string($text);
		mysql_query("INSERT INTO `advantage` (`id`, `title`, `text`, `icon`) VALUES (NULL, '$title', '$text', '$icon')") or die(mysql_error());
	}
	public function advantageEdit($id){
		$id = intval($id);
		$advantageQuery = mysql_query("SELECT * FROM `advantage` WHERE `id`='$id'") or die(mysql_error());
		$advantageRow = mysql_fetch_assoc($advantageQuery);
		return $advantageRow;
	}
	public function advantageSave($id, $title, $icon, $text){
		$id = intval($id);
		$title = mysql_real_escape_string($title);
		$icon = mysql_real_escape_string($icon);
		$text = mysql_real_escape_string($text);
		mysql_query("UPDATE `advantage` SET `id`='$id', `title`='$title', `icon`='$icon', `text`='$text' WHERE `id`='$id'") or die(mysql_error());
	}
	public function advantageDelete($id){
		$id = intval($id);
		mysql_query("DELETE FROM `advantage` WHERE `id` ='$id'") or die(mysql_error());
		if(mysql_affected_rows() > 0){
			return 'deleted';
		}else{
			return 'error';
		}
	}
}

/* Статьи */
class admin_article{
	public function articleList(){
		$articleListQuery = mysql_query("SELECT * FROM `articles`") or die(mysql_error());
		while($articleListRow = mysql_fetch_assoc($articleListQuery)){
			$articleListRow['edit_link'] = SITE_PATH.'admin/article_edit/'.$articleListRow['id'];
			$array[] = $articleListRow;
		}
		return $array;
	}
	public function articleAdd($title, $title_translit, $meta_keywords, $meta_description, $short_img, $short_text, $text, $visible){
		$title = mysql_real_escape_string($title);
		$title_translit = mysql_real_escape_string($title_translit);
		$meta_keywords = mysql_real_escape_string($meta_keywords);
		$meta_description = mysql_real_escape_string($meta_description);
		$short_img = mysql_real_escape_string($short_img);
		$short_text = mysql_real_escape_string($short_text);
		$text = mysql_real_escape_string($text);
		$visible = intval($visible);
		$date_add = time();
		mysql_query("INSERT INTO `articles` (`id`, `date_add`, `title`, `title_translit`, `meta_keywords`, `meta_description`, `short_img`, `short_text`, `text`, `visible`) VALUES (NULL, '$date_add', '$title', '$title_translit', '$meta_keywords', '$meta_description', '$short_img', '$short_text', '$text', '$visible');") or die(mysql_error());
	}
	public function articleEdit($id){
		$id=intval($id);
		$articleEditQuery = mysql_query("SELECT `id`,`date_add`,`title`,`meta_keywords`,`meta_description`,`short_img`,`short_text`,`text`,`visible` FROM `articles` WHERE `id`=$id") or die(mysql_error());
		$articleEditRow = mysql_fetch_assoc($articleEditQuery);
		$articleEditRow['date_add'] = date('d.m.Y H:i', $articleEditRow['date_add']);
		return $articleEditRow;
	}
	public function articleSave($id, $title, $meta_keywords, $meta_description, $short_img, $short_text, $text, $visible){
		$id = intval($id);
		$title = mysql_real_escape_string($title);
		$meta_keywords = mysql_real_escape_string($meta_keywords);
		$meta_description = mysql_real_escape_string($meta_description);
		$short_img = mysql_real_escape_string($short_img);
		$short_text = mysql_real_escape_string($short_text);
		$text = mysql_real_escape_string($text);
		$visible = intval($visible);
		mysql_query("UPDATE `articles` SET `title`='$title', `meta_keywords`='$meta_keywords', `meta_description`='$meta_description', `short_img`='$short_img', `short_text`='$short_text', `text`='$text', `visible`='$visible' WHERE `id`=$id") or die(mysql_error());
	}
	public function articleDelete($id){
		$id = intval($id);
		mysql_query("DELETE FROM `articles` WHERE `id` ='$id'") or die(mysql_error());
		if(mysql_affected_rows() > 0){
			return 'deleted';
		}else{
			return 'error';
		}
	}
}

/* Статические страницы */
class admin_static{
	public function staticList(){
		$staticListQuery = mysql_query("SELECT * FROM `static`") or die(mysql_error());
		while($staticListRow = mysql_fetch_assoc($staticListQuery)){
			$staticListRow['edit_link'] = SITE_PATH.'admin/static_edit/'.$staticListRow['id'];
			$array[] = $staticListRow;
		}
		return $array;
	}
	public function staticAdd($title, $title_translit, $meta_keywords, $meta_description, $text, $visible){
		$title = mysql_real_escape_string($title);
		$title_translit = mysql_real_escape_string($title_translit);
		$meta_keywords = mysql_real_escape_string($meta_keywords);
		$meta_description = mysql_real_escape_string($meta_description);
		$text = mysql_real_escape_string($text);
		$visible = intval($visible);
		mysql_query("INSERT INTO `static` (`id`, `title`, `title_translit`, `meta_keywords`, `meta_description`, `text`, `visible`) VALUES (NULL, '$title', '$title_translit', '$meta_keywords', '$meta_description', '$text', '$visible');") or die(mysql_error());
	}
	public function staticEdit($id){
		$id=intval($id);
		$staticEditQuery = mysql_query("SELECT `id`,`title`,`meta_keywords`,`meta_description`,`text`,`visible` FROM `static` WHERE `id`=$id") or die(mysql_error());
		$staticEditRow = mysql_fetch_assoc($staticEditQuery);
		$staticEditRow['date_add'] = date('d.m.Y H:i', $staticEditRow['date_add']);
		return $staticEditRow;
	}
	public function staticSave($id, $title, $title_translit, $meta_keywords, $meta_description, $text, $visible){
		$id = intval($id);
		$title = mysql_real_escape_string($title);
		$title_translit = mysql_real_escape_string($title_translit);
		$meta_keywords = mysql_real_escape_string($meta_keywords);
		$meta_description = mysql_real_escape_string($meta_description);
		$text = mysql_real_escape_string($text);
		$visible = intval($visible);
		mysql_query("UPDATE `static` SET `title`='$title', `title_translit`='$title_translit', `meta_keywords`='$meta_keywords', `meta_description`='$meta_description', `text`='$text', `visible`='$visible' WHERE `id`=$id") or die(mysql_error());
	}
	public function staticDelete($id){
		$id = intval($id);
		mysql_query("DELETE FROM `static` WHERE `id` ='$id'") or die(mysql_error());
		if(mysql_affected_rows() > 0){
			return 'deleted';
		}else{
			return 'error';
		}
	}
}

/* Настройки сайта */
class admin_setting{
	public function viewSetting(){
		$settingListQuery = mysql_query("SELECT * FROM `site_setting`") or die(mysql_error());
		while($settingListRow = mysql_fetch_assoc($settingListQuery)){
			$array = $settingListRow;
		}
		return $array;
	}
	public function editSetting($meta_title, $meta_description, $meta_keywords, $status){
		$meta_title = mysql_real_escape_string($meta_title);
		$meta_description = mysql_real_escape_string($meta_description);
		$meta_keywords = mysql_real_escape_string($meta_keywords);
		$status = mysql_real_escape_string($status);
		$settingEditQuery = mysql_query("UPDATE `site_setting` SET `meta_title`='$meta_title', `meta_description`='$meta_description', `meta_keywords`='$meta_keywords', `site_status`='$status' WHERE `id`=1") or die(mysql_error());
	}
}

/* Отзывы */
class opinions{
	public function getOpinions($page){
		$page = intval($page);
		$opinionPagingQuery = mysql_query("SELECT COUNT(id) AS count FROM opinion WHERE `patern_id`=0") or die(mysql_error());
		$opinionPaging = mysql_result($opinionPagingQuery, 0);
		$opinionPaging = ceil($opinionPaging/20);
		for($i = 1; $i <= $opinionPaging; $i++){
			$array['paging'][$i]['num'] = $i;
			if($i == $page){
				$array['paging'][$i]['current'] = 'yes';
			}else{
				$array['paging'][$i]['current'] = 'no';
			}
		}
		$page = ($page-1)*20;
		$opinionListQuery = mysql_query("SELECT * FROM opinion WHERE `patern_id`=0 ORDER BY `id` DESC LIMIT $page, 20") or die(mysql_error());
		$i=0;
		while($opinionListrow = mysql_fetch_assoc($opinionListQuery)) {
			$answerQuery = mysql_query("SELECT * FROM opinion WHERE `patern_id`='{$opinionListrow['id']}'") or die(mysql_error());
			if(mysql_num_rows($answerQuery) != 0){
				$opinionListrow['moderator'] = 1;
				$answerRow = mysql_fetch_assoc($answerQuery);
				$opinionListrow['answer'] = html_entity_decode($answerRow['text']);
			}else{
				$opinionListrow['moderator'] = 0;
			}
			$opinionListrow['name'] = html_entity_decode($opinionListrow['name']);
			$opinionListrow['text'] = html_entity_decode($opinionListrow['text']);
			$array['list'][] = $opinionListrow;
		}
		// print_r($array);
		return $array;
	}
	public function addOpinion($id){
		$id = intval($id);
		mysql_query("UPDATE opinion SET moderate='1' WHERE `id`='$id'") or die(mysql_error());
		if(mysql_affected_rows() > 0){
			return 'added';
		}else{
			return 'error';
		}
	}
	public function delOpinion($id){
		$id = intval($id);
		mysql_query("DELETE FROM `opinion` WHERE `id`='$id'") or die(mysql_error());
		if(mysql_affected_rows() > 0){
			return 'deleted';
		}else{
			return 'error';
		}
	}
	public function addOpinionAnswer($id, $text){
		$id = intval($id);
		$text = mysql_real_escape_string($text);
		mysql_query("INSERT INTO `opinion` (`id`, `name`, `text`, `moderate`, `page_id`, `date`, `rating`, `patern_id`) VALUES (NULL, 'Анатолий, менеджер СЦ \"Нанобайт\"', '$text', '1', '0', NULL, '0', '$id')") or die(mysql_error());
		if(mysql_affected_rows() > 0){
			return 'added';
		}else{
			return 'error';
		}
	}
}
?>