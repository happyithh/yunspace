<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/9/22
 * Time: 16:42
 */
class Api_Wechat_Ticket_Get_Ticket_Stock extends Api
{
        static function  handle()
    {
        $result = self::getStock($_REQUEST);
        return $result;
    }
    static function getStock($args)
    {
      $request = Func_Input::filter(array(
            'ticket_id' => 'int',
            'ticket_num' => 'int',
        ), $args);
        $user_id = Api_Session::user_id();
        if(empty($user_id)){
            $result =self::request('error','',"请先登录！");
            return $result;
        }
        if(empty($request['ticket_id']) ||empty($request['ticket_num'])){
            $result =self::request('error','',"参数错误！");
            return $result;
        }
        $ticketInfo= Data_Mysql_Table_Weixin_Ticket_Info::select("id,name,price,stock,create_time,update_time,status", array("id=?" => $request['ticket_id'], "status" => 1), 'ORDER BY id asc', 1);

        if(empty($ticketInfo)){
            $result =self::request('error','',"门票不存在");
            return $result;
        }
        if($ticketInfo[0]['stock']<$request['ticket_num']){
            $result =self::request('error','',"门票库存不足，请重新选择，或选择其他时间点门票");
            return $result;
        }else{
            $result =self::request('success',$request,"库存充足！");
            return $result;
        }
    }
}