<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-8-17
 * Time: 下午3:05
 * 管家app订单接口
 */
class Api_Order_App extends Api
{
    static function  handle()
    {
        Api_Session::checkToken(1);
        return self::handleOrder();
    }
    static function handleOrder()
    {
        $request = Func_Input::filter(array(
            'action' => 'string',
        ), $_REQUEST);
        if (empty($request['action'])) {
            return self::request('error','','参数错误1！！');
        }
        switch ($request['action']) {
            case 'order_list':
                $data = self::getOrderListApp();
                break;
            case 'order_info':
                $data = self::getOrderInfoApp();
                break;
            case 'order_status':
                $data=self::getCountOrderByOrderStatus();
                break;
            case 'order_accept':
                $data=self::acceptOrder();
                break;
            case 'order_refuse':
                $data=self::refuseOrder();
                break;
            default:
                $data = self::request('error', '', '失败');
                break;
        }
        return $data;
    }

    //获取订单信息
    static function getOrderInfoApp(){
        $request = Func_Input::filter(array(
            'order_id' => 'int',
            'user_id'=>'int',
        ), $_REQUEST);
        if (empty($request['order_id'])) {
            return self::request('error','','参数错误2！！');
        }
        if (empty($request['user_id'])) {
            return self::request('error','','参数错误4！！');
        }
        $condition['{table}.id = ?']=$request['order_id'];
        $condition['vendor_account_id']=$request['user_id'];

        $cols=array('{table}.id,{table}.order_no,{table}.product_id,{table}.product_set_id,{table}.order_title,{table}.start_time,{table}.order_status,{table}.buyer_account_id,{table}.end_time,{table}.remark,{table}.create_time,{prefix}account.username,{prefix}account.phone');
        $rs =  Data_Mysql_Table_Order_Info::select($cols, $condition,'',1,'{table} LEFT JOIN {prefix}account ON {table}.buyer_account_id = {prefix}account.id');
        if (empty($rs[0]['id'])) {
            return self::request('error','','订单不存在！！');
        };
        if (!empty($rs[0]['product_id'])) {
            $product = Data_Mysql_Table_Product_Search::select('logo', array('id'=>$rs[0]['product_id']));
            $rs[0]['logo']=empty($product[0]['logo'])?'':'http://' . Core::$urls['host'] . Page_Site_Global::displayLogo($product[0]['logo'], 100, 100);
        }
        if (!empty($rs[0]['product_set_id'])) {
            $set = Data_Mysql_Table_Product_Set::select('logo', array('id'=>$rs[0]['product_set_id']));
            $rs[0]['logo']=empty($set[0]['logo'])?'':'http://' . Core::$urls['host'] . Page_Site_Global::displayLogo($set[0]['logo'], 100, 100);
        }
        $rs[0]['order_status_text'] = Api_Order_Normal_Api::getOrderStatusTpl($rs[0]['order_status']);
        $rs[0]['create_time'] = date("Y-m-d h:i:s", $rs[0]['create_time']);
        $rs[0]['start_time'] = date("Y-m-d h:i:s", $rs[0]['start_time']);
        $rs[0]['end_time'] = date("Y-m-d h:i:s", $rs[0]['end_time']);

        $rs2 = Data_Mysql_Table_Account::select('phone,username', array('id' => $rs[0]['buyer_account_id']));
        if(empty($rs2[0])){
            return self::request('error','','用户不存在！！');
        }
        $data = array_merge($rs[0], $rs2[0]);
        return self::request('success',$data,'获取订单信息成功！！');
    }

