<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/7/9
 * Time: 10:10
 * 订单详情
 */
class Api_Order_Info extends Api
{
    static $_orderInfo;

    /*
     * @获取订单信息
     * @ param $orderNo:订单编号
     * @ return array(状态，数据，信息);
     */
    static function getOrderInfo($orderNo)
    {
        $r = Data_Mysql_Table_Order_Info::select('*', array(
            'order_no = ?' => $orderNo,
        ));
        if (empty($r[0]['id'])) {
            return self::request('error','','参数错误！！');
        }
        self::$_orderInfo = $r[0];
        //判断是否是买家
        self::$_orderInfo['is_buyer'] = $_SESSION['user']['id'] == self::$_orderInfo['buyer_account_id'];
        //判断是否是卖家
        self::$_orderInfo['is_vendor'] = self::$_orderInfo['vendor_account_id'] ? self::$_orderInfo['vendor_account_id'] == $_SESSION['user']['id'] : $_SESSION['user']['super_vendor'];
        if (!self::$_orderInfo['is_buyer'] && !self::$_orderInfo['is_vendor']) {
            return self::request('error','','操作错误！！');
        }
        self::$_orderInfo['order_detail'] = json_decode(self::$_orderInfo['order_detail'], 1);
        self::$_orderInfo['order_conform'] = json_decode(self::$_orderInfo['order_conform'], 1);
        self::$_orderInfo['order_tracking'] = json_decode(self::$_orderInfo['order_tracking'], 1);
        self::$_orderInfo['start_date'] = self::$_orderInfo['start_time'] ? date('Y-m-d', self::$_orderInfo['start_time']) : '';
        self::$_orderInfo['order_close_info'] =json_decode(self::$_orderInfo['order_close_info'], 1) ;
        if(!empty(self::$_orderInfo['create_time3'])){
            self::handleStep4();
        }
        if(!empty(self::$_orderInfo['create_time2'])){
            self::handleStep2();
            self::handleStep3();
        }
//        if(!empty(self::$_orderInfo['create_time2'])){
//            //如果没有要签约的合同，支付订单
//            $not_conform=Api_Order_Normal_Api::getConformAmountAndList(self::$_orderInfo['id'],1,0);
//            if(empty($not_conform['data'])){
//                //更改订单签约时间,订单状态和订单金额
//                $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
//                     'create_time3' => time(),
//                ));
//            }else{
//                $_REQUEST['tab']=2;
//            }
//        }

        if(!empty(self::$_orderInfo['order_price_pay'])){
            $evaluate=Api_Order_Normal_Api::getOrderEvaluate(self::$_orderInfo);
            self::$_orderInfo['evaluate']=$evaluate;
//            //活动时间已过，评价订单
//            if(time()>self::$_orderInfo['end_time'] && !$evaluate){
//                Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
//                    'order_status' => 80,
//                ));
//            }
//            之前已完成，且已评价，更改订单状态为90
//            if(self::$_orderInfo['create_time5'] && $evaluate){
//                Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
//                    'order_status' => 90,
//                ));
//            }
        }

        self::handleTab();
        Data_Config_Site::seo('订单详情: [' . self::$_orderInfo['order_no'] . '] ' . self::$_orderInfo['order_title']);
        return self::request('success',self::$_orderInfo,'获取订单信息');
    }

    /*
     * @验证交易密码
     * @ param null
     * @ return null;
     */
    static function checkPassword2($password2)
    {
        if (empty($password2) || !Data_Mysql_Table_Account::checkPassword2($password2)) {
            return self::request('error','','交易密码错误');
        }
    }

    /*
    * @设置默认显示的 tab
    * @ param null
    * @ return null;
    */
    static function handleTab()
    {
      if (empty($_REQUEST['tab'])) {
            if (self::$_orderInfo['create_time5']) {
                $_REQUEST['tab'] = 4;
            } elseif (self::$_orderInfo['create_time3']) {
                $_REQUEST['tab'] = 3;
            } elseif (self::$_orderInfo['create_time2']) {
                $_REQUEST['tab'] = 2;
            } else {
                $_REQUEST['tab'] = 1;
            }
        }elseif($_REQUEST['tab']==4  && (self::$_orderInfo['order_price'] != self::$_orderInfo['order_price_pay'])){
            $_REQUEST['tab'] = 3;
        }

    }

