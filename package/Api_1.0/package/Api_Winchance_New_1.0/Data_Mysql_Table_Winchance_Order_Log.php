<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/7
 * Time: 13:43
 * 订单日志表
 */
class Data_Mysql_Table_Winchance_Order_Log extends Data_Mysql_Table{
    public $cols = array(
        'order_id'=>'int',  // 场地
        'log_data'=>'array', // 联系人姓名
        'create_time'=>'int',//创建时间
        'update_time'=>'int',//修改时间
    );
    public $index = array(
        'order_id'=>'i'
    );

    static $step = array(
    );
}