<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/26
 * Time: 10:35
 *签到 存入地理位置
 */
class Api_Sign_In_SetLocation extends Api{
    static function handle(){
        return self::setLocation($_REQUEST);
    }
    static function setLocation($args)
    {
        $request = Func_Input::filter(array(
                'id'=>'id',
                'latitude'=>'string',
                'longitude'=>'string'
            ),$args);
        if(empty($request['id'])){
            return self::request('error','','ID异常!');
        }
        if(empty($request['latitude']) || empty($request['longitude'])){
            return self::request('error','','没有获取到您的地理位置!');
        }
        $data['latitude']=$request['latitude'];
        $data['longitude']=$request['longitude'];
        $data['sign_time']=time();
        $data['status']=2;
        $res = Data_Mysql_Table_Sign_In::update(array('id'=>Func_NumEncode::d($request['id'])),$data);
        if(!empty($res[0])){
            return self::request('success','','签到成功！');
        }else{
            return self::request('error','','签到失败！');
        }
    }
}