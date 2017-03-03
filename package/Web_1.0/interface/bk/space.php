<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/2/26
 * Time: 15:14
 */
$webConfig = Data_Config_Site::get('service_list');
$navIndex = 1;
if (!empty($_REQUEST['mode'])) {
    if($_REQUEST['mode']=='space'){


        $navIndex=1;
    }else if($_REQUEST['mode']=='service'){

        $navIndex=2;
    }else if($_REQUEST['mode'=='vendor']){
        $navIndex=0;
    }
//    $navIndex = $_REQUEST['mode'] == 'service' ? 2 : 0;
    if ($_REQUEST['mode'] == 'vendor') {
        include dirname(__FILE__) . '/vendor.php';
        die();
    }
}
if (empty(Core::$urls['action'])) {
    Core::$urls['action'] = $webConfig['space_id'];
}
include dirname(__FILE__) . '/service.php';