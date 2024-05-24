<?php
class app_models_operatorfull extends app_model{
	public function get_list(){
		$sql = "SELECT ta.*, cl.*, de.*, fi.*, st.* FROM tasks ta\n"
				."LEFT JOIN clients cl ON cl.cl_id = ta.ta_cl_id\n"
				."LEFT JOIN devices de ON de.de_id = ta.ta_de_id\n"
				."LEFT JOIN find_out fi ON fi.fi_id = ta.ta_fi_id\n"
				."LEFT JOIN statuses st ON st.st_id = ta.ta_st_id\n"
				."WHERE ta.ta_show = 1 AND ta.ta_st_id = 4\n"
				."AND cl.cl_phone LIKE '+79%' AND cl.cl_id != 13 ORDER BY ta.ta_date_add ASC";
		$list = $this->base()->query($sql, array());
		$List = $list->assoc();
		foreach($List as $id => $item){
			$List[$id]['cl_phone'] = preg_replace("/(\+7)(\d{3})(\d{3})(\d{2})(\d{2})/i","\$1(\$2) \$3-\$4-\$5",$item['cl_phone']);
			$List[$id]['ta_what_to_do'] = str_replace("\r\n", "<br>", $item['ta_what_to_do']);
			$List[$id]['ta_what_is_done'] = str_replace("\r\n", "<br>", $item['ta_what_is_done']);
		}
		return $List;
	}
	public function edit_task($id){
		$sql = "SELECT ta.*, cl.*, de.*, fi.*, st.* FROM tasks ta\n"
			."LEFT JOIN clients cl ON cl.cl_id = ta.ta_cl_id\n"
			."LEFT JOIN devices de ON de.de_id = ta.ta_de_id\n"
			."LEFT JOIN find_out fi ON fi.fi_id = ta.ta_fi_id\n"
			."LEFT JOIN statuses st ON st.st_id = ta.ta_st_id\n"
			."WHERE ta.ta_id = ?i";
		$list = $this->base()->query($sql, array($id));
		$list = $list->row();
		$list['cl_phone'] = preg_replace ("/(\+7)(\d{3})(\d{3})(\d{2})(\d{2})/i","\$1(\$2) \$3-\$4-\$5",$list['cl_phone']);
		$list['ta_equipment'] = json_decode($list['ta_equipment']);
		$list['ta_act'] = json_decode($list['ta_act']);
		return $list;
	}
	public function edit_save(array $data){
		if($_SESSION['rand']==$data['rand']){
			$return = false;
		}else{
			$id = $data['ta_id'];
			$datA = array(
				'ta_what_to_do' => $data['ta_what_to_do'],
				'ta_what_is_done' => $data['ta_what_is_done'],
				'ta_price_work' => $data['ta_price_work'],
				'ta_price_hard' => $data['ta_price_hard'],
				'ta_act' => json_encode($data['act'])
			);
			if(isset($data['save'])){
				$datA['ta_st_id'] = 2;
				$time = ", ta_date_end = null";
			}else{
				$datA['ta_st_id'] = 3;
				$time = ", ta_date_end = NOW()";
			}
			$sql = "UPDATE tasks SET ?set ?e WHERE ta_id = ?i";
			$this->base()->query($sql, array($datA, $time, $id));
			$return = true;
		}
		//print_r($return);
		return $return;
	}
	public function pay_task($id){
		$sql = "UPDATE tasks SET ?e WHERE ta_id = ?i";
		$data = "ta_date_pay = NOW(), ta_st_id = 4";
		$query = $this->base()->query($sql, array($data, $id));
		if($query){
			$result = array(
				'result' => 'ok',
				'id' => $id
			);
		}else{
			$result = array(
				'result' => 'fail'
			);
		}
		return $result;
	}
	public function add_task(array $request){
		$request['cl_phone'] =  preg_replace ("/[^0-9\+]/","",$request['cl_phone']);
		if($_SESSION['rand']==$request['rand'] && $request['type'] != 'fastTask'){
			$return = array(
				'result' => 'fail'
			);
		}else{
			if($request['type'] == 'fastTask'){
				$request['ta_cl_id'] = 1;
				$request['ta_equipment'] = array();
				$request['ta_model'] = 'Fast';
				$request['ta_serial'] = 'FAST';
				$request['ta_fi_id'] = null;
				$request['ta_what_to_do'] = '';
				$request['ta_date_end'] = 'now()';
				$ta_date_end = '?e';
				$request['ta_st_id'] = 3;
			}else{
				$request['priceWork'] = null;
				$request['priceHard'] = null;
				$request['ta_date_end'] = null;
				$ta_date_end = '?n';
				$request['ta_st_id'] = 1;
			}
			if(empty($request['ta_cl_id']))
				$request['ta_cl_id'] = $this->add_client(array($request['cl_name'], $request['cl_phone']));
			$sql = "INSERT INTO tasks \n"
					."(ta_id, ta_cl_id, ta_date_add, ta_de_id, ta_model, ta_serial,\n"
					."ta_equipment, ta_fi_id, ta_what_to_do, ta_what_is_done, ta_price_work, ta_price_hard, ta_date_end,\n"
					."ta_date_pay, ta_st_id, ta_show, ta_diagnostics) VALUES (\n"
					."null, ?i, now(), ?i, ?, ?,\n"
					."?, ?in, ?, ?, ?, ?, ".$ta_date_end.",\n"
					."null, ?i, 1, ?n)";
			$request['ta_equipment'] = array_filter(
				$request['ta_equipment'],
				function($el){ return !empty($el);}
			);
			$pattern = array(
				$request['ta_cl_id'],
				$request['ta_de_id'],
				$request['ta_model'],
				strtoupper($request['ta_serial']),
				json_encode($request['ta_equipment']),
				$request['ta_fi_id'],
				$request['ta_what_to_do'],
				$request['ta_what_is_done'],
				$request['priceWork'],
				$request['priceHard'],
				$request['ta_date_end'],
				$request['ta_st_id'],
				null
			);
			$ta_id = $this->base()->query($sql, $pattern, 'id');
			$_SESSION['rand'] = $request['rand'];
			$return = array(
				'result' => 'ok',
				'id' => $ta_id
			);
		}
		return $return;
	}
	public function client_request($cl_id){
		$sql = "SELECT ta.*, cl.*, de.*, fi.*, st.* FROM tasks ta\n"
			."LEFT JOIN clients cl ON cl.cl_id = ta.ta_cl_id\n"
			."LEFT JOIN devices de ON de.de_id = ta.ta_de_id\n"
			."LEFT JOIN find_out fi ON fi.fi_id = ta.ta_fi_id\n"
			."LEFT JOIN statuses st ON st.st_id = ta.ta_st_id\n"
			."WHERE ta.ta_show = 1 AND cl.cl_id = ?i ORDER BY ta.ta_id DESC";
		$list = $this->base()->query($sql, array($cl_id));
		$List = $list->assoc();
		foreach($List as $id => $item){
			$List[$id]['cl_phone'] = preg_replace ("/(\+7)(\d{3})(\d{3})(\d{2})(\d{2})/i","\$1(\$2) \$3-\$4-\$5",$item['cl_phone']);
		}
		return $List;
	}
	public function search($pattern){
		$sql = "SELECT ta.*, cl.*, de.*, fi.*, st.* FROM tasks ta\n"
			."LEFT JOIN clients cl ON cl.cl_id = ta.ta_cl_id\n"
			."LEFT JOIN devices de ON de.de_id = ta.ta_de_id\n"
			."LEFT JOIN find_out fi ON fi.fi_id = ta.ta_fi_id\n"
			."LEFT JOIN statuses st ON st.st_id = ta.ta_st_id\n"
			."WHERE ta.ta_show = 1 AND (ta.ta_id = ?i OR cl.cl_phone LIKE '%?e%') ORDER BY ta.ta_id DESC";
		$list = $this->base()->query($sql, array($pattern, $pattern));
		$List = $list->assoc();
		foreach($List as $id => $item){
			$List[$id]['cl_phone'] = preg_replace ("/(\+7)(\d{3})(\d{3})(\d{2})(\d{2})/i","\$1(\$2) \$3-\$4-\$5",$item['cl_phone']);
		}
		return $List;
	}
	private function add_client(array $client){
		$sql = "INSERT INTO clients (`cl_id`, `cl_old_id`, `cl_name`, `cl_phone`) VALUES (null, null, ?, ?)";
		$cl_id = $this->base()->query($sql, $client, 'id');
		return $cl_id;
	}
}