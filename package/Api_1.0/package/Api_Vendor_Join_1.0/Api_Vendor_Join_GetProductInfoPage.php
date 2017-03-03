<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/25
 * Time: 16:13
 */
class Api_Vendor_Join_GetProductInfoPage extends Api
{

    /**
     * @args = array(
     *
     *
     * )
     *
     */
    //获取供应商加盟提交的数据
    static function getPage($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'category_ids' => 'string',
            'categoryId' => 'int',
        ), $args);
        $table = "{table} as t1 LEFT JOIN {prefix}vendor_info_update as t2 ON t1.vendor_id = t2.id";
        $cols = "t1.id ,t1.refuse_reason,t1.category_id,t1.product_name, t1.status,t1.status as update_status,t1.counter_view";
        if (!empty($request['categoryId']) && $request['categoryId'] > 0) {
            $conditions[] = 't1.category_id in (' . $request['category_ids'] . ')';
        } else {
            $conditions[] = 't1.category_id not in (' . $request['category_ids'] . ')';
        }
        $conditions['t2.vendor_account_id =?'] = $request['account_id'];
        $data = Data_Mysql_Table_Product_Info::subTable('_update')->page(0, 0, $cols,
            $conditions, '', $table);

        $categories = Data_Mysql_Table_Product_Category::getInfoCache();
        foreach ($data['rows'] as $k => $v) {
            if (!empty($categories[$v['category_id']][0])) {
                $data['rows'][$k]['category_name'] = $categories[$v['category_id']][0];
            }
        }
        $data['is_vendor_join'] = 1;
        return $data;
    }


}