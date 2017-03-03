<?php
/**
 * Created by PhpStorm.
 * User: Yangchenglin
 * Date: 2015/7/3
 * Time: 11:25
 */
class Api_Raiders_Comment extends Api
{
    static function handle($args='')
    {
        if(Api_Session::user_info()){
            $result = self::handleComment($args);
        }else{
            $result = array(
                'status' => 0,
                'msg' => "请登录后再评论~",
                "data" => ''
            );
        }
        return $result;
    }

    //进行评论
    static function  handleComment($data)
    {
        $request = Func_Input::filter(array(
            'from_id' => 'int',
            'from_type' => 'int',
            'user_id' => 'int',
            'parent_id' => 'int',
            'comment_cont' => 'string',
        ),$data);
        if (empty($request['comment_cont'])) {
            $result = array(
                'status' => 0,
                'msg' => "请输入评论内容~",
                "data" => ''
            );
            return $result;
        }
        if (strlen($request['comment_cont']) > 800) {
            $result = array(
                'status' => 0,
                'msg' => "输入字符过长~",
                "data" => ''
            );
            return $result;
        }
        $data = $request;
        $data['cont'] = $request['comment_cont'];
        $data['ip'] = Func_Input::ip();
        $row = Data_Mysql_Table_Comment::insert($data);
        if ($row[0] > 0) {
            $results = array(
                'fullname'=>$_SESSION['user']['fullname'],
                'comment_time'=>date('y-m-d h:i:s',time()),
                'id'=>$row[0],
                'user_id'=>$_SESSION['user']['id'],
                'from_id'=>$request['from_id'],
                );
            $result = self::request('success',$results,'评论成功');
        }else{
            $result = self::request('error','','评论失败,请稍后再试~');
        }
        return $result;
    }
}