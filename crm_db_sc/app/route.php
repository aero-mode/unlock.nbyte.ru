<?php
class app_route{
	private static $controllerDir = 'app_controllers_';
	static function run(){
		$controllerName = 'index';
		$actionName = 'index';
		$controller = null;
		
		// вырезаем папку
		$_SERVER['REQUEST_URI'] = str_replace('/crm_db_sc', '', $_SERVER['REQUEST_URI']);
		
		$routes = explode('/', $_SERVER['REQUEST_URI']);
		
		if(!empty($routes[1])){
			$controllerName = $routes[1];
		}
		if(!empty($routes[2])){
			$actionName = $routes[2];
		}
		$controllerName = self::$controllerDir.$controllerName;
		if(class_exists($controllerName)){
			$controller = new $controllerName();
		}else{
			app_route::error404();
		}
		if(method_exists($controller, $actionName)){
			$controller->$actionName();
		}else{
			app_route::error404();
		}
	}
	static function error404(){
		$host = 'http://'.$_SERVER['HTTP_HOST'].'/';
		header('HTTP/1.1 404 Not Found');
		header("Status: 404 Not Found");
		header('Location:'.$host.'404/');
	}
}