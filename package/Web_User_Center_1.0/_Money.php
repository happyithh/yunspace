<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/19
 * Time: 11:14
 */
class Web_User_Center_Money extends Base
{
    static $account;

    static function _getAccountInfo()
    {
        $account = Finance_Account::getAccountInfo($_SESSION['user']['id']);
        if (empty($account['id'])) {
            Finance_Account::create($_SESSION['user']['id'], !empty($_SESSION['user']['attr']['identity']) ? $_SESSION['user']['fullname'] : '-');
        }
        if (!empty($_SESSION['user']['attr']['identity']) && $account['account_name'] != $_SESSION['user']['fullname']) {
            Finance_Account::update($_SESSION['user']['id'], $_SESSION['user']['fullname']);
            $account = Finance_Account::getAccountInfo($_SESSION['user']['id']);
        }
        //获取当前账户所有自动提现信息
        $auto=array();
        $auto=Data_Mysql_Table_Auto_Cash::select('*',array('account_id'=>$_SESSION['user']['id']),'',100);
        if(!empty($auto)){
            foreach($auto as $k=>$v){
                $account['bank_account'][md5($v['bank_account_no'])]['pup_no']=empty($v['pup_no'])?'':$v['pup_no'];
                $account['bank_account'][md5($v['bank_account_no'])]['auto_id']=empty($v['auto_id'])?0:$v['auto_id'];
            }
        }
        //获取当前账户使用的自动提现信息
        $auto=array();
        $auto=Data_Mysql_Table_Auto_Cash::select('*',array('account_id'=>$_SESSION['user']['id'],'status'=>1));
        Tpl_Smarty::assign('auto_info', empty($auto[0])?array():$auto[0]);
        Tpl_Smarty::assign('account', $account);
        self::$account = $account;
    }

    static function handle()
    {
        if (empty($_REQUEST['action'])) {
            $_REQUEST['action'] = '';
        }
        self::_getAccountInfo();
        switch ($_REQUEST['action']) {
            case "":
                self::handleOverview();
                break;
            case "cash":
                self::handleCash();
                break;
            case "detail_info":
                self::handleDetailInfo();
                break;
            case "new_card":
                self::handleNewCard();
                break;
            case "auto_cash":
                self::handleAutoCash();
                break;
            case "close_auto_cash":
                self::handleCloseAutoCash();
                break;
            case "my_card":
                self::handleMyCard();
                break;
            case "edit_card":
                self::handleEditCard();
                break;
            case "remove_card":
                self::handleRemoveCard();
            default:
                self::handleOverview();
                break;
        }
    }

