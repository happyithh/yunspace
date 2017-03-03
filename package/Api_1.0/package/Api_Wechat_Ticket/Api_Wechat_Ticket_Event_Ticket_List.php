<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/3
 * Time: 16:44
 * @微信售票门票列表 前端
 */
class  Api_Wechat_Ticket_Event_Ticket_List extends Api
{
    /**
     *
     *
     *
     */

//    static function  handle()
//    {
//        $result = self::getTicketList($_REQUEST);
//        return $result;
//    }

    static function  getTicketList($args)
    {
        $request = Func_Input::filter(array(
            "event_id"=>'int', //
        ),$args);
        if(empty($request['event_id'])){
            $result =self::request('error','',"参数传递错误");
            return $result;
        }
//        //要判断登录
//        $conditions =array(
//            "id"=>$request['event_id'],
//        );
//        //订单信息
//        $rs = Data_Mysql_Table_Weixin_Event_Info::select("*",$conditions,'',1);
//
//        if(empty($rs[0]) || empty($rs[0]['id'])){
//            $result =self::request('error','',"该活动不存在");
//            return $result;
//        }

        $ticketList = Data_Mysql_Table_Weixin_Ticket_Info::select("id,name,price,stock,event_time,status,price_is_score",array("envent_id=?"=>$request['event_id'],"status=?"=>1),'order by price asc',200);
        if(empty($ticketList)){
            $result =self::request('error','',"该活动下没有门票");
            return $result;
        }else{
            $result =self::request('success',$ticketList,"返回失败，数据为空");
            return $result;
        }



    }


}