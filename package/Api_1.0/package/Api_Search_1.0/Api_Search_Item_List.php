<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/6/16
 * Time: 15:58
 * 子空间搜索列表
 */
class Api_Search_Item_List extends Api
{

    static function getSearchItemList($args)
    {
        $area = empty($args['admin_area']) && empty($args['business_area']);
        $dis = !empty($args['lat']) && !empty($args['lng']);
        /**
         * 1、有经纬度，并且没有搜索行政区域/商圈
         * 2、关键词为空的时候
         */
        if($area==true && $dis==true) {
            // 搜索排序  有经纬度时根据距离由近及远排序
            $cols = 'max(item_id) as item_id,baike_id,baike_logo,baike_item_name,baike_des,addr,tags_new,facility,order_index,baike_min_people,baike_max_people,baike_min_size,min_price,max(item_count) as item_count,category_id,price_unit,click,item_media,geo_lat,geo_lng,item_max_price,item_min_price,ABS(geo_lat-' . $args['lat'] . ')+ABS(geo_lng-' . $args['lng'] . ') as distance';
            $order = 'ORDER BY distance ASC,type_level DESC';
        }else {
            switch ($args['rank']) {
                case 'pup':
                    $order = 'ORDER BY max_price_B DESC,type_level DESC';
                    break;
                case 'pdown':
                    $order = 'ORDER BY min_price_B ASC,type_level DESC';
                    break;
                case 'iup':
                    $order = 'ORDER BY order_index DESC,type_level DESC';
                    break;
                case 'idown':
                    $order = 'ORDER BY order_index ASC,type_level DESC';
                    break;
                default:
                    $order = ' ORDER BY type_level DESC,order_index DESC';
            }
            $cols = 'max(item_id) as item_id,baike_id,baike_logo,baike_item_name,baike_des,addr,tags_new,facility,order_index,baike_min_people,baike_max_people,baike_min_size,baike_max_size,min_price,max(item_count) as item_count,category_id,price_unit,click,item_media,geo_lat,geo_lng,item_max_price,item_min_price';
        }
        $conditions = array();
        if (!empty($args)) {
            $conditions = self::dealSearchData($args);
        }
        $conditions[] = 'baike_status =1 AND item_status=1';

        /*
         * 第一次搜索：
         *
         * */
        // 关键词搜索时，只搜索8条数据
        if(!empty($args['keyword2']) && $dis==false){
            $data['rows'] = Data_Mysql_Table_Search_Space_Item::select($cols, $conditions, 'GROUP BY baike_id ' . $order,8);
        }else{
            $data = Data_Mysql_Table_Search_Space_Item::page(0, 8, $cols, $conditions, 'GROUP BY baike_id ' . $order);
            // 经纬度搜索，匹配与关键字最接近的一条数据
            if (!empty($data['rows']) && $dis==true && !empty($args['keyword2']) && ((!empty($_REQUEST['dp']) && $_REQUEST['dp'] == 1) || !isset($_REQUEST['dp']))) {
                $conditions['baike_item_name'] = $args['keyword2'];
                $data_1 = Data_Mysql_Table_Search_Space_Item::select($cols, $conditions, 'GROUP BY baike_id ' . $order, 1);
                if (!empty($data_1)) {
                    array_unshift($data['rows'], $data_1[0]);
                }
            }
        }



        /*
         * 第二次搜索：
         *
         * 通过经纬度未获取到数据时处理 注：没有其他条件且为查询不到数据的情况下使用
         */
        $is_search = self::isSearch($args);
        if ((empty($data['rows']) && $is_search == true)) {
            $data = self::getItemListByKeyword($args, $conditions);
        }


        // 最终数据处理
        if (!empty($data['rows'])) {
            foreach ($data['rows'] as $k => $v) {
                if($k!=0 && !empty($data_1) && $v['baike_id']==$data_1[0]['baike_id']){
                    unset($data['rows'][$k]);
                }else {
                    // 获取百科名称
                    if (!empty($v['baike_item_name'])) {
                        $name = explode('--', $v['baike_item_name']);
                        $data['rows'][$k]['baike_item_name'] = !empty($name[0]) ? $name[0] : $v['baike_item_name'];
                    }
                    if (!empty($v['tags_new'])) {
                        $data['rows'][$k]['tags_new'] = explode(',', $v['tags_new']);
                    }
                    if (!empty($v['min_price'])) {
                        $data['rows'][$k]['min_price'] = intval($v['min_price'] / 100);
                    }
                    // 没有百科logo时，使用子空间图片
                    if (empty($v['baike_logo']) && !empty($v['item_media'])) {
                        $media = json_decode($v['item_media'], 1);
                        $data['rows'][$k]['baike_logo'] = !empty($media[0]['path']) ? $media[0]['path'] : '';
//                    q($data['rows'][2]['baike_logo'],$media);
                    }
                    $data['rows'][$k]['facility'] = explode(',', $v['facility']);
                    if ((!empty($v['item_min_price']) && empty($v['item_max_price']))) {
                        $data['rows'][$k]['item_max_price'] = intval($v['item_min_price'] / 100);
                    } else {
                        $data['rows'][$k]['item_max_price'] = intval($v['item_max_price'] / 100);
                    }
                }
            }
        }
        return $data;
    }

