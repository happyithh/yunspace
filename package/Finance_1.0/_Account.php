<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/19
 * Time: 10:39
 *  系统对外收款的账户永远是负值
 *
 * accountId: -100    >   现金池
 * accountId: -1   >   第三方支付转入，代表我们从客户银行收到的款项                 永远负值   进入系统
 * accountId: -2   >   第三方代付，代表我们转出到客户银行卡的款项                     永远正值   出系统
 * accountId: -3   >   我们公司账户，收取费用
 * accountId: -4   >   我们公司账户，汇付手续费                                                     永远负值  进入系统
 * accountId: -5   >   我们公司账户，收取押金
 * accountId: -6   >   我们公司账户，担保支付
 * accountId: -7   >   直接分账的款项到这里
 * accountId: -15   >   理财账户（生利宝） 本金
 * accountId: -16   >   理财账户（生利宝）收益，用于支出客户的收益                     永远负值  进入系统
 *
 *
 * 用户的银行付款操作:
 *      (-1   >   第三方支付转入 )                      ---------扣除手续费的金额-------->         (0    >   现金池)
 *      (-4   >   我们公司账户，汇付手续费 )    ---------手续费-------->                          (0    >   现金池)
 *      如果不是押金:
 *      (0    >   现金池)                                     ---------支付金额-------->                      (n    >   供应商账户)
 *      如果是押金:
 *      (0    >   现金池)                                     ---------支付金额(押金)-------->             (-5   >   我们公司账户,收取押金)
 *      如果是该订单的第一笔付款
 *      (n    >   供应商账户)                              --------订单佣金-------->                       (n    >   推广人员账户)
 *      (n    >   供应商账户)                              --------合同佣金-------->                       (-3   >   我们公司账户)
 *
 * 用户的提现操作
 *      (n    >   供应商账户)                              --------提现金额-------->                       (-2   >   第三方代付)
 *      代付系统每天3点后提取之前生成的 (-2   >   第三方代付) 账户明细, 转入代付流程
 *
 */
class Finance_Account extends Base
{
    static private $_accounts = array();

    static function getAccountInfo($accountId)
    {
        if (!isset(self::$_accounts[$accountId])) {
            $r = Data_Mysql_Table_Finance_Account::select('id,account_id, account_name, balance, salt, bank_account,sign,pup_no,bank_account_no', array('account_id' => $accountId));
            if (empty($r[0]['id'])) {
                self::$_accounts[$accountId] = null;
            } else {
                if ($r[0]['sign'] != self::_sign($r[0])) {
                    self::$_accounts[$accountId] = null;
                } else {
                    $r[0]['account_name'] = Func_String::decrypt($r[0]['account_name'], $r[0]['salt']);
                    $r[0]['balance'] = Func_String::decrypt($r[0]['balance'], $r[0]['salt']);
                    $r[0]['bank_account'] = $r[0]['bank_account'] ? json_decode($r[0]['bank_account'], 1) : array();
                    unset($r[0]['sign']);
                    self::$_accounts[$accountId] = $r[0];
                }
            }
        }
        return self::$_accounts[$accountId];
    }

    static function create($accountId, $accountName)
    {
        $r = Data_Mysql_Table_Finance_Account::select('id', array('account_id' => $accountId));
        if (!empty($r[0]['id'])) {
            return false;
        }
        $data = array(
            'account_id' => $accountId,
            'account_name' => '',
            'balance' => '0.00',
            'salt' => md5(microtime(1) . 'abcd' . rand(0, 999999)),
            'sign' => '',
            'create_time' => time(),
        );
        $data['account_name'] = Func_String::encrypt($accountName, $data['salt']);
        $data['balance'] = Func_String::encrypt($data['balance'], $data['salt']);
        $data['sign'] = self::_sign($data);
        $r = Data_Mysql_Table_Finance_Account::insert($data);
        unset(self::$_accounts[$accountId]);
        return empty($r[0]) ? false : $accountId;
    }

