<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Account_Identity_Company_Info extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => '50',  //要换成 account_id 帐户id
        'fullname' => '50',  //法定代表人姓名
//        'phone' => '15',    //法定代表人手机号
        'id_card_number' => '18',//法定代表人身份证
        'company_name'=>'150',//企业名称
        'company_license_number'=>'string',//营业执照注册号
        'organization_code'=>'string',//组织机构代码
        'business_licence_img'=>'string',   //营业执照副本
        'organization_code_img'=>'string', //组织机构代码证
        'tax_registration_img'=>'string',  //税务登记证
        'create_time'=>'int', //添加时间
        'pass_time'=>'int',  //通过时间
        'update_time'=>'int',  //更新时间
        'refuse_reason'=>'150',
        'status' => 'tinyint',   //等待审核 0  审核通过 1 审核未通过 -1
    );
    public $index = array(
        'account_id,company_license_number' => 'u',                                                    //p:主键, u:唯一索引, i:索引
//        'phone' => 'i',
        'id_card_number' => 'i',
    );
    public $title = array(
        "" => "企业认证信息",                                                     //空键,表名
        'fullname' => '姓名',
//        'phone' => '手机',
    );

}