    // 处理搜索字段
    static function dealSearchData($search)
    {
        $conditions = array();
        // 优先选择 行政区域/所属商圈作为搜索条件，行政区域/所属商圈都为空时，才考虑使用经纬度
        if(!empty($search['admin_area']) || !empty($search['business_area'])){
            if (!empty($search['admin_area'])) {
                $conditions['attr']['行政区域'] = '+' . $search['admin_area'];
            }
            if (!empty($search['business_area'])) {
                $conditions['attr']['所属商圈'] = '+' . $search['business_area'];
            }
        }else{
            if (!empty($search['lat']) && !empty($search['lng'])) {
                $conditions[] = 'geo_lat <=' . ($search['lat'] + 0.5 * 10.4 * 25) . ' AND geo_lat >=' . ($search['lat'] - 0.5 * 10.4 * 25) . ' AND geo_lng <=' . ($search['lng'] + 0.5 * 10.4 * 25) . ' AND geo_lng >=' . ($search['lng'] - 0.5 * 10.4 * 25);
                Data_Mysql_Table_Search_Logm::searchLog($search['keyword2'], 'space_item');
            }
        }
        /*
         *  1、未获取到经纬度默认使用场地名称搜索
         * */
        $no_dis = empty($search['lat']) && empty($search['lng']);
        if (!empty($search['keyword2']) && $no_dis==true) {
            $conditions['baike_item_name'] = $search['keyword2'];
            Data_Mysql_Table_Search_Logm::searchLog($search['keyword2'], 'space_item');
        }
        if(!empty($search['city']) && empty($search['lat']) && empty($search['lng']) && $search['city']!='不限'){
            $conditions['city'] = !empty($search['city'])?$search['city']:'上海';
        }
        if (!empty($search['category']) && $search['category'] != 112) {
            $conditions['category_id'] = $search['category'];
        }
        if (!empty($search['active_type'])) {
            $conditions['past_case'] = '+' . $search['active_type'];
        }
        if (!empty($search['industry_type'])) {
            $conditions['attr']['行业类型'] = '+' . $search['industry_type'];
        }
        if (!empty($search['is_outside'])) {
            if ($search['is_outside'] == 5) {
                $conditions['is_outside'] = 2;
            } else {
                $conditions['is_outside'] = $search['is_outside'];
            }

        }
        if (!empty($search['people_range'])) {
            $search['people_range'] = explode(',', $search['people_range']);
            if (!empty($search['people_range'][0]) && !empty($search['people_range'][1])) {
                $conditions[] = 'baike_min_people <' . $search['people_range'][1] . ' AND baike_max_people >=' . $search['people_range'][0];
            } elseif (!empty($search['people_range'][0]) && empty($search['people_range'][1])) {
                if($search['people_range'][0]=='min'){
                    $conditions[] = 'baike_max_people <=50';
                }else{
                    $conditions[] = 'baike_max_people >='.$search['people_range'][0];
                }
            } elseif (empty($search['people_range'][0]) && !empty($search['people_range'][1])) {
                $conditions[] = 'baike_max_people <=' . $search['people_range'][1];
            }
        }

        if (!empty($search['size_range'])) {
            $search['size_range'] = explode(',', $search['size_range']);
            if (!empty($search['size_range'][0]) && !empty($search['size_range'][1])) {
                $conditions[] = 'size <=' . $search['size_range'][1] . ' AND size >=' . $search['size_range'][0];
            } elseif (!empty($search['size_range'][0]) && empty($search['size_range'][1])) {
                if($search['size_range'][0]=='min'){
                    $conditions[] = 'size <=200';
                }else{
                    $conditions[] = 'size >=' . $search['size_range'][0];
                }
            } elseif (empty($search['size_range'][0]) && !empty($search['size_range'][1])) {
                $conditions[] = 'size <=' . $search['size_range'][1];
            }
        }
        if (!empty($search['price_range'])) {
            $search['price_range'] = explode(',', $search['price_range']);
            if (!empty($search['price_range'][0]) && !empty($search['price_range'][1])) {
                $conditions[] = 'min_price_B <=' . ($search['price_range'][1] * 100) . ' AND min_price_B >=' . ($search['price_range'][0] * 100);
            } elseif (!empty($search['price_range'][0]) && empty($search['price_range'][1])) {
                if($search['price_range'][0]=='min'){
                    $conditions[] = 'min_price_B <=200000';
                }else{
                    $conditions[] = 'min_price_B >=' . ($search['price_range'][0] * 100);
                }

            } elseif (empty($search['price_range'][0]) && !empty($search['price_range'][1])) {
                $conditions[] = 'min_price_B  <=' . ($search['price_range'][1] * 100);
            }
        }


        return $conditions;
    }

