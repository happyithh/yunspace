<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/5/28
 * Time: 上午10:05
 */
class Data_Mysql_Table_Login_Dwz extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',  //访问的用户
        'access_url' => 'string',     //访问的连接
        'url_code' => 10,       //短网址代码
        'overdue_time' => 'int',      //超时时间
        'auth_code'=>'int',   //超时验证码
    );
    public $index = array(
        'user_id' => 'i',
        'url_code' => 'i',
        'account_id,access_url' => 'u',
    );




}