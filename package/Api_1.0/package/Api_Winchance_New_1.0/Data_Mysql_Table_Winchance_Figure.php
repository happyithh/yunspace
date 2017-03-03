<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/7
 * Time: 20:10
 * 人物形象
 */
class Data_Mysql_Table_Winchance_Figure extends Data_Mysql_Table{
    public $cols = array(
        'name'=>'300',
        'company'=>'300',
        'note'=>'1000',
        'status'=>'int',  // 0 正常，-1 删除
        'create_time'=>'int',
        'update_time'=>'int',
    );
    public $index = array(
        'name,company'=>'title',
    );
}