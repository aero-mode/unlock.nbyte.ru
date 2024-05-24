<?php
class app_controllers_operator{
	public function index(){
		$listO = new app_models_operator();
		$data = new app_models_data;
		$header_stat = new app_models_stats();
		$echo = array(
			'data' => $listO->get_list(),
			'header_stat' => $header_stat->header_stats(),
			'devices' => $data->get_devices(),
			'current_active' => $data->current_active(),
			'today_tasks' => $data->today_tasks(),
			'link' => 'main'			
		);
		$view = new app_view();
		echo $view->display('operator', $echo);
	}
	public function edit(){
		if($_SERVER['REQUEST_METHOD'] == 'GET'){
			$id = $_GET['id'];			
			
			// zak
			if(!isset($_GET['zak'])){
				include($_SERVER['DOCUMENT_ROOT']."/crm_db_sc/zak/edit.php");
			}else{
				$editO = new app_models_operator();
				$data = array('data' => $editO->edit_task($id));
				$view = new app_view();
				echo $view->display('operator-edit', $data);	
			}			
			
		}
		elseif($_SERVER['REQUEST_METHOD'] == 'POST')
		{
			$data = $_POST;
			$edit = new app_models_operator();
			$save = $edit->edit_save($data);
			if($save)
				header('Location:'.SITE_PATH.'/operator/');
			else
				die('ni');
		}
	}
	public function search(){
		$pattern = $_GET['value'];
		$list = new app_models_operator();
		$header_stat = new app_models_stats();
		$data = array('data' => $list->search($pattern), 'header_stat' => $header_stat->header_stats(), 'search_value' => $pattern);
		$view = new app_view();
		echo $view->display('operator', $data);
	}
	public function client(){
		$id = $_GET['cl_id'];
		$list = new app_models_operator();
		$header_stat = new app_models_stats();
		$data = array('data' => $list->client_request($id), 'header_stat' => $header_stat->header_stats(), 'add_for_client' => '?for_cl_id='.$_GET['cl_id']);
		$view = new app_view();
		echo $view->display('operator', $data);
	}
	public function pay(){
		$pay = new app_models_operator();
		$result = $pay->pay_task($_GET['id']);
		header("Content-Type: application/json");
		echo json_encode($result);
	}
	public function add(){
		$data = new app_models_data;
		if($_SERVER['REQUEST_METHOD'] == 'GET'){
			
			// zak
			if(!isset($_GET['zak'])){
				include($_SERVER['DOCUMENT_ROOT']."/crm_db_sc/zak/add.php");
			}else{				
				$data = array('devices' => $data->get_devices(), 'find_outs' => $data->get_find_out(), 'comp_parts' => $data->get_comp_parts());
				$view = new app_view();
				echo $view->display('operator-add', $data);
			}
		}
		elseif($_SERVER['REQUEST_METHOD'] == 'POST')
		{
			$addO = new app_models_operator();
			$id = $addO->add_task($_POST);
			header("Content-Type: application/json");
			echo json_encode($id);
		}
	}
}