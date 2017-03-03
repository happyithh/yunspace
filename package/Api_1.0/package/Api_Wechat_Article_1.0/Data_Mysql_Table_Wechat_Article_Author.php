<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/20
 * Time: 15:37
 *
 * 跟踪微信公众号被采用、点赞、踩、隐藏等数量
 */
class Data_Mysql_Table_Wechat_Article_Author extends Data_Mysql_Table{
    public $cols = array(
        'author'=>'20',
        'bad_sum'=>'int',
        'user_sum'=>'int',
        'click_sum'=>'int',
        'suggest_sum'=>'int',
        'hide_sum'=>'int',
        'create_time'=>'int',
        'status'=>'int',
        'collect_status'=>'int',   // 0 未操作  1 采集  2 停止采集
        'update_time'=>'int',
        'url'=>'2000'
    );
    public $index = array(
        'author'=>'u',
        'bad_sum'=>'i',
        'user_sum'=>'i',
        'suggest_sum'=>'i',
        'click_sum'=>'i',
        'hide_sum'=>'i',
        'create_time'=>'i',
        'status'=>'i',
        'collect_status'=>'i',
        'update_time'=>'i',
        'url'=>'i'
    );
    public $title = array(
        'author'=>'作者名称',
        'bad_sum'=>'被踩数量',
        'user_sum'=>'采用数量',
        'click_sum'=>'采用数量',
        'suggest_sum'=>'建议使用数量',
        'hide_sum'=>'被隐藏数量',
        'create_time'=>'创建时间',
        'status'=>'状态',
        'collect_status'=>'采集状态',
        'update_time'=>'更新时间',
        'url'=>'公众号url'
    );
}