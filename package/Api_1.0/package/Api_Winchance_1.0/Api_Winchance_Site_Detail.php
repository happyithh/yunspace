<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/4/8
 * Time: 16:07
 * 文创场地详情
 */
class Api_Winchance_Site_Detail extends Api{
    static function detail($args){
        $request=Func_Input::filter(array(
            'id'=>'int',
        ),$args);
        if(empty($request['id'])){
           Func_Header::back('场地ID异常!');
        }
        $conditions['t1.id = ?'] = $request['id'];
        $data =Data_Mysql_Table_Winchance_Site::select('t1.*,t2.fullname',$conditions,'',1,'{table} as t1 LEFT JOIN {prefix}administrator as t2 ON t1.admin_id = t2.id');

        if(!empty($data[0]['plan'])){
            $data[0]['plan'] = json_decode($data[0]['plan'],1);
        }
        if(!empty($data[0]['des'])){
            $data[0]['des'] = json_decode($data[0]['des']);
        }
        if(!empty($data[0]['note'])){
            $data[0]['note'] = json_decode($data[0]['note']);
        }
        return $data[0];
    }
}