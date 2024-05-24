<?php
class app_models_act extends app_model{
	public function reception_act($id){
		$sql = "SELECT ta.*, cl.*, de.*, fi.*, st.* FROM tasks ta\n"
			."LEFT JOIN clients cl ON cl.cl_id = ta.ta_cl_id\n"
			."LEFT JOIN devices de ON de.de_id = ta.ta_de_id\n"
			."LEFT JOIN find_out fi ON fi.fi_id = ta.ta_fi_id\n"
			."LEFT JOIN statuses st ON st.st_id = ta.ta_st_id\n"
			."WHERE ta.ta_id = ?i";
		$list = self::base()->query($sql, array($id));
		return $list->row();
	}
	public function issuing_act($id){
		$sql = "SELECT ta.*, cl.*, de.*, fi.*, st.* FROM tasks ta\n"
			."LEFT JOIN clients cl ON cl.cl_id = ta.ta_cl_id\n"
			."LEFT JOIN devices de ON de.de_id = ta.ta_de_id\n"
			."LEFT JOIN find_out fi ON fi.fi_id = ta.ta_fi_id\n"
			."LEFT JOIN statuses st ON st.st_id = ta.ta_st_id\n"
			."WHERE ta.ta_id = ?i";
		$list = self::base()->query($sql, array($id));
		$return = $list->row();
		$return['ta_act'] = json_decode($return['ta_act']);
		return $return;
	}
	public function diagnosis_act($id){
		$sql = "SELECT ta.*, cl.*, de.*, fi.*, st.* FROM tasks ta\n"
			."LEFT JOIN clients cl ON cl.cl_id = ta.ta_cl_id\n"
			."LEFT JOIN devices de ON de.de_id = ta.ta_de_id\n"
			."LEFT JOIN find_out fi ON fi.fi_id = ta.ta_fi_id\n"
			."LEFT JOIN statuses st ON st.st_id = ta.ta_st_id\n"
			."WHERE ta.ta_id = ?i";
		$list = self::base()->query($sql, array($id));
		$return = $list->row();
		$return['ta_diagnostics'] = json_decode($return['ta_diagnostics']);
		return $return;
	}
}