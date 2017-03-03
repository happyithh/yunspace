<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/10/16
 * Time: 10:11
 * 场地百科子空间数据表
 */
class Data_Mysql_Table_Space_Assign extends Data_Mysql_Table
{
    public $cols = array(
        'space_pedia_id' => 'int',
        'space_item_id' => 'array',
        'phone' => '11',
        'create_time' => 'int',
        'pedia_assign_status' => 'int',    //1为百科ID和手机号绑定，2为百科ID没有和手机号绑定
    );
//    public $index = array(
//        'item_name,addr' => 'title',
//        'activity_type' => 'attr',
//        'tags' => 'attr',
//        'city' => 'i',
//        'phone' => 'i',
//        'min_price,max_price' => 'i',
//        'min_people,max_people' => 'i',
//        'status,expand_status' => 'i',
//    );
    public $title = array(
        'space_pedia_id' => '场地百科ID',
        'space_item_id' => '子空间ID',
        'phone' => '要授权的手机号',
        'create_time' => '创建时间',
    );

}