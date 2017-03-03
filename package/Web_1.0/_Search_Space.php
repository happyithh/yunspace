<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15-5-4
 * Time: 搜索
 */
class Web_Search_Space extends Page_Base
{
    function __construct()
    {
        $this->topCategoryId;
    }

    //默认值
    function  webConfig()
    {
        return Data_Config_Site::get('service_list');
    }


    //接受REQUEST 过的值
    function  request()
    {
        $request = Func_Input::filter(array(
            'keyword' => 'string',
            'category_id' => 'int',
            'filter' => 'array',
            'size_range' => 'int',
            'orderBy' => 'int',
            'nearbymi' => 'string',   //附近距离
            'baidu_lng' => 'string',  //坐标点
            'baidu_lat' => 'string',  //坐标点
            "activity" => "string",   //活动类型
            "industry" => "string",   //适合行业
            "adminarea" => "string",   //行政区域
            "businesscircle" => "string",   //商圈
        ), $_REQUEST);
//        foreach($request as $k=>$v){
////            if(!empty($v)&&!is_array($v)){
////                $request[$k]=Func_String::RemoveXSS($v);
////            }
//            if(!empty($v)&&is_array($v)){
////                $v_tmp = array_map(function ($val) {
////                    $val= Func_String::RemoveXSS($val);
////                    return $val;
////                }, $v);
//                $request[$k]= $v;
//            }
//        }
        if (!empty($request['activity'])) {
            $request['filter'][49] = $request['activity'];
        }
        if (!empty($request['industry'])) {
            $request['filter'][9] = $request['industry'];
        }
        if (!empty($request['adminarea']) && !isset($request['nearbymi']) && !isset($request['businesscircle'])) {
            $request['filter'][4] = $request['adminarea'];
        }
        if (!empty($request['businesscircle']) && !isset($request['nearbymi']) && !isset($request['adminarea'])) {
            $request['filter'][2] = $request['businesscircle'];
        }
        if (!empty($request['filter'])) {
            foreach ($request['filter'] as $k => $v) {
                if ($v == 'all') {
                    unset($request['filter'][$k]);
                }
            }
        }
        return $request;
    }
    function request_filter(){
        $request = $this->request();
        if(isset($request['filter'])){
            foreach ($request['filter'] as $k => $v) {
                $filterAttr = $this->filterAttr();
                $v = strip_tags($v);
                if(array_key_exists($v,$filterAttr[$k]['val'])){
                    $request['filter'][$k] = $v;
                }else{
                    unset($request['filter'][$k]);
                }
                if ($v == 'all') {
                    unset($request['filter'][$k]);
                }
            }
        }
        return $request;
    }
    //城市tags  id
    function  cityId()
    {
        $cityId = Page_Site_Global::tagsName('城市');
        return $cityId;
    }

    //分类categoryId
    function  categoryId()
    {

        if (!empty($this->request['category_id'])) {
            $categoryId = $this->request['category_id'];
        } elseif (is_numeric(Core::$urls['action'])) {
            $categoryId = Core::$urls['action'];
        } else {
            $categoryId = 0;
        }
        return $categoryId;
    }

