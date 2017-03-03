<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/25
 * Time: 13:57
 *
 * 签到审核
 */
class Api_Sign_In_Get_Poi extends Api{
    static function handle($args){
        return self::getPoi($_REQUEST);
    }
    static function getPoi($args){
        $request = Func_Input::filter(array(
            'lat'=>'string',
            'lng'=>'string',
        ),$args);
        if(empty($request['lat'])||empty($request['lng'])){
            return self::request('error','','地理位置出错！');
        }
        $url = 'http://apis.map.qq.com/ws/geocoder/v1/?location='.urlencode($request['lat'].','.$request['lng']).'&key=4L2BZ-R5BW4-7KLUH-XTW4L-X42TO-3EBKD&get_poi=1';
        $result = file_get_contents($url);
        if($result){
            $res = json_decode($result,1);
            return self::request('success',$res,'操作成功！');
        }else{
            return self::request('error','','操作失败！');
        }

//        if(!empty($result)){
//            return self::request('success',$result,'操作成功！');
//        }else{
//            return self::request('error','','操作失败！');
//        }
    }
}