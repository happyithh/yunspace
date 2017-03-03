<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/3
 * Time: 16:44
 * @微信售票订单列表 前端
 */
@session_start();
class  Api_Wechat_Ticket_Get_Order_List_By_Account_Id extends Api
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

    static function  getOrderList()
    {
//        $request = Func_Input::filter(array(
//            "account_id"=>'int', //
//        ),$args);
//        if(empty($request['account_id'])){
//            $result =self::request('error','',"参数传递错误");
//            return $result;
//        }
        //判断是否登录
        if(empty($_SESSION['user']['id'])){
            $result =self::request('error','',"请登录后再查看");
            return $result;
        }
        //获取用户id 如果不存在 提示登录 登录
//        $condition = array(
//            "tb1.buyer_account_id" => $_SESSION['user']['id'],
//            "tb1.buyer_account_phone" => $_SESSION['user']['phone'],
//        );
        $sqlT = "tb1.buyer_account_id=? AND tb1.buyer_account_phone=?";

        //订单状态筛选
        if(!empty($_REQUEST['order_status'])) {
//            $sqlT .= "  AND tb1.order_status=?";
//            $sqlT .= "  AND ";
            $conditions = array($_SESSION['user']['id'],$_SESSION['user']['phone']);
        } else {
            $conditions = array($_SESSION['user']['id'],$_SESSION['user']['phone']);
        }


//        $table = "{table} as tb1 left join  {prefix}weixin_ticket_num_info as tb2 ON tb1.order_no=tb2.order_no";
//        $orderList = Data_Mysql_Table_Weixin_Ticket_Order_Info::select("tb1.*,tb2.status as ticket_status", $condition, "order by tb1.create_time desc", 1000,$table);
        $sql=" SELECT
                      tb1.*,tb2.status as ticket_status,tb3.title,tb3.event_logo,tb3.activity_time,tb3.is_mail,tb3.ticket_type
                FROM
                      {table} AS tb1 LEFT JOIN
                      (select order_no,min(status) AS status FROM {prefix}weixin_ticket_num_info  GROUP BY order_no) AS tb2 ON tb1.order_no=tb2.order_no
                       LEFT JOIN {prefix}weixin_event_info AS tb3 ON tb1.event_id=tb3.id
                WHERE ".$sqlT."  GROUP BY tb1.order_no  ORDER BY tb1.create_time DESC LIMIT 1000";
//        $sql="SELECT tb1.*,tb2.price as low_price  FROM {table} as tb1 left join (select envent_id,min(price)as price from {prefix}weixin_ticket_info group by envent_id) as tb2 ON tb1.id=tb2.envent_id   WHERE ".$sqlT."  group by tb1.id  ORDER BY tb1.update_time DESC LIMIT 100";
////        Data_Mysql_Table_Weixin_Event_Info::debug(1);
//        $list = Data_Mysql_Table_Weixin_Event_Info::query( $sql, array(time(),1),1);
        $orderList = Data_Mysql_Table_Weixin_Ticket_Order_Info::query($sql, $conditions,1);
        foreach($orderList as $k=>$v) {
            @$orderList[$k]['logisticsInfo'] = json_decode($v['logisticsInfo'],1);
        }
//        Q($orderList);
        if(!empty($orderList)){
            $orderList_no_pay = $orderList_pay = $orderList_cancel =  array();
//        门票邮寄组合及状态：
//            1、电子票不需要邮寄：已使用、未使用
//            2、实体票不需要邮寄：现场领取
//            3、实体票需要邮寄：已寄出、未寄出
//         状态分类：
//            全部、未付款，已付款（包含以上3种状态）、、已取消
            foreach ($orderList as $k => $v) {
                $orderList[$k]['order_detail'] = json_decode($v['order_detail'], 1);

                if($v['order_status']==1 && is_numeric($v['ticket_status']) && $v['ticket_status']==0 && $v['ticket_type']==0){
                    $orderList[$k]['order_status'] = 11;  //电子票未使用11（订单付款，并且有未使用的门票）
                    $orderList_pay[] = $orderList[$k];
                }

                if($v['order_status']==1 && $v['ticket_status']==1 && $v['ticket_type']==0){
                    $orderList[$k]['order_status'] = 12;  //电子票已使用12（订单付款，并且所有门票都已使用）
                    $orderList_pay[] = $orderList[$k];

                }
                if($v['order_status']==1 && $v['ticket_type']==1 && $v['is_mail']==0){
                    $orderList[$k]['order_status'] = 13;  //实体票不需要邮寄13（订单付款，并且是实体票）
                    $orderList_pay[] = $orderList[$k];
                }

                if($v['order_status']==1 && $v['ticket_type']==1 && $v['is_mail']==1 && $v['logisticsInfo']['status']==1){
                    $orderList[$k]['order_status'] = 14;  //实体票需要邮寄14 已寄出（订单付款，并且是实体票）
                    $orderList_pay[] = $orderList[$k];
                }
                if($v['order_status']==1 && $v['ticket_type']==1 && $v['is_mail']==1 && $v['logisticsInfo']['status']==0){
                    $orderList[$k]['order_status'] = 15;  //实体票需要邮寄15 未寄出（订单付款，并且是实体票）
                    $orderList_pay[] = $orderList[$k];
                }
                //未付款
                if($v['order_status']==0) {
                    $orderList_no_pay[] = $orderList[$k];
                }
                //已取消
                if($v['order_status']==-1) {
                    $orderList_cancel[] = $orderList[$k];
                }
            }
            //未付款
            if(isset($_REQUEST['order_status']) && $_REQUEST['order_status']==1) {
                return $result =self::request('success',$orderList_no_pay,"返回成功");
            }
            //已付款
            if(isset($_REQUEST['order_status']) && $_REQUEST['order_status']==2) {
                return $result =self::request('success',$orderList_pay,"返回成功");
            }
            //未使用
//            if(isset($_REQUEST['order_status']) && $_REQUEST['order_status']==2) {
//                return $result =self::request('success',$orderList_two,"返回成功");
//            }
            //已使用
//            if(isset($_REQUEST['order_status']) && $_REQUEST['order_status']==3) {
//                return $result =self::request('success',$orderList_three,"返回成功");
//            }
            //已取消
            if(isset($_REQUEST['order_status']) && $_REQUEST['order_status']==3) {
                return $result =self::request('success',$orderList_cancel,"返回成功");
            }
//            Q($orderList);
            $result =self::request('success',$orderList,"返回成功");
            return $result;
        }
//        if(!empty($orderList)){
//            $result =self::request('success',$orderList,"返回成功");
//            return $result;
//        }
        else{
            $result =self::request('error','',"您还没有任何订单记录");
            return $result;
        }
    }


}