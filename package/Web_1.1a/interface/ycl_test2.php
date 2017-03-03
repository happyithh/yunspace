<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/28
 * Time: 16:40
 */
//往档期管理表中更新一条需求表的demand_id进去;
for($i=201510;$i<201514;$i++) {
    if($i==201513) {
        $i=201601;
    }
    $conditions = array();
    $conditions['{table}.offer_time != ?'] = '';
    $rs = Data_Mysql_Table_Demand_Match_Result::subTable('_'.$i)->select('{table}.offer_time,{table}.offer_info,{table}.demand_id', $conditions, '', 9999, '{table} LEFT JOIN {prefix}space_item ON {table}.item_id ={prefix}space_item.id LEFT JOIN {prefix}demand ON {prefix}demand.id = {table}.demand_id');
    foreach ($rs as $k => $v) {
        $rs[$k]['offer_info'] = json_decode($v['offer_info'], 1);
    }
    $data = array();
    foreach ($rs as $k => $v) {
        $data[$k]['demand_time'] = !empty($v['offer_time']) ? $v['offer_time'] : '';
        $data[$k]['account_phone'] = !empty($v['offer_info']['联系电话']) ? $v['offer_info']['联系电话'] : '';
        Data_Mysql_Table_Product_Demand::update(array('account_phone'=>$v['offer_info']['联系电话'],'demand_time'=>$v['offer_time']),array('demand_id'=>$v['demand_id']));
    }
}