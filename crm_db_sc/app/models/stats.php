<?php
class app_models_stats extends app_model{
	public function header_stats(){
		include_once('./conf.php');
		$month_money = $this->month_money();
		$day_money = $this->day_money(date('Y-m-d'));
		$money_smart = $this->money_smart(date('Y-m-d'));
		$money_note = $this->money_note(date('Y-m-d'));
		$money_sale = $this->money_sale(date('Y-m-d'));
		$month_money['need'] = ($config['plan_smart']+$config['plan_note']+$config['plan_sale'])*count($this->working_day(date('Y-m')));
		//$day_money['need'] = $config['plan_smart']+$config['plan_note']+$config['plan_sale'];
		$day_money['need'] = round((170000-$month_money['work'])/($this->count_current_working_day()-$this->count_working_day()), 2);
		$money_smart['need'] = $config['plan_smart'];
		$money_note['need'] = $config['plan_note'];
		$money_sale['need'] = $config['plan_sale'];
		$month_money['percent'] = round($month_money['work']*100/170000, 2);
		$month_money['percent_need'] = round((170000/$this->count_current_working_day())*$this->count_working_day()*100/170000, 2);
		$day_money['percent'] = round($day_money['all']*100/$day_money['need'], 2);
		$day_money['percent_need'] = round($day_money['all']*100/$day_money['need']*20, 2);
		$money_smart['percent'] = round($money_smart['all']*100/$money_smart['need'], 2);
		$money_smart['percent_need'] = round($money_smart['all']*100/$money_smart['need']*20, 2);
		$money_note['percent'] = round($money_note['all']*100/$money_note['need'], 2);
		$money_note['percent_need'] = round($money_note['all']*100/$money_note['need']*20, 2);
		$money_sale['percent'] = round($money_sale['all']*100/$money_sale['need'], 2);
		$money_sale['percent_need'] = round($money_sale['all']*100/$money_sale['need']*20, 2);
		$active_request = $this->active_request();
		return array(
			'month_money' => $month_money,
			'day_money' => $day_money,
			'money_smart' => $money_smart,
			'money_note' => $money_note,
			'money_sale' => $money_sale,
			'active_request' => $active_request
		);
	}
	private function month_money(){
		$sql = "SELECT SUM(ta_price_work) as work, SUM(ta_price_hard) as hard, SUM(ta_price_service) as service FROM tasks\r
				WHERE ta_date_pay BETWEEN STR_TO_DATE('?e;-01 00:00:00', '%Y-%m-%d %H:%i:%s')\r
				AND STR_TO_DATE('?e;-31 23:59:59', '%Y-%m-%d %H:%i:%s')\r
				AND ta_date_pay IS NOT NULL AND ta_show = 1 AND ta_st_id = 4";
		$query = $this->base()->query($sql, array(date('Y-m'), date('Y-m')));
		$return = $query->row();
		$return['all'] = array_sum($return);
		return $return;
	}
	private function day_money($day){
		$sql = "SELECT SUM(ta_price_work) as work, SUM(ta_price_hard) as hard, SUM(ta_price_service) as service FROM tasks\r
				WHERE ta_date_pay BETWEEN STR_TO_DATE('?e 00:00:00', '%Y-%m-%d %H:%i:%s')\r
				AND STR_TO_DATE('?e 23:59:59', '%Y-%m-%d %H:%i:%s')\r
				AND ta_date_pay IS NOT NULL AND ta_show = 1 AND ta_st_id = 4";
		$query = $this->base()->query($sql, array($day, $day));
		$return = $query->row();
		$return['all'] = array_sum($return);
		return $return;
	}
	private function money_smart($day){
		$sql = "SELECT SUM(ta_price_work) as price FROM tasks\r
				WHERE ta_date_pay BETWEEN STR_TO_DATE('?e 00:00:00', '%Y-%m-%d %H:%i:%s')\r
				AND STR_TO_DATE('?e 23:59:59', '%Y-%m-%d %H:%i:%s')\r
				AND ta_date_pay IS NOT NULL AND ta_show = 1 AND ta_st_id = 4 AND ta_de_id IN (3, 4, 6)";
		$query = $this->base()->query($sql, array($day, $day));
		return $query->row();
	}
	private function money_note($day){
		$sql = "SELECT SUM(ta_price_work) as price FROM tasks\r
				WHERE ta_date_pay BETWEEN STR_TO_DATE('?e 00:00:00', '%Y-%m-%d %H:%i:%s')\r
				AND STR_TO_DATE('?e 23:59:59', '%Y-%m-%d %H:%i:%s')\r
				AND ta_date_pay IS NOT NULL AND ta_show = 1 AND ta_st_id = 4 AND ta_de_id IN (1, 2, 5, 7, 8)";
		$query = $this->base()->query($sql, array($day, $day));
		return $query->row();
	}
	private function money_sale($day){
		$sql = "SELECT SUM(ta_price_work) as price FROM tasks\r
				WHERE ta_date_pay BETWEEN STR_TO_DATE('?e 00:00:00', '%Y-%m-%d %H:%i:%s')\r
				AND STR_TO_DATE('?e 23:59:59', '%Y-%m-%d %H:%i:%s')\r
				AND ta_date_pay IS NOT NULL AND ta_show = 1 AND ta_st_id = 4 AND ta_de_id = 9";
		$query = $this->base()->query($sql, array($day, $day));
		return $query->row();
	}
	private function active_request(){
		$sql = "SELECT COUNT(ta_id) FROM tasks WHERE ta_date_pay IS NULL AND ta_show = 1 AND ta_st_id != 4";
		$query = $this->base()->query($sql);
		return $query->el();
	}
	public function working_day($month){
		$sql = "SELECT ca_date FROM calendar WHERE ca_date < DATE_ADD('?e;-01', INTERVAL 1 MONTH) AND ca_date >= '?e;-01'";
		$query = $this->base()->query($sql, array($month, $month));
		return $query->col();
	}
	public function count_working_day(){
		$sql = "SELECT COUNT(ca_date) FROM calendar\n
					WHERE ca_date BETWEEN STR_TO_DATE('?e;-01', '%Y-%m-%d')\n
					AND STR_TO_DATE('?e;', '%Y-%m-%d')\n
					AND ca_work_day = 1";
		$query = $this->base()->query($sql, array(date('Y-m'), date('Y-m-d')));
		return $query->el();
	}
	public function count_current_working_day(){
		$sql = "SELECT COUNT(ca_date) FROM calendar\n
					WHERE ca_date BETWEEN STR_TO_DATE('?e;-01', '%Y-%m-%d')\n
					AND STR_TO_DATE('?e;-31', '%Y-%m-%d')\n
					AND ca_work_day = 1";
		$query = $this->base()->query($sql, array(date('Y-m'), date('Y-m')));
		return $query->el();
	}
	private function count_day_request($day){
		$sql = "SELECT COUNT(ta_id) FROM tasks WHERE ta_show = 1 AND\r
				ta_date_pay BETWEEN STR_TO_DATE('?e 00:00:00', '%Y-%m-%d %H:%i:%s')\r
				AND STR_TO_DATE('?e 23:59:59', '%Y-%m-%d %H:%i:%s')\r
				AND ta_date_pay IS NOT NULL AND ta_show = 1 AND ta_st_id = 4";
		$query = $this->base()->query($sql, array($day, $day));
		return $query->el();
	}
	public function getMonthName($month){
		$month = explode("-", $month);
		$month = intval($month[1])-1;
		$monthName = array("Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь");
		$monthNameA = array("Января", "Февраля", "Марта", "Апреля", "Мая", "Июня", "Июля", "Августа", "Сентября", "Октября", "Ноября", "Декабря");
		return array('month' => $monthName[$month], 'monthA' => $monthNameA[$month]);
	}
	public function stats($month){
		$working_day = $this->working_day($month);
		$count_days = count($working_day);
		$return = array();
		for($i=0; $i<$count_days; $i++){
			$return[$working_day[$i]] = array(
				'day_money' => $this->day_money($working_day[$i]),
				'money_smart' => $this->money_smart($working_day[$i]),
				'money_note' => $this->money_note($working_day[$i]),
				'money_sale' => $this->money_sale($working_day[$i]),
				'request' => $this->count_day_request($working_day[$i])
			);
		}
		return($return);
	}
}