<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/10/30
 * Time: 11:45
 * 微信端年会投票列表
 */

//class OA_Weixin_Year_Vote
//{
//    static function handle()
//    {
//        $action = empty($_REQUEST['action']) ? 'vote_list' : $_REQUEST['action'];
//        if($action == 'vote_list') {
//            self::handleVoteList();
//        }
//    }
//
//
//    static function handleVoteList()
//    {
//        $conditions = array();
//        if (!empty($_REQUEST['search'])) {
//            $search = Func_Input::filter(array(
//                'year_id' => 'int',
//                'phone' => 'string',
//                'end_time' => 'string',
//                'start_time' => 'string',
//                'nickname' => 'string',
//            ), $_REQUEST['search']);
//            if (!empty($search['year_id'])) {
//                $conditions['year_id'] = $search['year_id'];
//            }
//            if (!empty($search['phone'])) {
//                $conditions['{prefix}account.phone'] = $search['phone'];
//            }
//            if (!empty($search['nickname'])) {
//                $conditions['{prefix}account.phone'] = $search['phone'];
//            }
//            if (!empty($search['start_time']) && !empty($search['end_time'])) {
//                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
//                    Func_Header::back('请正确选择时间范围！！');
//                } else {
//                    $conditions['{table}.vote_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
//                }
//            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
//                $conditions['{table}.vote_time > ?'] = strtotime($search['start_time']);
//            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
//                $conditions['{table}.vote_time < ?'] = strtotime($search['end_time']);
//            }
//        }
//
////        Data_Mysql_Table_YearMeeting_Vote::debug(1);
//        $order = 'ORDER BY vote_time DESC';
//        $rs = Data_Mysql_Table_YearMeeting_Vote::page(0,10,'{table}.id,{table}.year_id,{table}.openid,{table}.vote_time,{prefix}account.username,{prefix}account.phone,{prefix}account_wechat.user_info',$conditions,$order,'{table} LEFT JOIN {prefix}account_wechat ON {table}.openid={prefix}account_wechat.openid LEFT JOIN {prefix}account ON {prefix}account.id={prefix}account_wechat.account_id');
////        q($rs);
//        foreach($rs['rows'] as $k=>$v) {
//            $rs['rows'][$k]['user_info'] = json_decode($v['user_info'],1);
//        }
//        Tpl_Smarty::assign('_data',$rs);
//        Tpl_Smarty::display('OA_Static', 'year_vote_list/year_vote_list.tpl');
//
//    }
//}

class OA_Weixin_Year_Vote
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'vote_list' : $_REQUEST['action'];
        if($action == 'vote_list') {
            self::handleVoteList();
        }
    }


    static function handleVoteList()
    {
        $conditions = array();
        $conditions[] =1;
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'year_id' => 'int',
                'phone' => 'string',
                'end_time' => 'string',
                'start_time' => 'string',
                'nickname' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['year_id'])) {
                $conditions['year_id'] = $search['year_id'];
            }
            if (!empty($search['phone'])) {
                $conditions['phone'] = $search['phone'];
            }
            if (!empty($search['nickname'])) {
                $conditions['fullname'] = $search['nickname'];
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['vote_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['vote_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['vote_time < ?'] = strtotime($search['end_time']);
            }
        }
//        q($conditions);

//        $conditions = array();
//        Data_Mysql_Table_YearMeeting_Vote::debug(1);
//        Data_Mysql_Table_Account::rebuildIndex();
        $order = 'ORDER BY vote_time DESC';
        $rs = @Data_Mysql_View_YearMeeting_Vote::page(0,10,'id,year_id,openid,vote_time,username,phone,user_info',$conditions,$order);
//        q($rs);
//        q($rs['rows'][4]);
        foreach($rs['rows'] as $k=>$v) {
            $rs['rows'][$k]->user_info = json_decode($v->user_info,1);
        }
//        q($rs['rows'][4]);
//        q($arr);
//        q($rs['rows'][1]);
//        foreach($arr as $k=>$v) {
//            $arr[$k] = json_decode($v,1);
//        }
//        q($rs['rows']);
        Tpl_Smarty::assign('_data',$rs);
        Tpl_Smarty::display('OA_Static', 'year_vote_list/year_vote_list.tpl');

    }
}