<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/15
 * Time: 9:59
 */
class Data_Mysql_Table_Comments extends Data_Mysql_Table{
    public $cols = array(
        'space_id'=>'int',              // 百科ID
        'article_id'=>'int',            // 文章ID
        'account_id'=>'int',            // 账户ID
        'wechat_id'=>'int',            // 微信ID
        'phone'=>'string',                 // 评论者手机号
        'content'=>'text',              // 评论内容
//        'parent_id'=>'int',
        'comments_id'=>'int',           // 父级ID
        'ip'=>'100',                    // 评论者IP
//        'reject'=>'1000',               // 拒绝理由  （后期可能使用）
        'is_good'=>'int',               // 点赞数量
        'count_reply'=>'int',           // 回复数量
//        'is_love'=>'int',               // 是否喜欢     1为我喜欢
//        'is_go'=>'int',               // 是否去现场     1为去现场
        'create_time'=>'int',
        'status'=>'int'      // 待审核  0  ;  已通过  1 ; 拒绝 -1
    );
    public $index=array(
        'space_id'=>'i',
        'account_id'=>'i',
        'ip'=>'i',
        'comments_id'=>"i"
    );
    public $title=array(
        'space_id'=>'百科ID',
        'article_id'=>'文章ID',
        'account_id'=>'账户ID',
        'content'=>'评论内容',
        'comments_id'=>'父级ID',
//        'is_love'=>'点赞'
    );
}