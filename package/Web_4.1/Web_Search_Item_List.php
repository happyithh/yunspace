<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/6/16
 * Time: 15:52
 * 子空间搜索
 */
class Web_Search_Item_List extends Web_Global
{
    function seo()
    {

        $show = $this->getScreenValue();
        $title = '';
        unset($show['category']);
        foreach ($show as $k => $v) {
            $title = $title . $v;
        }
        $key = $this->getKeyword();
        $title = ((!empty($key['city']) && $key['city']!='不限') ? $key['city'] : '') . (!empty($key['active_type']) ? $key['active_type'] : '') . $title;
        if (!empty($key['category']) && $key['category'] != 112 && !empty($this->getCategory[$key['category']])) {
            $key['category'] = $this->getCategory[$key['category']];
        } else {
            $key['category'] = '';
        }
        if (!empty($key['category'])) {
            $title_new = $title . $key['category'] . '_活动场地,年会场地,场地租赁 - 云·SPACE';
        } else {
            $title_new = $title . '活动场地,年会场地,场地租赁 - 云·SPACE';
        }
        if(!empty($key['keyword2'])){
            if(!empty($key['lat']) && !empty($key['lat']) && empty($key['admin_area']) && empty($key['business_area'])){
                $title_new = $key['keyword2'].'附近-'.$title_new;
            }else{
                $title_new = $key['keyword2'].'相关-'.$title_new;
            }
        }
        return array(
            '网页标题' => $title_new,
            '网页关键词' => '云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地',
            '网页简介' => '云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定',
        );
    }

    /**
     *
     * 获取搜索字段内容  ----开始-----
     */

    //获取场地类型
    function getCategory()
    {
        $category = Data_Mysql_Table_Spacepedia::getChildrenByCid(112);
        $category[112] = '空间';
//        ksort($category);
        return $category;
    }

    // 获取行政区域
    function  getArea()
    {
        $conditions['city'] = $this->getKeyword['city'];
        // $_REQUEST['update_area_cache']=1 清空行政区域缓存数据
        if(empty($_REQUEST['update_area_cache'])){
            $attr_1 = Api_Common_Cache::get('item_area', $conditions['city']);
        }
        if (empty($attr_1) || (isset($_REQUEST['update_area_cache']) && $_REQUEST['update_area_cache']==1)) {
                $attr = Data_Mysql_Table_Search_Space_Item::getArea($conditions);
                if(!empty($attr)){
                    $area = json_encode($attr['行政区域'], 1);
                    Api_Common_Cache::set('item_area', $conditions['city'], $area, 3600 * 24 * 30);
                    $attr['行政区域'] = array_values($attr['行政区域']);
                }
        } else {
            $attr['行政区域'] = json_decode($attr_1, 1);
            $attr['行政区域'] = array_values($attr['行政区域']);
        }

        return $attr;
    }

    // 获取所属商圈
    function getBusinessArea()
    {
        $conditions['city'] = $this->getKeyword['city'];
        // $_REQUEST['update_cache_business'] =1 清空商圈缓存数据
        if(empty($_REQUEST['update_business_cache'])){
            $attr_1 = Api_Common_Cache::get('item_business_area', $conditions['city']);
        }
        if (empty($attr_1) || (isset($_REQUEST['update_business_cache']) && $_REQUEST['update_business_cache']==1)) {
                $attr = Data_Mysql_Table_Search_Space_Item::getBusinessArea($conditions);
                if(!empty($attr)){
                    $business = json_encode($attr['所属商圈'],1);
                    Api_Common_Cache::set('item_business_area', $conditions['city'], $business, 3600 * 24 * 7);
                    $attr['所属商圈'] = array_values($attr['所属商圈']);
                }
        }else{
            $attr['所属商圈'] = json_decode($attr_1,1);
            $attr['所属商圈'] = array_values($attr['所属商圈']);
        }
        return $attr;
    }

    // 获取行业类型
    function getIndustryType()
    {
        return Data_Mysql_Table_Search_Space_Item::$industry_attr;
    }

