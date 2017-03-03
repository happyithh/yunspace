<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/10/10
 * Time: 10:17
 */
class Web_Winchance_List extends Page_Base
{

    static function conditions()
    {
        $conditions = array();
        $conditions['status = ?'] = 1;
        $action = explode('/',Core::$urls['action']);
        if(!empty($action[1])) {
            $conditions['category'] = intval($action[1]);
        }
        return $conditions;
    }


    static function getWinList()
    {
        $conditions = self::conditions();
        $order = 'ORDER BY {table}.order_lv desc,{table}.create_time desc';
        $rs = Data_Mysql_Table_Winchance::page(0,0,'*',$conditions,$order);
        foreach($rs['rows'] as $key =>$val){
            $rs['rows'][$key]['create_time'] = Date('Y-m-d',$val['create_time']);
            $rs['rows'][$key]['update_time'] = Date('Y-m-d',$val['update_time']);
            $rs['rows'][$key]['media'] = json_decode($val['media'],1);
            $rs['rows'][$key]['tags_info'] = json_decode($val['tags_info'],1);
            $rs['rows'][$key]['tags_info'][0] = explode(',',$rs['rows'][$key]['tags_info'][0]);
            $rs['rows'][$key]['accessory'] = json_decode($val['accessory'],1);
            $rs['rows'][$key]['attr'] = json_decode($val['attr'],1);
        }
        return $rs;
    }
}