    //获取所有买家下的订单列表
    static function getOrderListApp(){
        $request = Func_Input::filter(array(
            'user_id' => 'int',
            'from_id' => 'int',
            'status_filter'=>'int',
            'last_id'=>'id',
        ), $_REQUEST);

        $condition['vendor_account_id =?'] = $request['user_id'];
        $condition['{table}.status = ?'] = 1;
//        $condition['order_status >= ?'] = 0;
        $msg = '您还没有订单，登录云·SPACE官网获取更多操作！';

        if (!empty($request['from_id'])) {
            $condition['buyer_account_id =?'] = $request['from_id'];
            $msg = '该联系人还没有订单，登录云·SPACE官网获取更多操作！';
        }
        if (!empty($request['last_id'])) {
            $condition['{table}.id < ?']= $request['last_id'];
        }

        //状态筛选
        if (!empty($request['status_filter'])) {
            switch ($request['status_filter']) {
                case -9:
                    //已关闭
                    $condition['{table}.status != ?'] = 1;
                    break;
                case -10:
                    //已取消
                    $condition[] = "order_status < 0";
                    break;
                case 1:
                    //待审核
                    $condition[] = "order_status < 5 AND order_status >=0";
                    break;
                case 2:
                    //待签约
                    $condition[] = "order_status >4 AND order_status < 12";
                    break;
                case 3:
                    //待支付
                    $condition[] = "order_status > 11 AND order_status < 15";
                    break;
//                case 4:
//                    //待评价
//                    $condition[] = "order_status > 14 AND order_status < 90";
//                    break;
                case 5:
                    //已完成
                    $condition[] = "order_status > 14 AND order_status < 100";
                    break;
            }
        }
        $cols=array('{table}.id,{table}.order_no,{table}.product_id,{table}.product_set_id,{table}.order_title,{table}.start_time,{table}.order_status,{table}.buyer_account_id,{table}.end_time,{table}.remark,{table}.create_time,{prefix}account.username,{prefix}account.phone');
        $rs =  Data_Mysql_Table_Order_Info::select($cols, $condition,'ORDER BY {table}.id DESC',15,'{table} LEFT JOIN {prefix}account ON {table}.buyer_account_id = {prefix}account.id');
        if (empty($rs[0]['id'])) {
            return self::request('error','',$msg);
        };
        $data_product=$data_set = array();
        foreach ($rs as $k => $v) {
            $ids[] = $v['product_id'];
            $set_ids[] = $v['product_set_id'];
        }
        if(!empty($ids)){
            $product = Data_Mysql_Table_Product_Search::select('id,logo', array("id IN (" . implode(',', $ids) . ")"));
            foreach ($product as $key => $val) {
                $data_product[$val['id']]['logo'] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayLogo($product[$key]['logo'], 100, 100);
            }

        }
        if(!empty($set_ids)){
            $set = Data_Mysql_Table_Product_Set::select('id,logo', array("id IN (" . implode(',', $set_ids) . ")"));
            foreach ($set as $key => $val) {
                $data_set[$val['id']]['logo'] = 'http://' . Core::$urls['host'] . Page_Site_Global::displayLogo($set[$key]['logo'], 100, 100);
            }

        }
        foreach ($rs as $k => $v) {
            if (!empty($v['product_id'])) {
                $rs[$k]['logo']=empty($data_product[$v['product_id']]['logo'])?'':$data_product[$v['product_id']]['logo'];
            }
            if (!empty($v['product_set_id'])) {
                $rs[$k]['logo']=empty($data_set[$v['product_set_id']]['logo'])?'':$data_set[$v['product_set_id']]['logo'];
            }
            $rs[$k]['order_status_text'] =Api_Order_Normal_Api::getOrderStatusTpl($rs[$k]['order_status']);
            $rs[$k]['update_time'] = date("Y-m-d h:i:s", $rs[$k]['update_time']);
            $rs[$k]['create_time'] = date("Y-m-d h:i:s", $rs[$k]['create_time']);
            $rs[$k]['start_time'] = date("Y-m-d h:i", $rs[$k]['start_time']);
            $rs[$k]['end_time'] = date("Y-m-d h:i", $rs[$k]['end_time']);
        }
        return self::request('success',$rs,'获取订单列表');
    }

    //获取订单某状态下的总数
    static function  getCountOrderByOrderStatus(){
        $request = Func_Input::filter(array(
            'user_id' => 'int',
        ), $_REQUEST);
        if(empty($request['user_id'])){
            return self::request('error','','参数错误3!');
        }
        $account = Finance_Account::getAccountInfo($request['user_id']);

        $conditions = array(
            'vendor_account_id' => $request['user_id'],
            'status'=>1,
        );

        $orders = Data_Mysql_Table_Order_Info::select('count(id) as c, order_status', $conditions, 'GROUP BY order_status', 300);
        $status_count=Data_Mysql_Table_Order_Info::$counter;
        foreach ($orders as $v) {
            $status_count[0][1] += $v['c'];
            if ($v['order_status'] < 0) {
                $status_count[-10][1] += $v['c'];
            } elseif ($v['order_status'] < 5 && $v['order_status']>=0) {
                $status_count[1][1] += $v['c'];
            } elseif ($v['order_status'] > 4 && $v['order_status'] < 12) {
                $status_count[2][1] += $v['c'];
            } elseif ($v['order_status'] > 11 && $v['order_status'] < 15) {
                $status_count[3][1] += $v['c'];
//            } elseif ($v['order_status'] > 14 && $v['order_status'] < 90) {
//                $status_count[4][1] += $v['c'];
            } elseif ($v['order_status'] > 14 && $v['order_status'] < 100) {
                $status_count[5][1] += $v['c'];
            }
        }
        //获取所有已关闭（status==-9或status==3）的订单
        $con['status != ?']=1;
        $con['vendor_account_id']=$request['user_id'];
        $close_rs = Data_Mysql_Table_Order_Info::select('count(id) as c', $con);
        if(!empty($close_rs)){
            $status_count[-9][1] += $close_rs[0]['c'];
        }
        $status_count[0][1] += $status_count[-9][1];
        $return=array();
        $i=0;
        foreach($status_count as $k=>$v){
            $return[$i]['status_text']=$v[0];
            $return[$i]['status']=$k;
            $return[$i]['count']=$v[1];
            $i++;
        }
        $data = array(
            'balance' => $account['balance'],
            'orders' => $return,
        );
        return self::request('success',$data,'获取订单各状态下的总数');
    }

