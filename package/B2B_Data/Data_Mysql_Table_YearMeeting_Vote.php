<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/10/8
 * Time: 16:36
 */
Class  Data_Mysql_Table_YearMeeting_Vote extends Data_Mysql_Table
{
    public $cols = array(
        'user_id' => 'int',                 //用户标识
        'openid' => '200',                 //微信openid
        'year_id' => 'int',                 //年会主题id或标识
        'vote' => 'int',                    //投票数
        'vote_time' => 'int'                //投票时间
    );

    public $index = array(
        'openid' => 'u',
        'vote_time'=>'i',
        'year_id'=>'i'
    );

}