    // 获取子空间相关搜索
    function getSearchKeywordList()
    {
        $request = $this->getKeyword;
        if (!empty($request['keyword2'])) {
            $condition = array(
                " search_title like '" . $request['keyword2'] . "%'"
            );
            $condition['search_type'] = 'space_item';
            $list = Data_Mysql_Table_Search_Logm::select("*", $condition, ' GROUP BY search_title ORDER BY  search_time DESC,date_time DESC', 10);
            return $list;
        }
    }

    // 搜索人数区间
    function getPeople()
    {
        $people = array(
            'min' => '50人以下',
            '50,100' => '50-100人',
            '100,300' => '100-300人',
            '300,500' => '300-500人',
            '500,1000' => '500-1000人',
            '1000' => '1000人以上',
        );
        return $people;
    }

    // 搜索面积区间
    function getSize()
    {
        $size = array(
            'min' => '小于200m²',
            '200,500' => '200-500m²',
            '500,800' => '500-800m²',
            '800,1000' => '800-1000m²',
            '1000,2000' => '1000-2000m²',
            '2000' => '2000m²以上',
        );
        return $size;
    }

    // 搜索价格区间
    function getPrice()
    {
        $size = array(
            'min' => '2000元以下',
            '2000,5000' => '2000-5000元',
            '5000,10000' => '5000-1万元',
            '10000,30000' => '1万-3万',
            '30000,50000' => '3万-5万元',
            '50000' => '5万以上',
        );
        return $size;
    }

    /**
     * 获取搜索字段内容         ----------结束----------
     */


    // 获取子空间列表
    function getItemSearchList()
    {
        $data = Api_Search_Item_List::getSearchItemList($this->getKeyword());
        return $data;

    }

    /**
     *
     * 处理搜 索字段    -----开始-----
     */
    // 处理搜索字段
    function getKeyword()
    {
        $key_deal = self::$key_deal;
        $all_city = Web_Global::$city_name;

        if (!empty($_REQUEST['filter'])) {
            // 兼容老版本
            foreach ($_REQUEST['filter'] as $k => $v) {
                if (array_key_exists($k, $key_deal)) {
                    $_REQUEST[$key_deal[$k]] = trim($v);
                }
            }
        }
        $action = Func_Url::str_urldecode(Func_String::utf8(Core::$urls['action']));
        $keywords = explode('-', $action);
        $getValue = array();
        if (!empty(explode('tags/', $action)[1])) {
            $getValue = explode('-', explode('tags/', $action)[1]);
        }
        //是否设置cookie 的开关
        $set_cookie = 0;
        if (!empty($keywords[0]) && !is_numeric($keywords[0])) {
            if(!empty($all_city[$keywords[0]])){
                $_REQUEST['city'] = array_key_exists($keywords[0],$all_city)?$all_city[$keywords[0]]:'';
            }elseif($keywords[0]=='wod'){
                $_REQUEST['city']='不限';
            }
            $set_cookie = 1;
        } elseif (!empty($_GET['city'])) {
            $_REQUEST['city'] = $_GET['city'];
            $set_cookie = 1;
        }
        if(empty($_REQUEST['city'])){
            $_REQUEST['city']='不限';
        }
        if ($set_cookie == 1) {
            $is_exist = in_array($_REQUEST['city'], $all_city);
            if ($is_exist) {
                setcookie('city', $_REQUEST['city'], time() + 3600 * 24 * 30, '/');
                setcookie('city_key', $is_exist, time() + 3600 * 24 * 30, '/');
            }
        }
        if (!isset($_REQUEST['category'])) {
            $_REQUEST['category'] = (!empty($keywords[1]) && is_numeric($keywords[1])) ? $keywords[1] : '';
        }
        // 获取搜索标签val ------最新版本-----
        if(!empty($keywords) && !empty($getValue) ) {
            array_shift($keywords);
            array_shift($keywords);
            array_pop($keywords);
            foreach($keywords as $k=>$v){
                if(!empty($key_deal[$v])&&!empty($getValue[$k])){
                    $_REQUEST[$key_deal[$v]] = $getValue[$k];
                }
            }
        }
        if (isset($_REQUEST['active_type']) && $_REQUEST['active_type'] == '全部') {
            unset($_REQUEST['active_type']);
        }
        $request = Func_Input::filter(array(
            'city' => 'string',
            'active_type' => 'string',
            'category' => 'int',
            'is_outside' => 'int',
            'rank' => 'string',
            'admin_area' => 'string',  // 行政区域
            'business_area' => 'string',
            'industry_type' => 'string',
            'keyword2' => 'string',
        ), $_REQUEST);
        // 经纬度搜索处理   限制条件$area、$key、$lat
        $area = empty($request['admin_area']) && empty($request['business_area']);
        $key = !empty($request['city']) && $request['city']!='不限' && !empty($request['keyword2']) && (mb_strlen($request['keyword2'])>3);
        $lat = !empty($_REQUEST['lat']) && !empty($_REQUEST['lng']);
        if ($area==true && $key==true &&  $lat==true) {
            $getLatLng = $this->getLatLngData($request);
            if (!empty($getLatLng['lat']) && !empty($getLatLng['lng'])) {
                $request['lat'] = $getLatLng['lat'];
                $request['lng'] = $getLatLng['lng'];
                $_REQUEST['lat'] = $getLatLng['lat']/10000;
                $_REQUEST['lng'] = $getLatLng['lng']/10000;
            }
        }else{
            unset($_REQUEST['lat']);
            unset($_REQUEST['lng']);
        }
        /*
        *  自定义字段处理
        *
        */
        $keyword_array = self::dealCustomField();
        $custom = self::$custom;
        foreach ($custom as $k => $v) {
            $request[$v] = $keyword_array[$v];
        }
        return $request;
    }

