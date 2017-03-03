<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/28
 * Time: 10:26
 * 跟进 抓取微信文章的详情
 *
 */
class Data_Mysql_Table_Wechat_Article_Log extends Data_Mysql_Table{
    public $cols = array(
        'title'=>'200',
        'html_size'=>'int',
        'article_sum'=>'int',
        'search_type'=>'20',  // 区分 文章来源 关键词/公众号 抓取
        'insert_sum'=>'int',  // 写入数量
        'create_time'=>'int',
        'update_time'=>'int',
    );
    public $index = array(
        'title'=>'u',
        'html_length'=>'i',
        'article_sum'=>'i',
        'search_type'=>'i',
        'insert_sum'=>'i',
        'create_time'=>'i',
        'update_time'=>'i',
    );
    public $title = array(
        'title'=>'搜索标题',
        'html_length'=>'网页大小',
        'article_sum'=>'抓取到的文章总数',
        'search_type'=>'文章来源',
        'insert_sum'=>'实际写入数量',
        'create_time'=>'创建时间',
        'update_time'=>'更新时间',
    );
}