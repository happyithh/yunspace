<?php
/**
 * Created by PhpStorm.
 * User: sdd
 * Date: 2016/8/26
 * Time: 11:37
 */
Class  Data_Mysql_Table_Wechat_Web_Article extends Data_Mysql_Table {

    public $cols = array(
        'category_id' => 'int',         //分类id
        'title' => '200',               //题目
        'image' => 'string',            //图片
        'introduction' => 'string',     //简介
        'is_lnk' => 'int',              //判断是否有链接
        'link' => 'string',             //链接
        'content' => 'html',
        'status' => 'int',              //0下线   1上线
        'create_time' => 'int',         //创建时间
        'update_time' => 'int',         //更新时间
        'is_recommend' => 'int',        //是否推荐
    );

    public $index = array(
        'title' => 'title',
    );

    //状态
    public static $status = array(
        1 => '上线',
        0 => '下线',
    );

    //链接
    public static $is_lnk = array(
        1 => '有',
        -1 => '没有',
    );

    //推荐
    public static $is_recommend = array(
        1 => '推荐',
        -1 => '不推荐',
    );

}