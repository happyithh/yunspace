<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/27
 * Time: 00:20
 */
class OA_Finance_Cash extends Base
{
    static function handlePnr()
    {
        if (!empty($_REQUEST['action'])) {
            switch ($_REQUEST['action']) {
                case "check":
                    return self::handleCheck();
                case "submit_pass":
                    return self::handleCheckPass();
                case "submit_reject":
                    return self::handleCheckPass(1);
            }
        }
        self::handleList();
    }

    static function handleList()
    {
        $timeNow = time();
        $all_month=array();
        do {
            $all_month[] = date("Y-m", $timeNow);
            $timeNow -= 86400 * 30;
        } while ($timeNow > '1425279172');
        $_REQUEST['month']=empty($_REQUEST['month'])?date('Y-m'):$_REQUEST['month'];

        $request = Func_Input::filter(array(
            'type' => 'string',
            'month' => 'string',
        ));
        $type = $request['type'] ? ($request['type'] == 'is_check' ? 1 : -1) : 0;
        $list = Finance_Account::getDetailList(-2, $request['month'] ? strtotime($request['month']) : '', '', $type);
        Tpl_Smarty::assign('list_title', '汇付收款对账');
        Tpl_Smarty::assign('list', $list);
        Tpl_Smarty::assign('month', $all_month);
        Tpl_Smarty::display('OA_Finance', 'cash_check_list.tpl');
    }

    static function handleCheck()
    {
        $request = Func_Input::filter(array(
            'id' => 'string',
        ));
        $detail = Finance_Account::getDetailById($request['id']);
        Tpl_Smarty::assign('detail', $detail);
        $account = Finance_Account::getAccountInfo($detail['target_account_id']);
        Tpl_Smarty::assign('account', $account);
        $list = Finance_Account::getDetailList($detail['target_account_id'], $detail['create_time'], '');
        if (empty($list) || count($list) < 3) {
            $list2 = Finance_Account::getDetailList($detail['target_account_id'], strtotime(date('Y-m-d', $detail['create_time']) . ' -1 month'), '');
            if (!empty($list2)) {
                if (empty($list)) {
                    $list = $list2;
                } else {
                    $list = array_merge($list, $list2);
                }
            }
        }
        Tpl_Smarty::assign('list', $list);
        $totalAmount = array(0, 0);
        foreach ($list as $v) {
            if (($v['confirm_time'] == 0 && $v['order_no'] != $detail['order_no']) || $v['confirm_time'] > 0) {
                if ($v['amount'] > 0) {
                    $totalAmount[0] += $v['amount'];
                } else {
                    $totalAmount[1] -= $v['amount'];
                }
            }
        }
        $totalAmount[0] = Finance_Account::amountFormat($totalAmount[0]);
        $totalAmount[1] = Finance_Account::amountFormat($totalAmount[1]);
        Tpl_Smarty::assign('total_amount', $totalAmount);
        Tpl_Smarty::display('OA_Finance', 'cash_check_detail.tpl');
    }

    static function handleCheckPass($isError = 0)
    {
        $request = Func_Input::filter(array(
            'id' => 'string',
        ));
        if (!$request['id']) {
            Func_Header::back('参数错误!');
        }
        Finance_Account::confirmDetail($request['id'], $isError);
        if (!$isError) {
//            TODO: 提交到汇付的代发接口

//            $detail = Finance_Account::getDetailById($request['id']);
            //$orderId, $amount, $accountName, $bankId, $accountId, $mobile, $prType, $retUrl
//            Payment_Pnr_Cash::handle($detail['order_no'], $detail['amount'], $detail['detail']['bank_account'], $detail['detail']['bank_id'], str_replace(array(' ', '-'), '', $detail['detail']['bank_account_no']), empty($detail['detail']['phone']) ? '' : $detail['detail']['phone'], '', 'http://' . Core::$urls['host'] . '/' . dirname(Core::$urls['package']) . '/open_api/finance_cash_return');
        }
        Func_Header::to(' 操作成功!', '?');
    }

}