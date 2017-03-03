<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/15
 * Time: 17:57
 * 评论列表页面
 *
 */


class Api_Comments_GetCommentsList extends Api
{
    static function handle($args)
    {
        /**
         * $args['id'] => 百科ID
         *
         */
        return self::commentsList($args);
    }

    static function commentsList($args)
    {
        @session_start();
//        $conditions['{prefix}spacepedia.space_name = ?'] = urldecode($args[0]);
        $conditions['{table}.space_id = ?'] = $args['id'];
        $conditions['{table}.comments_id = ?'] = 0;
        if(!empty($_SESSION['user']['id'])){
            $conditions[] = '({table}.status !=0 OR {table}.account_id='.$_SESSION['user']['id'].')';
        }elseif(!empty($_SESSION['wechat_id'])){
            $conditions[] = '({table}.status !=0 OR {table}.wechat_id='.$_SESSION['wechat_id'].')';
        }else{
            $conditions['{table}.status !=?'] = 0;
        }
        $data = Data_Mysql_Table_Comments::page(0,10,'{table}.*,{prefix}account_wechat.user_info', $conditions, 'ORDER BY create_time DESC', '{table} LEFT JOIN {prefix}account_wechat ON {table}.wechat_id = {prefix}account_wechat.id');
            // 首次获取列表数据
            foreach ($data['rows'] as $k => $v) {
                $data['rows'][$k]['user_info'] = json_decode($v['user_info'], 1);
//                $data['rows'][$k]['user_info']['nickname']=empty($data['rows'][$k]['user_info']['nickname'])?$v['fullname']:$data['rows'][$k]['user_info']['nickname'];
                $data['rows'][$k]['user_info']['headimgurl']=empty($data['rows'][$k]['user_info']['headimgurl'])?'':$data['rows'][$k]['user_info']['headimgurl'];
                $data['rows'][$k]['id']=Func_NumEncode::e($v['id']);
            }
            return $data['rows'];
        }
}