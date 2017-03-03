<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/3
 * Time: 16:44
 * @订单详情前台
 */
@session_start();
class  Api_Wechat_Ticket_Cancel_Order extends Api
{
    /**
     *
     *
     *
     */

//    static function  handle()
//    {
//        $result = self::getEventInfo($_REQUEST);
//        return $result;
//    }

    static function  cancelOrder($args)
    {

        $request = Func_Input::filter(array(
            'order_no' => 'string',
        ), $args);


        if(empty($_SESSION['user']['id'])){
            $result =self::request('error','',"请登录后再查看");
            return $result;
        }
        if(empty($request['order_no'])){
            $result =self::request('error','',"参数错误,订单id未传递！");
            return $result;
        }
        $orderInfo = Data_Mysql_Table_Weixin_Ticket_Order_Info::select("*",array("order_no=?"=>$request['order_no']),'',1);
        if(empty($orderInfo)){
            $result =self::request('error','',"此订单不存在！");
            return $result;
        }
        if($orderInfo[0]['order_status']==-1){
            $result =self::request('error','',"订单已取消，不要重复点击！");
            return $result;
        }
        $rs =  Data_Mysql_Table_Weixin_Ticket_Order_Info::update(array(
            "order_no"=>$request['order_no'],
            "buyer_account_id"=>$_SESSION['user']['id']
        ),array("order_status=?"=>-1));
        if($rs){
            $result =self::request('success',$request,"取消订单成功");
            return $result;
        }else{
            $result =self::request('error','',"取消订单失败，请稍后重试");
            return $result;
        }
    }


}