    //条件
    function  conditions()
    {
        $conditions = array(
            'status' => 1,
        );
        $request = $this->request_filter();
        $categoryId = $this->categoryId;
        $webConfig = $this->webConfig;
        $cityId = $this->cityId;

        if (!empty($request['keyword'])) {
            $conditions['product_name'] = $request['keyword'];
            $conditions['addr'] = $request['keyword'];
            if(!$this->is_space){
                $conditions['vendor_name'] = $request['keyword'];
            }
        }

        if (!empty($request['filter'])) {
            $conditions['attr_index'] = array();
            foreach ($request['filter'] as $k => $v) {
                $conditions['attr_index'][$k] = '+' . trim($v);
            }
        }
        //分类
        if (!empty($categoryId)) {
            $children = Data_Mysql_Table_Product_Category::getChildren($categoryId);
            $children[] = $categoryId;
            $conditions[] = '{table}.category_id in (' . implode(',', $children) . ')';
        } else {
            $children = Data_Mysql_Table_Product_Category::getChildren($webConfig['space_id']);
            $children[] = $webConfig['space_id'];
            $conditions[] = '{table}.category_id not in (' . implode(',', $children) . ')';
        }
        if (!empty($_COOKIE['city'])) {
            $conditions['attr_index'][$cityId] = '+' . $_COOKIE['city'].',全国';
        } else {
            $_COOKIE['city'] = '上海';
        }
        $conditions['{table}.vendor_id !=?'] = 2697;
        //折扣，签约
//        if(!empty($_REQUEST['discount']) && $_REQUEST['discount']==1){
//
//        }
//        if(!empty($_REQUEST['signing']) && $_REQUEST['signing']==1){
//
//        }
        //面积筛选
        if (!empty($request['size_range'])) {
            $product_size = $request['size_range'];
            switch ($product_size) {
                case 1:
                    $conditions[] = 'order_product_size < 200';
                    break;
                case 200:
                    $conditions[] = 'order_product_size >=200 and  order_product_size <= 500';
                    break;
                case 500:
                    $conditions[] = 'order_product_size >=500 and  order_product_size <= 800';
                    break;
                case 800:
                    $conditions[] = 'order_product_size >=800 and  order_product_size <= 1000';
                    break;
                case 1000:
                    $conditions[] = 'order_product_size >=1000 and  order_product_size <= 2000';
                    break;
                case 2000:
                    $conditions[] = 'order_product_size > 2000';
                    break;
                default :
                    '';
                    break;
            }
        }
        if (!empty($request['nearbymi']) && !empty($request['baidu_lng']) && !empty($request['baidu_lat']) && !isset($request['adminarea']) && !isset($request['businesscircle'])) {
            $request['baidu_lng'] = (float)$request['baidu_lng'] * 1000;
            $lng = substr($request['baidu_lng'], 0, 6);
            $request['baidu_lat'] = (float)$request['baidu_lat'] * 1000;
            $lat = substr($request['baidu_lat'], 0, 5);
            switch ($request['nearbymi']) {
                case 1:
                    $conditions[] = "geo_lat < " . ($lat + 0.5 * 10.4) . " and geo_lat > " . ($lat - 0.5 * 10.4);
                    $conditions[] = "geo_lng < " . ($lng + 0.5 * 10.4) . " and geo_lng > " . ($lng - 0.5 * 10.4);
                    break;
                case 2:
                    $conditions[] = "geo_lat < " . ($lat + 1 * 10.4) . " and geo_lat > " . ($lat - 1 * 10.4);
                    $conditions[] = "geo_lng < " . ($lng + 1 * 10.4) . " and geo_lng > " . ($lng - 1 * 10.4);
                    $conditions[] = "(geo_lat >= " . ($lat + 0.5 * 10.4) . " OR geo_lat <= " . ($lat - 0.5 * 10.4) . ')';
                    $conditions[] = "(geo_lng >= " . ($lng + 0.5 * 10.4) . " OR geo_lng <= " . ($lng - 0.5 * 10.4) . ')';
                    break;
                case 3:
                    $conditions[] = "geo_lat < " . ($lat + 2 * 10.4) . " and geo_lat > " . ($lat - 2 * 10.4);
                    $conditions[] = "geo_lng < " . ($lng + 2 * 10.4) . " and geo_lng > " . ($lng - 2 * 10.4);
                    $conditions[] = "(geo_lat >= " . ($lat + 1 * 10.4) . " OR geo_lat <= " . ($lat - 1 * 10.4) . ')';
                    $conditions[] = "(geo_lng >= " . ($lng + 1 * 10.4) . " OR geo_lng <= " . ($lng - 1 * 10.4) . ')';
                    break;
                case 4:
                    $conditions[] = "geo_lat < " . ($lat + 4 * 10.4) . " and geo_lat > " . ($lat - 4 * 10.4);
                    $conditions[] = "geo_lng < " . ($lng + 4 * 10.4) . " and geo_lng > " . ($lng - 4 * 10.4);
                    $conditions[] = "(geo_lat >= " . ($lat + 2 * 10.4) . " OR geo_lat <= " . ($lat - 2 * 10.4) . ')';
                    $conditions[] = "(geo_lng >= " . ($lng + 2 * 10.4) . " OR geo_lng <= " . ($lng - 2 * 10.4) . ')';
                    break;
                case 5:
                    $conditions[] = "geo_lat < " . ($lat + 10 * 10.4) . " and geo_lat > " . ($lat - 10 * 10.4);
                    $conditions[] = "geo_lng < " . ($lng + 10 * 10.4) . " and geo_lng > " . ($lng - 10 * 10.4);
                    $conditions[] = "(geo_lat >= " . ($lat + 4 * 10.4) . " OR geo_lat <= " . ($lat - 4 * 10.4) . ')';
                    $conditions[] = "(geo_lng >= " . ($lng + 4 * 10.4) . " OR geo_lng <= " . ($lng - 4 * 10.4) . ')';
                    break;
                default :
                    '';
                    break;
            }
        }
        return $conditions;
    }

