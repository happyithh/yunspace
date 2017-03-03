<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/15
 * Time: 11:51
 */
class Api_Administrator_Integral_Log extends Api
{

    /***
     * 积分日志
     *
     *主要存储 积分增减数量及缘由
     */

    static function  create($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'intro' => 'string',
            'integral' => 'int',
        ), $args);
        $data = array(
            'account_id' => $request['account_id'],
            'intro' => $request['intro'],
            'integral' => $request['integral'],
            'time' => time(),
        );
        Data_Mysql_Table_Integral_Record::insert($data);
    }
}