    static function handleStep2()
    {
        if (empty(self::$_orderInfo['order_conform']['买家签约代表'])) {
            //加载买家信息
            $r = Data_Mysql_Table_Account::select('phone, attr', array('id' => self::$_orderInfo['buyer_account_id']));
            if (empty($r[0])) {
                return self::request('error','','买家信息不存在！');
            }
            $buyer = $r[0];
            $buyer['attr'] = json_decode($buyer['attr'], 1);
            if (!empty($buyer['attr']['identity']['data']['公司名称'])) {
                self::$_orderInfo['order_conform']['买家名称'] = $buyer['attr']['identity']['data']['公司名称'];
                self::$_orderInfo['order_conform']['买家签约代表'] = $buyer['attr']['identity']['data']['法人代表'];
                self::$_orderInfo['order_conform']['买家地址'] = $buyer['attr']['identity']['data']['公司地址'];
                self::$_orderInfo['order_conform']['买家电话'] = $buyer['attr']['identity']['data']['公司电话'];
                self::$_orderInfo['order_conform']['买家传真'] = $buyer['attr']['identity']['data']['传真号码'];
            } else if (!empty($buyer['attr']['identity']['data']['真实姓名'])) {
                self::$_orderInfo['order_conform']['买家名称'] = $buyer['attr']['identity']['data']['真实姓名'];
                self::$_orderInfo['order_conform']['买家签约代表'] = $buyer['attr']['identity']['data']['真实姓名'];
                self::$_orderInfo['order_conform']['买家电话'] = $buyer['phone'];
            } else {
                self::$_orderInfo['order_conform']['买家名称'] = '未认证';
                self::$_orderInfo['order_conform']['买家签约代表'] = '';
            }
        }
        if (empty(self::$_orderInfo['order_conform']['供应商名称'])) {
            //加载卖家信息
            $r = Data_Mysql_Table_Account::select('phone, attr', array('id' => self::$_orderInfo['vendor_account_id']));
            if (empty($r[0])) {
                return self::request('error','','卖家信息不存在！');

            }
            if (!empty($r[0])) {
                $vendor = $r[0];
                $vendor['attr'] = json_decode($vendor['attr'], 1);
                if (!empty($vendor['attr']['identity']['data']['公司名称'])) {
                    self::$_orderInfo['order_conform']['供应商名称'] = $vendor['attr']['identity']['data']['公司名称'];
                    self::$_orderInfo['order_conform']['供应商签约代表'] = $vendor['attr']['identity']['data']['法人代表'];
                    self::$_orderInfo['order_conform']['供应商地址'] = $vendor['attr']['identity']['data']['公司地址'];
                    self::$_orderInfo['order_conform']['供应商电话'] = $vendor['attr']['identity']['data']['公司电话'];
                    self::$_orderInfo['order_conform']['供应商传真'] = $vendor['attr']['identity']['data']['传真号码'];
                } else if (!empty($vendor['attr']['identity']['data']['真实姓名'])) {
                    self::$_orderInfo['order_conform']['供应商名称'] = $vendor['attr']['identity']['data']['真实姓名'];
                    self::$_orderInfo['order_conform']['供应商签约代表'] = $vendor['attr']['identity']['data']['真实姓名'];
                    self::$_orderInfo['order_conform']['供应商电话'] =$vendor['phone'];
                } else {
                    self::$_orderInfo['order_conform']['供应商名称'] ='未认证';
                    self::$_orderInfo['order_conform']['供应商签约代表'] ='';
                }
            }
        }
    }

    //加载付款信息
    static function handleStep3()
    {
        self::$_orderInfo['payment'] = Finance_Payment::getListByOrderId(self::$_orderInfo['id'], self::$_orderInfo['create_time2']);
        $payment_amount = Api_Order_Normal_Api::getPaymentAndAmount(self::$_orderInfo);
        self::$_orderInfo['total_payment_amount'] = $payment_amount['total_amount'];
        if (self::$_orderInfo['order_price_pay']!=0 && (self::$_orderInfo['order_price']==self::$_orderInfo['order_price_pay']) && self::$_orderInfo['order_status'] < 70 && self::$_orderInfo['order_status'] >0) {
            Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
                'create_time4' => self::$_orderInfo['create_time4'],
                'order_price_last' => self::$_orderInfo['order_price_pay'],
                'order_status' => 15,
            ));
        }
    }

    //更改订单金额
    static function handleStep4(){
        //获取已签约合同的总金额
        $conform=Api_Order_Normal_Api::getConformAmountAndList(self::$_orderInfo['id'],1,1);
        $amount=$conform['total_amount'];
        if(!empty($amount)){
            $r = Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
                'order_price' => $amount,
            ));
            self::$_orderInfo['order_price']=$amount;
        }
        //获取已支付的总金额（包含线上支付和线下支付）
        $payment_return=Api_Order_Info::getPaymentInfo();

        //获取所有已支付信息
        $paymen_amount=0;
        if(!empty($payment_return['data'])){
            self::$_orderInfo['total_pay_amount']=$payment_return['data']['total_amount'];
        }

    }

    //获取订单的所有支付信息
    static function getPaymentInfo(){
        $paymentInfo=array();
        $payment_info=Data_Mysql_Table_Order_Payment::select('*',array('order_id'=>self::$_orderInfo['id']),'ORDER BY create_time DESC',50);
        $amount=0;
//       q($payment_info);
        if(!empty($payment_info)){
            foreach($payment_info as $k=>$v){
                $v['payment_info']=json_decode($v['payment_info'],1);
                $paymentInfo[$v['payment_id']]=$v;
                $amount+=$v['payment_amount'];
            }
        }
        $return['data']=$paymentInfo;
        $return['total_amount']=$amount;
        return self::request('success',$return,'返回支付信息');
    }

    //获取订单指定paymentId的支付信息
    static function getPaymentInfoByPayId($paymentId){
        $payment_info=array();
        $payment_info=Data_Mysql_Table_Order_Payment::select('*',array('payment_id'=>$paymentId));
        if(!empty($payment_info[0])){
            $payment_info[0]['payment_info']=json_decode($payment_info[0]['payment_info'],1);
            $payment_info[0]['payment']=Finance_Payment::getPaymentInfoById($paymentId);
        }
        return self::request('success',$payment_info[0],'返回指定的支付信息');
    }

}