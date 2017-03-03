<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/3/10
 * 套餐订单详情
 */
class Web_Product_Set_Order_Info extends Base
{
    static $_orderInfo;

    static function checkPassword2()
    {
        if (empty($_REQUEST['password2']) || !Data_Mysql_Table_Account::checkPassword2($_REQUEST['password2'])) {
            Func_Header::back('交易密码错误');
        }
    }

    static function handle($orderNo)
    {
        $r = Data_Mysql_Table_Order_Info::select('*', array(
            'order_no = ?' => $orderNo,
        ));
        if (empty($r[0]['id'])) {
            Func_Header::notFound();
        }
        self::$_orderInfo = $r[0];
        //判断是否是买家
        self::$_orderInfo['is_buyer'] = $_SESSION['user']['id'] == self::$_orderInfo['buyer_account_id'];
        //判断是否是卖家
        self::$_orderInfo['is_vendor'] = self::$_orderInfo['vendor_account_id'] ? self::$_orderInfo['vendor_account_id'] == $_SESSION['user']['id'] : $_SESSION['user']['super_vendor'];
        if (!self::$_orderInfo['is_buyer'] && !self::$_orderInfo['is_vendor']) {
            Func_Header::notFound();
        }
        //获取买家信息
        $accountInfo = Data_Mysql_Table_Account::select('fullname,id,attr', self::$_orderInfo['buyer_account_id']);
        $accountInfo[0]['attr'] = json_decode($accountInfo[0]['attr'], 1);
        self::$_orderInfo['vendor_attr'] = $_SESSION['user']['attr'];
        self::$_orderInfo['buyer_fullname'] = $accountInfo[0]['fullname'];
        self::$_orderInfo['order_detail'] = json_decode(self::$_orderInfo['order_detail'], 1);
        self::$_orderInfo['order_close_info'] = json_decode(self::$_orderInfo['order_close_info'], 1);
        self::$_orderInfo['order_conform'] = json_decode(self::$_orderInfo['order_conform'], 1);
        self::$_orderInfo['order_complete'] = json_decode(self::$_orderInfo['order_complete'], 1);
        self::$_orderInfo['start_date'] = self::$_orderInfo['start_time'] ? date('Y-m-d', self::$_orderInfo['start_time']) : '';
        Data_Config_Site::seo('套餐订单详情: [' . Web_Product_Set_Order_Info::$_orderInfo['order_no'] . '] ' . Web_Product_Set_Order_Info::$_orderInfo['order_title']);
        return self::$_orderInfo;
    }

    static function handleTab()
    {
        //设置默认显示的 tab
        if (empty($_REQUEST['tab'])) {
            if (time() > self::$_orderInfo['start_time']) {
                $_REQUEST['tab'] = 4;
            } elseif (self::$_orderInfo['create_time4']) {
                $_REQUEST['tab'] = 3;
            } elseif (self::$_orderInfo['create_time2']) {
                $_REQUEST['tab'] = 2;
            } else {
                $_REQUEST['tab'] = 1;
            }
        }
    }

