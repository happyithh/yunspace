<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/19
 * Time: 14:16
 */
class Finance_Payment extends Base
{

    //付款进系统
    static function createReceive(
        $accountId,
        $targetAccountId,
        $orderId,
        $payment,
        $amount,
        $detail
    ) {
        if (empty($amount)) {
            return false;
        }
        $data = array(
            'account_id' => $accountId,
            'target_account_id' => $targetAccountId,
            'order_id' => $orderId,
            'amount' => Finance_Account::amountFormat($amount),
            'payment_time' => 0,
            'confirm_time' => 0,
            'admin_id' => 0,
            'create_time' => time(),
        );
        $data = self::_sign($data);
        $data['payment_title'] = $payment;
        $data['payment_detail'] = $detail;
        $r = Data_Mysql_Table_Finance_Payment::subTable(date("_Ym",
            $data['create_time']))->insert($data);
        if (empty($r[0])) {
            return false;
        }
        return 'P' . date('Ym') . str_pad($r[0], 9, '0',
            STR_PAD_LEFT);
    }

    //更新支付节点
    static function updateReceive($paymentId, $update_data)
    {
        if (empty($update_data['金额']) || empty($update_data['名称'])) {
            return false;
        }
        $payment = self::getPaymentInfoById($paymentId);
        $data = array(
            'account_id' => $payment['account_id'],
            'target_account_id' => $payment['target_account_id'],
            'order_id' => $payment['order_id'],
            'amount' => Finance_Account::amountFormat($update_data['金额']),
            'payment_time' => 0,
            'confirm_time' => 0,
            'admin_id' => 0,
            'create_time' => $payment['create_time'],
        );
        $data = self::_sign($data);
        $data['payment_title'] = $update_data['payment_title'];
        $data['payment_detail'] = $payment['payment_detail'];
        $data['payment_detail']['payment_title'] = $update_data['名称'];
        $data['payment_detail']['payment_demo'] = $update_data['支付备注'];
        $data['payment_detail']['payment_percent'] = $update_data['payment_percent'];
        $r = Data_Mysql_Table_Finance_Payment::subTable(date("_Ym",
            $payment['create_time']))->update(array('id' => $payment['id']),
            $data);
        if (empty($r[0])) {
            return false;
        } else {
            return true;
        }
    }

    //提现出系统
    static function createCash(
        $accountId,
        $amount,
        $detail,
        $text = '提现'
    ) {
        $account = Finance_Account::getAccountInfo($accountId);
        if ($amount < 0 || empty($account['balance']) || $account['balance'] < $amount) {
            return false;
        }
        $paymentId = self::createReceive($accountId, -2, -2,
            'cash:' . microtime(1), $amount, $detail);
        if ($paymentId) {
            // 提现操作
            //用户的提现操作
            //  (n    >   供应商账户)                              --------提现金额-------->                       (-2   >   第三方代付)
            Finance_Account::addDetail(-2, $accountId,
                $amount, $text, $paymentId, $detail);
        }
        return $paymentId;
    }

    static function _sign($data)
    {
        if (empty($data['account_id'])) {
            return false;
        }
        $signData = array(
            'account_id' => (int)$data['account_id'],
            'target_account_id' => (int)$data['target_account_id'],
            'order_id' => (int)$data['order_id'],
            'amount' => $data['amount'],
            'payment_time' => (int)$data['payment_time'],
            'confirm_time' => (int)$data['confirm_time'],
            'admin_id' => (int)$data['admin_id'],
            'create_time' => (int)$data['create_time'],
        );
        $data['sign_long'] = Func_String::encrypt(json_encode($signData),
            'get');
        $data['sign'] = md5($data['sign_long']);
        return $data;
    }

