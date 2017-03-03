<?php
/**
 * Created by PhpStorm.
 * User: zhaozhichao
 * Date: 2015/12/19
 * Time: 21:59
 * 检查手机号是否存在
 */

class Api_Administrator_CheckByPhone  extends  Api{

    static  $template = array();

    /**
     * @param $args
     * @return bool
     * 检查手机号 是否存在，
     */
    static  function  goCheck($args){
        $request = Func_Input::filter(array(
            'phone'=>'phone'
        ),$args);
        if(empty($request['phone'])){
            return false;
        }
       if(isset(self::$template[$request['phone']])){
             return self::$template[$request['phone']];
        }

       $data = Data_Mysql_Table_Administrator::select('id',array('phone=?'=>$request['phone']));
       if(empty($data[0]['id'])){
            return false;
       }
        return  self::$template[$request['phone']] = $data[0]['id'];

    }
}