    static function handleStep2()
    {
        $updateOrderConform = false;
        if (empty(self::$_orderInfo['order_conform']['buyer'])) {
            //加载买家信息
            $r = Data_Mysql_Table_Account::select('phone, attr', array('id' => self::$_orderInfo['buyer_account_id']));
            if (empty($r[0])) {
                Func_Header::notFound();
            }
            $buyer = $r[0];
            $buyer['attr'] = json_decode($buyer['attr'], 1);
            if (!empty($buyer['attr']['identity']['data']['公司名称'])) {
                self::$_orderInfo['order_conform']['buyer']['买家名称'] = $buyer['attr']['identity']['data']['公司名称'];
                self::$_orderInfo['order_conform']['buyer']['买家签约代表'] = $buyer['attr']['identity']['data']['法人代表'];
                self::$_orderInfo['order_conform']['buyer']['买家地址'] = @$buyer['attr']['identity']['data']['公司地址'];
                self::$_orderInfo['order_conform']['buyer']['买家电话'] = @$buyer['attr']['identity']['data']['公司电话'];
                self::$_orderInfo['order_conform']['buyer']['买家传真'] = @$buyer['attr']['identity']['data']['传真号码'];
            } else if (!empty($buyer['attr']['identity']['data']['真实姓名'])) {
                self::$_orderInfo['order_conform']['buyer']['买家名称'] = $buyer['attr']['identity']['data']['真实姓名'];
                self::$_orderInfo['order_conform']['buyer']['买家签约代表'] = $buyer['attr']['identity']['data']['真实姓名'];
                self::$_orderInfo['order_conform']['buyer']['买家电话'] = $buyer['phone'];
            } else {
                self::$_orderInfo['order_conform']['buyer']['买家名称'] = '未认证';
                self::$_orderInfo['order_conform']['buyer']['买家签约代表'] = '';
            }
            $updateOrderConform = true;
        }
        if (empty(self::$_orderInfo['order_conform']['vendor'])) {
            //加载卖家信息
            $r = Data_Mysql_Table_Account::select('phone, attr', array('id' => self::$_orderInfo['vendor_account_id']));
            if (empty($r[0])) {
                Func_Header::notFound();
            }
            if (!empty($r[0])) {
                $vendor = $r[0];
                $vendor['attr'] = json_decode($vendor['attr'], 1);
                if (!empty($vendor['attr']['identity']['data']['公司名称'])) {
                    self::$_orderInfo['order_conform']['vendor']['供应商名称'] = $vendor['attr']['identity']['data']['公司名称'];
                    self::$_orderInfo['order_conform']['vendor']['供应商签约代表'] = $vendor['attr']['identity']['data']['法人代表'];
                    self::$_orderInfo['order_conform']['vendor']['供应商地址'] = $vendor['attr']['identity']['data']['公司地址'];
                    self::$_orderInfo['order_conform']['vendor']['供应商电话'] = $vendor['attr']['identity']['data']['公司电话'];
                    self::$_orderInfo['order_conform']['vendor']['供应商传真'] = $vendor['attr']['identity']['data']['传真号码'];
                } else if (!empty($vendor['attr']['identity']['data']['真实姓名'])) {
                    self::$_orderInfo['order_conform']['vendor']['供应商名称'] = $vendor['attr']['identity']['data']['真实姓名'];
                    self::$_orderInfo['order_conform']['vendor']['供应商签约代表'] = $vendor['attr']['identity']['data']['真实姓名'];
                    self::$_orderInfo['order_conform']['vendor']['供应商电话'] = $vendor['phone'];
                } else {
                    self::$_orderInfo['order_conform']['vendor']['供应商名称'] = '未认证';
                    self::$_orderInfo['order_conform']['vendor']['供应商签约代表'] = '';
                }
            }
            $updateOrderConform = true;
        }
        self::$_orderInfo['order_conform']['协议标题'] = '云space套餐协议';
        if ($updateOrderConform) {
//                q(self::$_orderInfo);
        }
    }

