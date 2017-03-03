<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/2
 * Time: 18:43
 */

$actions = explode('/', Core::$urls['action'], 2);
$paymentId = strtoupper($actions[1]);
$payment = Finance_Payment::getPaymentInfoById($paymentId);
if (empty($payment['id']) || empty($payment['payment_detail']['order_no'])) {
    Func_Header::notFound();
}
if (!empty($payment['payment_time'])) {
    Func_Header::back('该笔款项已支付!');
}
switch ($actions[0]) {
    case 'bank':
        Web_Order_Pay::handleSelectBank($payment);
        break;
    case 'pay':
        Web_Order_Pay::handlePay($payment);
        break;
    case 'balance_pay':
        Web_Order_Pay::handleBalancePay($payment);
        break;
    case 'return':
        Web_Order_Pay::handleReturn($payment);
        break;
    case 'notify':
        Web_Order_Pay::handleNotify($payment);
        break;
    default:
        Func_Header::notFound();
        break;
}

class Web_Order_Pay extends Base
{
    static $banks = array(
        'b2b' => array(
            '70' => 'bank_icbc.gif',//'工行B2B',
            '71' => 'bank_abc.gif',//'农行B2B',
            '82' => 'bank_ccb.gif',//'建行B2B新',
            '78' => 'bank_cmb.gif',//'招行B2B',
            '69' => 'bank_shrcc.gif',//'上农商B2C',
            '74' => 'bank_ceb.gif',//'光大B2B',
            '75' => 'bank_bjrcb.gif',//'北农商B2B',
            '76' => 'bank_spdb.gif',//'浦发B2B',
            '81' => 'bank_sdb.gif',//'深发B2B',
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
        )
    );

    static function handleSelectBank($payment)
    {
        $_REQUEST['tab'] = 7;
        Web_Account::handleIsLogin();
        Web_Order_Info::handle($payment['payment_detail']['order_no']);
        $account = Finance_Account::getAccountInfo($_SESSION['user']['id']);
        Tpl_Smarty::assign('banks', self::$banks);
        Tpl_Smarty::assign('account', $account);
        Tpl_Smarty::assign('__user', $_SESSION['user']);
        Tpl_Smarty::assign('payment', $payment);
        Tpl_Smarty::assign('orderinfo', Web_Order_Info::$_orderInfo);
        Tpl_Smarty::display('Web', 'order-info.tpl');
    }

    static function handlePay($payment)
    {
        Web_Account::handleIsLogin();
        $request = Func_Input::filter(array(
            'bank' => 'int',
        ));
        $paymentOrderId = 'N' . date("md").rand(100,990) . str_pad($payment['id'], 9, '0', STR_PAD_LEFT);
        //Agent:user1:50.00;Agent:user2:800.00
        //1.商户号请填入你从汇付获得的六位商户号.<br>
        //2.订单号请与贵网站系统中的唯一订单号匹配.<br>
        //3.页面返回地址--当支付完成后跳转回贵网站系统的页面地址.<br>
        //4.后台返回地址--当支付完成后异步返回贵网站系统的地页面地址.<br>
        //5.网关号--当输入此项后，支付页面将直接跳转到网关号所对应的银行支付页面（您可向客服人员索取网关号）.<br>
        //6.分账明细--当存在一笔支付金额分发给不同的商户时使用，无此情况请留空.<br>
        //7.付款人用户号--如果付款人在汇付有账号，请填入此项.
        Payment_Pnr_Buy::handle($paymentOrderId, $payment['amount'], $payment['order_id'], $_SESSION['user']['phone'], "http://" . Core::$urls['host'] . '/order_pay/return/' . $payment['payment_id'], "http://" . Core::$urls['host'] . '/order_pay/notify/' . $payment['payment_id'], '', $request['bank']);
    }
    /*
     * 余额支付
     */
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
        Func_Header::to('支付成功！！',Core::$urls['root'] . 'order_info/' . $payment['payment_detail']['order_no'].'?tab=3');
    }
    static function handleReturn($payment)
    {
        Web_Account::handleIsLogin();
        $return = Payment_Pnr_Buy::checkReturn();
        if ($return) {
            $paymentOrderId = $_POST['OrdId'];
            $paymentId = intval(substr($paymentOrderId, -9));
            if (!$paymentId || $paymentId != $payment['id'] || empty($_POST['Pid']) || $_POST['Pid'] != $payment['order_id']) {
                Func_Header::notFound();
            }
            self::handlePaymentUpdate($payment);
            Func_Header::to('付款成功!', Core::$urls['root'] . 'order_info/' . $payment['payment_detail']['order_no']);
        } else {
            Func_Header::notFound();
        }
    }

    static function handleNotify($payment)
    {
        $return = Payment_Pnr_Buy::checkNotify();
        if ($return) {
            $paymentOrderId = $_POST['OrdId'];
            $paymentId = intval(substr($paymentOrderId, -9));
            if (!$paymentId || $paymentId != $payment['id'] || empty($_POST['Pid']) || $_POST['Pid'] != $payment['order_id']) {
                Func_Header::notFound();
            }
            self::handlePaymentUpdate($payment);
//            Finance_Payment::updatePaymentTime($payment['payment_id']);
        }
    }

    static function handlePaymentUpdate($payment,$fee=0.35)
    {
        $r = Finance_Payment::updatePaymentTime($payment['payment_id'],$fee);
        if ($r && !empty($payment['payment_detail']['payment_title']) && !empty($payment['order_id'])) {
            //更新订单已支付金额
            Data_Mysql_Table_Order_Info::update($payment['order_id'], array(
                'order_price_pay = order_price_pay+?' => intval($payment['amount']),
            ));
            //判断是否第一笔付款
            if (!empty($payment['payment_detail']['is_first']) || intval($payment['payment_detail']['payment_title']) == 1) {
                //收取经纪人佣金.
                if (!empty($payment['payment_detail']['deal_account_id']) && !empty($payment['payment_detail']['order_commission_deal'])) {
                    //从余额中扣除佣金
                    /*
                     *      (n    >   供应商账户)                              --------订单佣金-------->                       (n    >   推广人员账户)
                     */
                    $payment['payment_detail'] = $payment['agreement_title'] . " - 经纪人佣金";
                    Finance_Account::addDetail($payment['payment_detail']['deal_account_id'], $payment['payment_detail']['vendor_account_id'], $payment['payment_detail']['order_commission_deal'], '经纪人佣金', $payment['payment_id'], $payment['payment_detail']);
                }
            }
        }
    }
}