<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/6/22
 * Time: 15:20
 * PC列表页面查询符合条件的子空间价格详情
 */
class Api_Search_Get_Conform_Item extends Api
{
    static function handle($args)
    {
        // 安全处理 防止频繁访问
        @session_start();
        /**
         * $item_re = array(
         * request_time=>请求时间
         * request_num=>请求次数
         * ip=>请求主机的ip
         * );
         *
         */
        $ip = Func_Input::ip();
        if (isset($_SESSION['item_request_count'])) {
            $item_re = $_SESSION['item_request_count'];
            if ($item_re['ip'] == $ip && $item_re['request_time'] == date('Y-m-d', time()) && $item_re['request_num'] > 500) {
                return self::request('error', '', '请求过于频繁！');
            } else {
                // 非当天数据，清空记录
                if ($item_re['request_time'] != date('Y-m-d', time())) {
                    $item_re['request_time'] = date('Y-m-d', time());
                    $item_re['request_num'] = 1;
                } else {
                    $item_re['request_num'] += 1;
                }
                $_SESSION['item_request_count'] = $item_re;
            }
        } else {
            // 对未请求过的用户进行记录
            $_SESSION['item_request_count']['ip'] = $ip;
            $_SESSION['item_request_count']['request_num'] = 1;
            $_SESSION['item_request_count']['request_time'] = date('Y-m-d', time());
        }
        return self::getItemList($args);
    }

    static function getItemList($args)
    {
        $conditions = array();
        if (empty($args['baike_id'])) {
            return self::request('error', '', '没有百科ID');
        }
        if (!empty($args)) {
            $conditions = self::dealSearchData($args);
            $is_conditions = count($conditions) > 1 ? true : false;
        }
        $conditions[] = 'baike_status=1 AND item_status=1';
        $table = '{table} left join {prefix}item_price as t1 on {table}.item_id = t1.item_id';
        $order = 'ORDER BY t1.discount_price asc';
        $data = Data_Mysql_Table_Search_Space_Item::select('baike_id,baike_item_name,size,min_people,max_people,{table}.item_id,t1.discount_price,t1.market_price,t1.price_unit,t1.standard,t1.is_public,item_min_price,item_max_price,item_price_unit,t1.price_status', $conditions, $order, 50, $table);
        $data_new = array();
        if (!empty($args['baike_id'])) {
            // 百科下符合条件的空间数量
            if ($is_conditions == true) {
                $getFitItemCount = self::getFitItemCount($conditions);
            }
            foreach ($data as $k => $v) {
                if (!isset($data_new[$v['baike_id']]) || (isset($data_new[$v['baike_id']]) && count($data_new[$v['baike_id']]) < 4)) {
                    if (!isset($data_new[$v['baike_id']][$v['item_id']])) {
                        $data_new[$v['baike_id']][$v['item_id']] = $v;
                    }
                    $standard = !empty($data_new[$v['baike_id']][$v['item_id']]['standard_new'][$v['standard']]['discount_price']) ? $data_new[$v['baike_id']][$v['item_id']]['standard_new'][$v['standard']]['discount_price'] : array();
                    if (count($standard) < 4) {
                        if ((!empty($v['market_price']) || !empty($v['discount_price'])) && $v['is_public']==1) {
                            // 获取子空间下的所有规格下对应的价格
                            if (empty($v['standard'])) {
                                $v['standard'] = '常规';
                            }
                            if (strlen($v['standard']) > 15) {
                                $v['standard'] = mb_substr(str_replace('&nbsp;', '', strip_tags($v['standard'])), 0, 5, 'utf-8') . '...';
                            }
                            $data_new[$v['baike_id']][$v['item_id']]['standard_new'][$v['standard']]['market_price'] = intval($v['market_price'] / 100) . $v['price_unit'];
                            $data_new[$v['baike_id']][$v['item_id']]['standard_new'][$v['standard']]['discount_price'] = intval($v['discount_price'] / 100) . $v['price_unit'];
                            $data_new[$v['baike_id']][$v['item_id']]['standard_new'][$v['standard']]['price_status'] =  $v['price_status'];
                        }
                    }

                    // 获取百科名称
                    if (!empty($v['baike_item_name'])) {
                        $name = explode('--', $v['baike_item_name']);
                        if (!empty($name[1])) {
                            $data_new[$v['baike_id']][$v['item_id']]['item_name'] = $name[1];
                            $data_new[$v['baike_id']][$v['item_id']]['baike_name'] = $name[0];
                        } else {
                            $data_new[$v['baike_id']][$v['item_id']]['item_name'] = $v['baike_item_name'];
                            $data_new[$v['baike_id']][$v['item_id']]['baike_name'] = $v['baike_item_name'];
                        }
                        if (strlen($data_new[$v['baike_id']][$v['item_id']]['item_name']) > 46) {
                            $data_new[$v['baike_id']][$v['item_id']]['item_name'] = mb_substr(str_replace('&nbsp;', '', strip_tags($data_new[$v['baike_id']][$v['item_id']]['item_name'])), 0, 12, 'utf-8') . '...';
                        }
                        $data_new[$v['baike_id']][$v['item_id']]['item_url'] = 'http://' . Core::$urls['host'] . '/site/' . Func_Url::str_urlencode($data_new[$v['baike_id']][$v['item_id']]['baike_name']) . '-百科-' . Func_NumEncode::e($v['item_id']);
                    }
                }
                if (isset($getFitItemCount[$v['baike_id']])) {
                    $data_new[$v['baike_id']]['fitItemCount'] = $getFitItemCount[$v['baike_id']];
                }
                if(empty($data_new[$v['baike_id']][$v['item_id']]['standard_new']) && (!empty($data_new[$v['baike_id']][$v['item_id']]['item_min_price']) ||
                        !empty($data_new[$v['baike_id']][$v['item_id']]['item_max_price']))){
                    $data_new[$v['baike_id']][$v['item_id']]['item_min_price'] = intval($data_new[$v['baike_id']][$v['item_id']]['item_min_price']
                        /100)<100?0:intval($data_new[$v['baike_id']][$v['item_id']]['item_min_price'] /100);
                    $data_new[$v['baike_id']][$v['item_id']]['item_max_price'] = intval($data_new[$v['baike_id']][$v['item_id']]['item_max_price']
                        /100)<100?0:intval($data_new[$v['baike_id']][$v['item_id']]['item_max_price'] /100);
                    if(!empty($v['item_price_unit']) && substr_count($v['item_price_unit'],'元/元/')==1){
                        $data_new[$v['baike_id']][$v['item_id']]['item_price_unit'] = str_replace('元/元/','元/',$v['item_price_unit']) ;
                    }
                }

            }
        }
        return self::request('success', $data_new, '');
    }

