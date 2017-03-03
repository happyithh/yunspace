<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/25
 * Time: 13:54
 * 外出签到审核列表
 */
class Api_Sign_In_Check_List extends Api{
    static function checkList($args){
        if(isset($args['search']) && !empty($args['search'])){
            $request = Func_Input::filter(array(
                'start_time'=>'string',
                'end_time'=>'string',
                'fullname'=>'string'
            ),$args['search']);
            if(!empty($request['start_time']) && !empty($request['end_time'])){
                $condition['tb1.create_time between ? and ?'] = array(strtotime($request['start_time'].'00:00:00'),strtotime($request['end_time'].'23:59:59'));
            }elseif(!empty($request['start_time']) && empty($request['end_time'])){
                $condition['tb1.create_time >= ?'] = strtotime($request['start_time'].'00:00:00');
            }elseif(empty($request['start_time']) && !empty($request['end_time'])){
                $condition['tb1.create_time <= ?'] = strtotime($request['start_time'].'23:59:59');
            }
            if(!empty($request['fullname'])){
                $condition['tb2.fullname']=trim($request['fullname'],'');
            }
        }
        $condition['tb1.status = ?']=0;
        $condition['tb1.phone!=?']='';
        $table = "{table} as tb1 LEFT JOIN {prefix}administrator as tb2 ON tb2.phone=tb1.phone";
        $res = Data_Mysql_Table_Sign_In::page(0,15,'tb1.*,tb2.username,tb2.fullname as admin_fullname',$condition,'ORDER BY tb1.create_time DESC',$table);
        return $res;
    }
}