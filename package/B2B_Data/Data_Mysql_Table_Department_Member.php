<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/27
 * Time: 11:18
 */
class Data_Mysql_Table_Department_Member extends Data_Mysql_Table
{
    public $cols = array(
        'department_name' => '20',
        'city' => '20',
        'admin_id' => 'int',
        'team_name'=>'20',
        'level' => 'int',  //1 主管 0普通
        'position' => '50',  //职位
        'quota_now' => 'int',
        'data' => 'array',
        'quota_today' => 'int', //今日配额
        'reset_time' => 'int',
    );
    public $index = array(
        'department_name,admin_id' => 'u',
        'team_name' => 'i',
        'position' => 'i',
        'department_name' => 'i',
        'city' => 'i',
    );
    public $title = array(
        'admin_id' => '用户ID',
        'team_name' => '组名',
        'department_name' => '部门名称',
        'position' => '职位',
        'quota_now' => '当前配额',
        'indicator_data' => '指标数据',
        'quota_today' => '今日配额', //今日配额
        'reset_time' => '重置时间'
    );

    static  $department_name=array(
        '产品部','技术部','拓展部','市场部','销售部','运营部','人事部','测试部','总部'
    );

}