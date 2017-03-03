<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/12/7
 * Time: 20:23
 */
$a=Data_Mysql_Table_Baike_Dwz::getUrl($_REQUEST['url']);
q($a);
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
    $where['id>?'] =$id;
    $product = Data_Mysql_Table_Product_Search::select('id,product_name,category_id,order_counter_view', $where, ' ORDER  BY id ASC', 500);
    if (empty($product[0])) {

        Func_Header::to('  全部了', '?');
    }

    if ($product[0]) {
//        $cols = array('标识', '产品名称', '分类', '浏览量');
        $list = array();
        foreach ($product as $k => $v) {
            if (!empty($allC[$v['category_id']])) {
                $c_name = $allC[$v['category_id']];
            } else {
                $c_name = $v['category_id'];
            }
            $list[$k][] = $v['id'];
            $list[$k][] = $v['product_name'];
            $list[$k][] = $c_name;
            $list[$k][] = $v['order_counter_view'];
            $id = $v['id'];
        }
        Func_Csv::writeRow($cols, $list, 'old_product', Core::$paths['temp'] . 'export/old_product.csv');
        header('Location: http://' . Core::$urls['host'] . "/test-zzc?old_product=1&id=" . $id);

    }
} elseif (@$_REQUEST['baike']) {
    $where['id>?'] = $id;

    $data = Data_Mysql_Table_Spacepedia_Search::select('id,space_name,category_id,click', $where, 'ORDER  BY id ASC', 500);
    if (empty($data[0])) {
        Func_Header::to('  全部了', '?');
    }
//    $cols = array('标识', '百科名称', '分类', '浏览量');
    $list = array();
    foreach ($data as $k => $v) {
        if (!empty($allC[$v['category_id']])) {
            $c_name = $allC[$v['category_id']];
        } else {
            $c_name = $v['category_id'];
        }
        $list[$k][] = $v['id'];
        $list[$k][] = $v['space_name'];
        $list[$k][] = $c_name;
        $list[$k][] = $v['click'];
        $id = $v['id'];
    }
    Func_Csv::writeRow($cols, $list, 'new_baike', Core::$paths['temp'] . 'export/new_baike.csv');
    header('Location: http://' . Core::$urls['host'] . "/test-zzc?baike=1&id=" . $id);

} elseif (@$_REQUEST['demand']) {
    $where['id>?'] = array($id);
    $demand = Data_Mysql_Table_Demand::select('*', $where, 'ORDER  BY id ASC', 500);
    if (empty($demand[0])) {
        Func_Header::to('  全部了', '?');
    }
//    $cols = array('标识', '手机号', '公司名称', '城市', '活动类型', '场地类型', '预约咨询类型', '日期', '价格', '场地');
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

        $list[$k][] = @$demand_json['开始时间'] . '--' . @$demand_json['结束时间'];

        $list[$k][] = $v['price_up'] . '--' . $v['price_down'];
        $i_d_a = $i_d_b = $i_d_c = '';
        if (!empty($demand_json['product_id'])) {
            $i_d_a = '旧产品ID' . $demand_json['product_id'];
        }
        if (!empty($demand_json['set_id'])) {
            $i_d_b = '旧套餐ID' . $demand_json['set_id'];
        }
        if (!empty($demand_json['space_id'])) {
            $i_d_c = '百科ID' . $demand_json['space_id'];
        }
        $list[$k][] = $i_d_a;
        $list[$k][] = $i_d_b;
        $list[$k][] = $i_d_c;
        $id = $v['id'];
    };

    Func_Csv::writeRow($cols, $list, 'demand', Core::$paths['temp'] . 'export/demand.csv');

//    header('Status: 303 See Other' );
    header('Location: http://' . Core::$urls['host'] . "/test-zzc?demand=1&id=" . $id);
}