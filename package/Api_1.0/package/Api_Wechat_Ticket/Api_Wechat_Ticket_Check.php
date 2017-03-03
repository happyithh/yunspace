<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/3/30
 * Time: 15:58
 */

class Api_Wechat_Ticket_Check extends Api{

    static function handle(){
        return self::checkIn();
    }

    static function checkIn(){
        $is_login = Web_Wechat_Login::isLogin();
        if(!$is_login){
            $result =self::request('error','',"请先登录");
            return $result;
        }
        //接受门票号，二维码等提交
        $request = Func_Input::filter(array(
            "ticket_num"=>'string',
            'type' =>'string'
        ),$_REQUEST);
        if(empty($request['ticket_num'])){
            $result =self::request('error','',"票号不能为空");
            return $result;
        }
        $ticket_info = Data_Mysql_Table_Weixin_Ticket_Num_Info::select("*",array("ticket_num"=>$request['ticket_num']),'',1);
        if(empty($ticket_info[0]['id'])){
            $result =self::request('error','',"门票信息不存在");
            return $result;
        }
        self::checkAuthority($ticket_info[0]['event_id']);
        $rs = Data_Mysql_Table_Weixin_Ticket_Num_Info::update(array("ticket_num"=>$request['ticket_num']),array("status"=>1,"use_time"=>time()));
        if($rs){
            $result =self::request('success','',"验票通过，已使用");
            return $result;
        }else{
            $result =self::request('error','',"验票失败");
            return $result;
        }
    }
        static function checkAuthority($event_id){
            $event_info = Data_Mysql_Table_Weixin_Event_Info::select("*", array("id=?" => $event_id));
            if(empty($event_info)){
                $result =self::request('error','',"活动不存在");
                return $result;
            }
            if(empty($event_info[0]['checkticketphone'])){
                $result =self::request('error','',"你没有权限检票");
                return $result;
            }
            $event_info[0]['checkticketphone'] = explode(',',$event_info[0]['checkticketphone']);
            if(!in_array($_SESSION['user']['phone'],$event_info[0]['checkticketphone'])){
                $result =self::request('error','',"你没有权限检票");
                return $result;
            }
        }

} 