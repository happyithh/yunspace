<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/4/17
 * 产品备注表
 */

class Data_Mysql_Table_Product_Remark extends Data_Mysql_Table
{
    public $cols = array(
        'product_id' => 'int',
        'cooperate_price' => 'int',
        'charges_proportion' => 'int',
        'charges_rules' => 'text',
        'admin_score' => 'int',
        'admin_demo' => 'text',
        'admin_id' => 'int',
        'admin_name' => '50',
    );
    public $index = array(
        'product_id' => 'i',

    );
    public $title = array(
        "" => "产品备注信息",                                                     //空键,表名
        'product_id' => '产品ID',
        'cooperate_price' => '合作底价',
        'charges_proportion' => '佣金比例',
        'charges_rules' => '佣金规则',
        'admin_score' => '内部评分',
        'admin_demo' => '内部备注',
        'admin_id' => '备注人ID',
        'admin_name'=>'备注人'
    );

}