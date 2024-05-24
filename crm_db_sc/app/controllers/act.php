<?php
class app_controllers_act{
	private $act;
	private $view;
	public function __construct(){
		$this->act = new app_models_act;
		$this->view = new app_view;
	}
	public function reception(){
		$id = $_GET['id'];
		$data = array('data' => $this->act->reception_act($id));
		
		// ==============================================================
		// форматирование телефонов
		// ==============================================================
		function phone_format($phone){
			
			if($phone==""){
				return false;
			}else{
				$phone = str_replace(array('-',' ','(',')','&nbsp;'),'',$phone);
			}
			
			// проверка на недостающие символы
			if(substr($phone,0,2)=="79"){
				$phone = "+".$phone;
			}elseif(substr($phone,0,3)=="380"){
				$phone = "+".$phone;
			}elseif(substr($phone,0,2)=="89"){
				$phone = "+7".substr($phone,1);
			}
			
			
			
			// россия
			if(substr($phone,0,3)=="+79"){
				$p = substr($phone,0,2)." ".substr($phone,2,3)." ".substr($phone,5,3)." ".substr($phone,8,2)." ".substr($phone,10,2);
			
			// казахстан
			}elseif(substr($phone,0,3)=="+77"){
				$p = substr($phone,0,2)." ".substr($phone,2,3)." ".substr($phone,5,3)." ".substr($phone,8,2)." ".substr($phone,10,2);
				
			// украина
			}elseif(substr($phone,0,4)=="+380"){
				$p = substr($phone,0,4)." ".substr($phone,4,2)." ".substr($phone,6,3)." ".substr($phone,9,2)." ".substr($phone,11,2);
				
			// беларусь
			}elseif(substr($phone,0,4)=="+375"){
				$p = substr($phone,0,4)." ".substr($phone,4,2)." ".substr($phone,6,3)." ".substr($phone,9,2)." ".substr($phone,11,2);
			
			// армения
			}elseif(substr($phone,0,4)=="+374"){
				$p = substr($phone,0,4)." ".substr($phone,4,2)." ".substr($phone,6,3)." ".substr($phone,9,2)." ".substr($phone,11,2);
				
			// польша
			}elseif(substr($phone,0,3)=="+44"){
				$p = substr($phone,0,3)." ".substr($phone,3,3)." ".substr($phone,6,3)." ".substr($phone,9,2)." ".substr($phone,11,2);
				
			// все остальные страны
			}else{
				$p = $phone;
			}

			return $p;
		}
		
		// форматируем номер телефона
		$data['data']['cl_phone'] = phone_format($data['data']['cl_phone']);
		
		echo $this->view->display('act-reception', $data);
	}
	public function diagnosis(){
		$id = $_GET['id'];
		$data = array('data' => $this->act->diagnosis_act($id));
		echo $this->view->display('act-diagnosis', $data);
	}
	public function issuing(){
		$id = $_GET['id'];
		$data = array('data' => $this->act->issuing_act($id));
		echo $this->view->display('act-issuing', $data);
	}
}