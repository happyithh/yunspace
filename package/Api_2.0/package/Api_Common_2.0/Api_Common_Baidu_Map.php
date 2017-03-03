<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/11/1
 * Time: 11:05
 */

class Api_Common_Baidu_Map extends  Api{

    static function handle(){
        return self::getCoordinate();
    }
    static  $cols = array(
        'address'
    );
    static function getCoordinate(){
        $request = Func_Input::filter(array(
            'address' => 'string',
            'token' => 'string',
        ), $_REQUEST);
        if(empty($request['token'])){
            return self::request('error','','token不能为空');
        }
        if($request['token']!='31eff6'){
            return self::request('error','','token异常');
        }
        if(empty($request['address'])){
            return self::request('error','','地址不能为空');
        }
//        $request['address'] = '上海长宁区淮海西路570号';
        $urls = "http://api.map.baidu.com/geocoder/v2/?address=".urlencode($request['address'])."&output=json&ak=aaNCRRcGGai6klHMOGZ8yBbP";

        $data = file_get_contents($urls);
        $data = json_decode($data,1);
        if(!empty($data)){
            if($data['status']==0){
                $new_data = array(
                    'lng'=>intval($data['result']['location']['lng']*10000),
                    'lat'=>intval($data['result']['location']['lat']*10000),
                );
                $m_url = "http://api.map.baidu.com/geocoder/v2/?ak=aaNCRRcGGai6klHMOGZ8yBbP&location=".$data['result']['location']['lat'].",".$data['result']['location']['lng']."&output=json&pois=1";
                $other_data = file_get_contents($m_url);
                $other_data = json_decode($other_data,1);
                if($other_data&&isset($other_data['status'])&&$other_data['status']==0){
                    $new_data['business'] = $other_data['result']['business'];
                    $new_data['district'] = $other_data['result']['addressComponent']['district'];
                }
                return self::request('success',$new_data,'返回成功');
            }else{
                return self::request('error','','网络请求错误');
            }
        }else{
            return self::request('error','','网络请求错误');
        }

    }

} 