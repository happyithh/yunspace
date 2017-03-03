<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/6/29
 * Time: 16:45
 */
class Wechat_Config
{
    static $AppID = 'wx6187ec44b1f20db5';
    static $AppSecret = '2dad747931bb72524fe7c257acd75fc8';

    //云space 客户方
    static function accessToken()
    {
        $status = Data_Mysql_Table_Wechat_AccessToken::select('access_token,update_time', array('wechat_type=?' => 'customer'));
        if (!empty($status[0]['update_time']) && $status[0]['update_time'] > time()) {
            return $status[0]['access_token'];
        }
        $data = file_get_contents('https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=' . self::$AppID . '&secret=' . self::$AppSecret);
        $access = json_decode($data, 1);
        if (!empty($access['access_token'])) {
            $update = array(
                'wechat_type' => 'customer',
                'access_token' => $access['access_token'],
                'update_time' => time() + 7200
            );
            Data_Mysql_Table_Wechat_AccessToken::update($update);

            return $access['access_token'];

        }
        self::accessToken();
    }

    /**
     *  管家服务号
     *
     */
    static $ManagerAppID = 'wxa9e71c9544ef0bf5';
    static $ManagerAppSecret = 'ff5ceec944cd320bc500cd851a5f5737';

    static function ManagerAccessToken()
    {
        $status = Data_Mysql_Table_Wechat_AccessToken::select('access_token,update_time', array('wechat_type=?' => 'manager'));
        if (!empty($status[0]['update_time']) && $status[0]['update_time'] > time()) {
            return $status[0]['access_token'];
        }
        $data = @file_get_contents('https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=' . self::$ManagerAppID . '&secret=' . self::$ManagerAppSecret);
        $access = json_decode($data, 1);
        if (!empty($access['access_token'])) {

            $update = array(
                'wechat_type' => 'manager',
                'access_token' => $access['access_token'],
                'update_time' => time() + 7200
            );
            Data_Mysql_Table_Wechat_AccessToken::update($update);

            return $access['access_token'];

        }
        self::ManagerAccessToken();
    }


    /**
     *
     * 销售抢单服务号
     * access token
     */

    static $saleAppID = 'wx43c2afd25cb11b58';
    static $saleAppSecret = 'd8c122f7a0e17c636cc75162bc176ade';

    static function saleAccessToken()
    {

        $status = Data_Mysql_Table_Wechat_AccessToken::select('id,access_token,update_time', array('wechat_type=?' => 'sale'));
        if (!empty($status[0]['update_time']) && $status[0]['update_time'] > time()) {
            return $status[0]['access_token'];
        } else {
            $data = @file_get_contents('https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=' . self::$saleAppID . '&secret=' . self::$saleAppSecret);
            $access = json_decode($data, 1);
            if (!empty($access['access_token'])) {
                $update = array(
                    'id' => $status[0]['id'],
                    'wechat_type' => 'sale',
                    'access_token' => $access['access_token'],
                    'update_time' => time() + 7200
                );
                Data_Mysql_Table_Wechat_AccessToken::update($update);
                return $access['access_token'];
            }
        }
        self::saleAccessToken();
    }

    static function  saleAccessReset()
    {

        Data_Mysql_Table_Wechat_AccessToken::query("UPDATE {table} SET update_time =0 WHERE wechat_type=? ", array('sale'), 1);

    }

    static function ManagerAccessTokenReset()
    {
//        Data_Mysql_Table_Wechat_AccessToken::update(array('wechat_type=?' => 'manager', array('update_time' => '')));
        Data_Mysql_Table_Wechat_AccessToken::query("UPDATE {table} SET update_time =0 WHERE wechat_type=? ", array('manager'), 1);

    }
}



