<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/7
 * Time: 13:43
 * 订单阶段记录表（用于统计）
 */
class Data_Mysql_Table_Winchance_Order_Status extends Data_Mysql_Table{
    public $cols = array(
        'order_id'=>'int',  // 订单id
        'step'=>'string', // 订单阶段
        'confirm_time'=>'15',    // 确认时间
    );
    public $index = array(
        'order_id,step'=>'u'
    );
}