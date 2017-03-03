<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15-9-17
 * Time: 地图搜索
 */
class Web_Map_Search_V2
{

    static function  handle()
    {

        $seo = array(
            '网页标题'=>'【云SPACE－活动场地租赁平台】发布会_路演_展览_演出_答谢会_分享会场地_秀场_展馆_剧院_商场',
            '网页关键词'=>"云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定",
            '网页简介'=>"云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地",
        );
        Tpl_Smarty::assign('seo',$seo);
//        Tpl_Smarty::assign('searchTags', self::searchTags());
        Tpl_Smarty::assign('searchNewTags', self::searchNewTags());
        Tpl_Smarty::assign('topTagsName', self::topTagsName());
//        Tpl_Smarty::assign('city_area', self::city_area());
        Tpl_Smarty::assign('distance', self::distance());
        Tpl_Smarty::assign('demand', Data_Demand_Option_Config::all());
        self::getSpaceList();
        Web_Global::display('Web_Static::map.v1.0/html_map_php.tpl');
    }

    static function  distance()
    {
        return array(

            1 => '1公里',
            3 => '3公里',
            5 => '5公里',
            7 => '7公里',
            10 => '10公里',
        );

    }

    static function  conditions()
    {
        $children = Data_Mysql_Table_Spacepedia::getChildren(112);
        $children[] = 112;
        $conditions['status =?'] = 1;
        $conditions[] = 'category_id in (' . implode(',', $children) . ')';
        //  $conditions[] = 'category_id in (666)';

//        $conditions['city'] = $_COOKIE['city'];
        return $conditions;
    }

    static function  getSpaceList()
    {

        $conditions = self::conditions();
        $request = Func_Input::filter(array(
            'orderBy' => 'int'
        ));
//        排序方式
        switch ($request['orderBy']) {
            case '2':
                $order = 'ORDER BY order_index DESC';
                break;
            case '3':
                $order = 'ORDER BY update_time DESC';
                break;
            default:
                $order = 'ORDER BY order_index DESC';
                break;
        }
        //查询数据库
        $list = Data_Mysql_Table_Spacepedia_Search::page(0, 0, '*', $conditions, $order);
//        Q($list);
        if (!empty($list['rows'])) {
            $list['rows'] = Api_Map_Search_SpaceList_v2::HandleField($list['rows']);
        } else {
            //相关推荐
//            $data = Api_Space_Recommend::handle($conditions);
//
//            Tpl_Smarty::assign('recommend', $data['data']);
        }
        $coordinate = Api_Map_Search_SpaceList_v2::coordinate($conditions, $order, $list['page']);
        Tpl_Smarty::assign('coordinate', @json_encode($coordinate));
        $pageCoordinate = Api_Map_Search_SpaceList_v2::pageCoordinate($list['rows']);
        Tpl_Smarty::assign('pageCoordinate', json_encode($pageCoordinate));
        Tpl_Smarty::assign('list', $list);

    }

