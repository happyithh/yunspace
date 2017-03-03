<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/10/16
 * Time: 10:11
 * 场地出租数据表
 */
class Data_Mysql_Table_New_Space extends Data_Mysql_Table
{
    public $cols = array(
        'space_name' => '200',
        'category_id' => 'int',
        'city' => '200',
        'addr' => '200',
        'status' => 'tinyint',
        'refuse_reason' => '200',
        'create_time' => 'int',
        'card' =>'array',
        'contacts' =>'200',
        'phone' =>'11',
        'email' =>'100',
        'area'=>'200',
        'account_id'=>'int',


    );
    public $index = array(
        'id' => 'u',
        'space_name' => 'title',
        'attr' => 'attr',
        'status' => 'i',
    );
    public $title = array(
        'space_name' => '场地出租名称',
        'category_id' => '分类',
        'city' => '城市',
        'addr' => '地址',
        'attr' => '属性信息',
        'status' => '状态',//-1 删除     0审核中   1审核通过  2 审核拒绝
        'refuse_reason' => '拒绝原因',
        'create_time' => '创建时间',
        'card' =>'名片/营业执照',
        'contacts' =>'联系人',
        'phone' =>'联系电话',
        'email' =>'邮箱',
        'area'=>'区域',
        'account_id'=>'账号id',
    );

}