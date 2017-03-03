<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/20
 * Time: 20:25
 */
class Data_Mysql_View_Item_Search extends  Data_Mysql_View{

    public $cols = array(
        'id' => 'demand_match_space_archives.id',
        'item_id' => 'demand_match_space_archives.item_id',
        'price_up' => 'demand_match_space_archives.price_up',
        'price_down' => 'demand_match_space_archives.price_down',
        'people_up' => 'demand_match_space_archives.people_up',
        'people_down' => 'demand_match_space_archives.people_down',
        'city' => 'demand_match_space_archives.city',
        'item_name' => 'space_item.item_name',
        'grade' => 'demand_match_space_archives.grade',
        'response_sum' => 'demand_match_space_archives.response_sum',
        'tags' => 'demand_match_space_archives.tags',
        'notice_last_time' => 'demand_match_space_archives.notice_last_time',
        'expand_status' => 'space_item.expand_status',
        'status' => 'space_item.status',
        'activity_type' => 'space_item.activity_type',
        'contacts' => 'space_item.contacts',
        'phone' => 'space_item.phone',
        'space_name'=>'spacepedia.space_name',
        'attr'=>'spacepedia.attr',
        'size'=> 'space_item.size',
        'product_id'=> 'space_item.product_id',
        'category_id'=> 'spacepedia.category_id',
    );

    public $joins = array(
        'demand_match_space_archives.item_id' => 'space_item.id',
        'space_item.space_id' => 'spacepedia.id'
    );
}