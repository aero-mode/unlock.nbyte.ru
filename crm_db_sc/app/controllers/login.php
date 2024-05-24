<?php
class app_controllers_login{
	public function index(){
		if($_SERVER['REQUEST_METHOD'] == 'GET'){
			$view = new app_view();
			echo $view->display('login');
		}elseif($_SERVER['REQUEST_METHOD'] == 'POST'){
			$login = new app_models_login();
			$auth = $login->authorization($_POST['user_name'], $_POST['user_pass']);
			if($auth){
				header('Location: '.SITE_PATH.'/'.$auth['us_role'].'/');
				die();
			}else{
				header('Location: '.SITE_PATH.'/login/');
				die();
			}
		}else{
			header('Location:'.SITE_PATH.'/login/');
			die();
		}
	}
	public function checkLogin(){
		$login = new app_models_login();
		$check = $login->checkLogin($_SESSION['us_id']);
		return $check;
	}
	public function logout(){
		$login = new app_models_login();
		$login->logout();
	}
}