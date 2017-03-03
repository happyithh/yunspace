<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/9/24
 * Time: 12:56
 * 点击一个点显示附近商家
 */
class Api_Map_Search_PointShow_v2 extends Api
{

    /**
     * @param string $args
     * @return array
     */
    static function  handle($args = '')
    {
        return self::SpaceList($args);
    }

    static function  SpaceList($args)
    {
        $request = Func_Input::filter(array(
            'id' => "int",
            'lng' => 'string',//经度
            'lat' => 'string',//纬度
        ), $args);
        if (empty($request['id'])) {
            return Api::request('error', '', '缺少参数');
        }
        $request['lat'] = (float)$request['lat'] * 10000;
        $request['lng'] = (float)$request['lng'] * 10000;

        $lng = substr($request['lng'], 0, 7);
        $lat = substr($request['lat'], 0, 6);
        $is_conditions = Api_Map_Search_SpaceList_v2::conditions($args);
        if ($is_conditions) {

            $conditions = $is_conditions;

        } else {
            $conditions['status =?'] = 1;
        }

        $conditions['( id =? OR (geo_lat <=? AND geo_lat >=? AND geo_lng <=? AND geo_lng >=?))'] = array($request['id'], $lat + 0.2 * 10.4*10, $lat - 0.2 * 10.4*10, $lng + 0.2 * 10.4*10, $lng - 0.2 * 10.4*10);
        $data = Data_Mysql_Table_Spacepedia_Search::select('id,space_name,geo_lat,geo_lng,logo,attr', $conditions, "", 10);
        $list = Api_Map_Search_SpaceList_v2::HandleField($data);
        $thisData = '';
        foreach ($list as $k => $val) {
            if ($val['id'] == $request['id']) {
                $thisData[$k] = $val;
                unset($list[$k]);
                break;
            }
        }
        if ($thisData) {
            $NewList = array_merge($thisData, $list);
        } else {
            $NewList = $list;
        }
        Tpl_Smarty::assign('list', $NewList);
        if (empty($list)) {
            //相关推荐
//            $data = Api_Space_Recommend::handle($conditions);
//            Tpl_Smarty::assign('recommend', $data['data']);
        }
        $tpl = Tpl_Smarty::fetch("Web_Static::map.v1.0/inc/point_show_list.tpl");
        return Api::request('success', $tpl, '成功');
    }

    //获取某个场地两千米以内的场地
    static function getNearSpaceList($args){
        $request = Func_Input::filter(array(
            'id' => "int",
            'lng' => 'string',//经度
            'lat' => 'string',//纬度
        ), $args);
        if (empty($request['id'])) {
            return Api::request('error', '', '缺少参数');
        }
        $lat=$request['lat'];
        $lng=$request['lng'];
        $conditions['status =?'] = 1;
        $conditions['id !=?'] = $request['id'];

        $conditions['geo_lat <=? AND geo_lat >=? AND geo_lng <=? AND geo_lng >=? '] = array($lat + 2 * 10.4*10, $lat - 2 * 10.4*10, $lng + 2 * 10.4*10, $lng - 2 * 10.4*10);
        $data = Data_Mysql_Table_Spacepedia_Search::select('id,space_name,geo_lat,geo_lng,logo', $conditions, "ORDER BY order_index ASC", 4);
        //处理距离
        $list=self::getDistance($data,$lat,$lng);
        return $list;

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
            }else{
                $data[$k]['distance_note']="2000米以外";
            }
            $distance_sort[]=$distance;
        }
        array_multisort($distance_sort,SORT_ASC,SORT_NUMERIC,$data);
        return $data;
    }
}