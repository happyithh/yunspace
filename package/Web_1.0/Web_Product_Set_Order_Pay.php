<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/5/15
 * 套餐订单支付处理
 */
class Web_Product_Set_Order_Pay extends Base
{
    static $banks = array(
        'b2b' => array(
            '70' => 'bank_icbc.gif',//'工行B2B',
            '71' => 'bank_abc.gif',//'农行B2B',
            '82' => 'bank_ccb.gif',//'建行B2B新',
            '78' => 'bank_cmb.gif',//'招行B2B',
            '74' => 'bank_ceb.gif',//'光大B2B',
            '76' => 'bank_spdb.gif',//'浦发B2B',
//            '8005' => 'bank_icbc.gif',//'工行B2B',
//            '8007' => 'bank_cmb.gif',//'招行借贷',
//            '8108' => 'bank_abc.gif',//'农行B2B',
//            '8110' => 'bank_ccb.gif',//'建行B2B新',
//            '8025' => 'bank_bcom.gif',//'交行',
//            '8027' => 'bank_ceb.gif',//'光大',
//            '8004' => 'bank_citic.gif',//'中信',
//            '8015' => 'bank_cmbc.gif',//'民生',
//            '8013' => 'bank_pab.gif',//'平安银行',
//            '8021' => 'bank_hxb.gif',//'华夏',
//            '8022' => 'bank_spdb.gif',//'浦发B2B',
//            '8023' => 'bank_boc.gif',//'中行',
//            '8026' => 'bank_gdb.gif',//'广发',
//            '8051' => '8051.gif',//'东亚',
//            '8109' => 'bank_cib.gif',//'兴业',
//            '8034' => '8034.gif',//'青岛',
//            '69' => 'bank_shrcc.gif',//'上农商B2C',
//            '75' => 'bank_bjrcb.gif',//'北农商B2B',
//            '81' => 'bank_sdb.gif',//'深发B2B',
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
//            '61' => '',//'PNR钱管家',
        ),
    );

    static function handleSelectBank($payment)
    {
        $_REQUEST['tab'] = 5;
        Web_Account::handleIsLogin();
        Web_Product_Set_Order_Info::handle($payment['payment_detail']['order_no']);
        $orderInfo=Web_Product_Set_Order_Info::$_orderInfo;
        if(empty($orderInfo['create_time3']) && intval($payment['payment_detail']['payment_title'])==2 && empty($orderInfo['order_detail']['pay_transfer'])){
            Func_Header::back('请先支付定金！！');
        }
        $products=$orderInfo['order_detail']['products'];
        $total_price=0;
        foreach($products as $k=>$v){
            $total_price+=$v['price'];
        }
        //获取对账单的支付信息
        $paymentInfo=array();
        $payment_info=Data_Mysql_Table_Order_Payment::select('*',array('payment_id'=>$payment['payment_id']));
        if(!empty($payment_info[0])){
            $payment_info[0]['payment_info']=json_decode($payment_info[0]['payment_info'],1);
            $paymentInfo=$payment_info[0];
        }

        $account = Finance_Account::getAccountInfo($_SESSION['user']['id']);
        Tpl_Smarty::assign('account',$account);
        Tpl_Smarty::assign('orderinfo',$orderInfo);
        Tpl_Smarty::assign('productSet', $orderInfo['order_detail']['set_info']);
        Tpl_Smarty::assign('detail', $orderInfo['order_detail']['detail_data']);
        Tpl_Smarty::assign('days', $orderInfo['order_detail']['days']);
        Tpl_Smarty::assign('total_price',$total_price );
        Tpl_Smarty::assign('banks', Web_Product_Set_Order_Pay::$banks);
        Tpl_Smarty::assign('__user', $_SESSION['user']);
        Tpl_Smarty::assign('payment', $payment);
        Tpl_Smarty::assign('paymentInfo', $paymentInfo);
        Tpl_Smarty::display('Web', 'product_set_order_info.tpl');
    }

