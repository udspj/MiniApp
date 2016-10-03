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

		$coordla = 0.0;
		$coordlo = 0.0;
		if($param_get['coordx'] && $param_get['coordy']) {
			$coordla = $param_get['coordy'];
			$coordlo = $param_get['coordx'];
		}

		$dis = 10000000000;
		if($param_get['distance']) {
			$dis = (int)str_replace("m","",$param_get['distance']);	
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
		$sqlstr = "SELECT SQL_CALC_FOUND_ROWS * FROM shop_detail";// LIMIT $start_index, 5";
		if($whereTemp != "") {
			$sqlstr = $sqlstr." WHERE $whereTemp";// LIMIT $start_index, $per_page";
		}
		if($param_get['coordx'] && $param_get['coordy']) {
			if($whereTemp != "") {
				$sqlstr = $sqlstr." AND ";
			}else{
				$sqlstr = $sqlstr." WHERE ";
			}
			$sqlstr = $sqlstr."sqrt( ( ((113.914619-$coordlo)*PI()*12656*cos(((22.50128+$coordla)/2)*PI()/180)/180) * ((113.914619-$coordlo)*PI()*12656*cos (((22.50128+$coordla)/2)*PI()/180)/180) ) + ( ((22.50128-$coordla)*PI()*12656/180) * ((22.50128-$coordla)*PI()*12656/180) ) )<$dis";
		}
		$sqlstr = $sqlstr." LIMIT $start_index, $per_page";
		$sqlreslut = mysql_query($sqlstr);
		$apires = array();
		while($row = mysql_fetch_assoc($sqlreslut)) {
			$apires[] = $row;
		}

// combine result json
		$result = array( 'result' => $apires, 'meta' => array("status" => 0,"msg" => "success","total_count" => $totalcount,"page_total" => ceil($totalcount/$per_page)) ); 
		echo json_encode($result);

		// coordx=121.22&coordy=31.33&page=\u8bf7\u9009\u62e9&industry=\u9644\u8fd11000\u7c73

		// sqrt( ( ((113.914619-coordx)*PI()*12656*cos(((22.50128+coordy)/2)*PI()/180)/180) * ((113.914619-coordx)*PI()*12656*cos (((22.50128+coordy)/2)*PI()/180)/180) ) + ( ((22.50128-coordy)*PI()*12656/180) * ((22.50128-coordy)*PI()*12656/180) ) )<2000000
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