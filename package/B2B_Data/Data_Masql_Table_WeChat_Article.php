<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/4
 * Time: 11:39
 * 抓取 搜狗微信文章
 */
class Data_Masql_Table_WeChat_Article extends Data_Mysql_Table{
    public $cols = array(
        'title'=>'200',
        'digest'=>'html',
        'author'=>'100',
        'img'=>'300',
        'article_time'=>'50',
        'article_url'=>'2000',
        'create_time'=>'int',
        'status'=>'int',  // 待处理 0 ; 建议采用 1 ; 已采用 2 ; 隐藏 -1
        'is_good'=>'int',  // 点赞量
        'is_bad'=>'int',    // 被踩量
        'update_time'=>'int',
        'administrator'=>'200', // 操作者
    );
    public $index = array(
        'title'=>'u',
        'digest'=>'i',
        'title,author'=>'title',
        'create_time'=>'i',
        'article_time'=>'i',
        'status'=>'i',
        'is_good'=>'i',
        'is_bad'=>'i',
        'update_time'=>'i'
    );
    public $title = array(
        'title'=>'文章标题',
        'digest'=>'摘要',
        'author'=>'文章作者',
        'atricle_time'=>'文章发布时间',
        'img'=>'文章图片',
        'article_url'=>'文章链接',
        'create_time'=>'创建时间',
        'status'=>'文章状态'
    );
}