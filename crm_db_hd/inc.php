<?php
function connect() {
	$hostname="localhost";
	
	//$user="hdd_user";
	//$password="4N0k1P4r";
	//$db="hdd";	
	$user="u0363988_nbyte";
	$password="6C6q4C9j";
	$db="u0363988_crm_hd";

	mysql_connect ($hostname,$user,$password) OR DIE("Извините, сервер перегружен. Попробуйте через несколько минут..");
	mysql_select_db ($db);

	
	mysql_query ("set character_set_client='utf8'");
	mysql_query ("set character_set_results='utf8'");
	mysql_query ("set collation_connection='utf8_general_ci'");
	
}

function date_s($a){
	$d = substr($a,6,2);
	$m = substr($a,4,2);
	$y = substr($a,0,4);
	
	if(substr($d,0,1)=='0'){$d=substr($d,1,1);}
	
	if($m=='01'){$m2="января";}
	if($m=='02'){$m2="февраля";}
	if($m=='03'){$m2="марта";}
	if($m=='04'){$m2="апреля";}
	if($m=='05'){$m2="мая";}
	if($m=='06'){$m2="июня";}
	if($m=='07'){$m2="июля";}
	if($m=='08'){$m2="августа";}
	if($m=='09'){$m2="сентября";}
	if($m=='10'){$m2="октября";}
	if($m=='11'){$m2="ноября";}
	if($m=='12'){$m2="декабря";}
	
	return $d." ".$m2;
}

function clear($str) {
	if(isset($str)){
		$str = trim($str);								// вырезаем пробелы по краям
		$str = substr($str,0,50000);					// обрезаем до 50000 символов
	}else{
		$str="";
	}
	return $str;
}

function footer(){?>
	<div itemscope itemtype="http://schema.org/Organization" style="border-top:2px solid #cccccc;padding-top:10px;padding-bottom:10px;width:990px;margin:0 auto;margin-top:30px;">
		<div class="company" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
			© 2012-2013, <span itemprop="name">Нанобайт</span><br>
			<a href="mailto:remonthddbox@gmail.com"><span itemprop="email">remonthddbox@gmail.com</span></a>
		</div>
		
		<div class="telephone" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
			Телефоны: <span itemprop="telephone">(066) 07-07-222</span>, <span itemprop="telephone">(093) 69-111-65</span>, <span itemprop="telephone">(098) 0-222-948</span>.<br>
			С 9 до 19, без выходных.
		</div>

		<div class="address" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
			Адрес: 
			<span itemprop="addressRegion">Крым</span>, 
			<span itemprop="addressLocality">г. Симферополь</span>, 
			<span itemprop="streetAddress">ул. Павленко, 15/72</span>.
		</div>

	</div>
	<div id="SITEHELP_CONTAINER_3539" class="SITEHELP_CONTAINER_3539"></div>
	<div style="cursor: pointer;position:fixed;right:0;top:0;">
		<a href="promotion.php"><img src="img/promotion.png" width="120" height="120" /></a>
	</div>

<!-- Yandex.Metrika counter -->
<script type="text/javascript">
(function (d, w, c) {
    (w[c] = w[c] || []).push(function() {
        try {
            w.yaCounter18143200 = new Ya.Metrika({id:18143200, enableAll: true, webvisor:true});
        } catch(e) { }
    });
    
    var n = d.getElementsByTagName("script")[0],
        s = d.createElement("script"),
        f = function () { n.parentNode.insertBefore(s, n); };
    s.type = "text/javascript";
    s.async = true;
    s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

    if (w.opera == "[object Opera]") {
        d.addEventListener("DOMContentLoaded", f, false);
    } else { f(); }
})(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="//mc.yandex.ru/watch/18143200" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->
<script type="text/javascript" language="javascript"> document.write('<scri' + 'pt type="text/javas' + 'cript" language="javas' + 'cript" src="' + top.location.protocol + '//c.sitehelp.inkiev.net/code.cgi?c=3539' + (top.location.protocol=='http:' ? '' : '&ssl=1') + '&rnd=' + Math.random() + '"></sc' + 'ript>'); </script>
<?}

function header_info(){?>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name='yandex-verification' content='5e43b33a570ef53b' />
	<link rel="icon" href="/favicon.ico" type="image/x-icon" /> 
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />

	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link href="css/menu.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="script/fancybox/jquery.fancybox-1.3.4.css" media="screen" />
	
	<script type='text/javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js'></script>
	<script type="text/javascript" src="script/jquery.maskedinput.js"></script>
	<script type='text/javascript' src='script/fancybox/jquery.fancybox-1.3.4.pack.js'></script>
	<script type='text/javascript' src='script/fancybox.js'></script>

	<script type="text/javascript">
	 var _gaq = _gaq || [];
	 _gaq.push(['_setAccount', 'UA-30536313-1']);
	 _gaq.push(['_trackPageview']);

	 (function() {
	   var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	   ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	   var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	 })();
	</script>
<?}

function title_description_keywords($page = NULL, $id = NULL){
	if($id !== NULL && $page !== NULL){
		$zapros = mysql_query("SELECT * FROM $page WHERE id=$id"); 
		$r = mysql_fetch_array($zapros);
		?>
		<title><?echo $r['title']?> / Восстановление данных с любых носителей. Ремонт hdd, винчестеров, жестких дисков в Украине.</title>
		<meta name="description" content="<?echo $r['meta_description']?>">
		<meta name="keywords" content="<?echo $r['meta_keywords']?>">
	<?}
	else{
		?>
			<title>Восстановление данных с любых носителей. Ремонт hdd, винчестеров, жестких дисков в Украине.</title>
			<meta name="description" content="Восстановление данных с любых носителей. Ремонт hdd, винчестеров, жестких дисков в Украине. Сервис-центр «Нанобайт». Работаем по всей Украине.">
			<meta name="keywords" content="Восстановление данных с жёсткого диска, восстановление данных с usb жёсткого диска, восстановление данных с флешки, ремонт жёсткого диска">
		<?

	}
}
?>