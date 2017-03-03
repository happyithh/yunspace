<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/7/13
 * Time: 10:10
 * 订单支付
 */
@session_start();
class Api_Order_Pay extends Api
{
    static $banks = array(
        'b2b' => array(
            '70' => 'bank_icbc.gif',//'工行B2B',
            '71' => 'bank_abc.gif',//'农行B2B',
            '82' => 'bank_ccb.gif',//'建行B2B新',
            '78' => 'bank_cmb.gif',//'招行B2B',
            '74' => 'bank_ceb.gif',//'光大B2B',
            '76' => 'bank_spdb.gif',//'浦发B2B',
        ),
        'b2c' => array(
            '23' => 'bank_cmb.gif',//'招行借贷',
            '13' => 'bank_hxb.gif',//'华夏',
            '09' => 'bank_cib.gif',//'兴业',
            '12' => 'bank_cmbc.gif',//'民生',
            '25' => 'bank_icbc.gif',//'工商行',
            '15' => 'bank_bob.gif',//'北京',
            '16' => 'bank_spdb.gif',//'浦发',
            '19' => 'bank_gdb.gif',//'广发',
            '27' => 'bank_ccb.gif',//'建设行',
            '21' => 'bank_bcom.gif',//'交行',
            '49' => 'bank_njcb.gif',//'南京银行',
            '33' => 'bank_citic.gif',//'中信',
            '45' => 'bank_boc.gif',//'中行',
            '40' => 'bank_bjrcb.gif',//'北农商',
            '36' => 'bank_ceb.gif',//'光大',
            '46' => 'bank_post.gif',//'邮储',
            '29' => 'bank_abc.gif',//'农业行',
            '50' => 'bank_pab.gif',//'平安银行',
            '51' => 'bank_hzb.gif',//'杭州银行',
            '53' => 'bank_czb.gif',//'浙商',
            '54' => 'bank_shb.gif',//'上海银行',
            '55' => 'bank_cbhb.gif',//'渤海银行',
        ),
    );
    static function handle($args=''){
        if($args['action']=='balance_pay'){
            if(empty($args['payment_id'])){
                return self::request('error','','参数错误！！');
            }
            $payment = Finance_Payment::getPaymentInfoById($args['payment_id']);
            if (empty($payment['id']) || empty($payment['payment_detail']['order_no'])) {
                return self::request('error','','未找到该笔款项！！');
            }
            if (!empty($payment['payment_time'])) {
                return self::request('error','','该笔款项已支付!');
            }
            $args['payment']=$payment;
        }

        return self::handlePay($args);
    }
    static function handlePay($args)
    {
        $action = $args['action'];
        $payment=$args['payment'];
        switch ($action) {
            case 'bank':
                $data=self::handleSelectBank($payment);
                break;
            case 'balance_pay':
                $payment['pay_method'] = '账户支付';
                $data = self::handleBalancePay($payment);
                break;
            case 'online_pay':
                $payment['pay_method'] = '在线支付';
                $data = self::handleOnlinePay($payment);
                break;
            case 'return':
                $payment['pay_method'] = '在线支付';
                $data = self::handleReturn($payment);
                break;
            case 'notify':
                $data = self::handleNotify($payment);
                break;
            default:
                $data = self::request('error', '', '失败');
                break;
        }
        return $data;
    }

    static function handleSelectBank($payment)
    {
        $_REQUEST['tab']=6;
        //获取对账单的支付信息
//        $paymentInfo=array();
//        $payment_info=Data_Mysql_Table_Order_Payment::select('*',array('payment_id'=>$payment['payment_id']));
//        if(!empty($payment_info[0])){
//            $payment_info[0]['payment_info']=json_decode($payment_info[0]['payment_info'],1);
//            $paymentInfo=$payment_info[0];
//        }
        $account = Finance_Account::getAccountInfo($payment['target_account_id']);
        $return['account']=$account;
//        $return['payment_info']=$paymentInfo;
        return $return;
    }

    static function handleOnlinePay($payment)
    {
        Web_Account::handleAccountHasAuth('支付', 1);
        Web_Account::handleIsLogin();
        $request = Func_Input::filter(array(
            'bank' => 'int',
        ));
        $paymentOrderId = str_pad($payment['account_id'], 8, '0', STR_PAD_LEFT) . date("md") . str_pad($payment['id'], 4, '0', STR_PAD_LEFT);
        //Agent:user1:50.00;Agent:user2:800.00
        //1.商户号请填入你从汇付获得的六位商户号.<br>
        //2.订单号请与贵网站系统中的唯一订单号匹配.<br>
        //3.页面返回地址--当支付完成后跳转回贵网站系统的页面地址.<br>
        //4.后台返回地址--当支付完成后异步返回贵网站系统的地页面地址.<br>
        //5.网关号--当输入此项后，支付页面将直接跳转到网关号所对应的银行支付页面（您可向客服人员索取网关号）.<br>
        //6.分账明细--当存在一笔支付金额分发给不同的商户时使用，无此情况请留空.<br>
        //7.付款人用户号--如果付款人在汇付有账号，请填入此项.
        if ($request['bank'] > 1000) { //银联
            Payment_UnionPay_Buy::handle($paymentOrderId, $payment['amount'], $payment['order_id'], $_SESSION['user']['phone'], "http://" . Core::$urls['host'] . '/' . Core::$urls['route'] . 'return/' . $payment['payment_id'], "http://" . Core::$urls['host'] . '/' . Core::$urls['route'] . 'notify/' . $payment['payment_id'],
                '', $request['bank']);
        } else {
            Payment_Pnr_Buy::handle($paymentOrderId, $payment['amount'], $payment['order_id'], $_SESSION['user']['phone'], "http://" . Core::$urls['host'] . '/order_pay_new/return/' . $payment['payment_id'], "http://" . Core::$urls['host'] . '/order_pay_new/notify/' . $payment['payment_id'], '', $request['bank']);
        }
    }

