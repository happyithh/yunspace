<?php
/**
 * Created by PhpStorm.
 * User: Yangchenglin
 * Date: 2015/7/3
 * Time: 11:26
 */
@session_start();
class Api_Raiders_Praise_Up extends Api
{
    static function handle($args='')
    {
        return $result = self::handlePraiseUp($args);
    }


    //点赞
//    static function  handlePraiseUp($data)
//    {
//        $request = Func_Input::filter(array(
//            'id' => 'int',
//        ),$data);
//
//        //点赞成功则更新或插入一条数据
//        $r = Data_Mysql_Table_Praise::select('*',array('user_id =?' => $_SESSION['user']['id'],'title_id =?' => $request['id']));
//        if(empty($r[0])) {
//            $rs = Data_Mysql_Table_Praise::insert(array('title_id' => $request['id'],'user_id' => $_SESSION['user']['id'],'praise' => 1));
//        }else{
//            $rs = Data_Mysql_Table_Praise::update(array('title_id' => $request['id'],'user_id' => $_SESSION['user']['id']),array('praise' => 1));
//        }
//        $rows = Data_Mysql_Table_Raiders_Info::query("UPDATE {table} set  counter_praise = counter_praise+1 WHERE id =?", array($request['id']), 1);
//        if ($rows > 0 && $rs > 0) {
//            $result = array(
//                'status' => 1,
//                'msg' => "成功",
//                "data" => ''
//            );
//        }else{
//            $result = array(
//                'status' => 0,
//                'msg' => "失败",
//                "data" => ''
//            );
//        }
//       return $result;
//    }


    //点赞
    static function  handlePraiseUp($data)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ),$data);

        //点赞成功则更新或插入一条数据
        $rows = Data_Mysql_Table_Raiders_Info::query("UPDATE {table} set  counter_praise = counter_praise+1 WHERE id =?", array($request['id']),1);
        if ($rows > 0) {
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
