<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/11/24
 * Time: 14:01
 * 部门管理
 */
class Data_Mysql_Table_Department extends Data_Mysql_Table
{
    public $cols = array(
        'department_name' => '20',
        'create_time' => 'int',
        'update_time' => 'int',
    );
    public $index = array(
        'department_name' => 'u',
    );
    public $title = array(
        'department_name' => '部门名称',
        'create_time' => '创建时间',
        'update_time' => '修改时间',
    );
    /*
     *部门名称初始化
     */
    static function initDepartmentName(){
        $data=Data_Mysql_Table_Department_Member::select("department_name",'','GROUP BY department_name',99999);
        if(!empty($data)){
            foreach($data as $k=>$v){
                $name_data['department_name']=$v['department_name'];
                Data_Mysql_Table_Department::insert($name_data);
            }
        }
    }

    /*
     *获取所有部门名称
     */
    static function getAllDepartmentName(){
        $name_arr=array();
        $data=Data_Mysql_Table_Department::select("*",'','',100);
        if(!empty($data)){
            foreach($data as $k=>$v){
                $name_arr[]=$v['department_name'];
            }
            return $name_arr;
        }
        return $name_arr;
    }
}