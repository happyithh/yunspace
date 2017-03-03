<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/7/4
 * Time: 14:28
 * 移动子空间搜索
 *
 * $args = array(
 *      'active_type' => 'string',  // 用途搜索
 *      'category' => 'int',        // 场地类型
 *      'size_range' => 'string',   // 空间面积
 *      'price_unit' => 'string',   // 价格单位
 *      'price' => 'array',         // 价格区间
 *      'keyword' => 'string',     // 标题搜索
 *      'type' => 'int',         // 标题搜索类型 （1：用途；2：地标；3：标题名称）
 *      'geo_lat' => 'int',         // 如果是地标搜索传递经纬度
 *      'geo_lng' => 'int',         // 如果是地标搜索传递经纬度
 *      'rank' => 'string',         // 排序
 *      'hot'=>'string'             // 热词搜索
 * );
 *
 */
class Api_Search_Mobile_Get_Item_List extends Api
{
    static function handle()
    {
        return self::getItemList();
    }

    static function getItemList()
    {
        if (!empty($_REQUEST)) {
            $condiions = self::dealSearchData($_REQUEST);
        }
        $condiions[] = 'baike_status = 1 AND item_status = 1';
        // 搜索排序 1 最热； 2 价格降序；3 最新；0 默认 按级别
        if (!empty($_REQUEST['rank'])) {
            $rank = Func_Input::filter(array('rank' => 'string'), $_REQUEST);
        } else {
            $rank['rank'] = '';
        }
        if(!empty($_REQUEST['geo_lat']) && !empty($_REQUEST['geo_lng'])){
            $search['geo_lat'] = (float)$_REQUEST['geo_lat'] * 10000;
            $search['geo_lng'] = (float)$_REQUEST['geo_lng'] * 10000;
            $lng = substr($search['geo_lng'], 0, 7);
            $lat = substr($search['geo_lat'], 0, 6);
            $cols = 'baike_id,{table}.item_id,baike_logo,baike_mobile_logo,baike_item_name,size,addr,geo_lat,geo_lng,min(t1.discount_price) as min_price,t1.price_unit,item_media,attr,t1.discount_price_B,ABS(geo_lat-'.$lat.')+ABS(geo_lng-'.$lng.') as distance';
            $order = 'ORDER BY distance ASC,type_level DESC';
        }else{
            switch ($rank['rank']) {
                case '最热排序':
                    $order = 'ORDER BY click DESC,type_level DESC';
                    break;
                case '价格排序':
                    $order = 'ORDER BY min_price_B DESC,type_level DESC';
                    break;
                case '最新排序':
                    $order = 'ORDER BY item_create_time DESC';
                    break;
                default:
                    $order = ' ORDER BY type_level DESC,order_index DESC';
            }
            $cols = 'baike_id,{table}.item_id,baike_logo,baike_mobile_logo,baike_item_name,size,addr,geo_lat,geo_lng,min(t1.discount_price) as min_price,t1.price_unit,item_media,attr,t1.discount_price_B';
        }

        $table = '{table} LEFT JOIN {prefix}item_price as t1 ON {table}.item_id = t1.item_id';
        $data = Data_Mysql_Table_Search_Space_Item::page(0, 8, $cols, $condiions, 'GROUP BY {table}.item_id ' . $order, $table);
//        q($data,$order);
        if (!empty($data['rows'])) {
            foreach ($data['rows'] as $k => $v) {
                $price = self::unitConversion($v['min_price'], $v['price_unit']);
                $data['rows'][$k]['min_price'] = $price;
                if (!empty($v['baike_item_name'])) {
                    $name = explode('--', $v['baike_item_name']);
                    $data['rows'][$k]['baike_name'] = !empty($name[0]) ? $name[0] : $v['baike_item_name'];
                    if (strlen($v['baike_item_name']) > 75) {
                        $data['rows'][$k]['baike_item_name'] = mb_substr(str_replace('&nbsp;', '', strip_tags($v['baike_item_name'])), 0, 26, 'utf-8') . '...';
                    }
                }
                if (!empty($v['item_media'])) {
                    $data['rows'][$k]['item_media'] = json_decode($v['item_media'], 1);
                }
                if (empty($v['baike_mobile_logo'])) {
                    if (!empty($v['baike_logo'])) {
                        $data['rows'][$k]['baike_mobile_logo'] = $v['baike_logo'];
                    } else {
                        if (!empty($v['item_media'])) {
                            $data['rows'][$k]['baike_mobile_logo'] = $data['rows'][$k]['item_media'][0];
                        }
                    }
                }
                if (!empty($v['attr'])) {
                    $data['rows'][$k]['attr'] = json_decode($v['attr'], 1);
                }
                $data['rows'][$k]['item_id'] =Func_NumEncode::e($v['item_id']);
                $data['rows'][$k]['baike_id'] =Func_NumEncode::e($v['baike_id']);
            }
            return self::request('success', $data, '');
        }

    }

