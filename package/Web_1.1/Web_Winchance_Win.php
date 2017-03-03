<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/10/10
 * Time: 10:16
 */
class Web_Winchance_Win extends Page_Base
{
    //文创活动第一横排大图
    static function getHotList($num)
    {
        $conditions = array();
        $order = 'ORDER BY {table}.order_lv desc,{table}.create_time desc';
        $rs_hot = Data_Mysql_Table_Winchance::select('*',$conditions,$order,$num);
        foreach($rs_hot as $key =>$val){
            $rs_hot[$key]['create_time'] = Date('Y-m-d',$val['create_time']);
            $rs_hot[$key]['update_time'] = Date('Y-m-d',$val['update_time']);
            $rs_hot[$key]['media'] = json_decode($val['media'],1);
            $rs_hot[$key]['tags_info'] = json_decode($val['tags_info'],1);
            $rs_hot[$key]['tags_info'][0] = explode(',',$rs_hot[$key]['tags_info'][0]);
            $rs_hot[$key]['accessory'] = json_decode($val['accessory'],1);
            $rs_hot[$key]['attr'] = json_decode($val['attr'],1);
        }
        return $rs_hot;
    }


    //第二横排->其他活动->调用云发现的数据
    static function getOtherList()
    {
        $conditions_other = array();
        $order = 'ORDER BY {table}.create_time desc';
        $rs_other = Data_Mysql_Table_Raiders_Info::select('id,logo,title,des,create_time',$conditions_other,$order,5);
        foreach($rs_other as $key =>$val){
            $rs_other[$key]['create_time'] = Date('Y-m-d',$val['create_time']);
        }
        return $rs_other;
    }

    //合作案例
    static function getWinCase()
    {
        $conditions = array();
        $order = 'ORDER BY {table}.create_time desc';
        $rs = Data_Mysql_Table_Raiders_Info::select('id,logo,title,des,create_time',$conditions,$order,2);
        foreach($rs as $key =>$val){
            $rs[$key]['create_time'] = Date('Y-m-d',$val['create_time']);
        }
        return $rs;

    }
}