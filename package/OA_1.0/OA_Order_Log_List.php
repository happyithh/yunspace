<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-6-11
 * Time: 下午4:48
 */
class OA_Order_Log_List{
    static function handle(){
        $conditions = array();
        //筛选条件
        if(!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'order_no' => 'string',
                'admin_name' => 'string',
                'operate_type' => 'string',
                'end_time' => 'string',
                'start_time' => 'string',
            ), $_REQUEST['search']);
            //订单编号筛选
            if (!empty($search['order_no'])) {
                $conditions['order_no'] = $search['order_no'];
            }
            //操作人筛选
            if (!empty($search['admin_name'])) {
                $conditions['{prefix}administrator.username = ? '] = $search['admin_name'];
            }
            //操作类型筛选
            if (!empty($search['operate_type'])) {
                $conditions['operate_type'] = $search['operate_type'];
            }
            //操作时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.create_time < ?'] = strtotime($search['end_time']);
            }
        }
        $data = array();
        $order = 'ORDER BY {table}.create_time desc';
        $month = date('Ym', time());
        $data = Data_Mysql_Table_Order_Log::subTable('_' . $month)->page(0, 10, '{table}.operate_message,{table}.operate_type,{table}.order_id,{table}.order_no,{table}.create_time,{prefix}administrator.username', $conditions, $order, ' {table} LEFT JOIN {prefix}administrator ON {table}.admin_id={prefix}administrator.id');
        Tpl_Smarty::assign('data', $data);
        Tpl_Smarty::assign('operate_type', Data_Mysql_Table_Order_Log::$handle_type);
        Tpl_Smarty::display('OA', 'element/order_log_list.tpl');
    }
}