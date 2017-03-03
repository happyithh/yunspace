<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/17
 * Time: 19:26
 * 检查订单是否存在咯
 */
class Api_Grab_Order_Check extends Api
{
    /**
     * @param $args
     * @return bool
     * 看看是否存在
     */
    static function  goCheckIsExist($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int'
        ), $args);
        $data = Data_Mysql_Table_Grab_Order::select('id,sale_phone,status', array('id=?' => $request['id']));
        if (!empty($data[0]['id'])) {
            return $data[0];            //array(id=>'',status=>'');
        }
        return false;
    }

} 