    static function handleOverview()
    {
        $request = Func_Input::filter(array(
            'datetime' => 'string'
        ));
        $accountDetail = Finance_Account::getDetailList($_SESSION['user']['id'], $request['datetime'] ? strtotime($request['datetime']) : '');
        Tpl_Smarty::assign('account_detail', $accountDetail);
        $totalAmount = array(0, 0);
        foreach ($accountDetail as $v) {
            if ($v['confirm_time'] >= 0) {
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
        $dates = array();
        $timeNow = time();
        do {
            $dates[] = date("Y-m", $timeNow);
            $timeNow -= 86400 * 30;
        } while ($timeNow > '1425279172');
        Tpl_Smarty::assign('dates', $dates);
        Tpl_Smarty::display('Web_User_Center', 'user_admin_money.tpl');
    }


    static function handleCash()
    {
        if (!empty($_REQUEST['is_submit'])) {
            $request = Func_Input::filter(array(
                'bank' => 'string',
                'amount' => 'string',
                'password2' => 'string',
            ));
            if (!$request['bank'] || !$request['amount'] || !is_numeric($request['amount']) || empty(self::$account['bank_account'][$request['bank']])) {
                Func_Header::back('提交数据不全, 银行账号和提现金额必须填写!');
            }
            if ($request['amount'] > self::$account['balance']) {
                Func_Header::back('提现金额不能大于账户余额!');
            }
            if ($request['password2']) {
                if (!Data_Mysql_Table_Account::checkPassword2($_REQUEST['password2'])) {
                    Func_Header::back('交易密码错误!');
                }
                //提交提现请求到账户系统
                $r = Finance_Payment::createCash($_SESSION['user']['id'], $request['amount'], array(
                    'username' => $_SESSION['user']['username'],
                    'ip' => Func_Input::ip(1),
                    'bank_id' => self::$account['bank_account'][$request['bank']][1],
                    'bank_account' => self::$account['bank_account'][$request['bank']][0],
                    'bank_account_no' => self::$account['bank_account'][$request['bank']][2],
                    'bank_name' => self::$banks[self::$account['bank_account'][$request['bank']][1]]
                ));
                if ($r) {
                    //发送邮件
                    $email=Data_Config_Demand_Notice::get('财务部');
                    Web_Message::CashSuccessEmail($email,$_SESSION['user']['username'],$request['amount']);
                    Func_Header::to('提现请求,成功提交!', Core::$urls['action']);
                } else {
                    Func_Header::back('操作失败, 请稍候再试, 或联系客服人员!');
                }
            }
        }
        Tpl_Smarty::assign('banks', self::$banks);
        Tpl_Smarty::display('Web_User_Center', 'user_admin_money_cash.tpl');
    }

    static function handleDetailInfo()
    {
        $request = Func_Input::filter(array(
            'order_no' => 'string',
        ));
        if (!$request['order_no']) {
            Func_Header::back('请求参数错误!');
        }
        $payment = Finance_Payment::getPaymentInfoById($request['order_no']);
        if (empty($payment['id'])) {
            Func_Header::back('请求参数错误!');
        }
        Tpl_Smarty::assign('payment', $payment);
        Tpl_Smarty::assign('banks', self::$banks);
        Tpl_Smarty::display('Web_User_Center', 'user_admin_money_cash_info.tpl');
    }


    static $banks = array(
        'ICBC' => '工商银行',
        'ABC' => '农业银行',
        'CMB' => '招商银行',
        'CCB' => '建设银行',
        'BCCB' => '北京银行',
        'BJRCB' => '北京农村商业银行',
        'BOC' => '中国银行',
        'BOCOM' => '交通银行',
        'CMBC' => '民生银行',
        'BOS' => '上海银行',
        'CBHB' => '渤海银行',
        'CEB' => '光大银行',
        'CIB' => '兴业银行',
        'CITIC' => '中信银行',
        'CZB' => '浙商银行',
        'GDB' => '广发银行',
        'HKBEA' => '东亚银行', //无logo
        'HXB' => '华夏银行',
        'HZCB' => '杭州银行',
        'NJCB' => '南京银行',
        'PINGAN' => '平安银行',
        'PSBC' => '邮储银行',
        'SDB' => '深发银行',
        'SPDB' => '浦发银行',
        'SRCB' => '上海农村商业银行',
    );

    static function handleNewCard()
    {
        $account = Finance_Account::getAccountInfo($_SESSION['user']['id']);

        if (!empty($_REQUEST['is_submit']) && empty($_REQUEST['edit_bank_account'])) {
            $request = Func_Input::filter(array(
                'bank' => 'string',
                'bank_account' => 'string',
                'bank_city' => 'string',
            ));
            if (!$request['bank'] || !$request['bank_account'] || !$request['bank_city']  || empty(self::$banks[$request['bank']])) {
                Func_Header::back('提交数据不全, 银行账号和开户行所属城市必须填写!');
            }

            foreach ($account['bank_account'] as $k => $v) {
                if($v[2] == $request['bank_account']) {
                    Func_Header::back('请不要重复添加银行卡！');
                }
            }

            $r = Finance_Account::addBankAccount($_SESSION['user']['id'], $request['bank'], $request['bank_account'],$request['bank_city']);
            if ($r) {
                Func_Header::to('成功添加新的提现银行卡!', Core::$urls['action']);
            } else {
                Func_Header::back('操作失败, 请稍候再试, 或联系客服人员!');
            }
        }


        //编辑之后提交的银行卡信息
        if (!empty($_REQUEST['is_submit']) && !empty($_REQUEST['edit_bank_account'])) {
            $request = Func_Input::filter(array(
                'bank' => 'string',
                'bank_account' => 'string',
                'bank_city' => 'string',
                'edit_bank_account' => 'string',
            ));
            if (!$request['bank'] || !$request['bank_account'] || !$request['bank_city']  || empty(self::$banks[$request['bank']])) {
                Func_Header::back('提交数据不全, 银行账号和开户行所属城市必须填写!');
            }

            foreach ($account['bank_account'] as $k => $v) {
                if($v[2] == $request['edit_bank_account']) {
                    $v[2]='';
                }
                if($v[2] == $request['bank_account']) {
                    Func_Header::back('已经添加过该银行卡！');
                }

            }

            $r = Finance_Account::updateBankAccount($_SESSION['user']['id'], $request['bank'], $request['bank_account'],$request['bank_city'],$request['edit_bank_account']);
            if ($r) {
                Func_Header::to('成功编辑该银行卡信息!', Core::$urls['action']);
            } else {
                Func_Header::back('操作失败, 请稍候再试, 或联系客服人员!');
            }
        }


        Tpl_Smarty::assign('banks', self::$banks);
        Tpl_Smarty::display('Web_User_Center', 'user_admin_money_new_card.tpl');
    }


    static function handleMyCard()
    {
        Tpl_Smarty::assign('banks', self::$account);
        Tpl_Smarty::display('Web_User_Center', 'user_admin_money_my_card.tpl');
    }

    static function handleRemoveCard()
    {
        if (!empty($_REQUEST)) {
            $request = Func_Input::filter(array(
                'bank_account' => 'string',
            ));
        }
        $r = Finance_Account::removeBankAccount($_SESSION['user']['id'],$request['bank_account']);
        if ($r) {
            Func_Header::to('成功删除该银行卡!', Core::$urls['path'].'?action=my_card');
        } else {
            Func_Header::back('操作失败, 请稍候再试, 或联系客服人员!');
        }
    }


    static function handleEditCard()
    {
        $account = Finance_Account::getAccountInfo($_SESSION['user']['id']);

        if (!empty($_REQUEST)) {
            $request = Func_Input::filter(array(
                'bank_account' => 'string',
            ));
        }
        $banks_info = array();
        foreach ($account['bank_account'] as $k => $v) {
            if($v[2] == $request['bank_account']) {
                $banks_info[0] = $v[0];
                $banks_info[1] = $v[1];
                $banks_info[2] = $v[2];
                $banks_info[3] = $v[3];
                $banks_info[4] = $v[2];
            }
        }

        Tpl_Smarty::assign('banks_info', $banks_info);
        Tpl_Smarty::assign('banks', self::$banks);
        Tpl_Smarty::display('Web_User_Center', 'user_admin_money_new_card.tpl');
    }


    static function handleAutoCash()
    {
        if (!empty($_REQUEST['is_submit'])) {
            $request = Func_Input::filter(array(
                'bank' => 'string',
                'password2' => 'string',
                'bank_city'=>'string',
            ));
            if (!$request['bank'] || empty(self::$account['bank_account'][$request['bank']])) {
                Func_Header::back('提交数据不全, 银行账号必须填写!');
            }
            if (empty($request['password2']) || !Data_Mysql_Table_Account::checkPassword2($_REQUEST['password2']) ) {
                Func_Header::back('交易密码错误!');
            }
            //创建自动提现信息
            $data= array(
                'account_id' => $_SESSION['user']['id'],
                'account_name' => $_SESSION['user']['username'],
                'bank_id' => self::$account['bank_account'][$request['bank']][1],
                'bank_account' => self::$account['bank_account'][$request['bank']][0],
                'bank_account_no' => self::$account['bank_account'][$request['bank']][2],
                'bank_name' => self::$banks[self::$account['bank_account'][$request['bank']][1]],
                'status' => 1,
            );
            if(!empty(self::$account['bank_account'][$request['bank']][3])){
                $data['bank_city']=self::$account['bank_account'][$request['bank']][3];
            }elseif(!empty($request['bank_city'])){
                $data['bank_city']=$request['bank_city'];
            }else{
                Func_Header::back('开户行所属城市不能为空!');
            }
            $auto_id=0;
            //获取当前银行卡是否已被绑定自动提现
            $card=Data_Mysql_Table_Auto_Cash::select('*',array('bank_account_no'=>$data['bank_account_no']));
            if(!empty($card[0])){
                $auto_id=$card[0]['id'];
            }
            if(!empty($auto_id)){
                //更新当前使用的自动提现信息
                $r=Data_Mysql_Table_Auto_Cash::update($auto_id,$data);
                $msg='更新自动提现信息';
            }else{
                //创建自动提现信息
                $r=Data_Mysql_Table_Auto_Cash::insert($data);
                $auto_id=$r[0];
                $msg='创建自动提现信息';
            }
            if ($r) {
                //更新银行卡账户信息
                if(empty(self::$account['bank_account'][$request['bank']][3])){
                    Finance_Account::addBankAccount($_SESSION['user']['id'],self::$account['bank_account'][$request['bank']][1],self::$account['bank_account'][$request['bank']][2],$request['bank_city']);
                }
                //更新未使用的自动提现信息状态为-1
                Data_Mysql_Table_Auto_Cash::update(array('account_id = ? and id != ? and status = ?'=>array($_SESSION['user']['id'],$auto_id,1)),array('status'=>-1));
                //更新finance_account中信息
                Finance_Account::update($_SESSION['user']['id'],$_SESSION['user']['username'],'',self::$account['bank_account'][$request['bank']][2],empty($card[0]['pup_no'])?'':$card[0]['pup_no']);
                //创建操作日志
                Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '自动提现', $msg);
                Func_Header::to(' 操作成功！', Core::$urls['action']);
            } else {
                Func_Header::back('操作失败, 请稍候再试, 或联系客服人员!');
            }
        }
        Tpl_Smarty::display('Web_User_Center', 'user_admin_money_auto_cash.tpl');
    }
    static function handleCloseAutoCash(){
        $request=Func_Input::filter(array('auto_id'=>'int'));
        if(empty($request['auto_id'])){
            Func_Header::back('参数错误！！');
        }
        $r=Data_Mysql_Table_Auto_Cash::update($request['auto_id'],array('status'=>-1));
        if ($r) {
            //更新finance_account中的信息
            Finance_Account::update($_SESSION['user']['id'],$_SESSION['user']['username'],'',-1,-1);
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '自动提现', "关闭自动提现功能");
            Func_Header::to(' 操作成功！', Core::$urls['action']);
        } else {
            Func_Header::back('操作失败, 请稍候再试, 或联系客服人员!');
        }
    }
}