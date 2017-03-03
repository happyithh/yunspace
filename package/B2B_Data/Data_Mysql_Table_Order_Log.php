<?php

class Data_Mysql_Table_Order_Log extends Data_Mysql_Table
{
    public $cols = array(
        'order_id' => '50',
        'order_no' => '50',
        'admin_id' => 'int',
        'operate_type' => '50',
        'operate_message' => 'text',
        'create_time' => 'int',
    );
    public $index = array(
        'order_id' => 'i',
        'order_no' => 'i',
        'operate_message' => 'i',
    );
    public $title = array(
        'order_id' => '订单ID',
        'order_no' => '订单号',
        'admin_id' => '操作者',
        'operate_type' => '操作类型',
        'operate_message' => '操作信息',
        'create_time' => '操作时间',
    );

    static $handle_type = array(
        '其他', '取消','恢复','关闭','删除','更新',
    );

    //创建该订单的操作日志
    static function insertOrderLog($order_id,$order_no, $admin_id = 0, $operate_message = '更新账户信息', $operate_type = 0)
    {
        if (empty($order_id) || empty($order_no)) {
            return false;
        }
        if(!in_array($operate_type,self::$handle_type)){
            $operate_type="其他";
        }
        $log_data = array('order_id' => $order_id,'order_no'=>$order_no, 'admin_id' => $admin_id, 'operate_message' => $operate_message, 'operate_type' => $operate_type, 'create_time' => time());
        //获取当前月份
        $month = date('Ym', time());
        $rs = Data_Mysql_Table_Order_Log::subTable('_' . $month)->insert($log_data);
    }
}