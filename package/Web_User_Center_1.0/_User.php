<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/6
 * Time: 17:43
 */
class Web_User_Center_User extends Base
{

    static function handle()
    {
        if (empty($_SESSION['user']['id'])) {
            return false;
        }
        //新版用户中心：用户个人信息，钱包余额，需求，收藏，订单。消息，快捷入口设置
        //账户余额
        $account = Finance_Account::getAccountInfo($_SESSION['user']['id']);
        if (empty($account['id'])) {
            Finance_Account::create($_SESSION['user']['id'], empty($_SESSION['user']['attr']['identity']) ? '-' : (empty($_SESSION['user']['attr']['identity']['data']['真实姓名']) ? $_SESSION['user']['attr']['identity']['data']['公司名称'] : $_SESSION['user']['attr']['identity']['data']['真实姓名']));
            $account = Finance_Account::getAccountInfo($_SESSION['user']['id']);
        }
        $conditions = array(
            'buyer_account_id' => $_SESSION['user']['id'],
        );
        if ($_SESSION['user']['account_type'] == 21) {
            $conditions = array(
                'vendor_account_id = ? OR buyer_account_id = ?' => array($_SESSION['user']['id'], $_SESSION['user']['id']),
            );
            if (!empty($_SESSION['user']['super_vendor']) && $_SESSION['user']['super_vendor']) {
                $conditions = array(
                    'vendor_account_id =0 OR vendor_account_id=?' => $_SESSION['user']['id']
                );
            }
        }
        $conditions['status'] = 1;
        $counter = Web_User_Center_Order::handleCounter($conditions);
        $orders = Data_Mysql_Table_Order_Info::select('id,status, vendor_id,product_set_id, order_no, product_id, vendor_id, order_title, remark, order_price, order_price_last, order_price_pay, order_payment_percent, order_status, start_time, end_time, create_time', $conditions, 'order by id desc', 10);
        $orders = Web_User_Center_Order::handleOrderList($orders);
        $i = 0;
        $j = 0;
        $k = 0;
        $m = 0;
        foreach ($orders as $v) {
            if ($v['order_status_text'] == '待审核') {
                $i++;
            }
            if ($v['order_status_text'] == '待签约') {
                $j++;
            }
            if ($v['order_status_text'] == '待支付') {
                $k++;
            }
            if ($v['order_status_text'] == '待结算') {
                $m++;
            }
        }

        $account = Finance_Account::getAccountInfo($_SESSION['user']['id']);
        Tpl_Smarty::assign('i', $i);
        Tpl_Smarty::assign('j', $j);
        Tpl_Smarty::assign('k', $k);
        Tpl_Smarty::assign('m', $m);
        Tpl_Smarty::assign('balance', $account['balance']);
        Tpl_Smarty::assign('orders', $orders);
        Tpl_Smarty::assign('total', $counter[0][1]);
        Tpl_Smarty::assign('Auditing', $counter[1][1]);
        Tpl_Smarty::assign('sign', $counter[2][1]);
        Tpl_Smarty::assign('pay', $counter[3][1]);
//        Tpl_Smarty::assign('wait_pay', $counter[4][1]);
        Tpl_Smarty::assign('finish', $counter[5][1]);
        Tpl_Smarty::display('Web_User_Center', 'index.tpl');
    }

