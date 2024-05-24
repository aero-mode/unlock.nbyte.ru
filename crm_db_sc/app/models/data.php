<?php
class app_models_data extends app_model{
	public function get_clients($term){
		$sql = "SELECT cl.* FROM clients cl WHERE cl_phone LIKE '?e%'";
		$phone = preg_replace ("/[^0-9\\+]/","",$term);
		if(!preg_match("/^[\\+]/", $phone))
			$phone = "+".$phone;
		$list = $this->base()->query($sql, array($phone), 'assoc');
		$arr = array();
		foreach($list as $value){
			$value['cl_phone'] = preg_replace ("/(\\+7)(\\d{3})(\\d{3})(\\d{2})(\\d{2})/i","\$1(\$2) \$3-\$4-\$5",$value['cl_phone']);
			$arr[] = array('label' => $value['cl_phone']." - ".$value['cl_name'], 'id' => $value['cl_id'], 'name' => $value['cl_name'], 'phone' => $value['cl_phone'], 'value' => $value['cl_phone']);
		}
		return $arr;
	}
	public function get_devices(){
		$sql = "SELECT de.* FROM devices de WHERE de.de_enabled = 1 ORDER BY de.de_id ASC";
		$list = $this->base()->query($sql, array());
		return $list->assoc();
	}
	public function get_comp_parts(){
		$sql = "SELECT co.* FROM comp_parts co WHERE co.co_enabled = 1 ORDER BY co.co_id ASC";
		$list = $this->base()->query($sql, array());
		return $list->assoc();
	}
	public function get_find_out(){
		$sql = "SELECT fi.* FROM find_out fi WHERE fi.fi_enabled = 1 ORDER BY fi.fi_id ASC";
		$list = $this->base()->query($sql, array());
		return $list->assoc();
	}
	public function get_statuses(){
		$sql = "SELECT st.* FROM statuses st ORDER BY st.st_id ASC";
		$list = $this->base()->query($sql, array());
		return $list->assoc();
	}
	public function current_active(){
		$sql = "SELECT count(ta_id) FROM tasks WHERE ta_st_id != 4 AND ta_show = 1";
		$count = $this->base()->query($sql);
		return $count->el();
	}
	public function today_tasks(){
		$sql = "SELECT count(ta_id) FROM tasks WHERE ta_date_add BETWEEN STR_TO_DATE('?e 00:00:00', '%Y-%m-%d %H:%i:%s')\r
				AND STR_TO_DATE('?e 23:59:59', '%Y-%m-%d %H:%i:%s')";
		$count = $this->base()->query($sql, array(date('Y-m-d'), date('Y-m-d')));
//		print_r($count);
		return $count->el();
	}
}