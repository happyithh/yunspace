<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-9-11
 * Time: 下午1:44
 *拓展日志表视图
 */
class  Data_Mysql_View_Expand_Log extends Data_Mysql_View
{
    public $cols = array(
        'id' => 'expand_log.vendor_id',
        'account_id' => 'expand_log.account_id',
        'admin_id' => 'expand_log.admin_id',
        'admin_name' => 'expand_log.admin_name',
        'create_time' => 'expand_log.create_time',
        'log_status' => 'expand_log.status',
        'email' => 'expand_log.email',
        'username' => 'account.username',
        'phone' => 'account.phone',
        'vendor_name' => 'vendor_info.vendor_name',
        'attr' => 'vendor_info.attr',
        'attr_index' => 'vendor_info.attr_index',
        'city' => 'vendor_info.city',
        'status' => 'vendor_expand.status',
        'msg_time' => 'vendor_expand.create_time',
        'update_time' => 'vendor_expand.update_time',
    );
    public $joins = array(
        'expand_log.account_id' => 'account.id',
        'account.id' => 'vendor_info.vendor_account_id',
        'vendor_info.id' => 'vendor_expand.vendor_id',
    );
}