    /**
     * 使用经纬度搜索时，去缓存表检查与内部定位的经纬度是否一致，不一致，去search_space_item表查询内部经纬度
     * 一致则直接使用。
     *
     */
    function getLatLngData($keyword)
    {
        $request = Func_Input::filter(array(
            'lat' => 'int',
            'lng' => 'int',
        ), $_REQUEST);
        $request['lng'] = substr((float)$request['lng'] * 10000, 0, 7);
        $request['lat'] = substr((float)$request['lat'] * 10000, 0, 6);
        $cache = Data_Mysql_Table_Search_Lat_Lng::get(trim($keyword['city']) . trim($keyword['keyword2']));
        // 缓存表存在经纬度
        if (!empty($cache[0])) {
            // 完全符合条件直接使用
            if ($request['lng'] == $cache['lng'] && $request['lat'] == $cache['lat'] && $cache['status'] == 1 && (time() - $cache['update_time'] < 86400 * 10)) {
                return $request;
            }
            // 百度地图数据或者时间过期  更新经纬度
            if($cache['status'] == 0 || (time() - $cache['update_time'] >= 86400 * 10)){
                $con['baike_status'] = 1;
                $con['item_status'] = 1;
                $con['baike_item_name LIKE ?'] = '%'.$keyword['keyword2'].'%';
                $con['city'] = $keyword['city'];
                $getLl = Data_Mysql_Table_Search_Space_Item::select('geo_lat,geo_lng', $con, '', 1);
                if (!empty($getLl[0])) {
                    $request['lng'] = $getLl[0]['geo_lng'];
                    $request['lat'] = $getLl[0]['geo_lat'];
                    Data_Mysql_Table_Search_Lat_Lng::setUpdate(trim($keyword['city']) . trim($keyword['keyword2']), $request, $cache[0]['id']);
                    return  $request;
                }else{
                    return $request;
                }
            }
        } else {
            // 缓存表不存在经纬度
            $con['baike_status'] = 1;
            $con['item_status'] = 1;
            $con['baike_item_name LIKE ?'] = '%'.$keyword['keyword2'].'%';
            $con['city'] = $keyword['city'];
            $getLl = Data_Mysql_Table_Search_Space_Item::select('geo_lat,geo_lng', $con, '', 1);
            if (!empty($getLl[0])) {
                $request['lng'] = $getLl[0]['geo_lng'];
                $request['lat'] = $getLl[0]['geo_lat'];
                Data_Mysql_Table_Search_Lat_Lng::set(trim($keyword['city']) . trim($keyword['keyword2']), $request, 1);
                return $request;
            } else {
                Data_Mysql_Table_Search_Lat_Lng::set(trim($keyword['city']) . trim($keyword['keyword2']), $request, 0);
                return $request;
            }
        }
    }


