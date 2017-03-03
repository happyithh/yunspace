<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/3/30
 * Time: 14:36
 */
@session_start();
class Web_Wechat_Ticket {

    static function eventList(){
//        Q($_SESSION);
        $data = array(
//            'status=?'=>1,
//            "'%".$_SESSION['user']['phone']."%'",
        );
        $sql="SELECT * FROM {table} WHERE checkticketphone like '%".$_SESSION['user']['phone']."%' ORDER  BY activity_time DESC ";
//        Data_Mysql_Table_Weixin_Event_Info::debug(1);
        $eventList = Data_Mysql_Table_Weixin_Event_Info::query($sql,$data,1);
//        q($eventList);
        Tpl_Smarty::assign('event_list',$eventList);
        Tpl_Smarty::display("Web_Static::wechat_ticket/event_list.tpl");
    }


    static function orderList(){
        $request =Func_Input::filter(
            array(
                'event_id'=>'int',
                'phone'=>'int',
                'order_status'=>'int',
            ));
        if(empty($request['event_id'])){
            Func_Header::to("参数错误");
        }
        self::checkAuthority($request['event_id']);
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
        $orderList = Data_Mysql_Table_Weixin_Ticket_Order_Info::page(0, 15, "tb1.*,tb2.fullname", $conditions, 'ORDER BY tb1.create_time DESC',$table);
        Tpl_Smarty::assign('order_list',$orderList);
        Tpl_Smarty::assign('request',$request);
        Tpl_Smarty::display("Web_Static::wechat_ticket/order_list.tpl");
    }

    static function orderDetail(){
        $request = Func_Input::filter(array(
            "order_no"=>'string', //
        ));
        if(empty($request['order_no'])){
            Func_Header::back("参数传递错误");
        }
        //要判断登录
        $conditions =array(
            "order_no"=>$request['order_no'],
        );
        //订单信息
        $orderInfo = Data_Mysql_Table_Weixin_Ticket_Order_Info::select("*",$conditions,'',1);
        if(empty($orderInfo[0]) || empty($orderInfo[0]['id'])){
            Func_Header::back("该订单不存在或未登录");
        }
        self::checkAuthority($orderInfo[0]['event_id']);
        $conditions1['{table}.order_no = ?'] =$request['order_no'];
        $ticketInfo = Data_Mysql_Table_Weixin_Ticket_Num_Info::select("{table}.*,{prefix}weixin_ticket_info.event_time",$conditions1,'',100,'{table} LEFT JOIN {prefix}weixin_ticket_info ON {table}.event_id = {prefix}weixin_ticket_info.envent_id AND {table}.ticket_id = {prefix}weixin_ticket_info.id');

        $orderInfo[0]['order_detail'] = json_decode($orderInfo[0]['order_detail'],1);
            $orderInfo[0]['addressInfo'] = json_decode($orderInfo[0]['addressInfo'],1);
            $orderInfo[0]['logisticsInfo']=json_decode($orderInfo[0]['logisticsInfo'],1);
            $data['order_info'] = $orderInfo[0];
            $data['ticket_info'] = $ticketInfo;
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::assign('request',$request);
        Tpl_Smarty::display("Web_Static::wechat_ticket/detail.tpl");
    }

    static function checkAuthority($event_id){


        $event_info = Data_Mysql_Table_Weixin_Event_Info::select("*", array("id=?" => $event_id));
        if(empty($event_info)){
            Func_Header::back("该活动不存在");
        }
        if(empty($event_info[0]['checkticketphone'])){
            Func_Header::back('你没有权限检票');
        }
        $event_info[0]['checkticketphone'] = explode(',',$event_info[0]['checkticketphone']);
        if(!in_array($_SESSION['user']['phone'],$event_info[0]['checkticketphone'])){
            Func_Header::back('你没有权限检票');
        }
    }
} 