    static function update($accountId, $accountName = '', $balance = null, $bank_account_no = '', $pup_no = '')
    {
        $r = Data_Mysql_Table_Finance_Account::select('*', array('account_id' => $accountId));
        if (empty($r[0]['id'])) {
            return false;
        }
        $data = array(
            'account_id' => $accountId,
            'account_name' => '',
            'balance' => $r[0]['balance'],
            'salt' => $r[0]['salt'],
            'sign' => '',
        );
        if (!empty($bank_account_no)) {
            $data['bank_account_no'] = $bank_account_no;
            if ($bank_account_no == -1) {
                $data['bank_account_no'] = '';
            }
        }
        if (!empty($pup_no)) {
            $data['pup_no'] = $pup_no;
            if ($pup_no == -1) {
                $data['pup_no'] = '';
            }
        }
        $data['account_name'] = $accountName ? Func_String::encrypt($accountName, $data['salt']) : $r[0]['account_name'];
        if ($balance !== null && is_numeric($balance)) {
            $data['account_name'] = $r[0]['account_name'];
            $data['balance'] = Func_String::encrypt(self::amountFormat($balance), $data['salt']);
        }
//        Core::log('account', $accountId, $accountName, $balance);
        $data['sign'] = self::_sign($data);
        $rs = Data_Mysql_Table_Finance_Account::update($r[0]['id'], $data);
        unset(self::$_accounts[$accountId]);
        if (!empty($rs[0])) {
            Data_Mysql_Table_Finance_Backup::backup('account', $accountId, $r[0]);
            return $accountId;
        }
        return false;
    }

    static function addBankAccount($accountId, $bankId, $bankAccount, $bankCity)
    {
        if (!$bankId || !$bankAccount) {
            return false;
        }
        $account = self::getAccountInfo($accountId);
        if (empty($account['id'])) {
            return false;
        }
        foreach ($account['bank_account'] as $k => $v) {
            if (empty($v[1]) || empty($v[2]) || $v[0] != $account['account_name']) {
                unset($account['bank_account'][$k]);
            }
        }
        $account['bank_account'][md5($bankAccount)] = array($account['account_name'], $bankId, $bankAccount, $bankCity);
        $r = Data_Mysql_Table_Finance_Account::update(array('account_id' => $accountId), array(
            'bank_account' => $account['bank_account']
        ));
        unset(self::$_accounts[$accountId]);
        return empty($r[0]) ? false : $accountId;
    }


    //更新银行卡信息
    static function updateBankAccount($accountId, $bankId, $bankAccount, $bankCity, $oldbankAccount)
    {
        if (!$bankId || !$bankAccount) {
            return false;
        }
        $account = self::getAccountInfo($accountId);
        if (empty($account['id'])) {
            return false;
        }
        foreach ($account['bank_account'] as $k => $v) {
            if (empty($v[1]) || empty($v[2]) || $v[0] != $account['account_name']) {
                unset($account['bank_account'][$k]);
            }
        }
        //unnset掉旧的银行卡信息
        unset($account['bank_account'][md5($oldbankAccount)], $account['bank_account'][$oldbankAccount]);

        $account['bank_account'][md5($bankAccount)] = array($account['account_name'], $bankId, $bankAccount, $bankCity);
        $r = Data_Mysql_Table_Finance_Account::update(array('account_id' => $accountId), array(
            'bank_account' => $account['bank_account']
        ));
        unset(self::$_accounts[$accountId]);
        return empty($r[0]) ? false : $accountId;
    }


    static function removeBankAccount($accountId, $bankAccount)
    {
        $account = self::getAccountInfo($accountId);
        if (empty($account['id'])) {
            return false;
        }
        unset($account['bank_account'][md5($bankAccount)], $account['bank_account'][$bankAccount]);
        $r = Data_Mysql_Table_Finance_Account::update(array('account_id' => $accountId), array(
            'bank_account' => $account['bank_account']
        ));
        unset(self::$_accounts[$accountId]);
        return empty($r[0]) ? false : $accountId;
    }

    static $categoryName = array(
        '收款' => '支付',
        '支付' => '收款'
    );

