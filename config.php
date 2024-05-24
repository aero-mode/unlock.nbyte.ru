<?
define('SITE_PATH', '/');
define('TEMPLATE_DIR', dirname(__FILE__).'/tpl/nano/');
define('TEMPLATE', 'https://'.$_SERVER['HTTP_HOST'].SITE_PATH.'tpl/nano');

define('ADMIN_TEMPLATE_DIR', dirname(__FILE__).'/tpl/admin/');
define('ADMIN_TEMPLATE', 'https://'.$_SERVER['HTTP_HOST'].SITE_PATH.'tpl/admin');

define('DB_HOST', 'localhost');

//define('DB_USER', 'sites');
//define('DB_PASS', 'W7o6T0m5');
//define('DB_NAME', 'nanobyte-site');
define('DB_USER', 'u0363988_nbyte');
define('DB_PASS', '6C6q4C9j');
define('DB_NAME', 'u0363988_nanobyte');

define('CHARSET', 'utf8');
date_default_timezone_set('Europe/Moscow');

error_reporting(0);