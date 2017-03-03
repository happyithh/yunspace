<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/6/18
 * Time: 15:39
 */
session_start();
Class Web_Ajax
{

    static function  handleComment()
    {
        if(empty($_SESSION['user'])) {
            Func_Output::json('error', '', '请登录后再评论~');
        }
        $request = Func_Input::filter(array(
            'from_id' => 'int',
            'from_type' => 'int',
            'user_id' => 'int',
            'parent_id' => 'int',
            'comment_cont' => 'string',
        ), '', 1);
        if (empty($request['comment_cont'])) {
            Func_Output::json('error', '', '请输入评论内容~');
        }
        if (strlen($request['comment_cont']) > 800) {
            Func_Output::json('error', '', '输入字符过长~');
        }
        $data = $request;
        $data['cont'] = $request['comment_cont'];
        $data['ip'] = Func_Input::ip();
        $row = Data_Mysql_Table_Comment::insert($data);
        if ($row > 0) {
            Func_Output::json('success', '', '评论成功！');
        }
        Func_Output::json('error', '', '评论失败,请稍后再试~');
    }


    static function  handleReply()
    {
        if(empty($_SESSION['user'])) {
            Func_Output::json('error', '', '请登录后再回复~');
        }
        $request = Func_Input::filter(array(
            'from_id' => 'int',
            'from_type' => 'int',
            'user_id' => 'int',
            'parent_id' => 'int',
            'comment_cont' => 'string',
        ), '', 1);
        if (empty($request['comment_cont'])) {
            Func_Output::json('error', '', '请输入回复内容~');
        }
        if (strlen($request['comment_cont']) > 800) {
            Func_Output::json('error', '', '输入字符过长~');
        }
        $data = $request;
        $data['cont'] = $request['comment_cont'];
        $data['ip'] = Func_Input::ip();
        $row = Data_Mysql_Table_Comment::insert($data);
        if ($row > 0) {
            Func_Output::json('success', '', '回复成功！');
        }
        Func_Output::json('error', '', '回复失败,请稍后再试~');
    }

    //点赞功能
    static function  handleDianzan()
    {
        if(empty($_SESSION['user'])) {
            Func_Output::json('error', '', '请登录后再操作~');
        }
        $request = Func_Input::filter(array(
            'id' => 'int',
        ), '', 1);

        //点赞成功则更新或插入一条数据
        $r = Data_Mysql_Table_Praise::select('*',array('username =?' => $_SESSION['user']['username'],'title_id =?' => $request['id']));
        if(empty($r[0])) {
            $rs = Data_Mysql_Table_Praise::insert(array('title_id' => $request['id'],'username' => $_SESSION['user']['username'],'praise' => 1));
        }else{
            $rs = Data_Mysql_Table_Praise::update(array('title_id' => $request['id'],'username' => $_SESSION['user']['username']),array('praise' => 1));
        }

//        $rs = Data_Mysql_Table_Praise::update(array('title_id' => $request['id'],'username' => $_SESSION['user']['username']),array('praise' => 1));
        //$rs = Data_Mysql_Table_Praise::insert(array('title_id' => $request['id'],'username' => $_SESSION['user']['username'],'praise' => 1));
        $rows = Data_Mysql_Table_Raiders_Info::query("UPDATE {table} set  counter_praise = counter_praise+1 WHERE id =?", array($request['id']), 1);
        if ($rows > 0 && $rs > 0) {
            Func_Output::json('success', '', '成功');

        }
    }

    //取消点赞
    static function  handleJianzan()
    {
        if(empty($_SESSION['user'])) {
            Func_Output::json('error', '', '请登录后再操作~');
        }
        $request = Func_Input::filter(array(
            'id' => 'int',
        ), '', 1);
        //取消点赞则将praise表字段改为0
        $rs = Data_Mysql_Table_Praise::query("UPDATE {table} set praise = 0 WHERE title_id =? AND username =?",array($request['id'],$_SESSION['user']['username']),1);
        $rows = Data_Mysql_Table_Raiders_Info::query("UPDATE {table} set  counter_praise = counter_praise-1 WHERE id =?", array($request['id']), 1);
        if ($rows > 0 && $rs > 0) {
            Func_Output::json('success', '', '成功');

        }
    }
}