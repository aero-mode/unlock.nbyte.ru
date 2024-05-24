<? 
class site_setting{
	public function site_settings(){
		$settingQuery = mysql_query("SELECT * FROM `site_setting`") or die(mysql_error());
		while($settingRow = mysql_fetch_assoc($settingQuery)){
			$array = $settingRow;
		}
		return $array;
	}
}
class news{
	public function getShortNews($limit = 0, $id = 0){
		$limit = intval($limit);
		$id = intval($id);
		($limit > 0)?$limit = "LIMIT 0, $limit":$limit = "";
		($id != 0)?$where = "WHERE `page_id`=$id":$where = "";
		$shortNews = mysql_query("SELECT * FROM `news` $where ORDER BY `id` DESC $limit") or die(mysql_error());
		while($row = mysql_fetch_assoc($shortNews)){
			$row['link'] = SITE_PATH.'news/'.$row['id'].'-'.$row['title_translit'].'.html';
			$array[] = $row;
		}
		return $array;
	}
	public function getFullNews($id, $tit){
		$id = intval($id);
		$fullNews = mysql_query("SELECT * FROM `news` WHERE `id`='$id'");
		$numRows = mysql_num_rows($fullNews);
		if($numRows == 0){return NULL;}
		while($row = mysql_fetch_assoc($fullNews)){
			$array = $row;
		}
		if($tit != $array['title_translit']){
			$true_link['true_link'] = 'true';
			$true_link['link'] = SITE_PATH.'news/'.$array['id'].'-'.$array['title_translit'].'.html';
			return $true_link;
		}
		return $array;
	}
}
class articles{
	public function getShortArticle($limit = 0){
		$limit = intval($limit);
		($limit > 0)?$limit = "LIMIT 0, $limit":$limit = "";
		$shortNews = mysql_query("SELECT * FROM `articles` ORDER BY `id` DESC $limit") or die(mysql_error());
		while($row = mysql_fetch_assoc($shortNews)){
			$row['link'] = SITE_PATH.'articles/'.$row['id'].'-'.$row['title_translit'].'.html';
			$array[] = $row;
		}
		return $array;
	}
	public function getFullArticle($id, $tit){
		$id = intval($id);
		$fullArticless = mysql_query("SELECT * FROM `articles` WHERE `id`='$id'");
		$numRows = mysql_num_rows($fullArticless);
		if($numRows == 0){return NULL;}
		while($row = mysql_fetch_assoc($fullArticless)){
			$array = $row;
		}
		if($tit != $array['title_translit']){
			$true_link['true_link'] = 'true';
			$true_link['link'] = SITE_PATH.'articles/'.$array['id'].'-'.$array['title_translit'].'.html';
			return $true_link;
		}
		return $array;
	}
}
class page{
	public function getShortPage($limit, $page_id = 0){
		$limit = intval($limit);
		($page_id > 0)?$cat_id = "`page`.`cat` = (SELECT `page`.`cat` FROM `page` WHERE `page`.`id` = $page_id) AND":$cat_id = "";
		$shortPageQueryText = "SELECT `page`.`id`, `page`.`cat_icon`, `page`.`title`, `page`.`title_translit`, `page`.`visible`, `page`.`cat`, `cat`.`name_eng`, `cat`.`name` FROM `page`, `cat` WHERE $cat_id `cat`.`id` = `page`.`cat` AND `page`.`visible` = '1' ORDER BY `page`.`views` DESC LIMIT 0, $limit";
		$shortPageQuery = mysql_query($shortPageQueryText);
		while($shortPageRow = mysql_fetch_assoc($shortPageQuery)){
			$shortPageRow['link'] = SITE_PATH.$shortPageRow['cat'].'-'.$shortPageRow['name_eng'].'/'.$shortPageRow['id'].'-'.$shortPageRow['title_translit'].'.html';
			$array[] = $shortPageRow;
		}
		// print_r($array);
		return $array;
	}
	public function getFullPage($id, $tit){
		$id = intval($id);
		$fullPage = mysql_query("SELECT `page`.`id`, `page`.`cat_icon`, `page`.`title`, `page`.`title_translit`, `page`.`meta_keywords`, `page`.`meta_description`, `page`.`page_slogan`, `page`.`text_price`, `page`.`text`, `page`.`cat`, `page`.`advantage`, `page`.`price`, `page`.`price_hard`, `page`.`time_work`, `page`.`views`, `cat`.`name_eng`, `cat`.`name` FROM `page`, `cat` WHERE `page`.`id`='$id' AND `cat`.`id` = `page`.`cat`");
		$numRows = mysql_num_rows($fullPage);
		if($numRows == 0){return NULL;}
		while($row = mysql_fetch_assoc($fullPage)){
			$opinionsRow = mysql_query("SELECT COUNT(*) as `count` FROM `opinion` WHERE page_id='{$row['id']}' and `moderate`='1'") or die(mysql_error());
			$row['opinions'] = mysql_result($opinionsRow, 0);
			$advantages = explode(';', $row['advantage']);
			foreach($advantages as $advantage){
				$advantageQuery =  mysql_query("SELECT `title`, `icon`, `text` FROM `advantage` WHERE `id`=$advantage");
				while($advantageRow = mysql_fetch_assoc($advantageQuery)){
					$row['advantages'][] = $advantageRow;
				}
			}
			$array = $row;
		}
		if($tit != $array['title_translit']){
			$true_link['true_link'] = 'true';
			$true_link['link'] = SITE_PATH.$array['cat'].'-'.$array['name_eng'].'/'.$array['id'].'-'.$array['title_translit'].'.html';
			return $true_link;
		}
		return $array;
	}
	public function setViews($id, $views){
		$id = intval($id);
		$views = intval($views);
		$views = $views+1;
		$_SESSION['views'] = '1';
		mysql_query("UPDATE `page` SET `views`='$views' WHERE `id`='$id'");
	}
}
class category{
	public function getCategory($id, $tit){
		$id = intval($id);
		$catQuery = mysql_query("SELECT * FROM cat WHERE id='$id'");
		$array['cat_content'] = mysql_fetch_assoc($catQuery);
		if($tit != $array['cat_content']['name_eng']){
			$true_link['true_link'] = 'true';
			$true_link['link'] = SITE_PATH.$array['cat_content']['id'].'-'.$array['cat_content']['name_eng'].'/';
			return $true_link;
			// print_r($true_link);
		}else{
			$shortPageQuery = mysql_query("SELECT `id`, `cat_icon`, `title`, `title_translit`, `visible`, `cat`, `price` FROM `page` WHERE `cat` = $id AND `page`.`visible` = '1'");
			$numRows = mysql_num_rows($shortPageQuery);
			if($numRows == 0){return NULL;}
			while($categoryRow = mysql_fetch_assoc($shortPageQuery)){
				$opinionsRow = mysql_query("SELECT COUNT(*) as `count` FROM `opinion` WHERE page_id={$categoryRow['id']} and `moderate`='1'") or die(mysql_error());
				$categoryRow['opinions'] = mysql_result($opinionsRow, 0);
				$categoryRow['link'] = SITE_PATH.$array['cat_content']['id'].'-'.$array['cat_content']['name_eng'].'/'.$categoryRow['id'].'-'.$categoryRow['title_translit'].'.html';
				$array['short_pages'][] = $categoryRow;
			}	
			// print_r($array);
			return $array;
		}
	}
}
class statics{
	public function getStatic($id, $tit){
		$id = intval($id);
		$staticPageQuery = mysql_query("SELECT * FROM `static` WHERE `id`=$id");
		$numRows = mysql_num_rows($staticPageQuery);
		if($numRows == 0){return NULL;}
		while($staticPageRow = mysql_fetch_assoc($staticPageQuery)){
			$staticPageRow['link'] = SITE_PATH.$staticPageRow['id'].'-'.$staticPageRow['title_translit'].'.html';
			$array = $staticPageRow;
		}
		if($tit != $array['title_translit']){
			$true_link['true_link'] = 'true';
			$true_link['link'] = SITE_PATH.$array['id'].'-'.$array['title_translit'].'.html';
			return $true_link;
		}
		return $array;
	}
}
class opinions{
	public function getOpinions($page_id, $page){
		$page = intval($page);
		$page_id = intval($page_id);
		$rating = array( '1' => 'Оценка: Очень плохо', '2' => 'Оценка: Плохо', '3' => 'Оценка: Нормально', '4' => 'Оценка: Хорошо', '5' => 'Оценка: Очень хорошо');
		$cur_page = $page;
		$page -= 1;
		$per_page = 5;
		$previous_btn = true;
		$next_btn = true;
		$first_btn = true;
		$last_btn = true;
		$start = $page * $per_page;
		$result_pag_data = mysql_query("SELECT * FROM opinion WHERE `moderate`='1' AND `page_id`='$page_id' AND `patern_id`='0' ORDER BY `id` DESC LIMIT $start, $per_page") or die('MySql Error' . mysql_error());
		$msg['opinions'] = array();
		while ($row = mysql_fetch_assoc($result_pag_data)) {
			$zapros6 = mysql_query("SELECT * FROM `opinion` WHERE `patern_id`='{$row['id']}'");
			if(mysql_num_rows($zapros6)!=0){
				if($row['date'] != null){
					$row['date'] = date('d.m.Y H:i', $row['date']);
				}else{
					$row['date'] = '';
				}
				$row['name'] = html_entity_decode($row['name']);
				$row['text'] = html_entity_decode($row['text']);
				$row['rating'] = $rating[$row['rating']];
				$msg['opinions'][$i] = $row;
				$msg['opinions'][$i]['moderator'] = 0;
				$i++;
				$msg['opinions'][$i] = mysql_fetch_assoc($zapros6);
				$msg['opinions'][$i]['rating'] = $rating[$msg['opinions'][$i]['rating']];
				$msg['opinions'][$i]['moderator'] = 1;
				$i++;
			}else{
				if($row['date'] != null){
					$row['date'] = date('d.m.Y H:i', $row['date']);
				}else{
					$row['date'] = '';
				}
				$row['rating'] = $rating[$row['rating']];
				$row['name'] = html_entity_decode($row['name']);
				$row['text'] = html_entity_decode($row['text']);
				$msg['opinions'][$i] = $row;
				$msg['opinions'][$i]['moderator'] = 0;
				$i++;
			}
		}
		
		/* --------------------------------------------- */
		$query_pag_num = "SELECT COUNT(*) AS count FROM opinion WHERE `moderate`='1' AND `page_id`='$page_id' AND `patern_id`='0'";
		$result_pag_num = mysql_query($query_pag_num);
		$row = mysql_fetch_array($result_pag_num);
		$count = $row['count'];
		$no_of_paginations = ceil($count / $per_page);
			/* ---------------Calculating the starting and ending values for the loop----------------------------------- */
		if ($cur_page >= 7) {
			$start_loop = $cur_page - 3;
			if ($no_of_paginations > $cur_page + 3)
				$end_loop = $cur_page + 3;
			else if ($cur_page <= $no_of_paginations && $cur_page > $no_of_paginations - 6) {
				$start_loop = $no_of_paginations - 6;
				$end_loop = $no_of_paginations;
			} else {
				$end_loop = $no_of_paginations;
			}
		} else {
			$start_loop = 1;
			if ($no_of_paginations > 7)
				$end_loop = 7;
			else
				$end_loop = $no_of_paginations;
		}
		/* ----------------------------------------------------------------------------------------------------------- */
		if($no_of_paginations > 1){
			$msg['paginations'] = 1;
			for ($i = $start_loop; $i <= $end_loop; $i++) {
				if ($cur_page == $i){
					$msg['page'][$i]['page'] = $i;
					$msg['page'][$i]['active'] = 1;
				}else{
					$msg['page'][$i]['page'] = $i;
					$msg['page'][$i]['active'] = 0;
				}
			}
		}else{
			$msg['paginations'] = 0;
		}
		// print_r($msg);
		return $msg;
	}
	
