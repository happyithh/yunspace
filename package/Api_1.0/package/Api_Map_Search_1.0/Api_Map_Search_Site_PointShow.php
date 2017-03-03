<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/9/24
 * Time: 12:56
 * 百科附近场地数据获取
 */
class Api_Map_Search_Site_PointShow extends Api
{

    /**
     * @param string $args
     * @return array
     */
    static function  handle($args = '')
    {
        return self::getSiteList($args);
    }

    static function  getSiteList($args)
    {
        $list=array();
        $request = Func_Input::filter(array(
            'space_id' => "int",
            'lng' => 'string',//经度
            'lat' => 'string',//纬度
        ), $args);
        if (empty($request['space_id'])) {
            return Api::request('error', '', '缺少参数');
        }
        $return=self::returnSquarePoint($request['lng']/10000,$request['lat']/10000);
        $conditions['status =?'] = 1;
        $conditions['id != ? AND geo_lat <=? AND geo_lat >=? AND geo_lng <=? AND geo_lng >=?'] = array($request['space_id'],$return['left-top']['lat']*10000,$return['right-bottom']['lat']*10000,$return['right-bottom']['lng']*10000,$return['left-top']['lng']*10000);
//        $conditions['id != ? AND geo_lat <=? AND geo_lat >=? AND geo_lng <=? AND geo_lng >=?'] = array($request['space_id'],$request['lat'] + 2 * 10.4*10000, $request['lat'] - 0.1 * 10.4*10000, $request['lng'] + 2* 10.4*10000, $request['lng'] - 0.1 * 10.4*10000);
        $data = Data_Mysql_Table_Spacepedia::select('id,addr,space_name,geo_lat,geo_lng', $conditions, "", 4);
        $list = self::getDistance($data,$request['lat'],$request['lng']);
        return Api::request('success',$list, '返回附近2000米以内的场地');
    }

    //获取周围坐标       默认为2千米
    static  function returnSquarePoint($lng, $lat,$distance = 2000){
        $earthRadius = 6378138;
        $dlng =  2 * asin(sin($distance / (2 * $earthRadius)) / cos(deg2rad($lat)));
        $dlng = rad2deg($dlng);
        $dlat = $distance/$earthRadius;
        $dlat = rad2deg($dlat);
        return array(
            'left-top'=>array('lat'=>$lat + $dlat,'lng'=>$lng-$dlng),
            'right-top'=>array('lat'=>$lat + $dlat, 'lng'=>$lng + $dlng),
            'left-bottom'=>array('lat'=>$lat - $dlat, 'lng'=>$lng - $dlng),
            'right-bottom'=>array('lat'=>$lat - $dlat, 'lng'=>$lng + $dlng)
        );
    }


    //计算两个坐标的直线距离
    static  function getDistance($data,$lat1, $lng1){
        $earthRadius = 6378138; //近似地球半径米
        // 转换为弧度
        $lat1 = ($lat1 * pi()/10000) / 180;
        $lng1 = ($lng1 * pi()/10000) / 180;
        foreach($data as $k=>$v){
            $lat2 = ($v['geo_lat'] * pi() /10000 ) / 180;
            $lng2 = ($v['geo_lng'] * pi() /10000 ) / 180;
            // 使用半正矢公式  用尺规来计算
            $calcLongitude = $lng2 - $lng1;
            $calcLatitude = $lat2 - $lat1;
            $stepOne = pow(sin($calcLatitude / 2), 2) + cos($lat1) * cos($lat2) * pow(sin($calcLongitude / 2), 2);
            $stepTwo = 2 * asin(min(1, sqrt($stepOne)));
            $calculatedDistance = $earthRadius * $stepTwo;
            $distance=round($calculatedDistance);
            $data[$k]['distance']=$distance;
            if($distance>0 && $distance<500){
                $data[$k]['distance_note']="500米以内";
            }elseif($distance>=500 && $distance<1000){
                $data[$k]['distance_note']="500-1000米";
            }elseif($distance>=1000 && $distance<1500){
                $data[$k]['distance_note']="1000-1500米";
            }elseif($distance>=1500 && $distance<2000){
                $data[$k]['distance_note']="1500-2000米";
            }elseif($distance>=2000){
                $data[$k]['distance_note']="2000米以外";
            }
            $data[$k]['distance']=round($calculatedDistance);
        }
        return $data;
    }




}