    static function _signLong($data)
    {
        $signData = array(
            'account_id' => (int)$data['account_id'],
            'target_account_id' => (int)$data['target_account_id'],
            'order_id' => (int)$data['order_id'],
            'amount' => $data['amount'],
            'payment_time' => (int)$data['payment_time'],
            'confirm_time' => (int)$data['confirm_time'],
            'admin_id' => (int)$data['admin_id'],
            'create_time' => (int)$data['create_time'],
        );
        $sign = md5(Func_String::encrypt(json_encode($signData),
            'get'));
        if ($sign != $data['sign']) {
            $signData = json_decode(Func_String::decrypt($data['sign_long'],
                'get'), 1);
            if (!$signData) {
                return false;
            }
            foreach ($signData as $k => $v) {
                $data[$k] = $v;
            }
        }
        $data['payment_detail'] = json_decode($data['payment_detail'],
            1);
        $data['confirm_detail'] = $data['confirm_detail'] ? json_decode($data['confirm_detail'],
            1) : array();
        unset($data['sign'], $data['sign_long']);
        $data['payment_id'] = 'P' . date('Ym',
                $data['create_time']) . str_pad($data['id'],
                9, '0', STR_PAD_LEFT);
        //TODO: 结算支付的一个hack, 8月份删除
        if ($data['target_account_id'] == '-6') {
            $data['target_account_id'] = $data['payment_detail']['vendor_account_id'];
        }
        return $data;
    }

    static function getPaymentInfoById($paymentId)
    {
        $id = intval(substr($paymentId, -9));
        $r = Data_Mysql_Table_Finance_Payment::subTable("_" . substr($paymentId,
                1, 6))->select('*', array('id' => $id));
        if (empty($r[0]['id'])) {
            return false;
        }
        $data = self::_signLong($r[0]);
        return $data;
    }


    static function updatePaymentTime(
        $paymentId,
        $fee = 0.35
    ) {
        $data = self::getPaymentInfoById($paymentId);
        if (empty($data['id'])) {
            return false;
        }
        if ($data['payment_time'] > 0) {
            return false;
        }
        $data['payment_time'] = time();
        $data = self::_sign($data);
        if (!$data) {
            return false;
        }
        //如果是提现则需要验证账户余额
        if ($data['order_id'] == -2) {
            // 提现操作
            $account = Finance_Account::getAccountInfo($data['account_id']);
            if ($data['amount'] < 0 || empty($account['balance']) || $account['balance'] < $data['amount']) {
                return false;
            }
        }
        //添加 AccountDetail
        $accountDetail = $data['payment_detail'];
        $accountDetail['order_id'] = $data['order_id'];
        $accountDetail['payment_title'] = $data['payment_title'];
        $accountDetail['amount'] = $data['amount'];
        $accountDetail['account_id'] = $data['account_id'];
        $accountDetail['target_account_id'] = $data['target_account_id'];
        $accountDetail['payment_no'] = 'N' . date("Ymd") . str_pad($data['id'],
                9, '0', STR_PAD_LEFT);
        $accountDetail['_POST'] = $_POST;
        $data['payment_detail']['_POST'] = $_POST;
//        $data['payment_detail'] = $data['payment_detail'];
//        $data['confirm_detail'] = $data['confirm_detail'];
        $data['confirm_time'] = 0;
        $data = self::_sign($data);
        $r = Data_Mysql_Table_Finance_Payment::subTable(date("_Ym",
            $data['create_time']))->update($data['id'],
            array(
                'payment_time' => $data['payment_time'],
                'confirm_time' => $data['confirm_time'],
                'payment_detail' => $data['payment_detail'],
                'sign' => $data['sign'],
                'sign_long' => $data['sign_long'],
            ));
        if (empty($r[0])) {
            return false;
        }
        //backup
        Data_Mysql_Table_Finance_Backup::backup('payment_update',
            $data['id'], $data);
        if ($fee < 0) {
            return $paymentId;
        }
        if ($data['order_id'] > 0 && $data['amount'] > 0) {
            //支付操作
//            * 用户的银行付款操作:
//            *      (-1   >   第三方支付转入 )                      ---------扣除手续费的金额-------->         (-100    >   现金池)
//            *      (-4   >   我们公司账户，汇付手续费 )    ---------手续费-------->                          (-100    >   现金池)
            if ($fee) {//如果需要收取手续费， 如汇付天下。
                $pnrFee = ceil($data['amount'] * 0.35) / 100;
                if ($pnrFee < 0.1) {
                    $pnrFee = 0.1;
                }
                Finance_Account::addDetail(-100, -1,
                    $data['amount'] - $pnrFee, '汇入现金池',
                    $data['payment_id'], $accountDetail);
                Finance_Account::addDetail(-100, -4,
                    $pnrFee, '汇入手续费', $data['payment_id'],
                    $accountDetail);
                Finance_Account::addDetail($data['account_id'],
                    -100, $data['amount'], '充值',
                    $data['payment_id'], $accountDetail);
            } else {
//                    Finance_Account::addDetail(-100, -1, $data['amount'], '汇入现金池', $data['payment_id'], $accountDetail);
//                    Finance_Account::addDetail($data['account_id'], -100, $data['amount'], '充值', $data['payment_id'], $accountDetail);
            }
//            *      如果不是押金:
//            *      (0    >   现金池)                                     ---------支付金额-------->                      (n    >   供应商账户)
//            *      如果是押金:
//            *      (0    >   现金池)                                     ---------支付金额(押金)-------->             (-5   >   我们公司账户)
            if (!empty($data['target_account_id'])) {
                Finance_Account::addDetail($data['target_account_id'],
                    $data['account_id'], $data['amount'],
                    '收款', $data['payment_id'],
                    $accountDetail);
//                    if (!$toBalance) { //TODO: 如果是直接分账, 则直接扣除余额, 需要测试
//                        Finance_Account::addDetail(-7, $data['target_account_id'], $data['amount'], '分账', $data['payment_id'], $accountDetail);
//                    }
            }
//            *      (n    >   供应商账户)                              --------订单佣金-------->                       (n    >   推广人员账户)
//            *      (n    >   供应商账户)                              --------合同佣金-------->                       (-3   >   我们公司账户)

        }
        return $paymentId;
    }

