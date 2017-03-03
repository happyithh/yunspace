<?php

/**
 * Created by PhpStorm.
 * User: yaoli
 * Date: 15/11/17
 * Time: 14:00
 * 解决urlencode和urldecode
 */
class Func_Url
{

    static $special=array(
        " "=>'*',
        "+"=>"^",
        '•'=>"=",        
        '&#39;'=>"$",
    );
    static $types = array(
        1=>'-百科',
        3=>'-精华',
        4=>'-讨论组',
    );

    //url编码
    static function str_urlencode($str,$type=0)
    {
        if($type&&!empty(self::$types[$type])){
            $str.=self::$types[$type];
        }
        return urlencode(str_replace(array_keys(self::$special),array_values(self::$special),$str));
    }

    //url解码
    static function str_urldecode($str)
    {
        return str_replace(array_values(self::$special),array_keys(self::$special),urldecode($str));
    }

}