<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/11/10
 * Time: 9:50
 */
class  Data_Mysql_View_YearMeeting_Vote extends Data_Mysql_View
{
    public $cols = array(
        'id' => 'yearmeeting_vote.id',
        'year_id' => 'yearmeeting_vote.year_id',
        'openid' => 'yearmeeting_vote.openid',
        'vote_time' => 'yearmeeting_vote.vote_time',
        'user_info' => 'account_wechat.user_info',
        'username' => 'account.username',
        'phone' => 'account.phone',
        'fullname' => 'account.fullname'
    );

    public $joins = array(
        'account.id'=>'account_wechat.account_id',
        'account_wechat.openid' => 'yearmeeting_vote.openid',
    );
}