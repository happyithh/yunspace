<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/3
 * Time: 16:44
 * @订单详情前台
 */
@session_start();
class  Api_Wechat_Ticket_Order_Info_By_Order_No extends Api
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
        $orderInfo= Data_Mysql_Table_Weixin_Ticket_Order_Info::select("*",$conditions,'',1);
        if(empty($orderInfo[0]) || empty($orderInfo[0]['id'])){
            $result =self::request('error','',"该订单不存在或未登录");
            return $result;
        }
        $orderInfo[0]['addressInfo']=json_decode($orderInfo[0]['addressInfo'],1);
        $orderInfo[0]['logisticsInfo']=json_decode($orderInfo[0]['logisticsInfo'],1);
        $ticketList = Data_Mysql_Table_Weixin_Ticket_Num_Info::select("*",array("order_no=?"=>$request['order_no']),'',100);
        if(!empty($ticketList)){
            $countStatus  = 0;
            foreach($ticketList as $k=>$v){
                if($v['status']==0 ){
                    $countStatus=$countStatus+1;
                }
            }
            if($countStatus>0 && $orderInfo[0]['order_status']==1){
                $orderInfo[0]['order_status']=2;
            }
            if($countStatus==0 && $orderInfo[0]['order_status']==1){
                $orderInfo[0]['order_status']=3;
            }
        }
        $_REQUEST['event_id'] =$orderInfo[0]['event_id'];
        $eventInfo = Api_Wechat_Ticket_Event_Info::getEventInfo($_REQUEST);
        $orderInfo[0]['order_detail'] = json_decode($orderInfo[0]['order_detail'],1);
        $ticketInfo= Data_Mysql_Table_Weixin_Ticket_Info::select("id,name,price,stock,create_time,update_time,status,event_time", array("id=?" => $orderInfo[0]['order_detail'][0]['ticket_id'], "status" => 1), '', 1);
        $returnData['order_info'] = $orderInfo[0];
        $returnData['ticket_list'] = $ticketList;
        $returnData['ticket_info'] = $ticketInfo[0];
        $returnData['event_info'] = $eventInfo['data'];
        $result =self::request('success',$returnData,"返回成功");
        return $result;
    }


}