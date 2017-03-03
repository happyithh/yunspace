<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/9/7
 * Time: 9:59
 *
 */
class  Data_Mysql_View_Product_Search extends Data_Mysql_View
{
    public $cols = array(
        'id' => 'product_search.id',
        'price' => 'product_search.price',
        'category_id' => 'product_search.category_id',
        'product_name' => 'product_search.product_name',
        'order_people_number' => 'product_search.order_people_number',
        'attr_index' => 'product_search.attr_index',
        'vendor_id' => 'product_search.vendor_id',
        'status' => 'product_search.status',
        'price' => 'product_search.price',
        'expand_status' => 'vendor_expand.status',
        'phone' => 'vendor_expand.phone',
        'account_id' => 'vendor_expand.account_id',
    );

    public $joins = array(
        'product_search.vendor_id' => 'vendor_expand.vendor_id'
    );
}