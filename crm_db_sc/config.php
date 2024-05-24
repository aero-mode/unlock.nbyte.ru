<?php
// ini_set('display_errors', 0);
// error_reporting(E_ALL ^ E_NOTICE);
define('SID', session_id());
define('SITE_PATH', '/crm_db_sc');
define('SITE', 'http://'.$_SERVER['HTTP_HOST'].SITE_PATH);
define('THEME', 'old');
define('TEMPLATE_DIR', dirname(__FILE__).'/tpl/'.THEME.'/');
define('TEMPLATE', 'http://'.$_SERVER['HTTP_HOST'].SITE_PATH.'/tpl/'.THEME);
define('DB_HOST', 'localhost');
define('DB_USER', 'u0363988_nbyte');
define('DB_PASS', '6C6q4C9j');
define('DB_NAME', 'u0363988_crm_sc');
define('DB_CHAR', 'utf8');

include(dirname(__FILE__).'/lib/autoload.php');
autoloadRegister();

if($_SERVER['REQUEST_URI'] != SITE_PATH.'/login/'){	
	
	$login = new app_controllers_login();	
	
	if(!$login->checkLogin()){		
		header('Location: '.SITE_PATH.'/login/');
		die();
		
	}elseif($_SERVER['REQUEST_URI'] == '/'){
		
		header('Location: '.SITE_PATH.'/'.$_SESSION['us_role'].'/');
		die();
	}
}
app_route::run();