	public function addOpinion($page_id, $opinion_name, $rating, $opinion_text){
		$page_id = intval($page_id);
		$opinion_name = mysql_real_escape_string($opinion_name);
		$rating = intval($rating);
		$opinion_text  = mysql_real_escape_string($opinion_text);
		$date = time();
		mysql_query("INSERT INTO `opinion` (`id`, `name`, `text`, `moderate`, `page_id`, `date`, `rating`, `patern_id`) VALUES (NULL, '$opinion_name', '$opinion_text', '0', '$page_id', $date, '$rating', '0')");
		if(mysql_affected_rows() > 0){
			return 'added';
		}else{
			return 'error';
		}
	}
}
class advantages{
	public function getAdvantage($advantages){
		//$advantages = explode(';', $advantages);
		foreach($advantages as $advantage){
			$advantageQuery =  mysql_query("SELECT `title`, `icon`, `text` FROM `advantage` WHERE `id`=$advantage");
			while($advantageRow = mysql_fetch_assoc($advantageQuery)){
				$row[] = $advantageRow;
			}
		}
		return $row;
	}
}
class timer{
	public function setTimer(){
		$now =date('G');
			$time = time();
			$hour = date('G', $time);
			$min = date('i', $time);
			$min = 60-$min;
			$sec = date('s', $time);
			$sec = 60-$sec;
			if($now>=18 || $now<9){
				$limit = 54000;
				$colorLeft = "#008000";
				$colorRight = "#FF0000";
				$dataStart = date("d F Y");
				$dataStart = strtotime($dataStart."19:00:00");
				$current = time()-$dataStart;
				switch($hour){
					case 18:
						$hours = 14;
						$hour_text = 'часов';
						break;
					case 19:
						$hours = 13;
						$hour_text = 'часов';
						break;
					case 20:
						$hours = 12;
						$hour_text = 'часов';
						break;
					case 21:
						$hours = 11;
						$hour_text = 'часов';
						break;
					case 22:
						$hours = 10;
						$hour_text = 'часов';
						break;
					case 23:
						$hours = 9;
						$hour_text = 'часов';
						break;
					case 0:
						$hours = 8;
						$hour_text = 'часов';
						break;
					case 1:
						$hours = 7;
						$hour_text = 'часов';
						break;
					case 2:
						$hours = 6;
						$hour_text = 'часов';
						break;
					case 3:
						$hours = 5;
						$hour_text = 'часов';
						break;
					case 4:
						$hours = 4;
						$hour_text = 'часа';
						break;
					case 5:
						$hours = 3;
						$hour_text = 'часа';
						break;
					case 6:
						$hours = 2;
						$hour_text = 'часа';
						break;
					case 7:
						$hours = 1;
						$hour_text = 'час';
						break;
					case 8:
						$hours = 0;
						$hour_text = 'часов';
						break;
				}
				$timer_title = "Мы откроемся через:";
			}else{
				$limit = 36400;
				$colorLeft = "#FF0000";
				$colorRight = "#008000";
				$dataStart = date("d F Y");
				$dataStart = strtotime($dataStart."09:00:00");
				$current = time()-$dataStart;
				$hours = 17-$hour;
				$timer_title = "До конца рабочего дня осталось:";
			}
			$hour_text = array("час", "часа", "часов");
			$minute_text = array("минута", "минуты", "минут");
			$second_text = array("секунда", "секунды", "секунд");
				function getWord($number, $suffix) {
					$keys = array(2, 0, 1, 1, 1, 2);
					$mod = $number % 100;
					$suffix_key = ($mod > 7 && $mod < 20) ? 2: $keys[min($mod % 10, 5)];
					return $suffix[$suffix_key];
				}
		$eee = $current;
		$return = array("hours"=>$hours, "min"=>$min, "sec"=>$sec, "timer_title"=>$timer_title, "colorRight"=>$colorRight, "colorLeft"=>$colorLeft, "eee"=>$eee, "limit"=>$limit);
		return $return;
	}
}
?>