<?php
class app_model{
	public static function base(){
		$params = array(
			'host'     => DB_HOST,
			'username' => DB_USER,
			'password' => DB_PASS,
			'dbname'   => DB_NAME,
			'charset'  => DB_CHAR,
		);
		return go\DB\DB::create($params, 'mysql');
	}
}