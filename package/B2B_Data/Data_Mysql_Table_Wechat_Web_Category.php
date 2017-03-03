<?php
/**
 * Created by PhpStorm.
 * User: sdd
 * Date: 2016/8/26
 * Time: 11:37
 */
Class  Data_Mysql_Table_Wechat_Web_Category extends Data_Mysql_Table {

    public $cols = array(
        'category' => 'string',                       //分类名称
        'big_picture' => 'string',             //类别图片
        'status' => 'int',               //0下线   1上线
        'is_show' => 'int',               //0不在首页显示   1在列表显示
        'create_time' => 'int',          //创建时间
        'update_time' => 'int',          //更新时间
    );

    public $index = array(
        'category'=>'i',
    );

    //状态
    public static $status = array(
        1 => '上线',
        0 => '下线',
    );

}