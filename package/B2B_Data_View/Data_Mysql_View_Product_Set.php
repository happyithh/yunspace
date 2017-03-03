<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/5/12
 * Time: 9:52
 */
Class  Data_Mysql_View_Product_Set extends Data_Mysql_View
{
    public $cols = array(
        'id' => 'product_set.id',
        'set_name' => 'product_set.set_name',               //  套餐名称
        'version' => 'product_set.version',                       //  版本
        'addr' => 'product_set.addr',                       //  地址
        'category_id' => 'product_set.category_id',                  //分类id
        'vendor_id' => 'product_set.vendor_id',                  //供应商id
        'schedule_product_id' => 'product_set.schedule_product_id',              //关联档期产品ID
        'attr_index' => 'product_set.attr_index',                   //标签
        'logo' => 'product_set.logo',                        //logo
        'version' => 'product_set.version',                  //版本
        'detail_data' => 'product_set.detail_data',            //套餐版本细节
        'detail' => 'product_set.detail',                //套餐版本细节2
        'detail_des' => 'product_set.detail_des',            //套餐版本细节2
        'counter_order' => 'product_set.counter_order',              //订单总数
        'create_time' => 'product_set.create_time.',             //创建时间
        'update_time' => 'product_set.update_time',          //修改时间
        'score' => 'product_set.score',                //评分
        'hours' => 'product_set.hours',                 //小时数
        'status' => 'product_set.status',               //0下线，1上线，2待审核，3审核未通过  -n  关闭
        'search_attr_index' => 'product_search.attr_index',   //产品搜索表中的attr_index
        'geo_lat' => 'product_search.geo_lat',
        'geo_lng' => 'product_search.geo_lat',
    );

    public $joins = array(
        'product_set.schedule_product_id' => 'product_search.id',
    );

    static function getProductSearchAttrWithValues($cid = '112', $conditions)
    {
        $cache = Data_Mysql_Table_Cache_Array::get('product_set', array($cid, $conditions));
        if (!empty($cache)) {
            return $cache;
        }
        //可见的标签id  一维
        $attrIds = array();
        $attrTemp = array();
        //获取可分类下可搜索的标签
        $attrInfo = Data_Mysql_Table_Product_Category::getTagsInfo($cid, 1);
        foreach ($attrInfo as $k => $v) {
            $attrIds += $v;
        }
        unset($attrIds['']);

        //获取当前搜索每件下的可用标签值 -  //同时过滤
        $rs = self::select('search_attr_index', $conditions, 'ORDER BY update_time DESC', 999);
        if (!empty($rs)) {
            foreach ($rs as $v) {
                $attrIndex = json_decode($v->search_attr_index, 1);
                if (is_array($attrIndex)) {
                    foreach ($attrIndex as $vk => $vv) {
                        if (!isset($attrIds[$vk])) {
                            continue;
                        }
                        $vv = explode(',', $vv);

                        foreach ($vv as $vvv) {

                            if ($vvv && strlen($vvv) < 32 && !is_numeric($vvv)) {
                                if (empty($attrTemp[$vk][$vvv])) {
                                    $attrTemp[$vk][$vvv] = 1;
                                } else {
                                    $attrTemp[$vk][$vvv]++;
                                }
                            }
                        }

                    }
                }
            }
        }
        unset($attrTemp[49], $attrTemp[9]);
        //返回
        if (empty($attrTemp)) {
            $attr = false;
        } else {
            $attr = array();
            foreach ($attrTemp as $k => $v) {
                if (count($v) > 1) {
                    arsort($v);
                    foreach ($v as $kk => $vv) {
                        $kk1 = str_replace(' ', '', $kk);
                        unset($v[$kk]);
                        $v[$kk1] = $vv;
                    }
                    $attr[$k] = array('tags' => $attrIds[$k]['tags_name'], 'val' => array_slice($v, 0, 24));
                }
            }
            Data_Mysql_Table_Cache_Array::set('product_set', array($cid, $conditions), $attr);
        }
        return $attr;
    }
}
