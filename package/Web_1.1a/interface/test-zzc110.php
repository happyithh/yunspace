<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/12/7
 * Time: 20:23
 */
q('Gloria Jea\'ns Coff特殊符号测试z', Func_Url::str_urlencode('Gloria Jea\'ns Coff特殊符号测试z'));
die();
header("Pragma: no-cache");
$category = Data_Mysql_Table_Product_Category::getTreeCache();
$allC = array();
foreach ($category as $k => $val) {
    foreach ($val as $kk => $vv) {
        $allC[$kk] = $vv;
    }
}
$request = Func_Input::filter(array(
    'id' => 'int'
), $_REQUEST);

if (!empty($request['id'])) {
    $id = $request['id'];
} else {
    $id = 0;
}

if (!empty($_REQUEST['old_product'])) {
    $where['id>?'] = $id;
    $product = Data_Mysql_Table_Product_Search::select('id,attr_index,product_name,category_id,order_counter_view', $where, ' ORDER  BY id ASC', 500);
    if (empty($product)) {
        q('全部了');
    }
    if (!empty($product[0])) {
        $cols = array('ID', '城市', '场地', '分类', '浏览量','面积','人数','行政区','商圈');
        $list = array();
        if (!$id) {
            @file_put_contents(Core::$paths['temp'] . 'export/old_product.csv', '');
        }
        foreach ($product as $k => $v) {
            if (!empty($allC[$v['category_id']])) {
                $c_name = $allC[$v['category_id']];
            } else {
                $c_name = $v['category_id'];
            }
            $v['attr_index'] =  json_decode($v['attr_index'],1);
            $list[$k][] = $v['id'];
            $list[$k][] = $v['attr_index']['46'];
            $list[$k][] = $v['product_name'];
            $list[$k][] = $c_name;
            $list[$k][] = $v['order_counter_view'];
            $list[$k][] = intval($v['attr_index']['10']);
            $list[$k][] = intval($v['attr_index']['8']);
            $list[$k][] = $v['attr_index']['4'];
            $list[$k][] = $v['attr_index']['2'];
            $id = $v['id'];
        }
        Func_Csv::writeRow($cols, $list, 'old_product', Core::$paths['temp'] . 'export/old_product.csv');
        Func_Header::to('', "http://" . Core::$urls['host'] . "/test-zzc110?old_product=1&id=" . $id);
    }
} elseif (@$_REQUEST['baike']) {
    $where['id>?'] = $id;

    $data = Data_Mysql_Table_Spacepedia_Search::select('id,city,space_name,category_id,click', $where, 'ORDER  BY id ASC', 500);
    if (empty($data[0])) {
        q('全部了');
    }
    if (!$id) {
        @file_put_contents(Core::$paths['temp'] . 'export/new_baike.csv', '');
    }
    $cols = array('ID', '城市', '百科名称', '分类', '浏览量');
    $list = array();
    foreach ($data as $k => $v) {
        if (!empty($allC[$v['category_id']])) {
            $c_name = $allC[$v['category_id']];
        } else {
            $c_name = $v['category_id'];
        }
        $list[$k][] = $v['id'];
        $list[$k][] = $v['city'];
        $list[$k][] = $v['space_name'];
        $list[$k][] = $c_name;
        $list[$k][] = $v['click'];
        $id = $v['id'];
    }
    Func_Csv::writeRow($cols, $list, 'new_baike', Core::$paths['temp'] . 'export/new_baike.csv');
    Func_Header::to('', "http://" . Core::$urls['host'] . "/test-zzc110?baike=1&id=" . $id);

} elseif (@$_REQUEST['demand']) {
    $where['id>?'] = array($id);
    $demand = Data_Mysql_Table_Demand::select('*', $where, 'ORDER  BY id ASC', 500);
    if (empty($demand[0])) {
        q('全部了');
    }
    if (!$id) {
        @file_put_contents(Core::$paths['temp'] . 'export/demand.csv', '');
    }
    $cols = array('ID', '手机号', '公司名称', '城市', '活动类型', '场地类型', '预约咨询类型', '活动日期', '结束日期', '价格下限', '价格上限', '相关产品ID', '相关套餐ID', '相关百科ID');
    $list = array();
    foreach ($demand as $k => $v) {
        $list[$k][] = $v['id'];
        if (!empty($v['backup_demand'])) {
            $demand_json = json_decode($v['backup_demand'], 1);
            $list[$k][] = @$demand_json['联系方式'];
            $list[$k][] = @$demand_json['公司名称'];
            $list[$k][] = $v['city'];
            $list[$k][] = @$demand_json['活动类型'];
            $list[$k][] = @$demand_json['场地类型'];

        } elseif (!empty($v['demand'])) {
            $demand_json = json_decode($v['demand'], 1);
            $list[$k][] = $v['phone'];
            $list[$k][] = @$demand_json['公司名称'];
            $list[$k][] = $v['city'];
            $list[$k][] = @$demand_json['活动类型'];
            $list[$k][] = @$demand_json['场地类型'];
        } else {
            $list[$k][] = $v['phone'];
            $list[$k][] = '';
            $list[$k][] = $v['city'];
            $list[$k][] = '';
            $list[$k][] = '';
        }
        $list[$k][] = $v['demand_type'];

        $list[$k][] = @$demand_json['开始时间'];
        $list[$k][] = @$demand_json['结束时间'];

        $list[$k][] = $v['price_up'];
        $list[$k][] = $v['price_down'];
        $i_d_a = $i_d_b = $i_d_c = '';
        if (!empty($demand_json['product_id'])) {
            $i_d_a = $demand_json['product_id'];
        }
        if (!empty($demand_json['set_id'])) {
            $i_d_b = $demand_json['set_id'];
        }
        if (!empty($demand_json['space_id'])) {
            $i_d_c = $demand_json['space_id'];
        }
        $list[$k][] = $i_d_a;
        $list[$k][] = $i_d_b;
        $list[$k][] = $i_d_c;
        $id = $v['id'];
    };

    Func_Csv::writeRow($cols, $list, 'demand', Core::$paths['temp'] . 'export/demand.csv');
    Func_Header::to('', "http://" . Core::$urls['host'] . "/test-zzc110?demand=1&id=" . $id);
}