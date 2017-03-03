<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/3
 * Time: 16:44
 * @订单详情前台
 */
@session_start();
class  Api_Wechat_Ticket_Create_Order extends Api
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

    static function  createOrder($args)
    {

        $request = Func_Input::filter(array(
            'event_id' => 'int',
            'ticket_id' => 'int',
            'ticket_num' => 'int',
            'conn_id' => 'int',
            'addressInfo'=>'array',
            'integral'=> 'int',
        ), $_REQUEST);

        if (isset($request['conn_id'])) {
            if (!empty($_SESSION['conn_id']) && $request['conn_id'] == $_SESSION['conn_id']) {
                $result =self::request('error','',"不要重复提交");
                return $result;
            } else {
                $_SESSION['conn_id'] = $request['conn_id']; //存储code
            }
        }
        if(empty($request['event_id'])){
            $result =self::request('error','',"活动参数错误！");
            return $result;
        }
        if(empty($request['ticket_num'])){
            $result =self::request('error','',"请选择你要选择的门票类型和张数");
            return $result;
        }
        if(empty($request['ticket_id'])){
            $result =self::request('error','',"数据传输错误，门票不存在");
            return $result;
        }
        $eventInfo = Api_Wechat_Ticket_Event_Info::getEventInfo($request);
        if($eventInfo['status']==0){
            $result =self::request('error','',$eventInfo['msg']);
            return $result;
        }
        if($eventInfo['data']['ticket_type']==1){
            if(empty($request['addressInfo'])){
                $result =self::request('error','',"请选择地址！");
                return $result;
            }else{
                $request['addressInfo'] =  Func_Input::filter(array(
                    'name' => '50',
                    'phone' => '15',
                    'address_content' => 'string',
                ), $_REQUEST['addressInfo']);
            }
            if(empty($request['addressInfo']['name'])||empty($request['addressInfo']['phone'])||empty($request['addressInfo']['address_content'])){
                $result =self::request('error','',"请确认姓名，电话，地址等收货地址信息是否正确完善！");
                return $result;
            }
        }else{
            $request['addressInfo']=array();
        }
//        Q($eventInfo);
        $ticketInfo= Data_Mysql_Table_Weixin_Ticket_Info::select("id,name,price,price_is_score,stock,create_time,update_time,status", array("id=?" => $request['ticket_id'], "status" => 1), 'ORDER BY id asc', 1);

        if(empty($ticketInfo)){
            $result =self::request('error','',"门票不存在");
            return $result;
        }
        if($ticketInfo[0]['stock']<$request['ticket_num']){
            $result =self::request('error','',"门票库存不足，请重新选择，或选择其他时间点门票");
            return $result;
        }
        $order_detail =array(
            array(
                "ticket_num"=>$request['ticket_num'],
                "ticket_id"=>$ticketInfo[0]['id'],
                "ticket_price"=>$ticketInfo[0]['price'],
                "ticket_name"=>$ticketInfo[0]['name'],
            )
        );
        //生产订单插入数据库
        $data = array();
        $data['order_no'] = 'tmp_' . uniqid();
        $data['buyer_account_id'] = $_SESSION['user']['id'];
        $data['buyer_account_name'] = $_SESSION['user']['username'];
        $data['buyer_account_phone'] = $_SESSION['user']['phone'];
        $data['event_id'] = $eventInfo['data']['id'];
        $data['event_title'] = $eventInfo['data']['title'];
        $data['order_price'] = $request['ticket_num']*$ticketInfo[0]['price'];
        $data['order_ticket_num'] = $request['ticket_num'];
        $data['order_detail'] = $order_detail;
        $data['create_time'] = $data['update_time'] = time();
        $data['order_status'] = 0;
        $data['status'] = 1;
        $data['addressInfo'] = $request['addressInfo'];
        if(!empty($request['integral'])) {
            $data['price_is_score'] = 1;
        }
        $r = Data_Mysql_Table_Weixin_Ticket_Order_Info::insert($data);
        if (!empty($r[0])) {
            //更新 订单号 order_no
            $data['order_no'] = 'W' . str_pad(Func_Input::str2num($r[0], 10), 10, '0', STR_PAD_LEFT);
            Data_Mysql_Table_Weixin_Ticket_Order_Info::update($r[0], array('order_no' => $data['order_no']));
            $data['id'] = $r[0];
            $returnData['order_info'] = $data;
            $returnData['ticket_info'] = $ticketInfo[0];
            $returnData['event_info'] = $eventInfo['data'];
            $result =self::request('success',$returnData,"创建订单成功");
            return $result;
        }else{
            $result =self::request('error','',"创建订单失败！请重新选择门票！");
            return $result;
        }
    }


}