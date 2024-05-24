<?php
class app_models_login extends app_model{
	/*
	public function authorization($username, $userpass){
		$sql = "SELECT us_id, us_login, us_sid, us_role FROM users WHERE us_login = ? AND us_pass = ? AND us_enabled = 1";
		$salt = substr(md5($userpass), 0, 10);
		$pass = md5(md5($userpass).md5($salt));
		$login = $this->base()->query($sql, array($username, $pass));
		$login = $login->row();
		if($login){
			$_SESSION = array_merge($_SESSION, $login);
			$sql = "UPDATE users SET us_sid = ? WHERE us_id = ?i";
			$this->base()->query($sql, array(session_id(), $login['us_id']));
			setcookie('PHPSESSID', SID, time()+3600);
			return $login;
		}else{
			return false;
		}
	}
	*/
	
	public function authorization($username, $userpass){
		
		$sql = "SELECT us_id, us_login, us_sid, us_role FROM users WHERE us_login = ? AND us_pass = ? AND us_enabled = 1";
		$login = $this->base()->query($sql, array($username, $userpass));
		$login = $login->row();
		
		if($login){
			$_SESSION = array_merge($_SESSION, $login);
			$sql = "UPDATE users SET us_sid = ? WHERE us_id = ?i";
			$this->base()->query($sql, array(session_id(), $login['us_id']));
			setcookie('PHPSESSID', SID, time()+3600);
			return $login;
		}else{
			return false;
		}
	}
	
	public function checkLogin($us_id){
		$sql = "SELECT us_sid FROM users WHERE us_id = ?i";
		$sql_sid = $this->base()->query($sql, array($us_id), 'el');
		if(SID === $sql_sid){
			return true;
		}else{
			return false;
		}
	}
	public function logout() {
		session_destroy();
		header('Location: '.SITE_PATH.'/login/');
		die();
	}
}