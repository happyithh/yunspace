<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/9/18
 * Time: 15:00
 *
 *初始化地图数据
 */
class  Api_Map_Search_SpaceList_v2 extends Api
{
    static function  handle($args = '')
    {
        $request = Func_Input::filter(array(
            'handle' => 'string'
        ), $args);

        if (!empty($request['handle'])) {
            return self::ajaxSearch($args);
        } else {
            return self::SpaceList($args);
        }
    }

    static function  SpaceList($args)
    {
        $conditions = self::conditions($args);

        $data = Data_Mysql_Table_Spacepedia_Search::select('id,space_name,geo_lat,geo_lng,logo,attr', $conditions, '', 300);
        foreach($data as $k=>$v){
            $data[$k]['space_name_url']=Func_Url::str_urlencode($v['space_name'],1);
        }
        return array(
            'status' => 1,
            'data' => $data,
            'msg' => '成功'
        );

    }

    /**
     * param $args
     *
     * ajax 搜索
     */

    static function  ajaxSearch($args)
    {
        $request = Func_Input::filter(array(
            'p' => 'int',
            'n' => 'int',
            'order' => 'int',
        ), $args);
        $conditions = self::conditions($args);

        switch ($request['order']) {
            case 2:
                $order = "ORDER BY update_time DESC ";
                break;
            case 3:
                $order = "ORDER BY level DESC ";
                break;
            case 4:
                $order = "ORDER BY order_index DESC ";
                break;
            default:
                $order = "ORDER BY order_index DESC ";
                break;
        }
        $list = Data_Mysql_Table_Spacepedia_Search::page(
            empty($request['p']) ? 0 : $request['p'],
            empty($request['n']) ? 0 : $request['n'],
            '*',
            $conditions,
            $order
        );
        //处理所有坐标
        $coordinate = self::coordinate($conditions, $order, $list['page']);
        //处理分页的坐标数据
        $pageCoordinate = self::PageCoordinate($list['rows']);

        $list['rows'] = self::HandleField($list['rows']);

        Tpl_Smarty::assign('list', $list);
        if (empty($list['rows'])) {
            //相关推荐
//            $data = Api_Space_Recommend::handle($conditions);
//            Tpl_Smarty::assign('recommend', $data['data']);
        }
        $DataTpl = Tpl_Smarty::fetch("Web_Static::map.v1.0/inc/ajax_list.tpl");

        return array(
            'status' => 1,
            'data' => $DataTpl,
            'msg' => '成功',
            'coordinate' => $coordinate,
            'pageCoordinate' => $pageCoordinate,

        );

    }

    /**
     * @param $conditions
     * @param $order
     * @param $page
     * @return array
     * 坐标处理
     */
    static function  coordinate($conditions, $order, $page)
    {
        $cache = Data_Mysql_Table_Cache_Array::get('_coordinate', $conditions);
        if ($cache) {
            return $cache;
        }
        $list = Data_Mysql_Table_Spacepedia_Search::select(
            'id,geo_lat,geo_lng,space_name',
            $conditions,
            $order,
//            $page['dt']
            300
        );

        $coordinate = array();
        foreach ($list as $k => $val) {
            $coordinate[] = array(
                'id' => $val['id'],
                'space_name' => $val['space_name'],
                'geo_lat' => $val['geo_lat'],
                'geo_lng' => $val['geo_lng'],
                'space_name_url' => Func_Url::str_urlencode($val['space_name'],1)
            );
        }
        Data_Mysql_Table_Cache_Array::set('_coordinate', $conditions, $coordinate, 86400);
        return $coordinate;
    }

    /**
     * @param $list
     * @return array
     * 处理每一次分页的经纬度
     */
    static function  pageCoordinate($list)
    {
        $pageCoordinate = array();
        foreach ($list as $k => $val) {
            $pageCoordinate[] = array(
                'id' => $val['id'],
                'space_name' => $val['space_name'],
                'geo_lat' => $val['geo_lat'],
                'geo_lng' => $val['geo_lng'],
            );
        }
        return $pageCoordinate;

    }

