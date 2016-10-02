<?php

require_once "DBConnect.php";

class APIFunction {

	private $con;
	private $tablename = "zhonggou";

	function __construct() {
		$this->con = DBConnect::connectDB();
	}

	function getIndustry() {
		if(mysql_select_db($this->tablename,$this->con)) {
			mysql_select_db($this->tablename,$this->con);
			$sqlstr = "SELECT industryname FROM industry"; 
			$reslut = mysql_query($sqlstr);
			$apires = array();
			while($row = mysql_fetch_row($reslut)) {
				$apires[] = $row[0];
			}
			$result = self::createJSON($apires);
			return json_encode($result);
		}
	}

	function getDistance() {
		if(mysql_select_db($this->tablename,$this->con)) {
			mysql_select_db($this->tablename,$this->con);
			$sqlstr = "SELECT distancename FROM distance"; 
			$reslut = mysql_query($sqlstr);
			$apires = array();
			while($row = mysql_fetch_row($reslut)) {
				$apires[] = $row[0];
			}
			$result = self::createJSON($apires);
			return json_encode($result);
		}
	}

	private function createJSON($result) {
		$result = array( 'result' => $result, 'meta' => array("status" => 0,"msg" => "success") ); 
		return $result; 
	}

	function getShopDetailDatas($param_get) {
		$whereTemp = "";
		$whereTemp = 'industry'."='".$param_get['industry']."'";
		$page_index = $param_get['page'];
		if(!$page_index) {
			$page_index = 0;
		}

// list total count
		$sqlcountstr = "SELECT count(shopid) FROM shop_detail";
		if($whereTemp != "") {
			$sqlcountstr = $sqlcountstr . " WHERE $whereTemp";
		}
		$totalcount = mysql_fetch_row(mysql_query($sqlcountstr))[0];

// list detail data
		$per_page = 5;
		$start_index = $page_index * $per_page;
		// echo ceil($totalcount/$per_page);
		$sqlstr = "SELECT SQL_CALC_FOUND_ROWS * FROM shop_detail LIMIT $start_index, 5";
		if($whereTemp != "") {
			$sqlstr = "SELECT SQL_CALC_FOUND_ROWS * FROM shop_detail WHERE $whereTemp LIMIT $start_index, $per_page";
		}
		$sqlreslut = mysql_query($sqlstr);
		$apires = array();
		while($row = mysql_fetch_assoc($sqlreslut)) {
			$apires[] = $row;
		}

// combine result json
		$result = array( 'result' => $apires, 'meta' => array("status" => 0,"msg" => "success","total_count" => $totalcount,"page_total" => ceil($totalcount/$per_page)) ); 
		echo json_encode($result);

		// coordx=121.22&coordy=31.33&page=\u8bf7\u9009\u62e9&industry=\u9644\u8fd11000\u7c73
	}

	function distance($lat1, $lng1, $lat2, $lng2){
        return (2*ATAN2(SQRT(SIN(($lat1-$lat2)*PI()/180/2)
        *SIN(($lat1-$lat2)*PI()/180/2)+
        COS($lat2*PI()/180)*COS($lat1*PI()/180)
        *SIN(($lng1-$lng2)*PI()/180/2)
        *SIN(($lng1-$lng2)*PI()/180/2)),
        SQRT(1-SIN(($lat1-$lat2)*PI()/180/2)
        *SIN(($lat1-$lat2)*PI()/180/2)
        +COS($lat2*PI()/180)*COS($lat1*PI()/180)
        *SIN(($lng1-$lng2)*PI()/180/2)
        *SIN(($lng1-$lng2)*PI()/180/2))))*6378140;
    }

	function __destruct() {

	}

}

?>