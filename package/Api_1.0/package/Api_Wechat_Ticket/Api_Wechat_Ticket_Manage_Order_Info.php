<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/3
 * Time: 16:44
 * @订单详情后台
 */
class  Api_Wechat_Ticket_Manage_Order_Info extends Api
{
    /**
     *
     *
     *
     */


    static function  getOrderInfo($args)
    {
        $request = Func_Input::filter(array(
            "order_no"=>'string', //
        ),$args);
        if(empty($request['order_no'])){
            $result =self::request('error','',"参数传递错误");
            return $result;
        }
        //要判断登录
        $conditions =array(
            "order_no"=>$request['order_no'],
        );
        //订单信息
        $orderInfo = Data_Mysql_Table_Weixin_Ticket_Order_Info::select("*",$conditions,'',1);
        $conditions1['{table}.order_no = ?'] =$request['order_no'];
        //门票信息
//        $ticketInfo = Data_Mysql_Table_Weixin_Ticket_Num_Info::select("*",$conditions,'',100);
//        Data_Mysql_Table_Weixin_Ticket_Num_Info::debug(1);
        $ticketInfo = Data_Mysql_Table_Weixin_Ticket_Num_Info::select("{table}.*,{prefix}weixin_ticket_info.event_time",$conditions1,'',100,'{table} LEFT JOIN {prefix}weixin_ticket_info ON {table}.event_id = {prefix}weixin_ticket_info.envent_id AND {table}.ticket_id = {prefix}weixin_ticket_info.id');


        if(empty($orderInfo[0]) || empty($orderInfo[0]['id'])){
            $result =self::request('error','',"该订单不存在或未登录");
            return $result;
        }else{
            $orderInfo[0]['order_detail'] = json_decode($orderInfo[0]['order_detail'],1);
            $orderInfo[0]['addressInfo'] = json_decode($orderInfo[0]['addressInfo'],1);
            $orderInfo[0]['logisticsInfo']=json_decode($orderInfo[0]['logisticsInfo'],1);
            $data['order_info'] = $orderInfo[0];
            $data['ticket_info'] = $ticketInfo;
            $result =self::request('success',$data,"返回失败，数据为空");
            return $result;
        }
    }


}