    /*
     *@猜你喜欢
     */
    function  guessYouLike()
    {
        //猜你喜欢数据
        $guessConditions = Web_Account::getFootPrintConditions();
        $guessConditions['attr_index'][$this->cityId] = '+' . $_COOKIE['city'];
        $guessConditions['status'] = 1;
        $guessList = Data_Mysql_Table_Product_Search::select('id, product_name, logo', $guessConditions, '', 5);
        return $guessList;
    }

    //
    function  categoryTree()
    {
        $webConfig = $this->webConfig;
        $categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
        unset($categoryTree[0][$webConfig['space_id']], $categoryTree[0][93], $categoryTree[0][10], $categoryTree[0][140], $categoryTree[0][3], $categoryTree[0][135]);
        return $categoryTree;
    }

    function allCategory()
    {
        return Data_Mysql_Table_Product_Category::getInfoCache();
    }

    function  topCategoryId()
    {

        $allCategory = $this->allCategory;
        $topCategoryId = $this->categoryId;
        $parents = array();
        if ($topCategoryId) {
            $parents[] = $topCategoryId;
        }
        while (!empty($allCategory[$topCategoryId][3])) {
            $topCategoryId = $allCategory[$topCategoryId][3];
            $parents[] = $topCategoryId;
        }
        Data_Config_Site::seo('service_list', array(
            'category_name' => ($this->categoryId && !empty($allCategory[$this->categoryId][0]) ? $allCategory[$this->categoryId][0] : '全部服务'),
        ));
        return array(
            'topCategoryId' => $topCategoryId,
            'parents' => array_reverse($parents)
        );
    }

    function  is_space()
    {
        return Data_Config_Site::isSpace($this->topCategoryId['topCategoryId']);
    }

    //标签id
    function  tagsName()
    {
        $global = Page_Site_Global::getInstance();
        return $global->tags;
    }

    //返回给页面的筛选条件
    function filterString()
    {
        $filterString = http_build_query($this->request_filter);
        return $filterString . '&';
    }

    //定义空间面积范围数组
    function  size_range()
    {
        return Data_Mysql_Table_Product_Search::$product_size;
    }

    //基本信息 和基础信息等
    function  filterAttr()
    {
        //处理属性
        $categoryId = intval($this->categoryId);
        $filterAttr = Data_Mysql_Table_Product_Info::getProductSearchAttrWithValues($categoryId, $this->conditions);
        unset($filterAttr[46]);
        $tags = $this->tagsName;
        ksort($filterAttr);
        //选择区域删除商圈
        if (!empty($this->request_filter['filter'][$tags['行政区域']])) {
            unset($filterAttr[$tags['所属商圈']]);
        }
        //选择商圈删除区域
        if (!empty($this->request_filter['filter'][$tags['所属商圈']])) {
            unset($filterAttr[$tags['行政区域']]);
        }
        return $filterAttr;
    }

    //、执行查询返回数据     地图页面
    function getMapList()
    {
        $conditions = $this->conditions;
        $order = 'ORDER BY update_time DESC';

        $list = Data_Mysql_Table_Product_Search::page(0, 100, "id, category_id, vendor_id,geo_lat,geo_lng, product_name, attr_index, logo, addr, update_time", $conditions, $order);
        if (!empty($list['rows'])) {
            foreach ($list['rows'] as $k => $v) {
                $list['rows'][$k]['attr_index'] = json_decode($v['attr_index'], 1);
                if (!empty($v['logo'])) {
                    $logo = Page_Site_Global::displayMedia($v['logo'], 275, 195);
                } else {
                    $logo = 'images/map1.jpg';
                }
                $list['rows'][$k]['logo'] = $logo;
            }

        }
        return $list;
    }

