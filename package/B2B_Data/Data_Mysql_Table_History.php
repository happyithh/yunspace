<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_History extends Data_Mysql_Table
{
    public $cols = array(
        'object_id' => 'int',//百科id
        'admin_id' => 'int', //提交人
        'user_id' => 'int',  //用户
        'phone' => 'phone',  //提交人手机号
        'operate_type' => 'tinyint',
        'data_backup' => 'array',//百科数据
        'create_time' => 'int',//
        'auditor' => '200',  //审核人
        'Audit_time' => 'int',  //审核时间
        'status' => 'int',   //0待审核   1审核通过 2审核拒绝   3取消
        'refuse_reason' => '300',  //拒绝理由
    );
    public $index = array();
    public $title = array(
        '' => '数据修改记录',
        'object_id' => '对象ID',
        'admin_id' => '管理员ID',
        'user_id' => '用户ID',
        'operate_type' => '操作类型',
        'create_time' => '添加时间',
    );
    public $titleHidden = array( //    list / form / both
        'data_backup' => 'both',
    );
    public $filter = array();
    public static $status = array(
        -1=> '已删除',
        0 => '审核中',
        1 => '审核通过',
        2 => '审核拒绝',
        3 => '取消',
    );

}