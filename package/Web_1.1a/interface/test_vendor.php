<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/5/25
 * Time: 16:27
 * 导出  上海的供应商   类型非 112 下面的
 */
$category = Data_Mysql_Table_Product_Category::getTreeCache();
$newCA = array();
foreach ($category as $k => $val) {
    foreach ($val as $kk => $vv) {
        if (!empty($vv)) {
            $newCA[$kk] = $vv;
        }
    }
}

$request = Func_Input::filter(array(
    'action' => 'string',
    'p' => 'int',
));
$cols = array(
    '公司',
    '服务类型',
    '服务',
    '联系人',
    '手机',
    '邮箱'
);
if (!empty($request['action']) && $request['action'] == 'csv') {

    if ($request['p'] == 1) {
        $conditions['attr_index'][46] = '上海';
        $conditions['{table}.status=?'] = 1;
        $conditions['t2.vendor_account_id>?'] = 1;
        $conditions[] = "{table}.category_id NOT IN(112,113,114,115,116,117,118,119,120,121,122,123,124,125)";
        $table = "{table}  LEFT JOIN {prefix}vendor_info as t2 ON {table}.vendor_id = t2.id  LEFT JOIN {prefix}account as t3 ON t3.id = t2.vendor_account_id ";
        //Data_Mysql_Table_Product_Search::debug(1);
        $data = Data_Mysql_Table_Product_Search::select('{table}.vendor_name,{table}.category_id,{table}.product_name,{table}.addr,t3.phone,t3.fullname,t3.email',
            $conditions, 'GROUP BY {table}.vendor_name',
            '1500', $table);
//q(count($data));
        if (!empty($data[0])) {
            $list = array();
            foreach ($data as $k => $v) {
                $list[$k]['公司'] = $v['vendor_name'];
                $list[$k]['服务类型'] = @$newCA[$v['category_id']];
                $list[$k]['服务'] = $v['product_name'];
                $list[$k]['联系人'] = $v['fullname'];
                $list[$k]['手机'] = $v['phone'];
                $list[$k]['邮箱'] = $v['email'];
            }
            Func_Csv::writeRow($cols, $list, 'vendor',
                Core::$paths['temp'] . 'export/vendor.csv');
            // header('Location: http://' . Core::$urls['host'] . "/vendor?action=csv&p=2");
        }
    }

}
