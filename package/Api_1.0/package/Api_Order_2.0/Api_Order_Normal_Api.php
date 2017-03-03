<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-7-13
 * Time: 上午10:50
 */
class Api_Order_Normal_Api extends Api{
    /*
     * @创建支付节点
     * @$node array 节点数组;
     */
    static function resolveCreatePaymentInfo($node,$orderInfo,$is_full=0)
    {
        if(!is_array($node)){
            return self::request('error','','参数类型错误！！');
        }
//        if($orderInfo['order_price'] < ($node['金额'] + $orderInfo['total_payment_amount'])){
//            return self::request('error','','创建的款项总金额已超过签约总金额！！');
//        }
        //判断当前创建的已支付的支付节点是否已超过订单总金额
        if($orderInfo['order_price'] < ($node['金额'] + $orderInfo['total_pay_amount'])){
            return self::request('error','','请删除已有线下支付信息或者等待供应商确认后，再创建新的支付信息！');
        }

        if($orderInfo['order_price'] < ($node['金额'] + $orderInfo['order_price_pay'])){
            return self::request('error','','支付金额不能超过最大支付金额！！');
        }
        $buyer_bank_info = Finance_Account::getAccountInfo($orderInfo['buyer_account_id']);
        $buyer_bank_info['account_name']=empty($buyer_bank_info['account_name'])?$orderInfo['order_conform']['买家名称']:$buyer_bank_info['account_name'];
        $target_bank_info = Finance_Account::getAccountInfo($orderInfo['vendor_account_id']);
        $target_bank_info['account_name']=empty($target_bank_info['account_name'])?$orderInfo['order_conform']['供应商名称']:$target_bank_info['account_name'];
        $payment_detail=array(
            'order_no' => $orderInfo['order_no'],
            'agreement_title' => $node['名称'],
            'buyer_account_id' => $orderInfo['buyer_account_id'],
            'buyer_account_name' => $orderInfo['order_conform']['买家名称'],
            'vendor_account_name' => $orderInfo['order_conform']['供应商名称'],
            'pay_account_name' => $buyer_bank_info['account_name'],     //付款对象
            'getpay_account_name' => $target_bank_info['account_name'],  //收款对象
            'vendor_account_id' => $orderInfo['vendor_account_id'],
            'vendor_id' => $orderInfo['vendor_id'],
            'payment_title' => $node['名称'],
            'payment_percent' =>round($node['金额'] / $orderInfo['order_price'] ,2)*10000,
            'is_in_order' => true,
            'deal_account_id' => $orderInfo['deal_account_id'], //经纪人
            'order_commission_deal' => ceil($orderInfo['order_commission_deal_per'] * $orderInfo['order_price'] / 10) / 10,
            'payment_demo'=>$node['名称'],
            'is_full'=>$is_full,
        );

        //添加付款对账单
         $rs=Finance_Payment::createReceive($orderInfo['buyer_account_id'], $orderInfo['vendor_account_id'], $orderInfo['id'], '('.$node['名称'] . ') ' . $orderInfo['order_title'], $node['金额'],$payment_detail);
        if($rs){
            Api_Order_Normal_Api::setTracking('创建新的支付款项【￥'.$node['金额'].'】',$orderInfo['id'],'服务方');
            return self::request('success',$rs,'成功创建新的支付款项!!');
        }else{
            return self::request('error','','创建新的支付款项失败，可能是由于支付备注相同');
        }
    }

    /*
    * @修改支付节点
    * @$data array 修改的信息数组;
    */
    static function updatePaymentInfo($data,$orderInfo)
    {
        if(!is_array($data)){
            return self::request('error','','参数类型错误！！');
        }
        if(empty($data['payment_id']) || empty($data['金额']) || empty($data['名称'])){
            return self::request('error','','参数错误！！');
        }
        //获取更新之前支付节点的金额
        $payment = Finance_Payment::getPaymentInfoById($data['payment_id']);
        if (empty($payment['id']) || empty($payment['payment_detail']['order_no'])) {
            return self::request('error','','未找到该笔款项！！');
        }
        if (!empty($payment['payment_time'])) {
            return self::request('error','','该笔款项已支付!');
        }
//        if($orderInfo['order_price'] < ($data['金额'] + $orderInfo['total_payment_amount']-$payment['amount'])){
//            return self::request('error','','更新的款项总金额已超过签约总金额！！');
//        }
        if($orderInfo['order_price'] < ($data['金额'] + $orderInfo['order_price_pay'])){
            return self::request('error','','支付金额不能超过最大支付金额！！');
        }
        $update_data['payment_title']=$data['名称'].' '.$orderInfo['order_title'];
        $update_data['名称']=$data['名称'];
        $update_data['支付备注']=$data['支付备注'];
        $update_data['金额']=$data['金额'];
        $update_data['payment_percent']=round($data['金额'] / $orderInfo['order_price'] ,2)*10000;
        $rs=Finance_Payment::updateReceive($data['payment_id'],$update_data);
        if($rs){
            return self::request('success','','成功修改支付款项!!');
        }else{
            return self::request('error','','支付款项修改失败!!');
        }
    }


