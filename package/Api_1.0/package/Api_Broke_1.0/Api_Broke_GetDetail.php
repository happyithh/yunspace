<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/8/31
 * Time: 16:29
 *
 * 后台详情爆料信息（个人）包括 已处理、待处理、已放弃
 */

class Api_Broke_GetDetail extends Api{
    static function getDetail($args){
        $request = Func_Input::filter(array(
            'account_id'=>'int',
            'broke_time'=>'string',
            'type'=>'string'
        ),$args);
        if(!empty($request['account_id']) && !empty($request['broke_time'])){
            if(empty($request['type']) || $request['type']=='done'){
                $conditions['{table}.demand_status !=? and {table}.demand_status !=?'] = array(0, -1);
            }elseif($request['type']=='waiting'){
                $conditions['{table}.demand_status =?'] = 0;
            }else{
                $conditions['{table}.demand_status =?'] = -1;
            }
            $dateTime = $dateTime = Api_Broke_ListPreview::getMonth($request['broke_time']);
            $conditions['{table}.demand_type =?'] = '活动爆料';
            $conditions['{table}.submit_person_account_id =?']=$request['account_id'];
            $conditions['{table}.create_time between ? and ? '] =array($dateTime['month_start_day'],$dateTime['month_end_day']);
            $res = Data_Mysql_Table_Demand::select('{table}.id,{table}.demand,{table}.phone,{table}.submit_person,{table}.city,{table}.demand_type,{table}.create_time,{table}.demand_status,{prefix}account_wechat.user_info',$conditions,'ORDER BY demand_status DESC',999,'{table} LEFT JOIN {prefix}account_wechat ON {table}.submit_person_account_id = {prefix}account_wechat.account_id');
            if(!empty($res)){
                foreach($res as $k=>$v){
                    $res[$k]['demand'] = json_decode($v['demand'],1);
                    $res[$k]['user_info'] =json_decode($v['user_info'],1);
                }
            }
            return self::request('success',$res,'');


        }
    }
}