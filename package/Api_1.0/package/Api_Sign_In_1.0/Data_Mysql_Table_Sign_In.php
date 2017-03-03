<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/22
 * Time: 15:16
 * 内部管理人员签到表
 */
class Data_Mysql_Table_Sign_In extends Data_Mysql_Table{
    public $cols = array(
        'account_id'=>'int',
        'phone' => '15',
        'fullname'=>'50',
        'department'=>'50',
        'outside_time'=>'int',
        'back_time'=>'int',
        'address'=>'300',
        'latitude'=>'10',  // 纬度
        'longitude'=>'10',  // 经度
        'outside_reason'=>'1000',
        'reject_reason'=>'1000',
        'status'=>'int', // 0 待审核 1 已通过 -1 拒绝 2 已签到
        'check_time'=>'int', // 审核时间
        'admin_status'=>'int', // 确认签到状态  0待确认 1已确认
        'sign_time'=>'int', // 签到时间
        'create_time'=>'int',
    );
    public $index = array(
        'account_id'=>'i',
        'username'=>'i',
        'department'=>'i',
        'status'=>'i',
        'check_time'=>'i',
        'sign_time'=>'i',
        'create_time'=>'i',
    );
    public $title = array(
        'account_id'=>'用户ID',
        'department'=>'部门',
        'outside_time'=>'外出时间',
        'back_time'=>'返回时间',
        'address'=>'地址',
        'outside_reason'=>'外出理由',
        'reject_reason'=>'拒绝理由',
        'status'=>'状态',
        'check_time'=>'审核时间',
        'sign_time'=>'签到时间',
        'create_time'=>'创建时间',
    );
}