    //订单审核通过
    static function acceptOrder()
    {
       $request=Func_Input::filter(array(
           'order_id'=>'int',
           'user_id'=>'int',
       ));
        if(empty($request['order_id']) || empty($request['user_id'])){
            return self::request('error','','参数错误！！');
        }
        $check=self::checkOrderByUserId($request['user_id'],$request['order_id']);
        if(!$check){
            return self::request('error','','没有权限！！');
        }
        $r = Data_Mysql_Table_Order_Info::update($request['order_id'], array(
            'vendor_account_id' => $request['user_id'],
            'create_time2' => time(),
            'order_status' => 5,
        ));
        if (empty($r[0])) {
            return self::request('error','','操作失败，请稍候再试或联系客服人员！');
        }

        //更新档期
        Data_Mysql_Table_Product_Schedule::update(array('order_id' =>$request['order_id'],), array('status' => 1));
        //审核通过发通知
        $orderinfo=Data_Mysql_Table_Order_Info::select('order_no,buyer_account_id', array(
            'id' =>$request['order_id'],
        ));
        Api_Order_Send_Message::sendPendingMsg($orderinfo[0]['order_no'],$orderinfo[0]['buyer_account_id']);
        //添加订单追踪信息
        Api_Order_Normal_Api::setTracking('订单审核通过',$request['order_id'],'服务方');
        return self::request('success','','操作成功！');
    }
    //拒绝订单
    static function refuseOrder()
    {
        $request=Func_Input::filter(array(
            'order_id'=>'int',
            'user_id'=>'int',
            'refuse_reason'=>'string',
        ));
        if(empty($request['order_id']) || empty($request['user_id'])){
            return self::request('error','','参数错误！！');
        }
        if(empty($request['refuse_reason'])){
            return self::request('error','','拒绝理由不能为空！！');
        }
        $check=self::checkOrderByUserId($request['user_id'],$request['order_id']);
        if(!$check){
            return self::request('error','','没有权限！！');
        }
        $reason['reason']=$request['refuse_reason'];
        $reason['is_vendor']=1; //供应商取消订单
        $r = Data_Mysql_Table_Order_Info::update($request['order_id'], array(
            'order_status' => -1,
            'cancel_time' => time(),
            'order_close_info'=>$reason,
        ));
        if (empty($r[0])) {
            return self::request('error','','操作失败，请稍候再试或联系客服人员！');
        }

        //审核通过发通知
        $orderinfo=Data_Mysql_Table_Order_Info::select('product_id,product_set_id,start_time,end_time', array(
            'id' =>$request['order_id'],
        ));
        //删除档期
        if(!empty($orderinfo[0]['product_id'])){
            Api_Order_Delete_Schedule::deleteSchedule($orderinfo[0]['product_id'],'product',$orderinfo[0]['start_time'],$orderinfo[0]['end_time']);
        }elseif(!empty($orderinfo[0]['product_set_id'])){
            Api_Order_Delete_Schedule::deleteSchedule($orderinfo[0]['product_set_id'],'set',$orderinfo[0]['start_time'],$orderinfo[0]['end_time']);
        }
        //添加订单追踪信息
        Api_Order_Normal_Api::setTracking('订单已取消',$request['order_id'],'服务方');
        return self::request('success','','订单取消成功！');
    }

    //验证订单是否为该用户订单
   static function checkOrderByUserId($userId,$orderId){
       $r = Data_Mysql_Table_Order_Info::select('id', array(
           'vendor_account_id' => $userId,
           'id' =>$orderId,
       ));
       if(empty($r[0])){
           return false;
       }
       return true;
   }
}