<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/9/14
 * Time: 13:23
 */

//$a = Api_Common_SiteMap::postSiteMap();
//q($a);
//$data = Data_Mysql_Table_Product_Search::select('id,attr_index', '', '', 10000000000000);
//foreach ($data as $k => $val) {
//    $attr_index = json_decode($val['attr_index'], 1);
//
//    if (!empty($attr_index[8])) {
//        Data_Mysql_Table_Product_Search::update(array('id' => $val['id']), array('order_people_number' => intval($attr_index[8])));
//    }
//}
Data_Config_Vendor_Attr::set('333', microtime());
q(Data_Config_Vendor_Attr::get('333'));