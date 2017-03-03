<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Account_Identity_Personal_Info extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => '50',
        'fullname' => '50',
//        'phone' => '15',
        'hold_identity_card_img' => '300',
        'id_card_number' => '18',
        'create_time'=>'10', //添加时间
        'pass_time'=>'10',  //通过时间
        'update_time'=>'10',  //更新时间
        'refuse_reason'=>'150',
        'status' => 'tinyint',   //等待审核 0  审核通过 1 审核未通过 -1
    );
    public $index = array(
        'account_id' => 'u',                                                    //p:主键, u:唯一索引, i:索引
//        'phone' => 'i',
        'id_card_number' => 'i',
    );
    public $title = array(
        "" => "个人认证信息",                                                     //空键,表名
        'fullname' => '姓名',
//        'phone' => '手机',
    );

}