    //执行查询返回数据      搜索页面
    function  getSpaceList()
    {
        $conditions = $this->conditions;
        $webConfig = $this->webConfig;
        $request = $this->request_filter;
        //排序方式
        switch ($request['orderBy']) {
            case '2':
                $order = 'ORDER BY {table}.id DESC';
                break;
            case '3':
                $order = 'ORDER BY {table}.order_counter_view DESC';
                break;
            default:
                $order = 'ORDER BY {table}.order_index DESC';
                break;
        }
        //查询数据库

//        Data_Mysql_Table_Product_Search::debug(1);
        $table='{table} LEFT JOIN {prefix}product_info ON {table}.id={prefix}product_info.id';
        $list = Data_Mysql_Table_Product_Search::page(0, empty($webConfig['page_num']) ? 10 : $webConfig['page_num'], "{table}.id, {table}.category_id, {table}.vendor_id,{table}.vendor_name, {table}.product_name, {table}.attr_index, {table}.logo, {table}.addr, {table}.update_time, {table}.price,{prefix}product_info.create_by_quick", $conditions, $order,$table);
        if (!empty($list['rows'])) {
            foreach ($list['rows'] as $k => $v) {
                $list['rows'][$k]['price'] = $list['rows'][$k]['price'] > 10000 ? $list['rows'][$k]['price'] / 100 : 0;
                $list['rows'][$k]['attr_index'] = json_decode($v['attr_index'], 1);
                $list['rows'][$k]['media'] = array();
            }
            Data_Mysql_Table_Search_Log::searchLog($request['keyword'], $request['filter'], $list['page']['dt']);
        }
        return $list;
    }

    //获取供应商信息
    function  vendors()
    {

        $vendors = array();
        $list = $this->getSpaceList;
        if (!empty($list['rows'])) {
            foreach ($list['rows'] as $k => $v) {
                $vendors[] = $v['vendor_id'];
            }
            $rs = Data_Mysql_Table_Vendor_Info::select("id, vendor_name", array("id IN (" . implode(',', $vendors) . ")"), '', 100);
            $vendors = array();
            foreach ($rs as $v) {
                $vendors[$v['id']] = $v;
            }
        }
        return $vendors;

    }

    //手机端获取活动类型，行业类型
    function  getPhoneAttr($type)
    {
        $result = Data_Config_Vendor_Attr::get('attr');
        switch ($type) {
            case 1:
                return $result['活动类型'];
                break;
            case 2:
                return $result['服务行业'];
                break;
            default:
                return '';
                break;

        }
    }

    static function handleGetListForMobile()
    {
        return self::getInstance()->getListForMobile();
    }

    //手机端获取列表
    function  getListForMobile()
    {
        $conditions = $this->conditions;
        $webConfig = $this->webConfig;
        $request = $this->request_filter;
        //排序方式
        switch ($request['orderBy']) {
            case '2':
                $order = 'ORDER BY id DESC';
                break;
            case '3':
                $order = 'ORDER BY order_counter_view DESC';
                break;
            default:
                $order = 'ORDER BY order_index DESC';
                break;
        }
        $dataresult['rows'] = Web_Search_Space::fetch("Web_Mobile_Static::list_template.v1.0/space_list.tpl");
        $dataresult['page'] = $this->getSpaceList['page'];
        $req = array();
        if (!empty($request['filter'][49])) {
            $arr = $this->getPhoneAttr(1);
            $req['activity'] = array_search($request['filter'][49], $arr) + 1;
        }
        if (!empty($request['filter'][9])) {
            $arr = $this->getPhoneAttr(2);
            $req['industry'] = array_search($request['filter'][9], $arr) + 1;
        }
        if (!empty($request['category_id'])) {
            $req['category_id'] = $request['category_id'];
        }
        if (!empty($request['orderBy'])) {
            $req['orderBy'] = $request['orderBy'];
        }
        if (!empty($request['nearbymi'])) {
            $req['nearbymi'] = $request['nearbymi'];
        }
        if (!empty($request['adminarea'])) {
            $req['adminarea'] = "aa" . substr(md5($request['adminarea']), 0, 8);
        }
        if (!empty($request['businesscircle'])) {
            $req['businesscircle'] = "bc" . substr(md5($request['businesscircle']), 0, 8);
        }
        $dataresult['req'] = $req;
        Func_Output::json("success", $dataresult, "成功");
    }

    static function getRandList()
    {
//        sleep(2);
        $rand = mt_rand(1, 8000);
        $conditions = array(
            'id<?' => $rand,
            'status=?' => 1,
        );

        //查询数据库

//        Data_Mysql_Table_Product_Search::debug(1);
        $list = Data_Mysql_Table_Product_Search::select("id, category_id, vendor_id,vendor_name, product_name, attr_index, logo, addr, update_time, price", $conditions, 'ORDER BY id DESC', 3);

        if (!empty($list)) {
            foreach ($list as $k => $v) {
                $list[$k]['price'] = $list[$k]['price'] > 10000 ? $list[$k]['price'] / 100 : 0;
                $list[$k]['attr_index'] = json_decode($v['attr_index'], 1);
                $list[$k]['media'] = array();
            }
        }
        return $list;
    }

}