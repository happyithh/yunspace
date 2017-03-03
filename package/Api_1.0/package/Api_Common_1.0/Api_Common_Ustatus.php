<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/1/8
 * Time: 10:44
 */
class Api_Common_Ustatus extends Api
{
    static function handle()
    {
        return self::getUserStatus();
    }

    static function getUserStatus()
    {
        session_start();
        if (!empty($_SESSION['user'])&&isset($_SESSION['user']['id']) &&!empty($_SESSION['user']['id'])) {
            $data = array(
                'username'=>$_SESSION['user']['username'],
                'uid'=>$_SESSION['user']['id']
            );
            $result = self::request('success', $data, '已登录成功');
            return $result;
        }else{
            $result = self::request('error', '', "请先登录");
            return $result;
        }
    }
}