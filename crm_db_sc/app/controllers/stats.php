<?php
class app_controllers_stats{
	public function index(){
		$stat = new app_models_stats();
		$view = new app_view();
		if($_SERVER['REQUEST_METHOD'] == 'POST'){
			$month = $_POST['date'];
			$data = array('data' => $stat->stats($month), 'month' => $stat->getMonthName($month));
			echo $view->display('stat-post', $data);
		}else{
			$month = date('Y-m');
			$data = array('data' => $stat->stats($month), 'month' => $stat->getMonthName($month));
			echo $view->display('stat', $data);
		}
	}
	public function header_stat(){
		$stat = new app_models_stats();
		print_r($stat->header_stats());
	}
}