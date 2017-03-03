<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/1
 * Time: 18:57
 */
class OA_Weixin_Ticket_Order_Manage
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'event_list' : $_REQUEST['action'];
        switch ($action) {
            case 'event_list':
                self::eventList();
                break;
            case 'order_list':
                self::orderList();
                break;
            case 'order_detail':
                self::orderDetail();
                break;
            case 'export':
                self::orderExport();
                break;
            case 'edit_order_detail':
                self::editLogisticsInfo();
                break;

        }
    }

    static function eventList()
    {
        $res = Api_Wechat_Ticket_Manage_Event_List::getEventList($_REQUEST);
        Tpl_Smarty::assign('_data',$res['data']);
//        Tpl_Smarty::display('OA', 'weixin/event_list_by_order.tpl');
        Tpl_Smarty::display("OA_Static::wechat/event_list_by_order.tpl");

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
        $request['order_status'] = isset($request['order_status']) ? $request['order_status'] :1;
        //订单列表
        $res = Api_Wechat_Ticket_Get_Order_List_By_EventId::getOrderList($_REQUEST);
        //订单统计
        $Statistic =Api_Wechat_Ticket_Get_Order_List_By_EventId::getStatistic($_REQUEST);
        Tpl_Smarty::assign('statistic',$Statistic['data']);
        Tpl_Smarty::assign('data',$res['data']);
        Tpl_Smarty::assign('order_status', $request['order_status']);
        Tpl_Smarty::assign('event_id',$request['event_id']);
//        Tpl_Smarty::display('OA', 'weixin/order_list.tpl');
        Tpl_Smarty::display("OA_Static::wechat/order_list.tpl");
    }

    static function orderDetail()
    {
        $res = Api_Wechat_Ticket_Manage_Order_Info::getOrderInfo($_REQUEST);
        Tpl_Smarty::assign('data',$res['data']);
//        Tpl_Smarty::display('OA', 'weixin/user_ticket_detail.tpl');
        Tpl_Smarty::display("OA_Static::wechat/user_ticket_detail.tpl");
    }

    static function orderExport(){
        $request =Func_Input::filter(
            array(
                'event_id'=>'int',
            ));
        if(empty($request['event_id'])){
            Func_Header::to("参数错误");
        }
        $_REQUEST['order_status'] = 1;
        $res = Api_Wechat_Ticket_Get_Order_List_By_EventId::exportOrderList($_REQUEST);
        if($res['data']){
            $cols = array("订单号","手机号","票种","票号","票价");
            $list = array();
            foreach($res['data']['order_info'] as $k=>$v){
                $list[$k][] = $v['order_no'];
                $list[$k][] = $v['buyer_account_phone'];
                $list[$k][] = $v['ticket_detail'];
                $list[$k][] = $v['ticket_num'];
                $list[$k][] = $v['ticket_price'];
            }
            Func_Csv::writeRow($cols,$list,$res['data']['event_info']['title']);
            return ;
        }else{
            Func_Header::to("没有数据");
        }
    }

    // 修改物流信息
    static function editLogisticsInfo(){
       $data =  Api_Wechat_Ticket_Update_LogisticsInfo::updateLogisticsInfo($_REQUEST);
        Func_Header::to(  '  '.$data['msg'],'');
    }


}