    //获取筛选条件的值
    function getScreenValue()
    {
        $value = $this->getKeyword();
        if ($value['category'] != 112 && !empty($value['category']) && !empty($this->getCategory[$value['category']])) {
            $value['category'] = $this->getCategory[$value['category']];
        } else {
            $value['category'] = '';
        }

        /*
         *  自定义字段处理
         *
         */
        $custom = self::$custom;
        foreach ($custom as $k => $v) {
            $cus = explode(',', $value[$v]);
            $cus_new = array_filter($cus);
            $cuskey = implode('-', $cus_new);
            if (!empty($value[$v])) {
                switch ($k) {
                    case 'size':
                        if (!empty($this->getSize[$value[$v]])) {
                            $value[$v] = '空间面积:'.$this->getSize[$value[$v]];
                        } else {
                            $value[$v] = '空间面积:'.$cuskey . 'm²';
                        }
                        break;
                    case 'people':
                        if (!empty($this->getPeople[$value[$v]])) {
                            $value[$v] = '容纳人数:'.$this->getPeople[$value[$v]];
                        } else {
                            $value[$v] = '容纳人数:'.$cuskey . '人';
                        }
                        break;
                    case 'price':
                        if (!empty($this->getPrice[$value[$v]])) {
                            $value[$v] = '空间价格:'.$this->getPrice[$value[$v]];
                        } else {
                            $value[$v] = '空间价格:'.$cuskey . '元';
                        }
                        break;
                }

            } else {
                unset($value[$v]);
            }
            if (is_numeric($cuskey) && !strstr($value[$v],'以上')) {
                if (!empty($cus_new[1])) {
                    $value[$v] = $value[$v] . '以下';
                } else {
                    $value[$v] = $value[$v] . '以上';
                }
            }
        }
        if (!empty($value['is_outside'])) {
            switch ($value['is_outside']) {
                case '1':
                    $value['is_outside'] = '室内';
                    break;
                case '5':
                    $value['is_outside'] = '开放';
                    break;
                case '3':
                    $value['is_outside'] = '半开放';
                    break;
            }
        }
        unset($value['rank']);
        unset($value['keyword2']);
        unset($value['city']);
        unset($value['active_type']);
        unset($value['lat']);
        unset($value['lng']);
        return $value;

    }

    // 搜索无结果时显示的数据

    function showScreenValue(){
        $show = $this->getScreenValue();
        if(!empty($show['category'])){
            $show['category'] = '场地：'.$show['category'];
        }
        if(!empty($show['admin_area'])){
            $show['admin_area'] = '区域：'.$show['admin_area'];
        }
        if(!empty($show['business_area'])){
            $show['business_area'] = '商圈：'.$show['business_area'];
        }
        if(!empty($show['industry_type'])){
            $show['industry_type'] = '行业：'.$show['industry_type'];
        }
        return $show;
    }

