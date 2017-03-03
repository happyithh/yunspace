<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/7
 * Time: 19:23
 */
class Data_Mysql_Table_Winchance_Company extends Data_Mysql_Table {
    public $cols = array(
        'company'=>'300',
        'note'=>'1000',
        'status'=>'int',  // 0 正常 -1 删除
        'create_time'=>'int',
        'update_time'=>'int',
    );
    public $index = array(
        'company'=>'title',

    );
}