<?php
/**
 * Created by PhpStorm.
 * User: Yangchenglin
 * Date: 2015/7/3
 * Time: 11:26
 */
class Api_Raiders_Praise_Down extends Api
{
    static function handle($args='')
    {
        if(Api_Session::user_info()){
            $result = self::handlePraiseDown($args);
        }else{
            $result = array(
                'status' => 0,
                'msg' => "请登录后再操作~",
                "data" => ''
            );
        }
        return $result;
    }

    //取消赞
    static function  handlePraiseDown($data)
    {
//        if(empty($_SESSION['user'])) {
//            $result = array(
//                'status' => 0,
//                'msg' => "请登录后再操作~",
//                "data" => ''
//            );
//            return $result;
//        }
        $request = Func_Input::filter(array(
            'id' => 'int',
        ),$data);
        //取消点赞则将praise表字段改为0
        $rs = Data_Mysql_Table_Praise::query("UPDATE {table} set praise = 0 WHERE title_id =? AND user_id =?",array($request['id'],$_SESSION['user']['id']),1);
        $rows = Data_Mysql_Table_Raiders_Info::query("UPDATE {table} set  counter_praise = counter_praise-1 WHERE id =?", array($request['id']), 1);
        if ($rows > 0 && $rs > 0) {
            $result = array(
                'status' => 1,
                'msg' => "成功",
                "data" => ''
            );
        }else{
            $result = array(
                'status' => 0,
                'msg' => "失败",
                "data" => ''
            );
        }
        return $result;
    }
}