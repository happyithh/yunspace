<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-4-1
 * Time: 下午4:43
 * 云收藏
 */
class Web_User_Center_Collection extends Base
{

    static function handle()
    {
        $type = empty($_REQUEST['action']) ? 'list': $_REQUEST['action'];

        switch($type){
            case 'pdf':
                self::printPdf();
                break;
            case 'pdf_product':
                Web_User_Center_Pdf::handleProductPdf($_REQUEST['product_id']);
                break;
            case 'list':
                self::getUserCollectionList();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }

    static function getUserCollectionList()
    {
        //获取所有收藏
        $type = empty($_REQUEST['type']) ? 'space' : $_REQUEST['type'];
        $conditions = array(
            'user_id' => $_SESSION['user']['id'],
            'is_cancel' => 1
        );
        $order = 'ORDER BY {table}.create_time desc';
        switch ($type) {
            case 'set':
                $cols = "{table}.create_time,{prefix}product_set.id,{prefix}product_set.logo,{prefix}product_set.set_name,{prefix}product_set.addr,{prefix}product_set.category_id,{prefix}product_set.attr_index";

                $join = "{table}   LEFT JOIN {prefix}product_set  ON {table}.follow_id = {prefix}product_set.id";

                break;
            case 'space':
                $cols = array('{table}.create_time', 't2.logo', 't2.id', 't2.category_id', 't2.product_name',
                    't2.addr', 't2.order_product_size as product_size',  't2.attr_index', 't2.counter_follow',
                    't2.counter_order');
                $join = '{table} LEFT JOIN {prefix}product_search as t2 ON {table}.follow_id = t2.id';
                break;
            case 'vendor':
                $cols = array('{table}.create_time', '{prefix}vendor_info.id', '{prefix}vendor_info.categories_id as category_id', '{prefix}vendor_info.vendor_name',
                    '{prefix}vendor_info.base_info', '{prefix}vendor_info.attr', '{prefix}vendor_info.media', '{prefix}vendor_info.counter_follow',
                    '{prefix}vendor_info.counter_order');
                $join = '{table} LEFT JOIN {prefix}vendor_info ON {table}.follow_id = {prefix}vendor_info.id';
                break;
            case 'event':
                $cols = array('{table}.create_time', '{prefix}event_info.id', '{prefix}event_info.category_id', '{prefix}event_info.event_name',
                    '{prefix}event_info.addr', '{prefix}event_info.attr', '{prefix}event_info.des', '{prefix}event_info.media', '{prefix}event_info.counter_follow',
                    '{prefix}event_info.counter_view', '{prefix}event_info.logo');
                $join = '{table} LEFT JOIN {prefix}event_info ON {table}.follow_id = {prefix}event_info.id';
                break;
        }
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();
//        Data_Mysql_Table_Follow::subTable("_$type")->debug(1);
        $rs = Data_Mysql_Table_Follow::subTable("_$type")->page(0, 0, $cols, $conditions, $order, $join);
        if (!empty($rs['rows'])) {
            foreach ($rs['rows'] as $key => $value) {
                if (!empty($value['attr'])) {
                    $rs['rows'][$key]['attr'] = json_decode($value['attr'], 1);
                }
                if (!empty($value['base_info'])) {
                    $rs['rows'][$key]['base_info'] = json_decode($value['base_info'], 1);
                }
                if (!empty($value['media'])) {
                    $rs['rows'][$key]['media'] = json_decode($value['media'], 1);
                    foreach ($rs['rows'][$key]['media'] as $mk => $mv) {
                        //主图
                        if (empty($rs['rows'][$key]['logo'])) {
                            $rs['rows'][$key]['logo'] = $mv['path'];
                        }
                        $mvTags = explode(',', $mv['tags']);
                        foreach ($mvTags as $mTag) {
                            if ($mTag == '@主图') {
                                $rs['rows'][$key]['logo'] = $mv['path'];
                            }
                            $rs['rows'][$key]['media'][$mTag][$mv['path']] = $mv['name'];
                        }
                    }
                }
                if ($type == 'set') {
                    if (!empty($value['attr_index'])) {
                        $rs['rows'][$key]['attr_index'] = json_decode($value['attr_index'], 1);
                    }
                    if(isset($value['category_id'])){
                        $rs['rows'][$key]['category_name'] = Data_Mysql_Table_Product_Set::$category_name[$value['category_id']];
                    }
                } else {
                    if (!empty($categories[$value['category_id']][0])) {
                        $rs['rows'][$key]['category_name'] = $categories[$value['category_id']][0];
                    }
                }
            }
        }
        unset($conditions[0]);
        $total = Data_Mysql_Table_Follow::subTable('_set')->select('count(*) as c', $conditions);
        $set_num = empty($total[0]['c']) ? 0 : $total[0]['c'];
        $total = Data_Mysql_Table_Follow::subTable('_space')->select('count(*) as c', $conditions);
        $space_num = empty($total[0]['c']) ? 0 : $total[0]['c'];
        $total = Data_Mysql_Table_Follow::subTable('_vendor')->select('count(*) as c', $conditions);
        $vendor_num = empty($total[0]['c']) ? 0 : $total[0]['c'];
        $total = Data_Mysql_Table_Follow::subTable('_event')->select('count(*) as c', $conditions);
        $event_num = empty($total[0]['c']) ? 0 : $total[0]['c'];
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('set_num', $set_num);
        Tpl_Smarty::assign('space_num', $space_num);
        Tpl_Smarty::assign('vendor_num', $vendor_num);
        Tpl_Smarty::assign('event_num', $event_num);
        Tpl_Smarty::assign('data', $rs);
        Tpl_Smarty::display('Web_User_Center', 'user_admin_favorite.tpl');
    }

    /*
     *导出PDF
     */
    static function printPdf()
    {
        if (empty($_REQUEST['set_id'])) {
            Func_Header::notFound();
        }
        Web_User_Center_Pdf::handleProductSetPdf($_REQUEST['set_id']);
    }

}