    static function updateConfirmTime(
        $paymentId,
        $isError = 0
    ) {
        $data = self::getPaymentInfoById($paymentId);
        if (!$data['payment_time'] || empty($_SESSION['administrator']['id'])) {
            return false;
        }
        $data['admin_id'] = $_SESSION['administrator']['id'];
        $data['confirm_time'] = time() * ($isError ? -1 : 1);
        $data['confirm_detail'] = $_POST;
        $data = self::_sign($data);
        $data['confirm_detail'] = $data['confirm_detail'];
        $r = Data_Mysql_Table_Finance_Payment::subTable(date("_Ym",
            $data['create_time']))->update($data['id'],
            $data);
        return empty($r[0]) ? false : $paymentId;
    }

    static function getListByOrderId($orderId, $dateTime)
    {
        $rs = Data_Mysql_Table_Finance_Payment::subTable(date("_Ym",
            $dateTime))->select('*',
            array('order_id' => $orderId), '', 100);
        foreach ($rs as $k => $v) {
            $rs[$k] = self::_signLong($v);
        }
        return $rs;
    }

    static function getListByDate($dateTime = '')
    {
        $rs = Data_Mysql_Table_Finance_Payment::subTable(date("_Ym",
            $dateTime))->select('*', '', '', 500);
        foreach ($rs as $k => $v) {
            $rs[$k] = self::_signLong($v);
        }
        return $rs;
    }

    static function getListOfCash($dateTime = '')
    {

    }

    //删除支付节点
    static function deletePaymentByPid($paymentId)
    {
        $id = intval(substr($paymentId, -9));
        $r = Data_Mysql_Table_Finance_Payment::subTable("_" . substr($paymentId,
                1, 6))->delete(array('id' => $id));
        if (empty($r[0])) {
            return false;
        }
        return true;
    }

}