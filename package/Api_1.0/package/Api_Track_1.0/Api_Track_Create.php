<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/8
 * Time: 10:20
 * 用户轨迹记录
 */
class Api_Track_Create extends Api
{
    static function  handle($args = '')
    {
        self::create();
    }

    static function  create()
    {
        if(Core::$urls['referer']=='http://hao123.com/'||Core::$urls['referer']=='http://mp.weixinbridge.com/'||Core::$urls['referer']=='http://m.baidu.com/link'){
            return false;
        }
        if(self::isSpider()){
            return false;
        }
        @session_start();
        @$_SESSION['layer'] = isset($_SESSION['layer'])?intval(@$_SESSION['layer']) + 1:1;
        if(empty($_SESSION['referer'])){
            $_SESSION['enter'] = $_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
            $_SESSION['referer'] = Core::$urls['referer'];
        }
        Data_Mysql_Table_StaticLog::subTable(date('_Ym'))->insert(array(
            'user_id' => @$_SESSION['user']['id'],
            'session_id' => session_id(),
            'referer' => Core::$urls['referer'],
            'log' => '',
            'url' => $_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'],
            'layer' => @$_SESSION['layer'],
            'ip' => Func_Input::ip(),
            'create_time' => time(),
        ));
    }
    static function isSpider(){

        if(isset($_SERVER['HTTP_USER_AGENT']) && !empty($_SERVER['HTTP_USER_AGENT']) && preg_match("/(Bot|Googlebot|Crawl|Baiduspider|Spider|slurp|sohu-search|lycos|robozilla)/i", $_SERVER['HTTP_USER_AGENT'])) {
            return true;
        }else{
            return false;
        }

    }
}