    // 处理搜索字段
    static function dealSearchData($args)
    {
        $conditions = array();
        $search = Func_Input::filter(array(
//            'city' => 'string',
            'active_type' => 'string',
            'category' => 'int',
            'size_range' => 'string',
            'price_unit' => 'string',
            'price' => 'array',
            'keyword' => 'string',
            'type' => 'int',
            'geo_lat' => 'int',
            'geo_lng' => 'int',
//            'hot' => 'string',
//            'admin_area' => 'string',  // 行政区域
//            'business_area' => 'string',
//            'industry_type' => 'string',
        ), $args);
        if (!empty($search['keyword'])) {
            if($search['type']=='1'){
//                $conditions['attr']['活动类型'] = '+' . $search['keyword'];
                $conditions['past_case'] = '+' . $search['keyword'];
            }elseif($search['type']=='2'){
                // 暂时放着
            }else{
                $conditions['baike_item_name'] = $search['keyword'];
            }
//            Data_Mysql_Table_Search_Logm::searchLog($search['keyword2'], 'space_item');
        }
//        if (!empty($search['city'])) {
//            $citys = Web_Global::$city_name;
//            if (array_key_exists($search['city'], $citys)) {
//                $conditions['city'] = $citys[$search['city']];
//            }
//        }
        if (!empty($search['category']) && $search['category'] != 112) {
            $conditions['category_id'] = $search['category'];
        }
        if (!empty($search['active_type'])) {
            $conditions['past_case'] =  '+' . $search['active_type'];
        }
        if(!empty($search['geo_lat']) && !empty($search['geo_lng'])){
            $search['geo_lat'] = (float)$search['geo_lat'] * 10000;
            $search['geo_lng'] = (float)$search['geo_lng'] * 10000;
            $lng = substr($search['geo_lng'], 0, 7);
            $lat = substr($search['geo_lat'], 0, 6);
            $conditions[] ='geo_lat <='.($lat + 0.5 * 10.4*25).' AND geo_lat >='.($lat - 0.5 * 10.4*25).' AND geo_lng <='.($lng + 0.5 * 10.4*25).' AND geo_lng >='.($lng - 0.5 * 10.4*25);
        }
        if (!empty($search['price'])) {
            if (!empty($search['price_unit']) && $search['price_unit'] != '人计') {
                if (!empty($search['price'][0]) && !empty($search['price'][1])) {
                    $conditions[] = 't1.discount_price_B >=' . self::searchUnitConversion($search['price'][0], $search['price_unit']) . ' AND t1.discount_price_B <' . self::searchUnitConversion($search['price'][1], $search['price_unit']);
                } elseif(empty($search['price'][0]) && !empty($search['price'][1])) {
                    $conditions[] = 't1.discount_price_B <=' . self::searchUnitConversion($search['price'][1], $search['price_unit']);
                } elseif(!empty($search['price'][0]) && empty($search['price'][1])){
                    $conditions[] = 't1.discount_price_B >=' . self::searchUnitConversion($search['price'][0], $search['price_unit']);
                }
            } else {
                if (!empty($search['price'][0]) && !empty($search['price'][1])) {
                    $conditions[] = 't1.discount_price_B >=' . ($search['price'][0] * 100) . ' AND t1.discount_price_B<' . ($search['price'][1] * 100);
                } elseif(empty($search['price'][0]) && !empty($search['price'][1]))  {
                    $conditions[] = 't1.discount_price_B<=' . $search['price'][1] * 100;
                } elseif(!empty($search['price'][0]) && empty($search['price'][1])){
                    $conditions[] = 't1.discount_price_B>=' . $search['price'][0] * 100;
                }
            }
        }
        if(!empty($search['price_unit']) && $search['price_unit']=='人计'){
                $conditions[] = 't1.price_unit LIKE "%人%"';
        }
        if (!empty($search['size_range'])) {
            switch ($search['size_range']) {
                case '1':
                    $conditions[] = 'size<200';
                    break;
                case '200':
                    $conditions[] = 'size >= 200 AND size < 500';
                    break;
                case '500':
                    $conditions[] = 'size >= 500 AND size < 800';
                    break;
                case '800':
                    $conditions[] = 'size >= 800 AND size<1000';
                    break;
                case '1000':
                    $conditions[] = 'size >=1000 AND size < 2000';
                    break;
                case '2000':
                    $conditions[] = 'size >=2000';
            }
        }
        if (!empty($search['is_outside'])) {
            $conditions['is_outside'] = $search['is_outside'];
        }
        return $conditions;
    }

    //查询出的数据价格换算
    static function unitConversion($price, $unit)
    {
        if (strstr($unit, '周')) {
            $priceNew = intval($price * 7 / 100);
        } elseif (strstr($unit, '半天')) {
            $priceNew = intval($price / 2 / 100);
        } elseif (strstr($unit, '小时')) {
            $priceNew = intval($price / 24 / 100);
        } else {
            $priceNew = intval($price / 100);
        }
        return $priceNew;
    }

    //查询条件价格换算
    static function searchUnitConversion($price, $unit)
    {
        if (strstr($unit, '半天计')) {
            $priceNew = intval($price * 2 * 100);
        } elseif (strstr($unit, '小时计')) {
            $priceNew = intval($price * 24 * 100);
        } else {
            $priceNew = intval($price * 100);
        }
        return $priceNew;
    }
}