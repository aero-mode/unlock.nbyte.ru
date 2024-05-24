<?php
class app_controllers_404{
	public function index(){
		header('HTTP/1.1 404 Not Found');
		header("Status: 404 Not Found");
		$view = new app_view();
		echo $view->display('404');
	}
}