    static function addDetail($accountId, $targetAccountId, $amount, $category, $orderNo, $detail)
    {
        if (!is_numeric($amount) || !is_numeric($targetAccountId)) {
            return false;
        }
        $account = self::getAccountInfo($accountId);
        if (empty($account['id'])) {
            self::create($accountId, '-');
            $account = self::getAccountInfo($accountId);
        }
        $amount = self::amountFormat($amount);
        //正向
        $data = $dataBefore = array(
            'account_id' => $accountId,
            'target_account_id' => $targetAccountId,
            'order_no' => $orderNo,
            'category' => $category, // 类目
            'amount' => $amount, // 金额
            'create_time' => time(),
        );
        if (is_array($detail)) {
            $detail['balance'] = $account['balance'];
        } else {
            $detail = array(
                $detail,
                'balance' => $account['balance'],
            );
        }
        $dataBefore['detail'] = $detail;
        $data['sign_long'] = Func_String::encrypt(json_encode($dataBefore), $account['salt']);
        $data['sign'] = md5($data['sign_long']);
        $r = Data_Mysql_Table_Finance_Account_Detail::subTable(date("_Ym"))->insert($data);
        if ($r[0]) {
            self::update($accountId, $account['account_name'], $account['balance'] + $amount);
        } else {
            return false;
        }
        //反向
        $account = self::getAccountInfo($targetAccountId);
        if (empty($account['id'])) {
            self::create($targetAccountId, '-');
            $account = self::getAccountInfo($targetAccountId);
        }
        $data = $dataBefore = array(
            'account_id' => $targetAccountId,
            'target_account_id' => $accountId,
            'order_no' => $orderNo,
            'category' => !empty(self::$categoryName[$category]) ? self::$categoryName[$category] : $category, // 类目
            'amount' => self::amountFormat($amount * -1), // 金额
            'create_time' => time(),
        );
        if (is_array($detail)) {
            $detail['balance'] = $account['balance'];
        } else {
            $detail = array(
                $detail,
                'balance' => $account['balance'],
            );
        }
        $dataBefore['detail'] = $detail;
        $data['sign_long'] = Func_String::encrypt(json_encode($dataBefore), $account['salt']);
        $data['sign'] = md5($data['sign_long']);
        $r = Data_Mysql_Table_Finance_Account_Detail::subTable(date("_Ym"))->insert($data);
        self::update($targetAccountId, $account['account_name'], $account['balance'] - $amount);
        //backup
        $r = Data_Mysql_Table_Finance_Account_Detail::subTable(date("_Ym"))->select('*', array(
            'account_id' => $accountId,
            'order_no' => $orderNo,
        ));
        if (!empty($r[0]['id'])) {
            Data_Mysql_Table_Finance_Backup::backup('account_detail', $r[0]['id'], $r[0]);
        }
        $r = Data_Mysql_Table_Finance_Account_Detail::subTable(date("_Ym"))->select('*', array(
            'account_id' => $targetAccountId,
            'order_no' => $orderNo,
        ));
        if (!empty($r[0]['id'])) {
            Data_Mysql_Table_Finance_Backup::backup('account_detail', $r[0]['id'], $r[0]);
        }
        return true;
    }

    static function confirmDetail($dateId, $isError = '', $setPayment = true)
    {
        if (empty($_SESSION['administrator']['id'])) {
            return false;
        }
        $detailData = self::getDetailById($dateId);
        $account = self::getAccountInfo($detailData['account_id']);
        if (empty($account['id'])) {
            return false;
        }
        $table = Data_Mysql_Table_Finance_Account_Detail::subTable(date("_Ym", $detailData['create_time']));
        $lastConfirmTime = $detailData['confirm_time'];
        $detailData['confirm_time'] = $isError ? (time() * -1) : time();
        $r = $table->update($detailData['id'], array(
            'confirm_time' => $detailData['confirm_time'],
            'admin_id' => $_SESSION['administrator']['id'],
        ));
        if (!$r[0]) {
            return false;
        }
        //备份数据
        if (!empty($r[0]['id'])) {
            Data_Mysql_Table_Finance_Backup::backup('account_detail', $rs[0]['id'], $rs[0]);
        }
        $rs = $table->select('*', $detailData['id']);
        if (!empty($rs[0]['id'])) {
            Data_Mysql_Table_Finance_Backup::backup('account_detail', $rs[0]['id'], $rs[0]);
        }
        if (!$setPayment) {
            return true;
        }
        //处理order_no相同的所有Detail
        $rs = $table->select('id, account_id, create_time, confirm_time, amount', array('order_no' => $detailData['order_no'], 'id<>?' => $detailData['id']), '', 100);
        foreach ($rs as $v) {
            self::confirmDetail($v['create_time'] . '-' . $v['id'], $isError, 0);
        }
        //处理order_no (payment_id) 对应的Payment 的状态
        $_POST['url'] = Core::$urls['path'];
        Finance_Payment::updateConfirmTime($detailData['order_no'], $isError);
//        if ($setPayment) {
//        }
        //如果是初次处理已收则不再修正账户余额
        if ($lastConfirmTime >= 0 && !$isError) {
            return true;
        }
        //修正账户余额
        foreach ($rs as $v) {
            self::reBalance($v['account_id']);
        }
        return true;
    }

