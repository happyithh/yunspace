<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/3
 * Time: 16:44
 * @订单详情前台
 */
@session_start();
class  Api_Wechat_Ticket_Order_Info extends Api
{
    /**
     *
     *
     *
     */

//    static function  handle($args = '')
//    {
//        $result = self::getOrderInfo($args);
//        return $result;
//    }

    static function  getOrderInfo($args)
    {
        $request = Func_Input::filter(array(
            "order_no"=>'string', //
        ),$args);
        if(empty($request['order_no'])){
            $result =self::request('error','',"参数传递错误");
            return $result;
        }
        if(empty($_SESSION['user']['id'])){
            $result =self::request('error','',"请登录后再查看");
            return $result;
        }
        //要判断登录
        $conditions =array(
            "order_no"=>$request['order_no'],
            "buyer_account_id" => $_SESSION['user']['id'],
        );
        //订单信息
        $rs = Data_Mysql_Table_Weixin_Ticket_Order_Info::select("*",$conditions,'',1);
//        Q($rs);
        if(empty($rs[0]) || empty($rs[0]['id'])){
            $result =self::request('error','',"该订单不存在或未登录");
            return $result;
        }else{
            if($rs[0]['order_status']==1){
                $result =self::request('error','',"订单已付款，不要重复点击！");
                return $result;
            }else{
                $_REQUEST['event_id'] = $rs[0]['event_id'] ;
                $eventInfo = Api_Wechat_Ticket_Event_Info::getEventInfo($_REQUEST);
                $rs[0]['order_detail'] = json_decode($rs[0]['order_detail'],1);
                $ticketInfo= Data_Mysql_Table_Weixin_Ticket_Info::select("id,name,price,stock,create_time,update_time,status,price_is_score", array("id=?" => $rs[0]['order_detail'][0]['ticket_id'], "status" => 1), 'ORDER BY id asc', 1);
                $returnData['order_info'] = $rs[0];
                $returnData['ticket_info'] = $ticketInfo[0];
                $returnData['event_info'] = $eventInfo['data'];
                $result =self::request('success',$returnData,"返回成功");
                return $result;
            }
        }
    }


}