    // 返回拼接后的URL字符串
    function  getUrls($search_key, $val = '')
    {
//        Func_Console::logger($search_key, $val);
        if (strstr(Core::$urls['uri'], '/space/')) {
            $preuri = '/space/';  //拿到Uri前缀\
        } else {
            $preuri = '/space';  //拿到Uri前缀\
        }
        $uri = str_replace($preuri, '', Func_Url::str_urldecode(Func_String::utf8(Core::$urls['uri'])));     //去除前缀，避免匹配到Action数字
        $uri_arr = explode('?', $uri);      //标签显示过滤掉Uri中的面积 ?size_range=200
        // 获取前半部分的val值
        if (strstr($uri, 'tags')) {
            $tag_val = explode('tags/', $uri)[1];
            if (strstr($tag_val, '?')) {
                $tag_val_1 = explode('?', $tag_val);  // 去除?之后的参数
                $tag_val = explode('-', $tag_val_1[0]);
            } else {
                $tag_val = explode('-', $tag_val);
            }
        } else {
            $tag_val = array();
        }
        // 获取前半部分的key值
        if (!empty($uri_arr[0])) {
            if (!empty($tag_val)) {
                $tag_arr = explode('-', explode('-tags/', $uri)[0]);
            } else {
                $tag_arr = explode('-', $uri_arr[0]);
            }
        } else {
            $tag_arr = array();
        }
        // ?之前的处理
        $url_pre = self::getUrlPre($tag_arr, $tag_val, $search_key, $val);
        // ?之后的处理
        if (!empty($_REQUEST['keyword2']) || (!empty($_REQUEST['lat']) && !empty($_REQUEST['lng']))) {
            $keywords = Func_Input::filter(array(
                'keyword2' => 'string',
                'lng' => 'int',
                'lat' => 'int',
            ), $_REQUEST);
        }
        if (!empty($keywords)) {
            $url_pre = $url_pre . '?keyword2=' . $keywords['keyword2'] ;
            if(!empty($keywords['lng']) && !empty($keywords['lat'])){
                $url_pre = $url_pre.'&lng=' . $keywords['lng'] . '&lat=' . $keywords['lat'];
            }
        }
        return $url_pre;
    }

    // 获取?之前的处理
    function getUrlPre($tag_arr, $tag_val, $search_key, $val)
    {
        // ?之前的url处理
        /*
         * 场地类型处理
         * */
        if ($search_key == 'category') {
            $tag_arr[1] = !empty($val) ? $val : 112;
        } else {
            if ((!isset($tag_arr[1]) || !is_numeric($tag_arr[1])) && !empty($_REQUEST['category'])) {
                $tag_arr[1] = $_REQUEST['category'];
            } else {
                $tag_arr[1] = empty($tag_arr[1]) ? '112' : $tag_arr[1];
            }
        }
        // 兼容带有部分参数的版本 带有参数： size_range=100
//        if (!empty($_REQUEST['size_range']) && !in_array('size', $tag_arr) && !is_array($_REQUEST['size_range'])) {
//            $size = Func_Input::filter(array('size_range' => 'string'), $_REQUEST);
//            $tag_arr[] = 'size';
//            $tag_val[] = $size['size_range'];
//        }


        array_unshift($tag_val,'aaa');
        array_unshift($tag_val,'bbb');

        // 如果$tag_arr在$tag_val中没有对应的值存在，则清空$tag_arr中的key
        foreach($tag_arr as $k=>$v){
            if(empty($tag_val[$k])){
                if(isset($tag_val[$k])){
                    unset($tag_val[$k]);
                }
                unset($tag_arr[$k]);
            }
        }
        // 数据处理
        $key_deal = self::$key_deal;
        $tag_arr_new = !empty($tag_arr) ?array_flip($tag_arr):array();


        /*
       * 处理自定义搜索  价格price、面积size、人数people
       */
        $custom = self::$custom;
        foreach ($custom as $k => $v) {
            if (empty($tag_arr_new[$k])) {
                if (isset($_REQUEST[$v]) && is_array($_REQUEST[$v]) && $search_key != $v) {
                    $cus = Func_Input::filter(array($v => 'array'), $_REQUEST);
                    $is_array[$k] = implode(',', $cus[$v]);
                    $tag_arr[] = $k;
                    $tag_val[] = $is_array[$k];
                }
            }
        }

        foreach ($key_deal as $k => $v) {
            if ($search_key == $v) {
                if (!empty($tag_arr_new[$k])) {
                    $key_k = $tag_arr_new[$k];
                    // 清空之前数据

                    if(!empty($tag_val[$key_k])) {
                        unset($tag_val[$key_k]);
                    }
                    unset($tag_arr[$key_k]);
                    // 行政区域和所属商圈是所属关系，当行政区域改变的时候，清空所属商圈 商圈标识：2
                    if ($search_key == 'admin_area' && !empty($tag_arr_new[2])) {
                        if(!empty($tag_val[$tag_arr_new[2]])){
                            unset($tag_val[$tag_arr_new[2]]);
                        }
                        unset($tag_arr[$tag_arr_new[2]]);
                    }
                }
                if (!empty($val)) {
                    $tag_arr[] = $k;
                    $tag_val[] = $val;
                }
            }
            // 兼容form表单提交的数据
//            q(!in_array($k, $tag_arr),array_key_exists($v,$_REQUEST),$v,$_REQUEST);
            if (empty($tag_arr_new[$k])  &&  !empty($_REQUEST[$v]) &&  !is_array($_REQUEST[$v]) && $v!=$search_key) {
                $tag_arr[] = $k;
                $tag_val[] = $_REQUEST[$v];
            }
        }
        /*
        * 城市处理
        * */

        if ($search_key == 'city') {
//            Func_Console::logger($search_key, $val);
            if (!empty(Web_Global::$city_name[$val])) {
                $tag_arr[0] = $val;
            } else {
                $tag_arr[0] = 'wod';
            }
            if(!empty($tag_arr_new[4])){
                unset($tag_val[$tag_arr_new[4]]);
                unset($tag_arr[$tag_arr_new[4]]);
            }
            if(!empty($tag_arr_new[2])){
                unset($tag_val[$tag_arr_new[2]]);
                unset($tag_arr[$tag_arr_new[2]]);
            }
        } else {
            if (empty($tag_arr[0]) || is_numeric($tag_arr[0])) {
                if (!empty($_REQUEST['city'])) {
                    $city = array_search($_REQUEST['city'], Web_Global::$city_name);
                } else {
                    $city = 'wod';
                }
                $tag_arr[0] = $city;
            }

        }
        array_shift($tag_val);
        array_shift($tag_val);
        ksort($tag_arr);
        if(empty($tag_arr[0])){
            $tag_arr[0]='wod';
        }
        if (!empty($tag_val)) {
            $url_pre = implode('-', $tag_arr) . '-tags/' . implode('-', $tag_val);
        } else {
            $url_pre = implode('-', $tag_arr);
        }
        return $url_pre;
    }