    /**
     * @return array
     * 搜索用到的标签
     */
    static function  searchTags()
    {

        $cache = Data_Mysql_Table_Cache_Array::get('_map_search', 'map');
        if (!empty($cache)) {
            return $cache;
        }

        $menu_data = Data_Mysql_Table_Product_Category::getTreeCache();
        $menu[0] = '不限';
        foreach ($menu_data[112] as $k => $v) {
            $menu[$k] = trim($v);
        }
        $product_size[0] = '不限';
        $service_trade[0] = '不限';
        $activity_type[0] = '不限';
        $people[0] = '不限';

        //面积
        $product_size_data = Data_Mysql_Table_Product_Search::$product_size;
        foreach ($product_size_data as $k => $v) {
            $product_size[$k] = trim($v);
        }
        //人数
        $people_data = Data_Demand_Option_Config::get('people');
        foreach ($people_data as $k => $v) {
            $people[trim($k)] = trim($v);
        }
        $attr = Data_Config_Vendor_Attr::get('attr');
        //活动类型  49
        foreach ($attr['活动类型'] as $v) {
            $activity_type[trim($v)] = trim($v);
        }
        //服务行业  9
        foreach ($attr['服务行业'] as $v) {
            $service_trade[trim($v)] = trim($v);
        }
        $data = array(
            112 => $menu,
            8 => $people,

            10 => $product_size,
            49 => $activity_type,
            9 => $service_trade,
        );
//        Data_Mysql_Table_Cache_Array::set('_map_search', $_COOKIE['city'] . 'map', $data);
        Data_Mysql_Table_Cache_Array::set('_map_search',  'map', $data);
        return $data;
    }
    static function  searchNewTags()
    {

//        $cache = Data_Mysql_Table_Cache_Array::get('_map_search', $_COOKIE['city'] . 'map');
//        if (!empty($cache)) {
//            return $cache;
//        }

        $menu_data = self::getBaiKeCategory();
        $menu[0] = '不限';
        foreach ($menu_data as $k => $v) {
            $menu[$v] = trim($v);
        }
        $product_size[0] = '不限';
//        $service_trade[0] = '不限';
        $activity_type[0] = '不限';
//        $people[0] = '不限';

        //面积
        $product_size_data = self::getSizeRange();
        foreach ($product_size_data as $k => $v) {
            $product_size[$k] = trim($v);
        }
        //人数
//        $people_data = Data_Demand_Option_Config::get('people');
//        foreach ($people_data as $k => $v) {
//            $people[trim($k)] = trim($v);
//        }
        $attr = self::getActiveType();
        //活动类型  49
        foreach ($attr as $v) {
            $activity_type[trim($v)] = trim($v);
        }
//        //服务行业  9
//        foreach ($attr['服务行业'] as $v) {
//            $service_trade[trim($v)] = trim($v);
//        }
        $data = array(
            112 => $menu,
//            8 => $people,

            49 => $activity_type,
            10 => $product_size,
//            9 => $service_trade,
        );
//        Data_Mysql_Table_Cache_Array::set('_map_search', $_COOKIE['city'] . 'map', $data);
        return $data;
    }
//    //城市，行政区域
//    static  function  getCityArr(){
//        $cityArr = array(
//            'sh' => '上海',
//            'bj' => '北京',
//            'gz' => '广州',
//            'sz' => '深圳',
//            'cd' => '成都',
//            'hz' => '杭州',
//            'nj' => '南京',
//            'suzhou' => '苏州',
//            'chongqing' => '重庆',
//            'wuhan' => '武汉',
//            'xian' => '西安',
//            'changsha' => '长沙',
//            'kunming' => '昆明',
//            'guiyang' => '贵阳',
//            'dali' => '大理',
//            'lijiang' => '丽江',
//            'dalian' => '大连',
//            'qingdao' => '青岛',
//            'xiameng' => '厦门',
//        );
//        return $cityArr;
//    }
//
//    static function getAreas($city){
//        if(empty($city)){
//            $city = empty($_REQUEST['city_key'])?'':$_REQUEST['city_key'];
//        }
//        $cityArray =self::getCityArr();
//        if(!empty($cityArray[$city])){
//            $areaArray =  Data_Mysql_Table_Cache_Array::get('_space_category',$cityArray[$city]);
//            if(!empty($areaArray)){
//                return $areaArray;
//            }else{
//                $new_area_array = array();
//                $list = Data_Mysql_Table_Spacepedia_Search::select("id,attr",array('city=?'=>$cityArray[$city],'status=?'=>1),'ORDER BY level DESC',200);
//                foreach($list as $k=>$v){
//                    $v['attr']=json_decode($v['attr'],1);
//                    if(!empty($v['attr'][4])&& !in_array($v['attr'][4],$new_area_array)){
//                        $new_area_array[] = $v['attr'][4];
//                    }
//                }
//                Data_Mysql_Table_Cache_Array::set('_space_category',$cityArray[$city],$new_area_array,3600*24*7);
//                return $new_area_array;
//            }
//        }else{
//            return array();
//        }
//    }


    //百科类型
    static function  getBaiKeCategory($cid=112){
        $category_name_array = Data_Mysql_Table_Spacepedia::$category_name;
        $new_category_name_array  = array();
        foreach($category_name_array as $k=>$v){
            if($v['parent']==$cid){
                $new_category_name_array[$v['id']] = $v['name'];
            }
        }
        return $new_category_name_array;
    }

    //面积范围

    static function  getSizeRange(){
        $product_size = array(
            1 => '小于200㎡',
            200 => '200-500㎡',
            500 => '500-800㎡',
            800 => '800-1000㎡',
            1000 => '1000-2000㎡',
            2000 => '2000㎡以上',
        );
        return $product_size;
    }
    //活动类型
    static function  getActiveType(){
        $vendor_attr =  Data_Config_Vendor_Attr::get('attr');
        $new_active_type_array =$vendor_attr['活动类型'];
        return $new_active_type_array;
    }

    static function  topTagsName()
    {
        $data = array(
            112 => '场地类型',
            8 => '适合人数',
            49 => '活动类型',
            9 => '服务行业',
            10 => '场地面积',
        );
        return $data;
    }


    static function   city_area()
    {
        //TODO::开通城市需要手动新增city_code

        switch ($_COOKIE['city']) {
            case '北京':
                $city_code = 110100;
                break;
            case '广州':
                $city_code = 440100;
                break;
            case '深圳':
                $city_code = 440300;
                break;
            case '成都':
                $city_code = 510100;
                break;
            case '杭州':
                $city_code = 330100;
                break;
            case '南京':
                $city_code = 320100;
                break;
            case '苏州':
                $city_code = 320500;
                break;
            case '青岛':
                $city_code = 370200;
                break;
            case '武汉':
                $city_code = 420100;
                break;
            case '大连':
                $city_code = 210200;
                break;
            case '西安':
                $city_code = 610100;
                break;
            case '长沙':
                $city_code = 430100;
                break;
            case '昆明':
                $city_code = 530100;
                break;
            case '贵阳':
                $city_code = 520100;
                break;
            case '大理':
                $city_code = 532901;
                break;
            case '丽江':
                $city_code = 530700;
                break;
            case '厦门':
                $city_code = 350200;
                break;

            default:
                $city_code = 310100;
        };
        $data = Api_City_Auto_Complete::getCity(array('city_code' => $city_code));
        return $data['data'];
    }
}