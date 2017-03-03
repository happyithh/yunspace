<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/10/27
 * Time: 16:49
 */

class Api_Yearmeeting_Vote extends Api
{
    static function handle($args='')
    {
        if(!empty($_SESSION['user']['[id'])) {
            $result = self::handleVote($args);
        } else {
            return $result = array(
                'status' => 0,
                'msg' => "请授权登录后再投票~",
                "data" => ''
            );
        }
        return $result;
    }

    //Data_Mysql_Table_YearMeeting_Vote(年会投票关系表)
    //id  user_id   year_id   vote   vote_time
    static function handleVote($data)
    {
        $request = Func_Input::filter(array(
            'year_id' => 'int',
        ), $data);

        $rs_vote = Data_Mysql_Table_YearMeeting_Vote::select('*',array('year_id'=>$request['year_id'],'user_id'=>$_SESSION['user']['id'],'openid'=>$_SESSION['user']['openid']));
        if(!empty($rs_vote[0])) {
            return $result = array(
                'status' => 0,
                'msg' => "您已经投过票啦，请继续关注后续中奖情况~",
                "data" => ''
            );
        } elseif (empty($rs_vote[0])) {
            //评论点赞成功则插入表
            $rs = Data_Mysql_Table_YearMeeting_Vote::insert(array('yearmeeting_id' => $request['id'], 'user_id' => $_SESSION['user']['id'], 'vote_time' =>time(),'openid'=>$_SESSION['user']['openid'],'vote' => 1));
            if ($rs[0] > 0) {
                return $result = array(
                    'status' => 1,
                    'msg' => "投票成功",
                    "data" => ''
                );
            } else {
                return $result = array(
                    'status' => 0,
                    'msg' => "投票失败",
                    "data" => ''
                );
            }
        }
    }

}