    static function handleStep3()
    {
        if (self::$_orderInfo['create_time2']) {
            //加载付款信息
            self::$_orderInfo['payment'] = Finance_Payment::getListByOrderId(self::$_orderInfo['id'], self::$_orderInfo['create_time2']);
            if (empty(self::$_orderInfo['payment'])) {
                self::resolveCreatePaymentInfo();
            }
            if (self::$_orderInfo['create_time4'] && self::$_orderInfo['order_status'] >= 0) {
                Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
                    'create_time4' => self::$_orderInfo['create_time4'],
                    'order_price_last' => self::$_orderInfo['order_price_pay'],
                    'order_status' => 90,
                ));
            }
            self::$_orderInfo['payment']['buyer_bank_info'] = self::getBankInfo(self::$_orderInfo['buyer_account_id']);
            self::$_orderInfo['payment']['target_bank_info'] = self::getBankInfo(self::$_orderInfo['vendor_account_id']);
        }
    }


    static function resolveCreatePaymentInfo()
    {
        self::$_orderInfo['order_conform']['支付节点'] = array(
            0 => array(
                '名称' => '定金',
                '金额' => self::$_orderInfo['order_price'] * 0.3,
                '比例' => 30,
            ),
            1 => array(
                '名称' => '尾款',
                '金额' => self::$_orderInfo['order_price'] * 0.7,
                '比例' => 70,
            ),
            2 => array(
                '名称' => '全款',
                '金额' => self::$_orderInfo['order_price'],
                '比例' => 100,
            ),

        );
        $buyer_bank_info = self::getBankInfo(self::$_orderInfo['buyer_account_id']);
        $target_bank_info = self::getBankInfo(self::$_orderInfo['vendor_account_id']);
        //添加付款对账单
        foreach (self::$_orderInfo['order_conform']['支付节点'] as $k => $v) {
            Finance_Payment::createReceive(self::$_orderInfo['buyer_account_id'], self::$_orderInfo['vendor_account_id'], self::$_orderInfo['id'], self::$_orderInfo['order_conform']['协议标题'] . ' ' . ($k + 1) . '. ' . self::$_orderInfo['order_title'] . '(' . $v['名称'] . ')', $v['金额'], array(
                'order_no' => self::$_orderInfo['order_no'],
                'agreement_title' => self::$_orderInfo['order_conform']['协议标题'],
                'buyer_account_id' => self::$_orderInfo['buyer_account_id'],
                'buyer_account' => self::$_orderInfo['order_conform']['buyer']['买家名称'],
                'buyer_bank_info' => $buyer_bank_info,
                'target_bank_info' => $target_bank_info,
                'vendor_account_id' => self::$_orderInfo['vendor_account_id'],
                'vendor_id' => self::$_orderInfo['vendor_id'],
                'payment_title' => ($k + 1) . '(' . $v['名称'] . ')',
                'payment_percent' => $v['比例'] * 100,
//                'payment_deadline' => strtotime($v['期限']),
                'is_in_order' => true,
                'deal_account_id' => self::$_orderInfo['deal_account_id'], //经纪人
                'order_commission_deal' => ceil(self::$_orderInfo['order_commission_deal_per'] * self::$_orderInfo['order_price'] / 10) / 10,
            ));
        }
    }

    static function getBankInfo($accountId)
    {
        $bank_info = array();
        $banks = Web_User_Center_Money::$banks;
        //获取付款对象和收款对象的银行卡信息
        $bank_account = Finance_Account::getAccountInfo($accountId);
        if (empty($bank_account)) {
            $accountInfo = Data_Mysql_Table_Account::select('id,attr', $accountId);
            $accountInfo[0]['attr'] = json_decode($accountInfo[0]['attr'], 1);
            $account_name = empty($accountInfo[0]['attr']['identity']) ? '-' : (empty($accountInfo[0]['attr']['identity']['data']['真实姓名']) ? $accountInfo[0]['attr']['identity']['data']['公司名称'] : $accountInfo[0]['attr']['identity']['data']['真实姓名']);
            Finance_Account::create($accountId, $account_name);
            $bank_info['account_name'] = $account_name;
            $bank_info['balance'] = '0.00';
        } else {
            $bank_info['account_name'] = $bank_account['account_name'];
            $bank_info['balance'] = $bank_account['balance'];
            if (!empty($bank_account['bank_account'])) {
                $i = 1;
                foreach ($bank_account['bank_account'] as $bk => $bv) {
                    if ($i == 1) {
                        $bank_info['bank_name'] = $banks[$bv[1]];
                        $bank_info['bank_card'] = $bv[2];
                    }
                    $i++;
                }
            }

        }
        return $bank_info;
    }

}