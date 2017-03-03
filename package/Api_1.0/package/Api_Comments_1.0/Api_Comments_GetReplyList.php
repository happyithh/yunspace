<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/15
 * Time: 20:11
 *
 * 回复评论列表
 */
class Api_Comments_GetReplyList extends Api
{
    static function GetCommentInfo($args)
    {
//        Q($args,Func_NumEncode::d($args['id']));
        $conditions['t1.id=?'] = Func_NumEncode::d($args['id']);
        $data = Data_Mysql_Table_Comments::select('t1.*,t2.user_info', $conditions, '', 1, '{table} as t1 LEFT JOIN {prefix}account_wechat as t2 ON t1.wechat_id = t2.id');
        if (!empty($data[0])) {
            $data[0]['user_info'] = json_decode($data[0]['user_info'],1);
            $resNew = array();
            $resNew['info'] = $data[0];
            $resNew['replyList'] = self::GetCommentList($data[0]['id']);
            return $resNew;
        }
    }

    static function GetCommentList($args)
    {
        @session_start();
        $conditions['t1.comments_id = ?'] =$args;
        if(!empty($_SESSION['user']['id'])){
            $conditions[] = '(t1.status !=0 OR t1.account_id='.$_SESSION['user']['id'].')';
        }elseif(!empty($_SESSION['wechat_id'])){
            $conditions[] = '(t1.status !=0 OR t1.wechat_id='.$_SESSION['wechat_id'].')';
        }else{
            $conditions['t1.status !=?'] = 0;
        }
//        Data_Mysql_Table_Comments::debug(1);
        $data = Data_Mysql_Table_Comments::select('t1.*,t2.user_info', $conditions, 'ORDER BY t1.create_time DESC', 99, '{table} as t1 LEFT JOIN {prefix}account_wechat as t2 ON t1.wechat_id = t2.id');
        if(!empty($data)){
           foreach($data as $k=>$v){
               $data[$k]['user_info']=json_decode($v['user_info'],1);
           }
        }
        return $data;
    }
}