    // 处理搜索字段
    static function dealSearchData($search)
    {
        $conditions = array();
        $search = Func_Input::filter(array(
//            'keyword2' => 'string',
            'city' => 'string',
            'baike_id' => 'array',
            'activeType' => 'string',
            'category' => 'int',
            'size_range' => 'string',
            'people_range' => 'string',
            'is_outside' => 'int',
            'keyword2' => 'string',
//            'rank' => 'int',
            'admin_area' => 'string',  // 行政区域
            'business_area' => 'string',
            'industry_type' => 'string',
        ), $search);
        if (!empty($search['baike_id'])) {
            $conditions[] = 'baike_id in (' . implode(',', $search['baike_id']) . ')';
        }

        if (!empty($search['city'])) {
            $citys = Web_Global::$city_name;
            if (array_key_exists($search['city'], $citys)) {
                $conditions['city'] = $citys[$search['city']];
            }
        }
        if (!empty($search['category']) && $search['category'] != 112) {
            $conditions['category_id'] = $search['category'];
        }
        if (!empty($search['active_type'])) {
            $conditions['attr']['活动类型'] = '+' . $search['active_type'];
        }
        if (!empty($search['admin_area'])) {
            $conditions['attr']['行政区域'] = '+' . $search['admin_area'];
        }
        if (!empty($search['industry_type'])) {
            $conditions['attr']['行业类型'] = '+' . $search['industry_type'];
        }
        if (!empty($search['business_area'])) {
            $conditions['attr']['所属商圈'] = '+' . $search['business_area'];
        }
        if (!empty($search['activeType'])  && $search['activeType']!='全部') {
            $conditions['past_case'] = '+' . $search['activeType'];
        }
        if (!empty($search['people_range'])) {
            $search['people_range'] = explode(',', $search['people_range']);
            if (!empty($search['people_range'][0]) && !empty($search['people_range'][1])) {
                $conditions[] = 'min_people <' . $search['people_range'][1] . ' AND max_people >=' . $search['people_range'][0];
            } elseif (!empty($search['people_range'][0]) && empty($search['people_range'][1])) {
                if($search['people_range'][0]=='min'){
                    $conditions[] = 'max_people <=50';
                }else{
                    $conditions[] = 'max_people >='.$search['people_range'][0];
                }
            } elseif (empty($search['people_range'][0]) && !empty($search['people_range'][1])) {
                $conditions[] = 'max_people <=' . $search['people_range'][1];
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
        if (!empty($search['is_outside'])) {
            if($search['is_outside']==5){
                $conditions['is_outside'] = 2;
            }else{
                $conditions['is_outside'] = $search['is_outside'];
            }
        }
        return $conditions;
    }

    // 获取符合条件的空间数量
    static function getFitItemCount($conditions)
    {
        $count = Data_Mysql_Table_Search_Space_Item::select('count(*) as fitItemCount,baike_id,item_id', $conditions, 'GROUP BY baike_id', 8);
        $count_baike = array();
        if (!empty($count)) {
            foreach ($count as $k => $v) {
                $count_baike[$v['baike_id']] = $v['fitItemCount'];
            }
        }
        return $count_baike;
    }

}