    static function reBalance($accountId)
    {
        $account = self::getAccountInfo($accountId);
        $rs = self::getDetailList($accountId, '', '', null, 15);
        if (empty($rs) || count($rs) < 15) {
            $rs2 = self::getDetailList($accountId, strtotime('-1 month'), '', null, 15);
            $rs = array_merge($rs, $rs2);
            if (empty($rs) || count($rs) < 15) {
                $rs2 = self::getDetailList($accountId, strtotime('-2 month'), '', null, 15);
                $rs = array_merge($rs, $rs2);
            }
        }
        if (empty($rs)) {
            return false;
        }
        $rs = array_reverse($rs);
        $balances = array();
        $lastBalance = null;
        foreach ($rs as $k => $v) {
            if ($v['confirm_time'] < 0) {
                unset($rs[$k]);
                if ($lastBalance === null) {
                    $lastBalance = $v['detail']['balance'];
                }
                continue;
            }
            if (empty($balances[$v['id']])) {
                $balances[$v['id']] = $lastBalance !== null ? $lastBalance : $v['detail']['balance'];
            }
            foreach ($balances as $vk => $vv) {
                $balances[$vk] += $v['amount'];
                $lastBalance = $balances[$vk];
            }
        }
        if (empty($balances)) {
            $balance = $lastBalance;
        } else {
            foreach ($balances as $vk => $vv) {
                $balances[$vk] = ($vv * 1) . "";
            }
            $balance = array_count_values(array_values($balances));
            arsort($balance);
            $balance = each($balance);
            $balance = $balance['key'];
        }
//        if ($accountId == 4) {
////            q($lastBalance, $balance, $balances, $rs);
//        }
        return self::update($account['account_id'], $account['account_name'], $balance);
    }

    static function getDetailById($dateAndId)
    {
        $dateAndId = explode('-', $dateAndId);
        if ($dateAndId[0] < 1425139200 || empty($dateAndId[1])) {
            return false;
        }
        $rs = Data_Mysql_Table_Finance_Account_Detail::subTable(date("_Ym", $dateAndId[0] ? abs($dateAndId[0]) : time()))->select('*', $dateAndId[1]);
        if (empty($rs[0])) {
            return false;
        }
        $account = self::getAccountInfo($rs[0]['account_id']);
        if (empty($account['id'])) {
            return false;
        }
        return self::_signDetail($rs[0], $account['salt']);
    }

    static function getDetailList($accountId, $dateTime = '', $category = '', $isConform = null, $limit = 100)
    {
        $account = self::getAccountInfo($accountId);
        if (empty($account['id'])) {
            return false;
        }
        if ($dateTime && abs($dateTime) < 1425139200) {
            $dateTime = 1425139200;
        }
        $table = Data_Mysql_Table_Finance_Account_Detail::subTable(date("_Ym", $dateTime ? abs($dateTime) : time()));
        $conditions = array(
            'account_id' => $accountId,
        );
        if ($isConform !== null) {
            if ($isConform) {
                $conditions[] = $isConform > 0 ? 'confirm_time>0' : 'confirm_time<0';
            } else {
                $conditions['confirm_time'] = 0;
            }
        }
        if ($category) {
            $conditions['category'] = $category;
        }
        if ($dateTime && $dateTime < 0) {
            $dateTime = strtotime(date('Y-m-d', abs($dateTime)));
            $conditions["create_time >? AND create_time <?"] = array($dateTime, $dateTime + 86400);
        }
        if ($limit == 'page') {
            $rs = $table->page(0, 0, '*', $conditions, 'ORDER BY id DESC');
            $rows = &$rs['rows'];
        } else {
            $rs = $table->select('*', $conditions, 'ORDER BY id DESC', $limit);
            $rows = &$rs;
        }
        foreach ($rows as $k => $v) {
            $rows[$k] = self::_signDetail($v, $account['salt']);
        }
        return $rs;
    }

    private static function _sign($data)
    {
        return @md5($data['account_id'] . '--!-- ' . $data['account_name'] . '--!-- ' . $data['balance'] . ' ' . $data['salt']);
    }

    private static function _signDetail($data, $salt)
    {
        if ($data['sign'] != md5($data['sign_long'])) {
            return null;
        }
        $signData = json_decode(Func_String::decrypt(json_encode($data['sign_long']), $salt), 1);
        //异常日志记录
        if (!isset($singData['account_id']) || $singData['account_id'] != $data['account_id']) {

        }
        if (!isset($singData['target_account_id']) || $singData['target_account_id'] != $data['target_account_id']) {

        }
        if (!isset($singData['order_no']) || $singData['order_no'] != $data['order_no']) {

        }
        if (!isset($singData['amount']) || $singData['amount'] != $data['amount']) {

        }
        $signData['id'] = $data['id'];
        $signData['confirm_time'] = $data['confirm_time'];
        return $signData;
    }


    static function amountFormat($amount)
    {
        if ($amount < 0) {
            return '-' . self::amountFormat($amount * -1);
        }
        $amount = str_pad(ceil($amount * 100), 2, '0', STR_PAD_LEFT);
        return intval(substr($amount, 0, -2)) . '.' . substr($amount, -2);
    }


}