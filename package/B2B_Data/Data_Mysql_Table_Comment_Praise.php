<?php
/**
 * Created by PhpStorm.
 * User: Yangchenglin
 * Date: 2015/7/6
 * Time: 13:20
 */
class Data_Mysql_Table_Comment_Praise extends Data_Mysql_Table
{
    public $cols = array(
        'user_id' => 'int',      //用户名id
        'comment_id' => 'int',    //评论id
        'praise' => 'int',       //点赞数
    );
}