<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/3
 * Time: 16:44
 * @订单列表
 */
class  Api_Wechat_Ticket_Get_Order_List_By_EventId extends Api
{
    /**
     *
     *
     *
     */

//    static function  handle($args = '')
//    {
//        $result = self::getOrderList($args);
//        return $result;
//    }

    static function  getOrderList($args)
    {
        $request = Func_Input::filter(array(
            "event_id"=>'int', //
            "order_status"=>'int',  //订单状态，待付款。已付款。已取消
            "phone"=>'int'
        ),$args);
        if(empty($request['event_id'])){
            $result =self::request('error','',"参数传递错误");
            return $result;
        }
        //活动信息
        $rs = Data_Mysql_Table_Weixin_Event_Info::select("id,title,content,status",$request['event_id']);
        if(empty($rs[0]) || empty($rs[0]['id'])){
            $result =self::request('error','',"该活动不存在");
            return $result;
        }
        $request['order_status'] = (isset($request['order_status']) && is_numeric($request['order_status'])) ? $request['order_status'] : 1;
        $conditions =array(
            "tb1.event_id=?"=>$request['event_id'],
            "tb1.order_status=?"=>$request['order_status'],
            "tb1.status=?"=>1,
        );
        if(!empty($request['phone'])){
            $conditions['tb1.buyer_account_phone = ?']=$request['phone'];
        }
        $table = "{table} AS tb1 LEFT JOIN {prefix}account AS tb2 ON tb1.buyer_account_id=tb2.id";
        $list = Data_Mysql_Table_Weixin_Ticket_Order_Info::page(0, 15, "tb1.*,tb2.fullname", $conditions, 'ORDER BY tb1.create_time DESC',$table);
        if(!empty($list['rows'])){
            $result =self::request('success',$list,"返回成功");
            return $result;
        }else{
            $result =self::request('error','',"返回失败，数据为空");
            return $result;
        }
    }
    //统计信息
    static function  getStatistic($args){
        $request = Func_Input::filter(array(
            "event_id"=>'int', //
        ),$args);
        if(empty($request['event_id'])){
            $result =self::request('error','',"参数传递错误");
            return $result;
        }
        //活动信息
        $rs = Data_Mysql_Table_Weixin_Event_Info::select("id,title,content,status",$request['event_id']);
        if(empty($rs[0]) || empty($rs[0]['id'])){
            $result =self::request('error','',"该活动不存在");
            return $result;
        }
        $totalOrder = Data_Mysql_Table_Weixin_Ticket_Order_Info::query("SELECT COUNT(id) AS total_num FROM {table} WHERE  event_id=?",array($request['event_id']),1);
//        Data_Mysql_Table_Weixin_Ticket_Order_Info::debug(1);
       $res =  Data_Mysql_Table_Weixin_Ticket_Order_Info::query("SELECT COUNT(id) AS total,sum(order_price) AS prices,sum(order_price_pay) AS price_pay FROM {table} WHERE event_id=? AND order_status=?",array($request['event_id'],1),1);
       if(isset($res[0])){
           $res[0]['prices'] = round($res[0]['prices'],2);
           $res[0]['price_pay'] = round($res[0]['price_pay'],2);
       }else{
           $res[0]['prices'] =0.00;
           $res[0]['price_pay'] = 0.00;
           $res[0]['total'] = 0;
       }
        $data =array();
        if(isset($totalOrder[0])){
            $data['total_order_num'] =$totalOrder[0]['total_num'];
            $data['pay_order_num'] = $res[0]['total'] ;
            $data['pay_order_prices'] =   $res[0]['prices'];
            $data['pay_order_price_pay'] =   $res[0]['price_pay'];
            $result =self::request('error',$data,"该活动不存在");
            return $result;
        }else{
            $result =self::request('error',$data,"没有订单");
            return $result;
        }

    }
    //导出数据
    static function exportOrderList($args){
        $request = Func_Input::filter(array(
            "event_id"=>'int', //
            "order_status"=>'int',  //订单状态，待付款。已付款。已取消
        ),$args);
        if(empty($request['event_id'])){
            $result =self::request('error','',"参数传递错误");
            return $result;
        }
        //活动信息
        $rs = Data_Mysql_Table_Weixin_Event_Info::select("id,title,content,status",$request['event_id']);
        if(empty($rs[0]) || empty($rs[0]['id'])){
            $result =self::request('error','',"该活动不存在");
            return $result;
        }
        $request['order_status'] = isset($request['order_status']) ? $request['order_status']: 1;
        $sql = " SELECT
                      tb1.order_no,tb1.buyer_account_phone,tb2.ticket_num,tb2.ticket_detail,tb2.ticket_price
                  FROM
                      {table} AS tb1,{prefix}weixin_ticket_num_info AS tb2
                  WHERE
                  tb1.order_no=tb2.order_no AND  tb1.event_id=? AND tb1.order_status=? ";
        $list = Data_Mysql_Table_Weixin_Ticket_Order_Info::query($sql,array($request['event_id'],$request['order_status']),1);
        if($list){
            $data['event_info'] = $rs[0];
            $data['order_info'] = $list;
            $result =self::request('success',$data,"返回成功");
            return $result;
        }else{
            $result =self::request('error','',"数据不存在");
            return $result;
        }

    }


}