<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Event_Case extends Data_Mysql_Table
{
    public $cols = array(
        'event_id' => 'int',
        'product_id' => 'int',
        'product_set_id' => 'int',              //套餐id
        'vendor_id' => 'int',
        'case_name' => '200',
        'des' => '500',
        'status'=>'tinyint', //0下线，1上线，2待审核，3审核未通过
        'media'=>'array',
    );
    public $index = array(
        'event_id' => 'i',
        'product_id' => 'i',
        'product_set_id' => 'i',
        'vendor_id' => 'i',
        'case_name' => 'title',
        'status'=>'i',
    );
    public $title = array(
        "" => "案例信息",                                                     //空键,表名
        'event_id' => '活动ID',
        'product_id' => '产品ID',
        'vendor_id' => '供应商ID',
        'case_name' => '案例名称',
    );
    public $titleHidden = array( //    list / form / both
        'event_id' => 'list',
        'product_id' => 'list',
        'vendor_id' => 'list',
    );

    static function updateId()
    {
        $sql1 = "update {prefix}event_case c left join {prefix}product_info p on c.product_name=p.product_name
        set c.product_id=p.id WHERE p.id >0";
        self::query($sql1, null, 1);
        $sql2 = "update {prefix}event_case c left join {prefix}product_info p on c.product_name=p.product_name
        set c.vendor_id=p.vendor_id WHERE p.id >0";
        self::query($sql2, null, 1);
        $sql3 = "update {prefix}event_case c left join {prefix}vendor_info p on c.vendor_name=p.vendor_name
        set c.vendor_id=p.id WHERE p.id >0 AND c.product_id=0";
        self::query($sql3, null, 1);
        return true;
        die();
    }


}