<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/15
 * Time: 17:34
 * 获取用户微信信息
 *
 */
class Api_Comments_GetUserInfo extends Api
{
    static function userInfo($args)
    {
        if (empty($args)) {
            return false;
        }
        if(!empty($args['wechat_id'])){
            $res = Data_Mysql_Table_Account_Wechat::select('id,user_info', array('id' => $args['wechat_id']));
        }
        $re=array();
        if(!empty($res)){
            $re['user_info'] = json_decode($res[0]['user_info'], 1);
        }
        return $re;
    }
}