<?php
function autoload($classname){
	if(strpos($classname, 'go\DB') === 0){
		$localname = substr($classname, strlen('go\DB'));
		$filename = __DIR__.'/goDB'.str_replace('\\', '/', $localname.'.php');
		if (!file_exists($filename)) {
			return false;
		}
		require_once($filename);
		return class_exists($classname, false);
	}elseif(strpos($classname, 'Twig') === 0){
		$filename = dirname(__FILE__).'/'.str_replace(array('_', "\0"), array('/', ''), $classname).'.php';
		if (!file_exists($filename)) {
			return false;
		}
		require_once($filename);
		return true;
	}else{
		$filename=str_replace("_", "/", $classname).'.php';
		if (!file_exists($filename)) {
			return false;
		}
		require_once($filename);
		return true;
	}
}
function autoloadRegister(){
	spl_autoload_register('autoload');
}