<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-9-11
 * Time: 下午1:44
 * 激活表视图
 */
class  Data_Mysql_View_Vendor_Expand extends Data_Mysql_View
{
    public $cols = array(
        'id' => 'vendor_expand.vendor_id',
        'username' => 'vendor_expand.username',
        'phone' => 'vendor_expand.phone',
        'email' => 'vendor_expand.email',
        'status' => 'vendor_expand.status',
        'create_time' => 'vendor_expand.create_time',
        'update_time' => 'vendor_expand.update_time',
        'vendor_name' => 'vendor_info.vendor_name',
        'attr' => 'vendor_info.attr',
        'attr_index' => 'vendor_info.attr_index',
        'city' => 'vendor_info.city',
        'admin_id' => 'expand_log.admin_id',
    );

    public $joins = array(
        'vendor_expand.vendor_id' => 'vendor_info.id',
        'vendor_info.id' => 'expand_log.vendor_id'
    );
}