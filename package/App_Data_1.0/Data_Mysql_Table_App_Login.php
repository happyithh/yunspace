<?php
/**
 * Created by PhpStorm.
 * User: lihb
 * Date: 15/4/28
 * Time: 上午10:05
 */

class Data_Mysql_Table_App_Login extends Data_Mysql_Table{
    public $cols = array(
        'username' => '50',
        'fullname' => '50',
        'user_id'=>'int',
        'token'=>'string',
        'device_platform'=>'50',
        'device_uuid'=>'string',
        'device_version'=>'20',
        'device_token_iphone'=>'100',        //苹果推送 设备号
        'login_time'=>'int',
        'app_version'=>'float',
        'device_model'=>'string',
        'jpush_register_id'=>'100'
    );
    public $index = array(
        'username' => 'u',
        'fullname' => 'title',
        'user_id' => 'u',
        'token' => 'i',
        'device_platform' => 'title',
        'device_uuid'=>'i',
        'device_version'=>'i',
        'login_time' => 'i',
        'app_version'=>'i',
        'device_model'=>'title',
        'jpush_register_id'=>'i',
    );
}