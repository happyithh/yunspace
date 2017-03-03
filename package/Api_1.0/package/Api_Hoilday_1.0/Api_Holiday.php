<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/3/15
 * Time: 13:46
 * 检查节假日
 */
class Api_Holiday extends Api
{
    static function  handle($args = '')
    {
        return self::handleCheck($args);

    }

    static function  handleCheck($args)
    {
        $request = Func_Input::filter(array(
            'd' => 'string',
        ), $args);
        $json = file_get_contents(dirname(__FILE__) . '/holiday_' . date('Y') . '.json');
        $data = json_decode($json, 1);
        $key = substr($request['d'], 0, 6);
        $day = substr($request['d'], 6);

        if (isset($data["$key"]["$day"])) {

            return json_encode(array($request['d'] => $data[$key][$day]));

        } else {
            return 'Not find';
        }


    }

    static    function isWorkTime(){
        $is_weekday = 1;
        $is_workHours = 1;
        if(date('G')>18||date('G')<8){
            $is_workHours = 0;
        }
        if(date('N')>5){
            $is_weekday=0;
        }
        if($is_weekday&&$is_workHours){
            return true;
        }else{
            return false;
        }
    }

}