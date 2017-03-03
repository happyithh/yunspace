<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/9/24
 * Time: 12:56
 * 点击一个点显示附近商家
 */
class Api_Map_Search_PointShow extends Api
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
        $request['lat'] = (float)$request['lat'] * 1000;
        $request['lng'] = (float)$request['lng'] * 1000;

        $lng = substr($request['lng'], 0, 6);
        $lat = substr($request['lat'], 0, 5);
        $is_conditions = Api_Map_Search_SpaceList::conditions($args);
        if ($is_conditions) {

            $conditions = $is_conditions;

        } else {
            $conditions['status =?'] = 1;
        }

        $conditions['( id =? OR (geo_lat <=? AND geo_lat >=? AND geo_lng <=? AND geo_lng >=?))'] = array($request['id'], $lat + 0.2 * 10.4, $lat - 0.2 * 10.4, $lng + 0.2 * 10.4, $lng - 0.2 * 10.4);
        $data = Data_Mysql_Table_Product_Search::select('id,category_id,addr,price,logo,attr_index,product_name,order_people_number,order_product_size', $conditions, "", 10);
        $list = Api_Map_Search_SpaceList::HandleField($data);
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
            $data = Api_Space_Recommend::handle($conditions);
            Tpl_Smarty::assign('recommend', $data['data']);
        }
        $tpl = Tpl_Smarty::fetch("Web_Static::map_search.v1.0/inc/point_show_list.tpl");
        return Api::request('success', $tpl, '成功');
    }
}