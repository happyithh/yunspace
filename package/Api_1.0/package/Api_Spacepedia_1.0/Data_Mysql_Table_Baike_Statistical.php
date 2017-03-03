<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/10
 * Time: 14:57
 *
 * 与百科有关的文章 点赞量、浏览量、点赞+现场足迹量
 *
 */
class Data_Mysql_Table_Baike_Statistical extends Data_Mysql_Table
{
    public $cols=array(
        'space_id'=>'int',  // 百科ID
//        'space_name'=>'200',  // 百科名称
//        'data_time'=>'int',
        'click'=>'int',      //百科浏览量+相关文章浏览量
        'is_love'=>'int',    //百科我喜欢量
        'is_good'=>'int',   // 文章的点赞
        'is_go'=>'int',  //百科现场足迹量
        'comments'=>'int', //百科的评论数量
        'article_sum'=>'int', //百科文章总数
        'update_time'=>'int', //更新时间 （主要用于跟进百科文章数量）
    );
    public $index=array(
        'space_id'=>'u',
        'article_sum'=>'i',
        'is_love'=>'i',
        'click'=>'i',
        'is_go'=>'i',
        'comments'=>'i',
        'update_time'=>'i',
    );
    public $title =array(
        'space_id'=>'百科名称',
        'click'=>'浏览量',
        'is_good'=>'点赞量',
        'is_go'=>'现场足迹',
        'comments'=>'百科的评论数量',
        'article_sum'=>'百科文章总数',
        'update_time'=>'更新时间',

    );
}