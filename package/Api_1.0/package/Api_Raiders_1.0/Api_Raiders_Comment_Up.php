<?php
/**
 * Created by PhpStorm.
 * User: Yangchenglin
 * Date: 2015/7/3
 * Time: 17:00
 */
class Api_Raiders_Comment_Up extends Api
{
    static function handle($args='')
    {
        if(Api_Session::user_info()){
            $result = self::handleCommentUp($args);
        }else{
            $result = array(
                'status' => 0,
                'msg' => "请登录后再操作~",
                "data" => ''
            );
        }
        return $result;
    }

    static function handleCommentUp($data)
    {
//        if (empty($_SESSION['user'])) {
//            $result = array(
//                'status' => 0,
//                'msg' => "请登录后再操作~",
//                "data" => ''
//            );
//            return $result;
//        }
        $request = Func_Input::filter(array(
            'id' => 'int',
        ), $data);

        //评论点赞成功则插入数据库comment表
        $rs = Data_Mysql_Table_Comment_Praise::insert(array('comment_id' => $request['id'],'user_id' => $_SESSION['user']['id'],'praise' => 1));
        $rows = Data_Mysql_Table_Comment::query("UPDATE {table} set  count_praise = count_praise+1 WHERE id =?", array($request['id']), 1);

        if ($rows > 0 && $rs > 0) {
            $result = array(
                'status' => 1,
                'msg' => "成功",
                "data" => ''
            );
        } else {
            $result = array(
                'status' => 0,
                'msg' => "失败",
                "data" => ''
            );
        }
        return $result;
    }
}