    /*
     * @删除支付节点
     * @$node array 节点数组;
     */
    static function deletePaymentInfo($paymentId,$amount,$orderInfo)
    {
        if(!$paymentId){
            return self::request('error','','参数错误！！');
        }
        if(strpos($paymentId,'P') === false){
            $paymentId= 'P' . date('Ym') . str_pad($paymentId, 9, '0', STR_PAD_LEFT);
        }
        $rs=Finance_Payment::deletePaymentByPid($paymentId);
        if(!$rs){
            return self::request('error','','删除失败!!');
        }
        //删除order_payment中的信息
        Data_Mysql_Table_Order_Payment::delete(array('payment_id'=>$paymentId,'order_id'=>$orderInfo['id']));

        Api_Order_Normal_Api::setTracking('删除支付款项【￥'.$amount.'】',$orderInfo['id'],'服务方');
        return self::request('success','','成功删除支付款项!!');
    }

    /*
     * @获取账户的银行卡信息
     * @$accountId  int 账户ID;
     */
    static function getBankInfo($accountId)
    {
        $bank_info = array();
        $banks = Web_User_Center_Money::$banks;
        //获取收款对象的银行卡信息
        $bank_account = Finance_Account::getAccountInfo($accountId);
        if(!empty($bank_account['bank_account'])){
            foreach($bank_account['bank_account'] as $k=>$v){
                $bank_account['bank_account'][$k][4]=$banks[$v[1]];
            }
        }
        return $bank_account;
    }

    /*
     * 订单追踪
     * @param   $content:追踪内容
     * @param   $order_id:订单id
     * @return null
     */
    static function setTracking($content='产品预订',$order_id,$operator='采购方'){
        $order=Data_Mysql_Table_Order_Info::select('order_tracking',$order_id);
        $order_tracking=json_decode($order[0]['order_tracking'],1);
        $track_info=array('更新时间'=>time(),'操作内容'=>$content,'操作人'=>$operator);
        if(!empty($order_tracking)){
            $order_tracking[count($order_tracking)]=$track_info;
        }else{
            $order_tracking[0]=$track_info;
        }
        $r = Data_Mysql_Table_Order_Info::update($order_id, array(
            'order_tracking' => $order_tracking,
        ));
    }

    /*
     * 获取某个订单的所有合同和合同总金额
     * @param   $order_id:订单id
     * @return  $data:该订单下的所有合同
     */
//    static function getConformByOrderId($order_id){
//        $data=array();
//        $amount=0;
//        $data=Data_Mysql_Table_Order_Conform::select('*',array('order_id'=>$order_id),'ORDER BY update_time DESC',100);
//        if(!empty($data)){
//            foreach($data as $k=>$v){
//                $data[$k]['conform_path']=json_decode($v['conform_path'],1);
//                $amount+=$v['conform_amount'];
//            }
//        }
//        $return['data']=$data;
//        $return['total_amount']=$amount;
//        return $return;
//    }

    /*
     * 获取指定合同的详细信息
     * @param   $cid:合同id
     * @return  $data:指定合同信息
     */
    static function getConformInfoById($cid){
        $data=array();
        $data=Data_Mysql_Table_Order_Conform::select('*',array('id'=>$cid));
        if(!empty($data[0])){
            $data[0]['conform_path']=json_decode($data[0]['conform_path'],1);
        }
        return $data[0];
    }

