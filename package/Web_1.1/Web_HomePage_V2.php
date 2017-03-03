<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/6/23
 * Time: 10:41
 */
class Web_HomePage_V2 extends Data_Config
{
    public $all = array(
        'banner' => array(),
        'banner_moblie' => array(),
    );

    //banner焦点图
    static function banner()
    {
//        q($_REQUEST);
        $banner = self::get('banner');
       /* if (!empty($banner[$_COOKIE['city']])) {*/
        if (!empty($banner)){
           // $banner = $banner[$_COOKIE['city']];
            foreach ($banner as $k => $v) {
                if (@strpos($v['url'], 'yun.highspace.cn')) {
                    $banner[$k]['url'] = @str_replace('yun.highspace.cn', Core::$urls['host'], $v['url']);
                }
                if (@$v['path'] && strpos($v['path'], 'yun.highspace.cn')) {
                    $banner[$k]['path'] = @str_replace('yun.highspace.cn', Core::$urls['host'], $v['path']);
                }
            }
            return array_values($banner);
        }
        return array();
//        return $banner;
    }

    static function getHotContent($blockName)
    {
        $hotContent = self::get('hotContent');
        if (!empty($hotContent[$_COOKIE['city']][$blockName])) {
            $urls = $hotContent[$_COOKIE['city']][$blockName];
            if (preg_match_all('/\/([\d]+)\.html/i', $urls, $a)) {
                return $a[1];
            }
        }
        return false;
    }

    static function vendorAttr()
    {
        $attrs = self::get('vendor_attrs');
        if (empty($attrs)) {
            $attrs = Data_Config_Vendor_Attr::get('attr');
            self::set('vendor_attrs', $attrs);
        }
        return $attrs;
    }

    static function  goldPosition()
    {
        $goldPosition = self::get('goldPosition');
        if (empty($goldPosition[$_COOKIE['city']]['黄金位置'][0])) {
            return $goldPosition['上海']['黄金位置'];
        }
        return $goldPosition[$_COOKIE['city']]['黄金位置'];
    }

    static function  specialRecommend()
    {
        $specialRecommend = self::get('specialRecommend');
        return $specialRecommend['精心推荐'];
    }

    //超值套餐
    static function loadHotSet()
    {
        $ids = self::getHotContent('超值套餐');
        $conditions = array();
        if (!empty($ids)) {
            $conditions[] = "id IN(" . implode(',', $ids) . ")";
            $rs = Data_Mysql_Table_Product_Set::select('id,set_name,addr,logo,attr_index,set_price,detail,marketing_title,counter_view as counter_view_index', $conditions, '', count($ids));
        }
        if (empty($rs[0])) {
            $where['attr_index']['城市'] = $_COOKIE['city'].',全国';
            $where['status =?'] = 1;
            $rs = Data_Mysql_Table_Product_Set::select('id,set_name,addr,logo,attr_index,set_price,detail,marketing_title,counter_view as counter_view_index', $where, '', 8);
        }
        if (count($rs) < 8) {
            $where['attr_index']['城市'] = '';
            $where['status =?'] = 1;
            $rsNew = Data_Mysql_Table_Product_Set::select('id,set_name,addr,logo,attr_index,set_price,detail,marketing_title,counter_view as counter_view_index', $where, '', 8);
            if (!empty($rs)) {
                $rs_array_id = array();
                foreach ($rs as $k => $v) {
                    $rs_array_id[] = $v['id'];
                }
                foreach ($rsNew as $kk => $vv) {
                    if (!in_array($vv['id'], $rs_array_id) && count($rs) < 8) {
                        $rs[count($rs)] = $vv;
                    }
                }
            } else {
                $rs = $rsNew;
            }
        }
        foreach ($rs as $key => $val) {
            $rs[$key]['detail'] = json_decode($val['detail'], 1);
            $rs[$key]['attr_index'] = json_decode($val['attr_index'], 1);
        }
        $rs = array_slice($rs, 0, 8);
        return $rs;
    }