    static function handlePay($payment)
    {
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
            Payment_Pnr_Buy::handle($paymentOrderId, $payment['amount'], $payment['order_id'], $_SESSION['user']['phone'], "http://" . Core::$urls['host'] . '/product_set_order_pay/return/' . $payment['payment_id'], "http://" . Core::$urls['host'] . '/order_pay/notify/' . $payment['payment_id'], '', $request['bank']);
        }
    }
    static function handleBalancePay($payment)
    {
        Web_Account::handleIsLogin();
        $request = Func_Input::filter(array(
            'password2' => 'string',
        ));
        if(empty($request['password2']) || !Data_Mysql_Table_Account::checkPassword2($request['password2'])){
            Func_Header::back('支付密码错误！！');
        }
        self::handlePaymentUpdate($payment,0);
        Func_Header::to('支付成功！！',Core::$urls['root'] . 'product_set_order_info/' . $payment['payment_detail']['order_no'].'?tab=2');
    }
    static function handleTransferPay($payment)
    {
        Web_Account::handleIsLogin();
        if(empty($_REQUEST['transfer_agreement'])){
            Func_Header::back('请先阅读并同意云space转账支付协议！！');
        }
        $request = Func_Input::filter(array(
            'buyer_full_name'=>'string',
            'buyer_bank_name'=>'string',
            'buyer_account_name'=>'string',
            'payment_no'=>'string',
            'password2' => 'string',
        ),$_REQUEST);
        if(empty($request['buyer_full_name'])){
            Func_Header::back('付款对象不能为空！！');
        }
        if(empty($request['buyer_bank_name'])){
            Func_Header::back('付款银行不能为空！！');
        }
        if(empty($request['buyer_account_name'])){
            Func_Header::back('付款账户不能为空！！');
        }
        if(empty($request['password2']) || !Data_Mysql_Table_Account::checkPassword2($request['password2'])){
            Func_Header::back('支付密码错误！！');
        }

        $files = Func_Input::filter(array(
            'transfer_img' => 'array',
        ), $_FILES);
        $path='';
        if(!empty($files['transfer_img']['name'])){
            $path = Func_Upload::image('transfer_img');
            $payment_data['payment_img']=$path;
        }
        $transfer_info=array(
            '付款对象'=>$request['buyer_full_name'],
            '付款银行'=>$request['buyer_bank_name'],
            '付款账户'=>$request['buyer_account_name'],
//            '收款对象'=>$payment['payment_detail']['target_bank_info']['account_name'],
//            '收款银行'=>$payment['payment_detail']['target_bank_info']['bank_name'],
//            '收款卡号'=>$payment['payment_detail']['target_bank_info']['bank_card'],
            '交易流水号'=>$request['payment_no']);
        //添加支付信息
        $payment_data['order_id']= $payment['order_id'];
        $payment_data['order_no'] = $payment['payment_detail']['order_no'];
        $payment_data['buyer_account_id'] = $payment['account_id'];
        $payment_data['vendor_id'] = $payment['target_account_id'];
        $payment_data['payment_id'] = $payment['payment_id'];
        $payment_data['payment_amount'] =$payment['amount'];
        $payment_data['payment_status'] = -1;
        $payment_data['payment_method'] = $payment['pay_method'];
        $payment_data['payment_no'] = $request['payment_no'];
        $payment_data['payment_info'] = $transfer_info;
        //获取对账单的支付信息
        $payment_info=Data_Mysql_Table_Order_Payment::select('*',array('payment_id'=>$payment['payment_id']));
        if(empty($payment_info[0])){
            $r=Data_Mysql_Table_Order_Payment::insert($payment_data);
        }else{
            $r=Data_Mysql_Table_Order_Payment::update($payment_info[0]['id'],$payment_data);
        }
        if (empty($r[0])) {
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }else{
            Func_Header::to('提交成功，等待供应商确认！！',Core::$urls['root'] . 'product_set_order_info/' . $payment['payment_detail']['order_no'].'?tab=2');
        }
    }

    static function handleReturn($payment)
    {
        Web_Account::handleIsLogin();
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
            Func_Header::to('付款成功!', Core::$urls['root'] . 'product_set_order_info/' . $payment['payment_detail']['order_no']);
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
            if(intval($payment['payment_detail']['payment_title'])==1){
               $update_data=array(
                   'order_price_pay = order_price_pay+?' => $payment['amount'],
                   'create_time3'=>time(),
               );
            }elseif(intval($payment['payment_detail']['payment_title'])==2){
                $update_data=array(
                    'order_price_pay = order_price_pay+?' => $payment['amount'],
                    'create_time4'=>time(),
                );
            }elseif(intval($payment['payment_detail']['payment_title'])==3){
                $update_data=array(
                    'order_price_pay = order_price_pay+?' => $payment['amount'],
                    'create_time3'=>time(),
                    'create_time4'=>time(),
                );
            }
            Data_Mysql_Table_Order_Info::update($payment['order_id'], $update_data);
            //添加支付信息
            $buyer_account=Finance_Account::getAccountInfo($payment['account_id']);
            $target_account=Finance_Account::getAccountInfo($payment['target_account_id']);
            $payment_info=array(
                '收款对象'=>$payment['payment_detail']['target_bank_info']['account_name'],
                '账户余额'=>$target_account['balance'],
                '付款对象'=>$payment['payment_detail']['buyer_bank_info']['account_name'],
//                '付款账户余额'=>$buyer_account['balance'],
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
            //判断是否第一笔付款
//            if (!empty($payment['payment_detail']['is_first']) || intval($payment['payment_detail']['payment_title']) == 1) {
//                //收取经纪人佣金.
//                if (!empty($payment['payment_detail']['deal_account_id']) && !empty($payment['payment_detail']['order_commission_deal'])) {
//                    //从余额中扣除佣金
//                    /*
//                     *      (n    >   供应商账户)                              --------订单佣金-------->                       (n    >   推广人员账户)
//                     */
//                    $payment['payment_detail'] = $payment['agreement_title'] . " - 经纪人佣金";
//                    Finance_Account::addDetail($payment['payment_detail']['deal_account_id'], $payment['payment_detail']['vendor_account_id'], $payment['payment_detail']['order_commission_deal'], '经纪人佣金', $payment['payment_id'], $payment['payment_detail']);
//                }
//            }
        }
    }

    static function handleConfirmPay($payment)
    {
        Web_Account::handleIsLogin();;
        //更新订单已支付金额和支付时间
        if(intval($payment['payment_detail']['payment_title'])==1){
            $update_data=array(
                'order_price_pay = order_price_pay+?' => $payment['amount'],
                'create_time3'=>time(),
            );
        }elseif(intval($payment['payment_detail']['payment_title'])==2){
            $update_data=array(
                'order_price_pay = order_price_pay+?' => $payment['amount'],
                'create_time4'=>time(),
            );
        }elseif(intval($payment['payment_detail']['payment_title'])==3){
            $update_data=array(
                'order_price_pay = order_price_pay+?' => $payment['amount'],
                'create_time3'=>time(),
                'create_time4'=>time(),
            );
        }
        $r =Data_Mysql_Table_Order_Info::update($payment['order_id'], $update_data);
        $r_payment=Data_Mysql_Table_Order_Payment::update(array('payment_id'=>$payment['payment_id']),array('payment_status'=>1));
        if (empty($r[0]) || empty($r_payment[0])){
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }else{
            Func_Header::to('确认成功！！',Core::$urls['root'] . 'product_set_order_info/' . $payment['payment_detail']['order_no'].'?tab=2');
        }
    }
    static function handleNotConfirmPay($payment)
    {
        Web_Account::handleIsLogin();;
        $r_payment=Data_Mysql_Table_Order_Payment::update(array('payment_id'=>$payment['payment_id']),array('payment_status'=>2));
        if (empty($r_payment[0])){
            Func_Header::back('操作失败，请稍候再试或联系客服人员！');
        }else{
            Func_Header::to('操作成功！！',Core::$urls['root'] . 'product_set_order_info/' . $payment['payment_detail']['order_no'].'?tab=2');
        }
    }

}