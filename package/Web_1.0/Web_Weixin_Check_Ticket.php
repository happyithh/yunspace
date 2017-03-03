<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/6/10
 * Time: 11:18
 */
session_start();

class Web_Weixin_Check_Ticket extends Base
{

    static function handle()
    {
        //判断是否登录。没有登录就跳转到登录哪里
//        Web_Account::handleIsLogin('');
//        if (empty($_SESSION['openid'])) {
//            Func_Header::back('请求异常!');
//        }
        $action = !empty($_REQUEST['action']) ?  $_REQUEST['action'] : 'form';
        switch($action){
            case 'form':
                self::checkTicket();
                break;
            case 'tickeinfo':
                self::checkTicketResult();
                break;
            case 'useticket':
                self::useTicket();
                break;
            default:
                Func_Header::back("非法操作！");
                break;
        }

    }

    /**
     * 验票入口
     */
    static function checkTicket()
    {
        //判断是否登录。没有登录就跳转到登录哪里
        Web_Account::handleIsLogin('');
        if (empty($_SESSION['openid'])) {
            Func_Header::back('请求异常!');
        }
        //手动输入票号。验证门票入口

        //这个页面是否可以让任意人可以看到，如果不可以，用什么方法阻止
        Tpl_Smarty::display("Web_Mobile_Static::wechat.v1.0/ticket_texted.tpl");
    }

    /**
     * 验证结果页面（验证票号页面）
     */
    static function checkTicketResult()
    {
        //判断是否登录。没有登录就跳转到登录哪里
        Web_Account::handleIsLogin('');
        if (empty($_SESSION['openid'])) {
            Func_Header::back('请求异常!');
        }
        //门票信息页面，接受二维码和表单输入，显示门票信息
        $resquest = Func_Input::filter(array(
            "ticket_num"=>'string',
            'type' =>'string'
        ),$_REQUEST);
        if(empty($resquest['ticket_num'])){
            Func_Header::back("票号不能为空");
        }
        $ticketinfo = Data_Mysql_Table_Weixin_Ticket_Num_Info::select("*",array("ticket_num"=>$resquest['ticket_num']),'',1);
        if(empty($ticketinfo[0]['id'])){
            Func_Header::back("门票信息不存在");
        }
        self::checkAuthority($ticketinfo[0]['event_id']);
        $orderinfo = Data_Mysql_Table_Weixin_Ticket_Order_Info::select("*",array('order_no'=>$ticketinfo[0]['order_no']),'',1);
        $ticketinfo[0]['buyer_account_id'] = $orderinfo[0]['buyer_account_id'];
        $ticketinfo[0]['buyer_account_name'] = $orderinfo[0]['buyer_account_name'];
        $ticketinfo[0]['buyer_account_phone'] = $orderinfo[0]['buyer_account_phone'];
        Tpl_Smarty::assign("ticket_info",$ticketinfo[0]);
            switch($resquest['type']){
                case 'form':
                    $url_back =Core::$urls['root']."m/ticket/checkticket";
                    break;
                case 'code':
                    $url_back =Core::$urls['root']."m/";
                    break;
                default:
                    $url_back =Core::$urls['root']."m/";
                    break;
            }
        Tpl_Smarty::assign("url_back",$url_back);
        Tpl_Smarty::display("Web_Mobile_Static::wechat.v1.0/check_ticket.tpl");
    }

    /**
     * 使用门票
     */

    static function useTicket()
    {
        //判断是否登录。没有登录就跳转到登录哪里
        Web_Account::handleIsLogin('');
        if (empty($_SESSION['openid'])) {
            Func_Header::back('请求异常!');
        }
        //接受门票号，二维码等提交
        $resquest = Func_Input::filter(array(
            "ticket_num"=>'string',
            'type' =>'string'
        ),$_REQUEST);
        if(empty($resquest['ticket_num'])){
            Func_Header::back("票号不能为空");
        }
        $ticketinfo = Data_Mysql_Table_Weixin_Ticket_Num_Info::select("*",array("ticket_num"=>$resquest['ticket_num']),'',1);
        if(empty($ticketinfo[0]['id'])){
            Func_Header::back("门票信息不存在");
        }
        self::checkAuthority($ticketinfo[0]['event_id']);
        $rs = Data_Mysql_Table_Weixin_Ticket_Num_Info::update(array("ticket_num"=>$resquest['ticket_num']),array("status"=>1,"use_time"=>time()));
        if($rs){
            Func_Header::to("验票通过，已使用",Core::$urls['root']."m/ticket/checkticket?action=form");
        }else{
            Func_Header::to("验票失败",Core::$urls['root']."m/ticket/checkticket?action=tickeinfo&type=form&ticket_num=".$resquest['ticket_num']);
         }
    }

    static function checkAuthority($event_id){
        $eventinfo = Data_Mysql_Table_Weixin_Event_Info::select("*", array("id" => $event_id));
      //  $eventinfo[0]['checkticketids'] = json_decode($eventinfo[0]['checkticketids'],1);
        $eventinfo[0]['checkticketphone'] = explode(',',$eventinfo[0]['checkticketphone']);
        if(!isset($_SESSION['user']['phone'])){
            $data_wechat = Data_Mysql_Table_Account_Wechat::select(
                'tb2.phone,tb1.account_id',
                array('tb1.openid=?' => $_SESSION['openid'])
            ,'',1,"{table} AS tb1 LEFT JOIN {prefix}account as tb2 ON tb1.account_id=tb2.id");
            $user_phone  = $data_wechat[0]['phone'];
        }else{
            $user_phone = $_SESSION['user']['phone'];
        }
        if(!in_array($user_phone,$eventinfo[0]['checkticketphone'])){
            Func_Header::back("你没有权限检票！");
        }
        //暂时不用用户id来验证。只用手机号来验证
//        else{
//            if(!in_array($_SESSION['user']['id'],$eventinfo[0]['checkticketids'])){
//                Func_Header::back("你没有权限检票！");
//            }
//        }
    }


}