    static function  conditions($args)
    {

        $request = Func_Input::filter(array(
            'a_112' => 'string',   //场地类型
//            'a_8' => 'int',     //人数
            'a_49' => 'string',      //适合活动类型
//            'a_9' => 'string',        //服务行业
            'a_10' => 'int',        //面积
            'baidu_lng' => 'string',        //当前经度
            'baidu_lat' => 'string',        //当前纬度
            'nearbymi' => 'int',            //距离ID
            'keyword' => 'string',               //关键字       记录日志
            'right_top_lat' => 'string',   //右上角纬度
            'right_top_lng' => 'string',  //右上角经度
            'left_down_lat' => 'string',   //左下角纬度
            'left_down_lng' => 'string',    //左下角 纬度
        ), $args);
        Api_Log_Create::SpaceScreening(array(
                'class' => get_called_class(),
                'func' => __FUNCTION__,
                'behavior' => '地图ajax筛选场地',
                'screening' => $request
            )
        );
        $conditions['status=?'] = 1;
//        if(isset($_COOKIE['city'])){
//            $conditions['city']=$_COOKIE['city'];
//        }
        if (!empty($request['a_112'])) {
            $request['category_id'] =Data_Mysql_Table_Spacepedia::getCategoryId(Func_String::utf8($request['a_112']));
            $conditions['category_id =?'] = $request['category_id'];
        } else {
            $children = Data_Mysql_Table_Spacepedia::getChildren(112);
            $children[] = 112;
            $conditions[] = 'category_id in (' . implode(',', $children) . ')';
        }
//        switch ($request['a_8']) {
//            case 1:
//                $conditions['order_people_number <=?'] = 50;
//                break;
//            case 2:
//                $conditions['order_people_number >=? AND order_people_number <=?'] = array(50, 100);
//                break;
//            case 3:
//                $conditions['order_people_number >=? AND order_people_number <=?'] = array(100, 300);
//                break;
//            case 4:
//                $conditions['order_people_number >=? AND order_people_number <=?'] = array(300, 500);
//                break;
//            case 5:
//                $conditions['order_people_number >=? '] = 500;
//                break;
//        }
        //适合活动类型
        if (!empty($request['a_49'])) {
            $conditions['attr'][49] = '+' . trim($request['a_49']);
        }
        //适合行业类型
//        if (!empty($request['a_9'])) {
//            $conditions['attr_index'][9] = '+' . trim($request['a_9']);
//        }

        switch ($request['a_10']) {
            case 1:
                $conditions['size =?'] = 200;
                break;
            case 200:
                $conditions['size >=? AND  size <=? '] = array(200, 500);
                break;
            case 500:
                $conditions['size >=? AND  size <=? '] = array(500, 800);
                break;
            case 800:
                $conditions['size >=? AND  size <=?'] = array(800, 1000);
                break;
            case 1000:
                $conditions['size >=? AND  size <=?'] = array(1000, 2000);
                break;
            case 2000:
                $conditions['size >?'] = 2000;
                break;
        }

//        if (!empty($request['nearbymi']) && !empty($request['baidu_lng']) && !empty($request['baidu_lat'])) {
//            $request['baidu_lng'] = (float)$request['baidu_lng'] * 1000;
//            $lng = substr($request['baidu_lng'], 0, 6);
//            $request['baidu_lat'] = (float)$request['baidu_lat'] * 1000;
//            $lat = substr($request['baidu_lat'], 0, 5);
//            switch ($request['nearbymi']) {
//                case 1:
//                    $conditions[] = "geo_lat < " . ($lat + 1 * 10.4) . " and geo_lat > " . ($lat - 1 * 10.4);
//                    $conditions[] = "geo_lng < " . ($lng + 1 * 10.4) . " and geo_lng > " . ($lng - 1 * 10.4);
//                    break;
//                case 2:
//                    $conditions[] = "geo_lat < " . ($lat + 2 * 10.4) . " and geo_lat > " . ($lat - 2 * 10.4);
//                    $conditions[] = "geo_lng < " . ($lng + 2 * 10.4) . " and geo_lng > " . ($lng - 2 * 10.4);
//                    break;
//
//                case 3:
//                    $conditions[] = "geo_lat < " . ($lat + 3 * 10.4) . " and geo_lat > " . ($lat - 3 * 10.4);
//                    $conditions[] = "geo_lng < " . ($lng + 3 * 10.4) . " and geo_lng > " . ($lng - 3 * 10.4);
//
//                    break;
//                case 4:
//                    $conditions[] = "geo_lat < " . ($lat + 4 * 10.4) . " and geo_lat > " . ($lat - 4 * 10.4);
//                    $conditions[] = "geo_lng < " . ($lng + 4 * 10.4) . " and geo_lng > " . ($lng - 4 * 10.4);
//                    break;
//                case 5:
//                    $conditions[] = "geo_lat < " . ($lat + 5 * 10.4) . " and geo_lat > " . ($lat - 5 * 10.4);
//                    $conditions[] = "geo_lng < " . ($lng + 5 * 10.4) . " and geo_lng > " . ($lng - 5 * 10.4);
//                    break;
//                case 7:
//                    $conditions[] = "geo_lat < " . ($lat + 7 * 10.4) . " and geo_lat > " . ($lat - 7 * 10.4);
//                    $conditions[] = "geo_lng < " . ($lng + 7 * 10.4) . " and geo_lng > " . ($lng - 7 * 10.4);
//                    break;
//                case 10:
//                    $conditions[] = "geo_lat < " . ($lat + 10 * 10.4) . " and geo_lat > " . ($lat - 10 * 10.4);
//                    $conditions[] = "geo_lng < " . ($lng + 10 * 10.4) . " and geo_lng > " . ($lng - 10 * 10.4);
//                    break;
//            }
//        }
        //计算整个经纬度里面的所有场地
        if (!empty($request['right_top_lng']) && !empty($request['right_top_lat']) && !empty($request['left_down_lng']) && !empty($request['left_down_lat'])) {
            $request['right_top_lng'] = (float)$request['right_top_lng'] * 10000;
            $right_top_lng = substr($request['right_top_lng'], 0, 7);
            $request['right_top_lat'] = (float)$request['right_top_lat'] * 10000;
            $right_top_lat = substr($request['right_top_lat'], 0, 6);
            $request['left_down_lng'] = (float)$request['left_down_lng'] * 10000;
            $left_down_lng = substr($request['left_down_lng'], 0, 7);
            $request['left_down_lat'] = (float)$request['left_down_lat'] * 10000;
            $left_down_lat = substr($request['left_down_lat'], 0, 6);

            $conditions[] = "geo_lat < " . $right_top_lat . " and geo_lat > " . $left_down_lat;
            $conditions[] = "geo_lng < " . $right_top_lng . " and geo_lng > " . $left_down_lng;

        }

        return $conditions;


    }


    /*****
     * @param $list
     * @return mixed
     *
     * 处理字段
     *
     */
    static function HandleField($list)
    {
        $cache = Data_Mysql_Table_Cache_Array::get('_map_search',  'map');
        if (!is_array($list)) {
            return false;
        }
        $activity_type='';
        foreach ($list as $k => $v) {

//            $list[$k]['price'] = $v['price'] > 10000 ? $v['price'] / 100 : 0;
            $list[$k]['attr'] = json_decode($v['attr'], 1);
            if (!empty($list[$k]['attr'][49])&&trim($list[$k]['attr'][49])) {
                $activity_type = explode(',', str_replace('、',',',$list[$k]['attr'][49]));
            }

            if (empty($activity_type)) {
                $activity_type =array(@$cache[112][$v['category_id']]);

            }

            $list[$k]['activity_type'] = @array_slice($activity_type, 0, 3, 1);
            $list[$k]['space_name_url'] = Func_Url::str_urlencode($v['space_name'],1);

        }
        return $list;
    }

}