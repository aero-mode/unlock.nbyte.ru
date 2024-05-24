<?
$page = array(
	'1' => '/1-remont-noutbukov/1-zamena-ekrana-matritsi-v-noutbuke.html',
	'4' => '/1-remont-noutbukov/4-remont-ili-zamena-videokarti-v-noutbuke.html',
	'6' => '/1-remont-noutbukov/6-remont-ili-zamena-klaviaturi-v-noutbuke.html',
	'8' => '/1-remont-noutbukov/8-remont-ili-zamena-zaryadnogo-ustroystva-noutbuka.html',
	'11' => '/1-remont-noutbukov/11-zamena-usb-portov-gnezda-zu-shleyfa-matritsi-v-noutbuke.html',
	'12' => '/1-remont-noutbukov/12-remont-ili-zamena-gestkogo-diska-v-noutbuke.html',
	'13' => '/1-remont-noutbukov/13-chistka-ot-pili-i-zamena-termopasti-v-noutbuke.html',
	'14' => '/1-remont-noutbukov/14-remont-ili-zamena-sistemi-ohlagdeniya-v-noutbuke.html',
	'17' => '/1-remont-noutbukov/17-zamena-korpusnih-detaley-petel-v-noutbuke.html',
	'18' => '/1-remont-noutbukov/18-zamena-batarei-v-noutbuke.html',
	'22' => '/1-remont-noutbukov/22-apgreyd-noutbukov.html',
	'23' => '/1-remont-noutbukov/23-remont-materinskoy-plati-v-noutbuke.html',
	'69' => '/1-remont-noutbukov/69-diagnostika-noutbuka-poisk-apparatnoy-neispravnosti.html',
	'41' => '/2-remont-planshetov/41-razblokirovka-apple-ustroystv.html',
	'42' => '/2-remont-planshetov/42-nastroyka-apple-ustroystv.html',
	'43' => '/2-remont-planshetov/43-remont-apple-ustroystv.html',
	'44' => '/3-remont-smartfonov/44-razblokirovka-android-ustroystv.html',
	'45' => '/3-remont-smartfonov/45-nastroyka-android-ustroystv.html',
	'46' => '/3-remont-smartfonov/46-remont-android-ustroystv.html',
	'50' => '/4-remont-pk/50-remont-ili-zamena-materinskoy-plati-na-kompyutere.html',
	'51' => '/4-remont-pk/51-remont-ili-zamena-videokarti-na-kompyutere.html',
	'52' => '/4-remont-pk/52-remont-ili-zamena-operativnoy-pamyati-na-kompyutere.html',
	'53' => '/4-remont-pk/53-remont-ili-zamena-gestkogo-diska-na-kompyutere.html',
	'54' => '/4-remont-pk/54-zamena-setevoy-karti-na-kompyutere.html',
	'55' => '/4-remont-pk/55-chistka-ot-pili-i-zamena-termopasti-na-kompyutere.html',
	'56' => '/4-remont-pk/56-zamena-dvd-privoda-na-kompyutere.html',
	'58' => '/4-remont-pk/58-obnovlenie-proshivki-bios-matplati-na-kompyutere.html',
	'59' => '/4-remont-pk/59-diagnostika-kompyutera-poisk-aparatnoy-neispravnosti.html',
	'60' => '/4-remont-pk/60-remont-ili-zamena-korpusa-pk.html',
	'61' => '/4-remont-pk/61-remont-ili-zamena-bloka-pitaniya-na-kompyutere.html',
);

if(isset($_GET['id'])){
	$id = intval($_GET['id']);
	if(array_key_exists($id, $page)){
		header('HTTP/1.1 301 Moved Permanently');
		header ('Location: '.$page[$id]);
	}else{
		header("Location: /404.html");
	}
}else{
	header('HTTP/1.1 301 Moved Permanently');
	header ('Location: /');
}
?>