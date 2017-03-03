<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/14
 * Time: 18:09
 * 微信文章详情页面
 */
class Data_Mysql_Table_WeChat_Article_info extends Data_Mysql_Table {
    public $cols =array(
        'wechat_article_id'=>'int',
        'content'=>'html',
        'create_time'=>'int',
        'status'=>'int',
        'is_good'=>'int'
    );
    public $index = array(
        'wechat_article_id'=>'u',
        'create_time'=>'int',
        'status'=>'int',
        'is_good'=>'int'
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
