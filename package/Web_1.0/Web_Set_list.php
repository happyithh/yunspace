<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/6/10
 * Time: 10:16
 */
Class  Web_Set_list extends Page_Base
{
    function __construct()
    {
        if ($this->categoryId && empty(Data_Mysql_Table_Product_Set::$category_name[$this->categoryId])) {
            Func_Header::notFound();
        }
//        Data_Config_Site::seo('service_list', array(
//            'category_name' => ($this->categoryId ? Data_Mysql_Table_Product_Set::$category_name[$this->categoryId] . '超值套餐' : '超值套餐'),
//        ));
        Data_Config_Site::seo('service_package', array(
            'category_name' => ($this->categoryId ? Data_Mysql_Table_Product_Set::$category_name[$this->categoryId] . '超值套餐' : '超值套餐'),
        ));
    }

    function categoryId()
    {
        if (!empty($this->request['category_id'])) {
            $cid = $this->request['category_id'];
        } elseif (is_numeric(Core::$urls['action'])) {
            $cid = Core::$urls['action'];
        } else {
            $cid = 0;
        }
        return $cid;
    }

    //一级菜单
    function allCategory()
    {
        $cats = Data_Mysql_Table_Product_Set::$category_name;
        //隐藏路演, 派对
        unset($cats[5]);
        return $cats;
    }

    function  request()
    {
        $request = Func_Input::filter(array(
            'keyword' => 'string',
            'filter' => 'array',
            'price' => 'array',
            'orderBy' => 'int',
            'sort' => 'int',
            'nearbymi' => 'string',   //附近距离
            'baidu_lng' => 'string',  //坐标点
            'baidu_lat' => 'string',  //坐标点
//            "activity" => "string",   //活动类型
//            "industry" => "string",   //适合行业
            "adminarea" => "string",   //行政区域
            "businesscircle" => "string",   //商圈
            'category_id' => 'int',
            'peoplenum' => 'int',
            'daynum' => 'int',
            'price_start' => 'string',
            'price_end' => 'string',
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
        if (!empty($request['orderBy'])) {
            $request['sort'] = $request['orderBy'];
        }
        if (!empty($request['adminarea']) && !isset($request['nearbymi']) && !isset($request['businesscircle'])) {
            $request['filter'][4] = $request['adminarea'];
        }
        if (!empty($request['businesscircle']) && !isset($request['nearbymi']) && !isset($request['adminarea'])) {
            $request['filter'][2] = $request['businesscircle'];
        }
        if (!empty($request['peoplenum'])) {
            $request['filter']['人数'] = $request['peoplenum'];
        }
        if (!empty($request['daynum'])) {
            $request['filter']['天数'] = $request['daynum'];
        }
        if (!empty($request['price_start'])) {
            $request['price']['start'] = $request['price_start'];
        }
        if (!empty($request['price_end'])) {
            $request['price']['end'] = $request['price_end'];
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

    function  filterString()
    {
        $filterString = http_build_query($this->request);
        return $filterString . '&';
    }

    function  conditions()
    {
        $request = $this->request;

        if (!empty($request['keyword'])) {
            $conditions['set_name'] = $request['keyword'];
            $conditions['addr'] = $request['keyword'];
        }
        if (!empty($request['price'])) {
            if (!empty($request['price']['start']) && !empty($request['price']['end'])) {
                $conditions['set_price >=? AND set_price <=?'] = array(intval($request['price']['start']), intval($request['price']['end']));
            } elseif (!empty($request['price']['start'])) {
                $conditions['set_price >=?'] = intval($request['price']['start']);
            } elseif (!empty($request['price']['end'])) {
                $conditions['set_price <=?'] = intval($request['price']['end']);
            }
        }
        if (!empty($request['filter']['人数'])) {
            switch ($request['filter']['人数']) {
                case 1:
                    $conditions['people <=?'] = 20;
                    break;
                case 2:
                    $conditions['people >=? AND people <=?'] = array(20, 50);
                    break;
                case 3:
                    $conditions['people >=? AND people <=?'] = array(50, 100);
                    break;
                case 4:
                    $conditions['people >=? AND people <=?'] = array(100, 200);
                    break;
                case 5:
                    $conditions['people >=? AND people <=?'] = array(200, 500);
                    break;
                case 6:
                    $conditions['people >=? '] = 500;
                    break;
            }
            unset($request['filter']['人数']);
        }
        if (!empty($request['filter']['天数'])) {
            switch ($request['filter']['天数']) {
                case 1:
                    $conditions['hours <=?'] = 12;
                    break;
                case 2:
                    $conditions['hours>? AND hours<=?'] = array(0, 24);
                    break;
                case 3:
                    $conditions['hours>? AND hours<=?'] = array(24, 48);
                    break;
                case 4:
                    $conditions['hours>? AND hours<=?'] = array(48, 72);
                    break;
                case 5:
                    $conditions['hours>? AND hours<=?'] = array(72, 96);
                    break;
                case 6:
                    $conditions['hours >=?'] = 96;
                    break;
            }
            unset($request['filter']['天数']);
        }
        //附近
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
        if (!empty($request['filter'])) {
            foreach ($request['filter'] as $k => $v) {
                $conditions['search_attr_index'][$k] = '+' . $v;
            }
        }
        if (!empty($_COOKIE['city'])) {
            $conditions['attr_index']['城市'] = '+' . $_COOKIE['city'].',全国';
        } else {
            $_COOKIE['city'] = '上海';
            $conditions['attr_index']['城市'] = '+上海,全国';
        }
        $conditions['status =?'] = 1;
        if ($this->categoryId != 0) {
            $conditions['category_id =?'] = $this->categoryId;
        }

        return $conditions;
    }

    function getSetList()
    {

        $cols = 'id,set_name,version,addr,hours,category_id,vendor_id,schedule_product_id,attr_index,logo,detail_data,detail,detail_des,counter_order,create_time,update_time,score,status,search_attr_index';

        $conditions = $this->conditions;
        $request = $this->request;
        $orderBy = "";
        if (!empty($request['sort'])) {
            if ($request['sort'] == 2) {
                $orderBy = " ORDER BY update_time desc";
            }
            if ($request['sort'] == 3) {
                $orderBy = " ORDER BY score desc";
            }
            if ($request['sort'] == 1) {
                $orderBy = " ORDER BY id desc";
            }
        } else {
            $orderBy = " ORDER BY id desc";
        }
        $rs = Data_Mysql_View_Product_Set::page(0, 12, $cols, $conditions, $orderBy);
        if (!empty($rs['rows'])) {
            foreach ($rs['rows'] as $key => $val) {
                $rs['rows'][$key]->attr_index = json_decode($val->attr_index, 1);
                $rs['rows'][$key]->detail = json_decode($val->detail, 1);
                $rs['rows'][$key]->hours = $val->hours > 24 ? round($val->hours / 24, 1) . '天' : $val->hours . '小时';
            }
        }
        return $rs;
    }

    //同类推荐
    function getSetListHot()
    {
        $rs = Data_Mysql_Table_Product_Set::select('id,set_name,logo,addr', array('status =?' => 1), "ORDER BY update_time desc", 5);
        return $rs;
    }

    //标签id
    function  tagsName()
    {
        $global = Page_Site_Global::getInstance();
        return $global->tags;
    }

    //基本信息 和基础信息等
    function  filterAttr()
    {
        $conditions['attr_index']['城市'] = '+' . $_COOKIE['city'];
        $conditions['status =?'] = 1;
        if ($this->categoryId != 0) {
            $conditions['category_id =?'] = $this->categoryId;
        }
        //处理属性
        $filterAttr = Data_Mysql_View_Product_Set::getProductSearchAttrWithValues(112, $conditions);

        $tags = $this->tagsName;
        //选择区域删除商圈
        if (!empty($this->request['filter'][$tags['行政区域']])) {
            unset($filterAttr[$tags['所属商圈']]);
        }
        //选择商圈删除区域
        if (!empty($this->request['filter'][$tags['所属商圈']])) {
            unset($filterAttr[$tags['行政区域']]);
        }
        unset($filterAttr[$tags['城市']]);
        return $filterAttr;
    }

    function searchValue()
    {
        $searchValue['人数'] = array(
            1 => '20人以内',
            2 => '20-50人',
            3 => '50-100人',
            4 => '100-200人',
            5 => '200-500人',
            6 => '500人以上'
        );
        $searchValue['天数'] = array(
            1 => '0.5天',
            2 => '1天',
            3 => '2天',
            4 => '3天',
            5 => '4天',
            6 => '5天及以上',
        );
        return $searchValue;
    }

    static function handleGetListForMobile()
    {
        return self::getInstance()->getListForMobile();
    }

    function getListForMobile()
    {
        $dataresult['rows'] = Web_Set_list::fetch("Web_Mobile_Static::list_template.v1.0/set_list.tpl");
        $dataresult['page'] = $this->getSetList['page'];
        $req = array();
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
        if (!empty($request['peoplenum'])) {
            $req['peoplenum'] = $request['peoplenum'];
        }
        if (!empty($request['daynum'])) {
            $req['daynum'] = $request['daynum'];
        }
        if (!empty($request['price_start'])) {
            $req['price_start'] = $request['price_start'];
        }
        if (!empty($request['price_end'])) {
            $req['price_end'] = $request['price_end'];
        }
        $dataresult['req'] = $req;
        Func_Output::json("success", $dataresult, "成功");
    }
    function getRandList(){
       return Web_Search_Space::getRandList();
    }
}