<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/28
 * Time: 16:40
 */
//        $rs_wenku = Data_Mysql_Table_Raiders_Info::query('UPDATE {table} SET category_id=12 where category_id in (12,13,14,15)');
//        $rs_anli = Data_Mysql_Table_Raiders_Info::query('UPDATE {table} SET category_id=3 where category_id in (1,2,3,4,5,6)');
//        $rs_zixun = Data_Mysql_Table_Raiders_Info::query('UPDATE {table} SET category_id=1 where category_id in (8,9,10,11,16,17,18,19,20,21)');
//        $rs_gonglue = Data_Mysql_Table_Raiders_Info::query('UPDATE {table} SET category_id=2 where category_id in (7)');


//$rs_wenku = Data_Mysql_Table_Raiders_Info::query('UPDATE {table} SET category_id=18 where category_id in (4,21)');
//$rs_anli = Data_Mysql_Table_Raiders_Info::query('UPDATE {table} SET category_id=16 where category_id=9');
//$rs_zixun = Data_Mysql_Table_Raiders_Info::query('UPDATE {table} SET category_id=11 where category_id in (7)');
//$rs_gonglue = Data_Mysql_Table_Raiders_Info::query('UPDATE {table} SET category_id=17 where category_id in (8)');
for($i=0;$i<3;$i++) {
    $conditions = array();
    $conditions['{table}.offer_time != ?'] = '';
//    Data_Mysql_Table_Demand_Match_Result::subTable('_20151'.$i)->debug(1);
    $rs = Data_Mysql_Table_Demand_Match_Result::subTable('_20151'.$i)->select('{table}.offer_price,offer_time,offer_info,item_id,{prefix}space_item.item_name,{prefix}demand.demand as demand,{prefix}demand.demand_name as demand_name', $conditions, '', 99999, '{table} LEFT JOIN {prefix}space_item ON {table}.item_id ={prefix}space_item.id LEFT JOIN {prefix}demand ON {prefix}demand.id = {table}.demand_id');
    foreach ($rs as $k => $v) {
        $rs[$k]['offer_info'] = json_decode($v['offer_info'], 1);
        $rs[$k]['demand'] = json_decode($v['demand'], 1);
    }
    $data = array();
    foreach ($rs as $k => $v) {
        $data[$k]['demand_time'] = !empty($v['offer_time']) ? $v['offer_time'] : '';
        $data[$k]['account_phone'] = !empty($v['offer_info']['联系电话']) ? $v['offer_info']['联系电话'] : '';
        $data[$k]['status'] = 1;
        $data[$k]['activity_start_time'] = !empty($v['demand']['开始时间']) ? strtotime($v['demand']['开始时间']) : '';
        $data[$k]['activity_end_time'] = !empty($v['demand']['结束时间']) ? strtotime($v['demand']['结束时间']) : '';
        $data[$k]['item_id'] = !empty($v['item_id']) ? $v['item_id'] : '';
        $data[$k]['item_name'] = !empty($v['item_name']) ? $v['item_name'] : '';
        $data[$k]['from_where'] = 1;

        $data[$k]['detail']['price'] = !empty($v['offer_price']) ? $v['offer_price'] : '';
        $data[$k]['detail']['per_price'] = '';
        $data[$k]['detail']['other_price'] = '';
        $data[$k]['detail']['per_other_price'] = '';
        $data[$k]['detail']['活动名称'] = !empty($v['demand']['活动名称']) ? $v['demand']['活动名称'] : $v['demand_name'];
        $data[$k]['detail']['活动类型'] = !empty($v['demand']['活动类型']) ? $v['demand']['活动类型'] : '';
        $data[$k]['detail']['活动人数'] = !empty($v['demand']['活动人数']) ? $v['demand']['活动人数'] : '';
        $data[$k]['detail']['活动备注'] = !empty($v['demand']['具体要求']) ? $v['demand']['具体要求'] : '';

        $data[$k]['demand']['people'] = !empty($v['demand']['联系人']) ? $v['demand']['联系人'] : '';
        $data[$k]['demand']['phone'] = !empty($v['demand']['联系电话']) ? $v['demand']['联系电话'] : '';
        $data[$k]['demand']['email'] = !empty($v['demand']['邮箱']) ? $v['demand']['邮箱'] : '';
        $data[$k]['demand']['company'] = !empty($v['demand']['公司名称']) ? $v['demand']['公司名称'] : '';
        $data[$k]['demand']['company_type'] = '';
        Data_Mysql_Table_Product_Demand::insert($data[$k]);
    }
}
//q($data);
//q($rs);