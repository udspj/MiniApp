<?php

require_once "APIFunction.php";

$paramstr = $_SERVER['QUERY_STRING'];
$args = explode('&', $paramstr);
$paramcount = count($args);

$action = trim($_GET['action']);

$apifunc = new APIFunction();

if ($action == "industry") {
	echo $apifunc->getIndustry();
}else if ($action == "distance") {
	echo $apifunc->getDistance();
}else{
	$apifunc->getShopDetailDatas($_GET);
}

// http://serverurl/select_api.php?industry=type1&page=1
// http://serverurl/select_api.php?action=industry
// http://serverurl/select_api.php?action=distance

?>