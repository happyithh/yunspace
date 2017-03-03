<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/27
 * Time: 00:20
 */
class OA_Finance_Income extends Base
{
    static function handlePnr()
    {
        $timeNow = time();
        $all_month = array();
        do {
            $all_month[] = date("Y-m", $timeNow);
            $timeNow -= 86400 * 30;
        } while ($timeNow > '1425279172');
        $_REQUEST['month'] = empty($_REQUEST['month']) ? date('Y-m') : $_REQUEST['month'];

        if (!empty($_REQUEST['action'])) {
            self::handleCheck($_REQUEST['action']);
        }
        $request = Func_Input::filter(array(
            'type' => 'string',
            'month' => 'string',
        ));
        $type = $request['type'] ? ($request['type'] == 'is_check' ? 1 : -1) : 0;
        $list = Finance_Account::getDetailList(-1,
            $request['month'] ? strtotime($request['month']) : '',
            '', $type);
        // 获取收款方名称
        if (!empty($list)) {
            $vendor_account_id = array_unique(array_column(array_column($list,
                'detail'), 'vendor_account_id'));
            $vendor_account_id = array_unique($vendor_account_id);
            $condition[] = 'id IN (' . implode(',',
                    $vendor_account_id) . ')';
            $vendor_name = Data_Mysql_Table_Account::select('id,fullname',
                $condition, '', 50);
            $vendor = array_combine(array_column($vendor_name,
                'id'),
                array_column($vendor_name, 'fullname'));
            foreach ($list as $k => $v) {
                if (array_key_exists($v['detail']['vendor_account_id'],
                    $vendor)) {
                    $list[$k]['detail']['vendor_account_name'] = $vendor[$v['detail']['vendor_account_id']];
                }
            }
        }
        Tpl_Smarty::assign('list_title', '汇付收款对账');
        Tpl_Smarty::assign('list', $list);
        Tpl_Smarty::assign('month', $all_month);
        Tpl_Smarty::display('OA_Finance',
            'income_check_list.tpl');
    }

    static function handleCheck($action)
    {
        $request = Func_Input::filter(array(
            'id' => 'string',
        ));
        if (!$request['id']) {
            Func_Header::back('参数错误!');
        }
        switch ($action) {
            case 'income_receive':
                Finance_Account::confirmDetail($request['id']);
                break;
            case 'income_error':
                Finance_Account::confirmDetail($request['id'],
                    true);
                break;
            default:

                Func_Header::back('参数错误!');
        }
        Func_Header::to(' 操作成功!');
    }

    static function handleAll()
    {
        $timeNow = time();
        $all_month = array();
        do {
            $all_month[] = date("Y-m", $timeNow);
            $timeNow -= 86400 * 30;
        } while ($timeNow > '1425279172');
        $_REQUEST['month'] = empty($_REQUEST['month']) ? date('Y-m') : $_REQUEST['month'];

        $request = Func_Input::filter(array(
            'type' => 'string',
            'month' => 'string',
        ));
        $list = Finance_Payment::getListByDate($request['month'] ? strtotime($request['month']) : '');
        foreach ($list as $k => $v) {
            $list[$k]['from_account'] = Finance_Account::getAccountInfo($v['account_id']);
            $list[$k]['target_account'] = Finance_Account::getAccountInfo($v['target_account_id']);
            if ($v['order_id'] > 0) {
                $tmp = Data_Mysql_Table_Order_Info::select('*',
                    array('id' => $v['order_id']));
                $list[$k]['order'] = array(
                    'remark' => $tmp[0]['remark'],
                    'order_no' => $tmp[0]['order_no'],
                    'order_price' => $tmp[0]['order_price'],
                    'order_price_pay' => $tmp[0]['order_price_pay'],
                );
            }
        }
        // 获取收款方名称
        Tpl_Smarty::assign('list_title', '汇付收款对账');
        Tpl_Smarty::assign('list', $list);
        Tpl_Smarty::assign('month', $all_month);
        Tpl_Smarty::assign('accounts',
            self::$defaultAccount);
        Tpl_Smarty::display('OA_Finance',
            'all_payment_list.tpl');
    }

    static $defaultAccount = array(
        '-100' => '现金池',
        '-1' => '第三方支付转入',
        '-2' => '提现',
        '-3' => '云SPACE-佣金',
        '-4' => '汇付手续费',
        '-5' => '云SPACE-押金',
        '-6' => '云SPACE-担保支付',
        '-7' => '直接分账'
    );
}