    // 参数url标识
    static $key_deal = array(
        '2' => 'business_area',
        '4' => 'admin_area',
        '9' => 'industry_type',
        '49' => 'active_type',
        'people' => 'people_range',
        'size' => 'size_range',
        'outside' => 'is_outside',
        'rank' => 'rank',
        'price' => 'price_range',
    );

    // 配置图标处理
    function icon_arr()
    {
        return $icon_arr = array(
            '卫手间' => 'wc',
            '化妆间' => 'dressing',
            '网路WIFI' => 'wifi',
            '空调暖气' => 'air-conditioning',
            '休息室' => 'lounge',
            '空间吊点' => 'space-hoisting',
            '停车场' => 'carpark',
            '货运电梯' => 'lift',
            '投影LED' => 'projection',
            '灯光音响' => 'sound',
        );
    }


    //   自定义搜索  价格price、面积size、人数people

    static $custom = array(
        'price' => 'price_range',
        'size' => 'size_range',
        'people' => 'people_range',
    );

    function dealCustomField($search_key = '')
    {
        $is_array = array();
        $custom = self::$custom;
        foreach ($custom as $k => $v) {
            if (isset($_REQUEST[$v]) && is_array($_REQUEST[$v]) && $search_key != $v) {
                $cus = Func_Input::filter(array($v => 'array'), $_REQUEST);
                $is_array[$v] = implode(',', $cus[$v]);
            } else {
                $cus = Func_Input::filter(array($v => 'string'), $_REQUEST);
                $is_array[$v] = $cus[$v];
            }
        }
        return $is_array;
    }

    function customShow()
    {
        $custom = $this->dealCustomField();
        if (isset($custom['size_range']) && empty($this->getSize[$custom['size_range']])) {
            $custom_arr['size_range'] = explode(',', $custom['size_range']);
        }
        if (isset($custom['price_range']) && empty($this->getPrice[$custom['price_range']])) {
            $custom_arr['price_range'] = explode(',', $custom['price_range']);
        }
        if (isset($custom['people_range']) && empty($this->getPeople[$custom['people_range']])) {
            $custom_arr['people_range'] = explode(',', $custom['people_range']);
        }
        return $custom_arr;

    }

    /**
     *
     * 处理搜索字段    -----结束-----
     */

}