    /*
     * 获取订单所有合同某状态下的总金额
     * @param   $order_id:订单id
     * @param   $status:合同状态
     * @param   $is_status:是否限制合同状态 1 指定状态下的合同  0 所有合同
     * @return  $data:该订单下的所有合同某状态下的总金额
     */
    static function getConformAmountAndList($order_id,$is_status=1,$status=1){
        $amount=0;
        $data=array();
        if(!empty($is_status)){
            $condition['status']=$status;
        }
        $condition['order_id']=$order_id;
        $data=Data_Mysql_Table_Order_Conform::select('*',$condition,'',100);
        if(!empty($data)){
            foreach($data as $k=>$v){
                $amount+=$v['conform_amount'];
                $data[$k]['conform_path']=json_decode($v['conform_path'],1);
            }
        }
        $return['data']=$data;
        $return['total_amount']=$amount;
        return $return;
    }
    /*
    * 获取订单所有支付节点的总金额
    * @param   $orderInfo:订单信息
    * @return  $data:该订单下所有支付节点和总金额
    */
    static function getPaymentAndAmount($orderInfo){
        $amount=0;
        $data=array();
        $data=Data_Mysql_Table_Finance_Payment::subTable('_'.date('Ym',$orderInfo['create_time2']))->select('*',array('order_id'=>$orderInfo['id']),'',100);
        if(!empty($data)){
            foreach($data as $k=>$v){
                $data[$k]['payment_detail']=json_decode($data[$k]['payment_detail'],1);
                if(empty($data[$k]['payment_detail']['is_full'])){
                    $amount+=$v['amount'];
                }
            }
        }
        $return['data']=$data;
        $return['total_amount']=$amount;
        return $return;
    }
    /*
    * 获取订单的评价
    * @param   $orderInfo:订单信息
    * @return  $data:该订单的评价
    */
    static function getOrderEvaluate($orderInfo){
        $data=array();
        $data=Data_Mysql_Table_Order_Evaluate::select('*',array('order_id'=>$orderInfo['id']));
        if(!empty($data[0])){
           return $data[0];
        }
        return $data;
    }

    //获取订单列表的所有状态对应的文字
    static function getOrderStatusTpl($order_status,$status=1)
    {
        $order_status_text='';
        if($status == 1){
            if ($order_status < 0) {
                $order_status_text ='已取消' ;
            }  elseif ($order_status >=0 && $order_status < 5) {
                $order_status_text ='待审核' ;
            } elseif ($order_status > 4 && $order_status < 12) {
                $order_status_text ='待签约' ;
            } elseif ($order_status > 11 && $order_status < 15) {
                $order_status_text ='待支付' ;
//            } elseif ($order_status > 14 && $order_status < 90) {
//                $order_status_text ='待评价' ;
            } elseif ($order_status > 14 && $order_status < 100) {
                $order_status_text ='已完成' ;
            }
        }else{
            $order_status_text ='已关闭' ;
        }
        return $order_status_text;
    }

    /*
      * 获取某个产品或供应商的订单总数
      * @param   $type:类别  product  产品；vendor 供应商
     * @param    $id 供应商或产品id
      * @return  $data：订单信息，订单总数，已完成订单数
      */
    static function getOrder($type = 'product',$id)
    {
        //获取该产品或供应商下已完成的订单信息
        $condition = array();
        $return = array();
        if ($type == 'product') {
            $condition['{table}.product_id = ?'] = $id;
        } elseif ($type == 'vendor') {
            $condition['{table}.vendor_id = ?'] = $id;
        }
        $orderInfo = Data_Mysql_Table_Order_Info::select('count(*) as total_order,{prefix}account.username,{table}.order_no,{table}.order_complete,{table}.product_id', $condition, 'ORDER BY {table}.update_time desc', 999999, '{table} LEFT JOIN {prefix}account ON {table}.buyer_account_id = {prefix}account.id');
        if (!empty($orderInfo[0])) {
            foreach ($orderInfo as $key => $value) {
                $orderInfo[$key]['order_complete'] = json_decode($value['order_complete'], 1);
            }
            $total_order = empty($orderInfo[0]['total_order']) ? 0 : $orderInfo[0]['total_order'];//总订单量
            $complete = Data_Mysql_Table_Order_Info::select('count(*) as c', array('product_id' => $id, 'order_status' => 90));
            if (!empty($complete)) {
                $complete_order = $complete[0]['c'];//已完成订单量
            }

        }
        $return['order_info'] = empty($orderInfo[0]) ? array() : $orderInfo[0];;
        $return['total_order'] = empty($total_order) ? 0 : $total_order;;
        $return['complete_order'] = empty($complete_order) ? 0 : $complete_order;
        return $return;
    }
}