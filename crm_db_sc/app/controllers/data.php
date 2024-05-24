<?php
class app_controllers_data{
	public function get_clients(){
		$listO = new app_models_data();
		$list = $listO->get_clients($_GET['term']);
		//print_r($list);
		echo json_encode($list);
	}
	public function get_devices(){

	}
	public function get_find_out(){

	}
	public function get_statuses(){

	}
}