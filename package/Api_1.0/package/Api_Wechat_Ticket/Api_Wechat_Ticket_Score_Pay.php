<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/12/29
 * Time: 16:28
 * 微信积分购票
 */
class Api_Wechat_Ticket_Score_Pay extends Api {

    static function handle($args='')
    {
        $result = self::ScorePay($args);
        return $result;
    }


    static function ScorePay($args)
    {
        $request = Func_Input::filter(array(
//            "order_info"=>'array', //
            'ticket_id' => 'int',
            'ticket_num' => 'int',
            'order_no'=> 'string',
            'order_price'=> 'int',
        ),$args);

        //付款之前再检查一下库存  $order_info['order_info']['order_detail'][0]['ticket_id']
        $user_id = Api_Session::user_id();
        if(empty($user_id)){
            $result =self::request('error','',"请先登录！");
            return $result;
        }
        if(empty($request['ticket_id']) ||empty($request['ticket_num'])){
            $result =self::request('error','',"参数错误！");
            return $result;
        }
        $ticketInfo= Data_Mysql_Table_Weixin_Ticket_Info::select("id,name,price,stock,create_time,update_time,status", array("id=?" => $request['ticket_id'], "status" => 1), 'ORDER BY id asc', 1);

        if(empty($ticketInfo)){
            $result =self::request('error','',"门票不存在");
            return $result;
        }
        if($ticketInfo[0]['stock'] < $request['ticket_num']){
            $result =self::request('error','',"门票库存不足，请重新选择，或选择其他时间点门票");
            return $result;
        }


        if(empty($request['order_no'])) {
            $result =self::request('error','',"参数传递错误");
            return $result;
        }

        if(empty($_SESSION['user']['id'])) {
            $result =self::request('error','',"请登录后再查看");
            return $result;
        }

        //根据票价积分扣去账户下相应积分，然后更新至账户
        $rs_account = Data_Mysql_Table_Account::select('integral',array('id=?'=>$_SESSION['user']['id']));
        if($rs_account[0]['integral'] < $request['order_price']) {
            $result =self::request('error','',"积分不足");
            return $result;
        }
        $integral_new = $rs_account[0]['integral']-$request['order_price'];
        $rs_account_update = Data_Mysql_Table_Account::update(array('id=?'=>$_SESSION['user']['id']),array('integral=?'=>$integral_new));
        if($rs_account_update[0]>0) {
            $request['integral_new'] = $integral_new;
            //更新订单，库存等信息
            $rs_pay = Web_Mobile_Wechat_Ticket::payOrder_byScore($request);
            if($rs_pay['status']==1) {
                $result =self::request('success',$request,"购票成功！");
                return $result;
            }
        }
    }

}