    static function loadHotContent($blockName)
    {
        $ids = self::getHotContent($blockName);

        if (!empty($ids)) {
            $rs0 = Data_Mysql_Table_Product_Search::select('id,product_name,vendor_name,price,des,order_counter_view,counter_follow,logo,addr,price', array(
                'id in (' . implode(',', $ids) . ') AND status = 1',
            ), '', count($ids));
        }
        if ($blockName == '秀场展馆') {
            $rs = self::loadService(113, 8, 1);
        } elseif ($blockName == '商业广场') {
            $rs = self::loadService(114, 8, 1);
        } elseif ($blockName == '高端会所') {
            $rs = self::loadService(119, 8, 1);
        } elseif ($blockName == '配套服务') {
            $rs = self::loadService(0, 8, 1);
        }
        if(!empty($rs0)){
            $rs = array_merge($rs0,$rs);
       }
        $ids1 = $ids ? array_flip($ids) : array();
        foreach ($rs as $k => $v) {

            if (!empty($v['price'])) {
                $rs[$k]['price'] = $v['price'] / 100;
            }
            if (!empty($v['attr_index'])) {
                $rs[$k]['attr_index'] = json_decode($v['attr_index'], 1);
            }
            if ($v) {
                $ids1[$v['id']] = $rs[$k];
            }
        }
        foreach($ids1 as $k=>$v){
            if(empty($v['id'])){
                unset($ids1[$k]);
            }
        }
        if(count($ids1)<8){
            return array_slice(array_values($ids1),0,4);
        }
        return array_slice(array_values($ids1),0,8);
    }
    static function  advertising()
    {
        $advertising = self::get('advertising');
        return $advertising['上海']['广告位'];
    }

    //block1: 最新空间
    static function loadService($categoryId, $num, $hot = '')
    {
        /**
         * 加载列表项
         */
        $conditions = array(
            'status' => 1,
        );
        $ctyId = Page_Site_Global::tagsName('城市');
        $conditions['attr_index'][$ctyId] = '+' . $_COOKIE['city'].',全国';
        if ($categoryId) {
            $children = Data_Mysql_Table_Product_Category::getChildren($categoryId);
            $children[] = $categoryId;
            $conditions[] = 'category_id in (' . implode(',', $children) . ')';
        } else {
            $children = Data_Mysql_Table_Product_Category::getChildren(Data_Config_Site::$staticConfig['space_id']);
            $children[] = Data_Config_Site::$staticConfig['space_id'];
            $conditions[] = 'category_id not in (' . implode(',', $children) . ')';
        }
        if ($hot) {
            $order = "ORDER BY order_counter_view DESC";
        } else {
            $order = "ORDER BY order_index DESC";
        }
        $rs = Data_Mysql_Table_Product_Search::select('id, product_name, order_counter_view,counter_follow,logo, addr,vendor_name,price,category_id', $conditions, $order, $num*3);

        if (count($rs) < 8) {
            unset($conditions['attr_index'][$ctyId]);
            $conditions['id>?'] = rand(0, 17000);
            $rsNew = Data_Mysql_Table_Product_Search::select('id, product_name, order_counter_view,counter_follow,logo, addr,vendor_name,price,category_id', $conditions, $order, $num*3);
            if (!empty($rs)) {
                $rs_array_id = array();
                foreach ($rs as $k => $v) {
                    $rs_array_id[] = $v['id'];
                }
                foreach ($rsNew as $kk => $vv) {
                    if (!in_array($vv['id'], $rs_array_id) && count($rs) < 8) {
                        $rs[count($rs)] = $vv;
                    }
                }
            } else {
                $rs = $rsNew;
            }
        }
        if ($categoryId == 0) {
            $category_ids = array();
            $new_rs = array();
            $i = 0;
            foreach ($rs as $k => $v) {
                if (empty($category_ids[$v['vendor_name']]) && !in_array($v['category_id'], $category_ids)) {
                    $category_ids[$v['vendor_name']] = $v['category_id'];
                    $new_rs[$i] = $v;
                    $i++;
                }
            }
            $rs = $new_rs;
        }
        return $rs;
    }

    //UPDATE  `yun_product_info` SET counter_view = (select ROUND(RAND() * 150))+150 WHERE id IN (2102,17,23,897,879,54,205,2047,396,390,301)
    static function recommendService($id = 0)
    {
        $ids = array(
            '112' => '2102,17,23,897,879,54,205,2047,396,390,301',
            '0' => '',
        );
        $rows = array();
        if (!empty($ids[$id])) {

        }
        return $rows;
    }

    static function activityStrategy($typeName = '精选专题')
    {
        switch ($typeName) {
            case '活动方案':
                $ids = Data_Mysql_Table_Raiders_Info::getCategoryChildren(1);
                break;
            case '经典案例':
                $ids = Data_Mysql_Table_Raiders_Info::getCategoryChildren(23);
                break;
            case '经验分享':
                $ids = Data_Mysql_Table_Raiders_Info::getCategoryChildren(6);
                break;
            case '精选专题':
                $ids = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
                break;
        }
        $conditions['status =?'] = 1;
        $conditions[] = "category_id IN (" . implode(',', $ids) . ")";
        $rs = Data_Mysql_Table_Raiders_Info::select('*', $conditions, 'ORDER BY create_time DESC', 8);
        return $rs;

    }


}