    /**
     *通过经纬度未获取到数据时处理
     * 条件：1、只有经纬度、关键词，没有其他条件且为查询不到数据的情况下使用
     *      2、没有经纬度，有关键词及其他条件使用
     *      3、搜索区域、商圈时使用
     */
    static function getItemListByKeyword($args, $conditions)
    {
        // 搜索排序 1 价格升序； 2 价格降序；3 指数降序；4 指数升序
        switch ($args['rank']) {
            case 'pup':
                $order = 'ORDER BY max_price_B DESC,type_level DESC';
                break;
            case 'pdown':
                $order = 'ORDER BY min_price_B ASC,type_level DESC';
                break;
            case 'iup':
                $order = 'ORDER BY order_index DESC,type_level DESC';
                break;
            case 'idown':
                $order = 'ORDER BY order_index ASC,type_level DESC';
                break;
            default:
                $order = ' ORDER BY type_level DESC,order_index DESC';
        }
        $cols = 'max(item_id) as item_id,baike_id,baike_logo,baike_item_name,baike_des,addr,tags_new,facility,order_index,baike_min_people,baike_max_people,baike_min_size,min_price,max(item_count) as item_count,category_id,price_unit,click,item_media,geo_lat,geo_lng,item_max_price,item_min_price';
        // 清空经纬度
        if(strstr($conditions[0],'geo_lat')){
            unset($conditions[0]);
        }
        if(!empty($args['keyword2'])){
            $conditions['baike_item_name'] = $args['keyword2'];
        }
        if (!empty($args['city']) && $args['city'] != '不限') {
            $conditions['city'] = $args['city'];
        }
        Data_Mysql_Table_Search_Logm::searchLog($args['keyword2'], 'space_item');
        $data['rows'] = Data_Mysql_Table_Search_Space_Item::select($cols, $conditions, 'GROUP BY baike_id ' . $order, 8);
        return $data;
    }

    /*
     * 判断是否只是经纬度搜索且不带其他搜索条件
     * 目的：用于判断  经纬度搜索不到数据时，改用关键词搜索
     * */
    static function isSearch($search)
    {
        if (!empty($search['lng']) && !empty($search['lat']) && !empty($search['keyword2'])  && (empty($search['category']) || $search['category'] == 112) && count(array_filter($search)) <=5 ) {
            return true;
        } else {
            return false;
        }
    }

}