<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/25
 * Time: 13:57
 *
 * 签到审核
 */
class Api_Sign_In_Update_Status extends Api{
    static function handle($args){
        return self::updateStatus($_REQUEST);
    }
    static function updateStatus($args){
        $request = Func_Input::filter(array(
            'id'=>'int',
            'status'=>'int',
        ),$args);
        if(!empty($request['id'])) {
            $data['admin_status']=$request['status'];
//            $data['check_time']=time();
            $res = Data_Mysql_Table_Sign_In::update(array('id'=>$request['id']),$data);
            if(!empty($res[0])){
                return self::request('success','','操作成功！');
            }else{
                return self::request('error','','操作失败！');
            }
        }else{
            return self::request('error','','操作异常！');
        }
    }
}