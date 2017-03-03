<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-5-7
 * Time: 下午3:19
 */
class OA_My_Demand_List
{
    static function handle($type = 1)
    {
        //获取我领取的所有联系人
        $my_demand = array();
        $cols = array(
            '{table}.id', '{table}.demand_type', '{table}.demand', '{prefix}contact_library.id as contact_id', '{table}.city', '{table}.create_time', '{prefix}contact_library.username', '{prefix}contact_library.phone'
        );
        if ($type) {
            $conditions['{prefix}contact_library.type = ?'] = $type;
            $_REQUEST['type'] = $type;
        } else {
            unset($cols[2]);
        }
        $conditions ['{prefix}contact_relation.admin_id = ?'] = $_SESSION['administrator']['id'];
        $table = "{table} LEFT JOIN {prefix}contact_library ON {table}.phone = {prefix}contact_library.phone LEFT JOIN {prefix}contact_relation ON {prefix}contact_library.id = {prefix}contact_relation.contact_id";
        $my_demand = Data_Mysql_Table_Demand::page(0, 15, $cols, $conditions, 'ORDER BY {table}.id DESC', $table);
        if (!empty($my_demand['rows'])) {
            foreach ($my_demand['rows'] as $key => $value) {
                if (!empty($value['demand'])) {
                    $my_demand['rows'][$key]['demand'] = json_decode($value['demand'], 1);
                }
            }
        }
        Tpl_Smarty::assign('_data', $my_demand);
        Tpl_Smarty::display('OA', 'my_demand_list.tpl');
    }
}