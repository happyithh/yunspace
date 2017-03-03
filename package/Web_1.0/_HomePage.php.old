<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/6
 * Time: 10:41
 */
class Web_HomePage extends Data_Config
{
    public $all = array(
        'banner' => array(),
    );

    //左侧导航
    static function leftNav()
    {
        $tree = Data_Mysql_Table_Product_Category::getTreeCache();
        $navArray = array(
            '112' => '',
            '2' => '',
            '9' => '',
            '146' => '',
//            '7' => '',
            '0' => array('其他', 'service', $tree[0]),
        );
        foreach ($navArray as $k => $v) {
            if ($k) {
                unset($navArray[0][2][$k]);
                $navArray[$k] = empty($tree[$k]) ? '' : array(
                    $tree[0][$k],
                    Data_Config_Site::isSpace($k) ? 'space' : 'service',
                    $tree[$k]
                );
            }
        }
        return $navArray;
    }

    //banner焦点图
    static function banner()
    {
        $banner = self::get('banner');
        if (!empty($banner[$_COOKIE['city']])) {
            $banner = $banner[$_COOKIE['city']];
            foreach ($banner as $k => $v) {
                if (@strpos($v['url'], 'yun.highspace.cn')) {
                    $banner[$k]['url'] = @str_replace('yun.highspace.cn', Core::$urls['host'], $v['url']);
                }
                if (@$v['path'] && strpos($v['path'], 'yun.highspace.cn')) {
                    $banner[$k]['path'] = @str_replace('yun.highspace.cn', Core::$urls['host'], $v['path']);
                }
            }
            return $banner;
        }
        return array();
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

    static function loadHotSet()
    {
        $conditions['attr_index']['城市'] = '+' . $_COOKIE['city'];
        $conditions['status'] = 1;
        $rs = Data_Mysql_Table_Product_Set::select('id,set_name,addr,logo,set_price,hours', $conditions, '', 4);
        return $rs;
    }

    static function loadHotContent($blockName)
    {
        $ids = self::getHotContent($blockName);
        if (empty($ids)) {
            if ($blockName == '热门空间') {
                $rs = self::loadService(112, 7, 1);
            } elseif ($blockName == '最新空间') {
                $rs = self::loadService(112, 7);
            } elseif ($blockName == '热门场地搭建') {
                $rs = self::loadService(0, 4, 1);
            } elseif ($blockName == '热门空间预定') {
                $rs = self::loadService(112, 11, 1);
                $rs = array_slice($rs, 7, 4);
            } elseif ($blockName == '热门商场') {
                $rs = self::loadService(114, 11, 1);
                $rs = array_slice($rs, 7, 4);
            } elseif ($blockName == '热门秀场') {
                $rs = self::loadService(113, 11, 1);
                $rs = array_slice($rs, 7, 4);
            } elseif ($blockName == '热门新奇场地') {
                $rs = self::loadService(124, 11, 1);
                $rs = array_slice($rs, 7, 4);
            }
        } else {
            $rs = Data_Mysql_Table_Product_Search::select('id, product_name, order_counter_view,counter_follow,logo,addr', array(
                'id in (' . implode(',', $ids) . ')',
            ), '', count($ids));
        }
        $ids = $ids ? array_flip($ids) : array();

        foreach ($rs as $k => $v) {
            if ($v) {
                $ids[$v['id']] = $rs[$k];
            }
        }
        shuffle($ids);
        return array_values($ids);
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
        $conditions['attr_index'][$ctyId] = '+' . $_COOKIE['city'];
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
            $order = "ORDER BY id DESC";
        }
        $rs = Data_Mysql_Table_Product_Search::select('id, product_name, order_counter_view,counter_follow,logo, addr', $conditions, $order, $num);
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

    static function newlyEvent()
    {
        $conditions = array();
        $conditions['{table}.status=? AND {prefix}event_case.id IS NOT NULL'] = 1;
        $conditions['{table}.addr=?'] = $_COOKIE['city'];
        $cols = '{table}.id,logo,event_name,{prefix}event_case.media';
        $list = Data_Mysql_Table_Event_Info::select($cols, $conditions, 'ORDER BY {table}.id DESC', 4, '{table} LEFT JOIN {prefix}event_case ON {table}.id = {prefix}event_case.event_id');
        if (count($list) < 4) {
            $list2 = Data_Mysql_Table_Event_Info::select($cols, array('status' => 1, '{prefix}event_case.id IS NOT NULL'), 'ORDER BY {table}.id DESC', 4 - count($list), '{table} LEFT JOIN {prefix}event_case ON {table}.id = {prefix}event_case.event_id');
            $list = array_merge($list, $list2);
        }
        foreach ($list as $k => $v) {
            if (empty($v['logo']) && isset($v['media'])) {
                $case_media = json_decode($v['media'], 1);
                foreach ($case_media[1] as $kk => $vv) {
                    $list[$k]['logo'] = $vv['path'];
                    break;
                }
            }
        }
        return $list;
    }

    static function activityStrategy()
    {

    }
}