    static function handleLogin()
    {
        if (!empty($_POST['remember'])) {
            session_set_cookie_params(86400 * 7);
        }
        if (empty($_POST['username'])) {
            Func_Header::back('用户名/手机/邮箱必须填写.');
        }
        if (empty($_POST['password'])) {
            Func_Header::back('密码必须填写.');
        }
        if (strpos($_POST['username'], '@')) {
            return self::handleLoginSubAccount();
        }
        $rs = Data_Mysql_Table_Account::select("{table}.*,{prefix}vendor_info.id as vendor_id,{prefix}vendor_info.vendor_name", array("{table}.username=? OR {table}.email= ? OR {table}.phone= ?" => array($_POST['username'], $_POST['username'], $_POST['username'])), '', 10, '{table} LEFT JOIN {prefix}vendor_info ON {table}.id= {prefix}vendor_info.vendor_account_id');
        if (empty($rs[0]['id'])) {
            Func_Header::back('账号不存在!');
        }
        foreach ($rs as $r) {
            if ($rs[0]['password'] == Data_Mysql_Table_Account::makePassword($_POST['password'])) {
                $_SESSION['user'] = array(
                    'id' => $r['id'],
                    'fullname' => $r['fullname'],
                    'email' => $r['email'],
                    'phone' => $r['phone'],
                    'username' => $r['username'],
                    'avatar' => $r['avatar'],
                    'account_type' => $r['vendor_id'] ? 21 : 1,
                    'identity_time' => $r['identity_time'],
                    'pnr_account' => $r['pnr_account'],
                    'password' => $r['password'],
                    'password2' => $r['password2'],
                    'attr' => $r['attr'] ? json_decode($r['attr'], 1) : '',
                    'register_time' => $r['register_time'],
                    'login_time' => time(),
                    'sub_account' => false,
                    'vendor_id' => $r['vendor_id'],
                    'vendor_name' => $r['vendor_name'],

                );
                Data_Mysql_Table_Account::update($r['id'], array("login_times = login_times + 1"));
                unset($_SESSION['url_back']);
                $_SESSION['user']['super_vendor'] = $r['username'] == 'vendor';
                Data_Mysql_Table_StaticLog::log('login', 0, $_SESSION['user']['id'], '');
                Data_Mysql_Table_Dwz_Record::updataRecord(); //更新通过分享url点击的记录
                Func_Header::to('', !empty($_POST['url_back']) ? $_POST['url_back'] : Core::$urls['root'] . 'user_admin');
            }
        }
        Func_Header::back("密码不正确!");
    }

    static function handleLoginSubAccount()
    {
        $account = explode('@', $_POST['username']);
        $rs = Data_Mysql_Table_Account::select("{table}.*,{prefix}vendor_info.id as vendor_id,{prefix}vendor_info.vendor_name", array("username=? OR email= ? OR phone= ?" => array($account[1], $account[1], $account[1])), '', 10,'{table} LEFT JOIN {prefix}vendor_info ON {table}.id= {prefix}vendor_info.vendor_account_id');
        if (empty($rs[0]['id'])) {
            Func_Header::back('账号不存在!');
        }
        foreach ($rs as $r) {
            $subAccount = json_decode($r['sub_account'], 1);
            if (!empty($subAccount[$account[0]]) && $subAccount[$account[0]][0] == Data_Mysql_Table_Account::makePassword($_POST['password'])) {
                $_SESSION['user'] = array(
                    'id' => $r['id'],
                    'fullname' => $r['fullname'],
                    'email' => $r['email'],
                    'phone' => $r['phone'],
                    'username' => $account[0] . '@' . $r['username'],
                    'account_type' => $r['account_type'],
                    'pnr_account' => $r['pnr_account'],
                    'password' => $r['password'],
                    'password2' => $r['password2'],
                    'attr' => $r['attr'] ? json_decode($r['attr'], 1) : '',
                    'register_time' => $r['register_time'],
                    'login_time' => time(),
                    'sub_account' => array(
                        'account' => $account[0],
                        'auth' => $subAccount[$account[0]][1],
                    ),
                    'vendor_id' => $r['vendor_id'],
                    'vendor_name' => $r['vendor_name'],
                    'avatar' => $r['avatar']
                );
                Data_Mysql_Table_StaticLog::log('login', 1, $_SESSION['user']['id'], $account[0]);
                unset($_SESSION['url_back']);
                $_SESSION['user']['super_vendor'] = $r['username'] == 'vendor';
                Func_Header::to('', !empty($_POST['url_back']) ? $_POST['url_back'] : 'user_admin');
            }
        }
        Func_Header::back("密码不正确!");
    }

}
