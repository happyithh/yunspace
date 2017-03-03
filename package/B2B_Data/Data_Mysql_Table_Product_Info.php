<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Product_Info extends Data_Mysql_Table
{
    public $cols = array(
        'category_id' => 'int',
        'vendor_id' => 'int',
        'admin_id' => 'int',
        'product_name' => '200',
        'addr' => '200',
        'geo_lat' => 'int',
        'geo_lng' => 'int',
        'logo' => '100',
        'attr' => 'array',
        'attr_new' => 'array',
        'attr_index' => 'array',
        'price' => 'int',
        'media_num' => 'int',
        'media' => 'array',
        'des' => 'html',
        'memo' => 'html',
        'score' => '10',                      //评分
        'counter_view' => 'int',
        'counter_view_index' => 'int',
        'counter_follow' => 'int',
        'counter_follow_cancel' => 'int',
        'counter_order' => 'int',
        'counter_order_complete' => 'int',
        'order_lv' => 'tinyint', //高2 中 1 低0
        'create_time' => 'int',
        'update_time' => 'int',
        'status' => 'tinyint',  //0下线，1上线，2待审核，3审核未通过
        'product_size' => 'int',
        'create_by_quick' => 'int', //1快速创建，0普通创建 2采集数据  3淘会场
        'refuse_reason' => '100' ,   //拒绝的理由
        'is_convert' => 'tinyint',    //是否已转化为场地百科   0 未转化   1  已转化
        'have_space' => '200'    //是否有对应的百科     0 没有  1 有
    );
    public $index = array(
        'category_id' => 'i',
        'admin_id' => 'i',
//        'vendor_id,product_name' => 'u',                                                    //p:主键, u:唯一索引, i:索引
        'product_name, addr' => 'title',
        'product_name' => 'i',
        'addr' => 'des',
        'attr_index' => 'attr',
        'attr_new'=>"attr",
//        'geo_lat' => 'i',
//        'geo_lng' => 'i',
        'price' => 'i',
        'counter_view_index' => 'i',
        'counter_follow' => 'i',
        'counter_order' => 'i',
        'status' => 'i',
        'product_size' => 'i',
    );
    public $title = array(
        "" => "产品信息",                                                     //空键,表名
        'admin_id' => '创建者',
        'category_id' => '分类ID',
        'vendor_id' => '供应商ID',
        'product_name' => '产品名称',
        'addr' => '地址',
        'geo_lat' => '地理GEO-LAT',
        'geo_lng' => ' 地理GEO-LNG',
        'attr' => '属性数据',
        'attr_new' => '新属性数据',
        'attr_index' => '属性索引-扁平',
        'price' => '价格',
        'media' => '媒体材料',
        'media_num' => '媒体材料',
        'des' => '介绍',
        'counter_view' => '浏览量',
        'counter_view_index' => '浏览量索引',
        'counter_follow' => '收藏量',
        'counter_follow_cancel' => '取消收藏量',
        'counter_order' => '订单数',
        'counter_order_complete' => '完成订单数',
        'create_time' => '添加时间',
        'update_time' => '更新时间',
        'product_size' => '面积',
    );
    public $titleHidden = array( //    list / form / both
        'geo_lat' => 'both',
        'geo_lng' => 'both',
        'attr_index' => 'both',
        'media' => 'list',
        'media_num' => 'form',
        'des' => 'list',
        'price' => 'list',
        'attr' => 'list',
        'addr' => 'list',
        'counter_view_index' => 'both',
        'counter_follow_index' => 'both',
        'counter_order_index' => 'both',
        'create_time' => 'list',
        'update_time' => 'list',
    );
    public $filter = array(
        'status' => array(
            99 => '回收站',
            98 => '停用',
            1 => '正常',
            0 => '待审核',
        ),
    );

    static function attrToIndex($attr)
    {
        unset($attr['基本信息>停车位'], $attr['基本信息>人数上限'], $attr['基本信息>面积'], $attr['基本信息>层高'], $attr['基本信息>供电量']);
        return $attr;
    }

    static function getProductAttrWithValues($cid, $conditions)
    {
        $attrTemp = array();
        $attrInfo = Data_Mysql_Table_Product_Category::getCategoryAttr($cid);
        foreach ($attrInfo as $v) {
            $attrTemp[$v['name']] = $v['values'] ? array_fill_keys(explode(',', $v['values']), 1) : array();
        }
        if (!empty($conditions['attr_index']['城市'])) {
            $conditions['attr_index'] = array('城市' => $conditions['attr_index']['城市']);
        } else {
            unset($conditions['attr_index']);
        }
        $rs = Data_Mysql_Table_Product_Info::select('attr_index', $conditions, 'ORDER BY update_time DESC', 200);
        if (!empty($rs)) {
            foreach ($rs as $k => $v) {
                $attrIndex = json_decode($v['attr_index'], 1);
                foreach ($attrIndex as $vk => $vv) {
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
        unset($attrTemp['市场价'], $attrTemp['价格单位']);
        $attr = array();
        foreach ($attrTemp as $k => $v) {
            if (count($v) > 1) {
                arsort($v);
                $attr[$k] = array_slice($v, 0, 24);
            }
        }
        return $attr;
    }

    static function getProductSearchAttrWithValues($cid, $conditions)
    {
        //处理一下$conditions ;
        $cityId = Page_Site_Global::tagsName('城市');
        if (!empty($conditions['attr_index'][$cityId])) {
            $conditions['attr_index'] = array($cityId => $conditions['attr_index'][$cityId]);
        } else {
            unset($conditions['attr_index']);
        }
        $cache = Page_Site_Global::get(array($cid, $conditions));
        if (!empty($cache)) {
            return $cache;
        }
        //可见的标签id  一维
        $attrIds = array();
        $attrTemp = array();
        //获取可分类下可搜索的标签
        $attrInfo = Data_Mysql_Table_Product_Category::getTagsInfo($cid, 1, 1);
        foreach ($attrInfo as $k => $v) {
            $attrIds += $v;
        }
        unset($attrIds['']);
        //获取当前搜索每件下的可用标签值 -  //同时过滤
        $rs = Data_Mysql_Table_Product_Search::select('attr_index', $conditions, 'ORDER BY update_time DESC', 600);
        if (!empty($rs)) {
            foreach ($rs as $k => $v) {
                $attrIndex = json_decode($v['attr_index'], 1);
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
        //返回
        if (empty($attrTemp)) {
            $attr = false;
        } else {
            $attr = array();
            foreach ($attrTemp as $k => $v) {
                if (count($v) > 1) {
                    arsort($v);
                    foreach($v as $kk=>$vv){
                        if($vv<3){
                            unset($v[$kk]);
                        }else{
                            $kk1 =str_replace(' ','',$kk);
                            unset($v[$kk]);
                            $v[$kk1]=$vv;
                        }
                    }
                    $attr[$k] = array('tags' => $attrIds[$k]['tags_name'], 'val' => array_slice($v, 0, 24));
                }
            }
            Page_Site_Global::set(array($cid, $conditions), $attr);
        }
        return $attr;
    }

    static function handleDelete($product_id, $status = -1)
    {
        //更新产品状态
        $r = Data_Mysql_Table_Product_Info::query("UPDATE {table} SET status = ? WHERE id = ?", array($status, $product_id), 1);
        $r_update = Data_Mysql_Table_Product_Info::query("UPDATE {table}_update SET status = ? WHERE id = ?", array($status, $product_id), 1);
        $r_search = Data_Mysql_Table_Product_Search::query("UPDATE {table} SET status = ? WHERE id = ?", array($status, $product_id), 1);
        if (empty($r[0]) || empty($r_update[0]) || empty($r_search[0])) {
            return false;
        }
        return true;
    }

}