    static function handleBalancePay($payment)
    {
        Web_Account::handleAccountHasAuth('支付', 1);
        Web_Account::handleIsLogin();
        $request = Func_Input::filter(array(
            'password2' => 'string',
        ));
        if(empty($request['password2']) || !Data_Mysql_Table_Account::checkPassword2($request['password2'])){
            return self::request('error','','请输入正确的支付密码！！');
        }
        self::handlePaymentUpdate($payment,0);
        Api_Order_Normal_Api::setTracking('订单余额支付成功',$payment['order_id'],'采购方');
        return self::request('success',$payment['payment_detail']['order_no'],'支付成功！！');
    }
    static function handleReturn($payment)
    {
        if (!empty($_POST['CuryId'])) {
            $return = Payment_UnionPay_Buy::checkReturn();
        } else {
            $return = Payment_Pnr_Buy::checkReturn();
        }
        if ($return) {
            $paymentOrderId = $_POST['OrdId'];
            $paymentId = intval(substr($paymentOrderId, -4));
            if (!$paymentId || $paymentId != $payment['id'] || empty($_POST['Pid']) || $_POST['Pid'] != $payment['order_id']) {
                Func_Header::notFound();
            }
            self::handlePaymentUpdate($payment);
            //添加订单追踪
            Api_Order_Normal_Api::setTracking('在线支付交易成功',$payment['order_id'],'采购方');
            return self::request('success','','付款成功');
        } else {
            Func_Header::notFound();
        }
    }

    static function handleNotify($payment)
    {
        if (!empty($_POST['CuryId'])) {
            $return = Payment_UnionPay_Buy::checkNotify();
        } else {
            $return = Payment_Pnr_Buy::checkNotify();
        }
        if ($return) {
            $paymentOrderId = $_POST['OrdId'];
            $paymentId = intval(substr($paymentOrderId, -9));
            if (!$paymentId || $paymentId != $payment['id'] || empty($_POST['Pid']) || $_POST['Pid'] != $payment['order_id']) {
                Func_Header::notFound();
            }
            self::handlePaymentUpdate($payment);
        }
    }

    static function handlePaymentUpdate($payment,$fee=0.35)
    {
        $r = Finance_Payment::updatePaymentTime($payment['payment_id'],$fee);
        if ($r && !empty($payment['payment_detail']['payment_title']) && !empty($payment['order_id'])) {
            $update_data=array();
            //更新订单已支付金额和支付时间
            $update_data=array(
                'order_price_pay = order_price_pay+?' => $payment['amount'],
                'create_time4'=>time(),
            );
            Data_Mysql_Table_Order_Info::update($payment['order_id'], $update_data);

            $payment_info=array(
                '收款对象'=>$payment['payment_detail']['getpay_account_name'],
                '付款对象'=>$payment['payment_detail']['pay_account_name'],
            );
            $payment_data=array(
                'order_id' => $payment['order_id'],
                'order_no' =>$payment['payment_detail']['order_no'],
                'buyer_account_id' => $payment['account_id'],
                'vendor_id' => $payment['target_account_id'],
                'payment_id' => $payment['payment_id'],
                'payment_amount' =>$payment['amount'],
                'payment_status' => 1,
                'payment_method' => $payment['pay_method'],
                'payment_info'=>$payment_info,
            );
            Data_Mysql_Table_Order_Payment::insert($payment_data);
        }

        //判断订单是否已设置自动提现
        $order=Data_Mysql_Table_Order_Info::select('id,order_detail,order_no',array('id'=>$payment['order_id']));
        $order_detail=json_decode($order[0]['order_detail'],1);
        //获取提现账户的银行卡信息
        $vendor_bank=Api_Order_Normal_Api::getBankInfo($payment['target_account_id']);
        //提交提现请求到账户系统
        if ($r && !empty($order_detail['bank_cash'])) {
             $rs_cash=Finance_Payment::createCash($payment['target_account_id'], $payment['amount'], array(
                'username' => $order_detail['vendor_account_name'],
                'ip' => Func_Input::ip(1),
                'bank_id' => $vendor_bank['bank_account'][$order_detail['bank_cash']][1],
                'bank_account' => $vendor_bank['bank_account'][$order_detail['bank_cash']][0],
                'bank_account_no' => $vendor_bank['bank_account'][$order_detail['bank_cash']][2],
                'bank_name' => Web_User_Center_Money::$banks[$vendor_bank['bank_account'][$order_detail['bank_cash']][1]],
                 'order_no'=>$order[0]['order_no'],
            ));
            if ($rs_cash) {
                //发送邮件
                $email=Data_Config_Demand_Notice::get('财务部');
                Web_Message::CashSuccessEmail($email,$_SESSION['user']['username'],$payment['amount']);
            }
        }
    }

    //微信支付后，处理订单和支付节点
    static function handleWechatPay($paymentId,$amount){
        //获取支付节点信息
        $payment = Finance_Payment::getPaymentInfoById($paymentId);
        if (empty($payment['id']) || empty($payment['payment_detail']['order_no'])) {
            return self::request('error','','未找到该笔款项！！');
        }
        if(empty($amount) || $payment['amount'] != $amount ){
            return self::request('error','','支付款项金额错误！');
        }
        $payment['pay_method']='微信支付';
        self::handlePaymentUpdate($payment);
    }
}