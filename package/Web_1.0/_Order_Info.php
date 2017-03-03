<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/10
 * Time: 11:18
 */
class Web_Order_Info extends Base
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
        self::$_orderInfo['order_detail'] = json_decode(self::$_orderInfo['order_detail'], 1);
        self::$_orderInfo['order_conform'] = json_decode(self::$_orderInfo['order_conform'], 1);
        self::$_orderInfo['order_complete'] = json_decode(self::$_orderInfo['order_complete'], 1);
        self::$_orderInfo['start_date'] = self::$_orderInfo['start_time'] ? date('Y-m-d', self::$_orderInfo['start_time']) : '';
        Data_Config_Site::seo('订单详情: [' . Web_Order_Info::$_orderInfo['order_no'] . '] ' . Web_Order_Info::$_orderInfo['order_title']);
        return self::$_orderInfo;
    }

    static function handleTab()
    {
        //设置默认显示的 tab
        if (empty($_REQUEST['tab'])) {
            if (self::$_orderInfo['create_time4']) {
                $_REQUEST['tab'] = 4;
            } elseif (self::$_orderInfo['create_time3']) {
                $_REQUEST['tab'] = 3;
            } elseif (self::$_orderInfo['create_time2']) {
                $_REQUEST['tab'] = 2;
            } else {
                $_REQUEST['tab'] = 1;
            }
        }
        if ($_REQUEST['tab'] == 6 && (!self::$_orderInfo['is_vendor'] || self::$_orderInfo['create_time3'])) {
            Func_Header::notFound();
        } else if ($_REQUEST['tab'] == 2 && !self::$_orderInfo['create_time2']) {
            Func_Header::notFound();
        } else if ($_REQUEST['tab'] == 3 && !self::$_orderInfo['create_time3']) {
            Func_Header::notFound();
        } else if ($_REQUEST['tab'] == 4 && !self::$_orderInfo['create_time4']) {
            Func_Header::notFound();
        }

    }

    static function handleStep2()
    {
        if (self::$_orderInfo['create_time2']) {
            $updateOrderConform = false;
            if (empty(self::$_orderInfo['order_conform']['买家签约代表'])) {
                //加载买家信息
                $r = Data_Mysql_Table_Account::select('phone, attr', array('id' => self::$_orderInfo['buyer_account_id']));
                if (empty($r[0])) {
                    Func_Header::notFound();
                }
                $buyer = $r[0];
                $buyer['attr'] = json_decode($buyer['attr'], 1);
                if (!empty($buyer['attr']['identity']['data']['公司名称'])) {
                    self::$_orderInfo['order_conform']['买家名称'] = $buyer['attr']['identity']['data']['公司名称'];
                    self::$_orderInfo['order_conform']['买家签约代表'] = $buyer['attr']['identity']['data']['法人代表'];
                    self::$_orderInfo['order_conform']['买家地址'] = $buyer['attr']['identity']['data']['公司地址'];
                    self::$_orderInfo['order_conform']['买家电话'] = $buyer['attr']['identity']['data']['公司电话'];
                    self::$_orderInfo['order_conform']['买家传真'] = $buyer['attr']['identity']['data']['传真号码'];
                } else if (!empty($buyer['attr']['identity']['data']['真实姓名'])) {
                    self::$_orderInfo['order_conform']['买家名称'] = $buyer['attr']['identity']['data']['真实姓名'];
                    self::$_orderInfo['order_conform']['买家签约代表'] = $buyer['attr']['identity']['data']['真实姓名'];
                    self::$_orderInfo['order_conform']['买家地址'] = $buyer['attr']['identity']['data']['住址'];
                    self::$_orderInfo['order_conform']['买家电话'] = $buyer['phone'];
                } else {
                    self::$_orderInfo['order_conform']['买家名称'] = '未认证';
                    self::$_orderInfo['order_conform']['买家签约代表'] = '';
                }
                $updateOrderConform = true;
            }
            if (empty(self::$_orderInfo['order_conform']['供应商名称'])) {
                //加载卖家信息
                $r = Data_Mysql_Table_Account::select('phone, attr', array('id' => self::$_orderInfo['vendor_account_id']));
                if (empty($r[0])) {
                    Func_Header::notFound();
                }
                if (!empty($r[0])) {
                    $vendor = $r[0];
                    $vendor['attr'] = json_decode($vendor['attr'], 1);
                    if (!empty($vendor['attr']['identity']['data']['公司名称'])) {
                        self::$_orderInfo['order_conform']['供应商名称'] = $vendor['attr']['identity']['data']['公司名称'];
//                        self::$_orderInfo['order_conform']['供应商签约代表'] = empty(self::$_orderInfo['order_conform']['供应商签约代表'])?$vendor['attr']['identity']['data']['法人代表']:self::$_orderInfo['order_conform']['供应商签约代表'];
                        self::$_orderInfo['order_conform']['供应商地址'] = empty(self::$_orderInfo['order_conform']['供应商地址'])?$vendor['attr']['identity']['data']['公司地址']:self::$_orderInfo['order_conform']['供应商地址'];
                        self::$_orderInfo['order_conform']['供应商电话'] = empty(self::$_orderInfo['order_conform']['供应商电话'])?$vendor['attr']['identity']['data']['公司电话']:self::$_orderInfo['order_conform']['供应商电话'];
                        self::$_orderInfo['order_conform']['供应商传真'] = empty(self::$_orderInfo['order_conform']['供应商传真'])?$vendor['attr']['identity']['data']['传真号码']:self::$_orderInfo['order_conform']['供应商传真'];
                    } else if (!empty($vendor['attr']['identity']['data']['真实姓名'])) {
                        self::$_orderInfo['order_conform']['供应商名称'] = empty(self::$_orderInfo['order_conform']['供应商名称'])?$vendor['attr']['identity']['data']['真实姓名']:self::$_orderInfo['order_conform']['供应商名称'];
//                        self::$_orderInfo['order_conform']['供应商签约代表'] = empty(self::$_orderInfo['order_conform']['供应商签约代表'])?$vendor['attr']['identity']['data']['真实姓名']:self::$_orderInfo['order_conform']['供应商签约代表'];
                        self::$_orderInfo['order_conform']['供应商电话'] =empty(self::$_orderInfo['order_conform']['供应商电话'])? $vendor['phone']:self::$_orderInfo['order_conform']['供应商电话'];
                    } else {
                        self::$_orderInfo['order_conform']['供应商名称'] = empty(self::$_orderInfo['order_conform']['供应商名称'])?'未认证':self::$_orderInfo['order_conform']['供应商名称'];
                        self::$_orderInfo['order_conform']['供应商签约代表'] =empty(self::$_orderInfo['order_conform']['供应商签约代表'])? '':self::$_orderInfo['order_conform']['供应商签约代表'];
                    }
                }
                $updateOrderConform = true;
            }
            if ($updateOrderConform) {
//                q(self::$_orderInfo);
            }
        }
    }

    static function handleStep3()
    {

        if (self::$_orderInfo['create_time3']) {
            //加载付款信息
            self::$_orderInfo['payment'] = Finance_Payment::getListByOrderId(self::$_orderInfo['id'], self::$_orderInfo['create_time3']);
            if (empty(self::$_orderInfo['payment'])) {
                self::resolveCreatePaymentInfo();
            }
            $lastPaymentTime = 0;
            foreach (self::$_orderInfo['payment'] as $v) {
                $lastPaymentTime = $v['payment_time'];
                if (!$lastPaymentTime) {
                    break;
                }
            }
            if ($lastPaymentTime && !self::$_orderInfo['create_time4']) {
                self::$_orderInfo['create_time4'] = $lastPaymentTime;
                Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
                    'create_time4' => self::$_orderInfo['create_time4'],
                    'order_status' => 20,
                ));
                $_REQUEST['tab'] = 4;
            }
            if ($_REQUEST['tab'] == 4) {
                self::$_orderInfo['order_price_settle'] = 0;
                self::$_orderInfo['order_price_settle_in'] = 0;
                foreach (self::$_orderInfo['payment'] as $v) {
                    if (!$v['payment_detail']['is_in_order']) {
                        self::$_orderInfo['order_price_settle'] += $v['amount'];
                    } elseif (!empty($v['payment_detail']['is_settle'])) {
                        self::$_orderInfo['order_price_settle'] += $v['amount'];
                        self::$_orderInfo['order_price_settle_in'] += $v['amount'];
                    }
                }
                if (self::$_orderInfo['order_status'] == 90) {
                    self::resolveOrderSettle();
                }
            }
            self::resolveOrderCommission();
        }
    }

    static function resolveOrderCommission()
    {

        //收取 平台佣金.
        if (!empty(self::$_orderInfo['order_commission']) && self::$_orderInfo['order_commission'] > 0 && empty(self::$_orderInfo['order_commission_is_pay'])) {
            //从余额中扣除佣金
            /*
             *      (n    >   供应商账户)                              --------合同佣金-------->                       (-3   >   我们公司账户)
             */
            Finance_Account::addDetail(-3, self::$_orderInfo['vendor_account_id'], self::$_orderInfo['order_commission'], '合同佣金', self::$_orderInfo['order_no'], array(
                'payment_title' => self::$_orderInfo['order_conform']['协议标题'] . " - 合同佣金",
                'order_commission' => self::$_orderInfo['order_commission'],
                'order_no' => self::$_orderInfo['order_no'],
            ));
            Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
                'order_commission_is_pay' => time(),
            ));
        }
    }

    static function resolveOrderSettle()
    {
        if (empty(self::$_orderInfo['order_price_settle']) || empty(self::$_orderInfo['order_complete']['结算金额']) || self::$_orderInfo['order_status'] != 90) {
            return false;
        }
        if (self::$_orderInfo['order_complete']['结算金额'] > self::$_orderInfo['order_price_settle']) {
            return false;
        }
        //结算,操作后续款项,  押金和担保交易余额结算给买家和卖家.//从余额中扣除佣金
        if (self::$_orderInfo['order_complete']['结算金额'] >= self::$_orderInfo['order_price_settle_in']) {
            // 如果结算金额 >= order_price_settle_in   :  -6 > vendor   ; -5 > vendor ; -5 > buyer
            Finance_Account::addDetail(self::$_orderInfo['vendor_account_id'], -6, self::$_orderInfo['order_price_settle_in'], '结算', self::$_orderInfo['order_no'], array(
                'payment_title' => self::$_orderInfo['order_conform']['协议标题'] . " - 结算",
                'order_commission' => self::$_orderInfo['order_commission'],
                'order_no' => self::$_orderInfo['order_no'],
            ));
            if (self::$_orderInfo['order_complete']['结算金额'] != self::$_orderInfo['order_price_settle_in']) {
                Finance_Account::addDetail(self::$_orderInfo['vendor_account_id'], -5, self::$_orderInfo['order_complete']['结算金额'] - self::$_orderInfo['order_price_settle_in'], '押金扣除', self::$_orderInfo['order_no'], array(
                    'payment_title' => self::$_orderInfo['order_conform']['协议标题'] . " - 押金扣除",
                    'order_commission' => self::$_orderInfo['order_commission'],
                    'order_no' => self::$_orderInfo['order_no'],
                ));
            }
            Finance_Account::addDetail(self::$_orderInfo['buyer_account_id'], -5, self::$_orderInfo['order_price_settle'] - self::$_orderInfo['order_complete']['结算金额'], '押金返还', self::$_orderInfo['order_no'], array(
                'payment_title' => self::$_orderInfo['order_conform']['协议标题'] . " - 押金返还",
                'order_commission' => self::$_orderInfo['order_commission'],
                'order_no' => self::$_orderInfo['order_no'],
            ));
        } else {
            // 如果 结算金额 < order_price_settle_in : -6 > vendor ; -6 > buyer ;  -5 > buyer ;
            Finance_Account::addDetail(self::$_orderInfo['vendor_account_id'], -6, self::$_orderInfo['order_complete']['结算金额'], '结算', self::$_orderInfo['order_no'], array(
                'payment_title' => self::$_orderInfo['order_conform']['协议标题'] . " - 结算",
                'order_commission' => self::$_orderInfo['order_commission'],
                'order_no' => self::$_orderInfo['order_no'],
            ));
            Finance_Account::addDetail(self::$_orderInfo['buyer_account_id'], -6, self::$_orderInfo['order_price_settle_in'] - self::$_orderInfo['order_complete']['结算金额'], '结算返还', self::$_orderInfo['order_no'], array(
                'payment_title' => self::$_orderInfo['order_conform']['协议标题'] . " - 结算返还",
                'order_commission' => self::$_orderInfo['order_commission'],
                'order_no' => self::$_orderInfo['order_no'],
            ));
            Finance_Account::addDetail(self::$_orderInfo['buyer_account_id'], -5, self::$_orderInfo['order_price_settle'] - self::$_orderInfo['order_price_settle_in'], '押金返还', self::$_orderInfo['order_no'], array(
                'payment_title' => self::$_orderInfo['order_conform']['协议标题'] . " - 押金返还",
                'order_commission' => self::$_orderInfo['order_commission'],
                'order_no' => self::$_orderInfo['order_no'],
            ));

        }
        //更改订单状态防止多次触发
        Data_Mysql_Table_Order_Info::update(self::$_orderInfo['id'], array(
            'order_status' => 91,
        ));
    }

    static function resolveCreatePaymentInfo()
    {
        if (empty(self::$_orderInfo['order_conform']['支付节点'])) {
            return;
        }
        //添加付款对账单
        foreach (self::$_orderInfo['order_conform']['支付节点'] as $k => $v) {
            //结算类支付则先支付到 担保帐户
            Finance_Payment::createReceive(self::$_orderInfo['buyer_account_id'], !empty($v['结算']) ? -6 : self::$_orderInfo['vendor_account_id'], self::$_orderInfo['id'], self::$_orderInfo['order_conform']['协议标题'] . ' ' . ($k + 1) . '. ' . $v['名称'], $v['金额'], array(
                'order_no' => self::$_orderInfo['order_no'],
                'agreement_title' => self::$_orderInfo['order_conform']['协议标题'],
                'buyer_account_id' => self::$_orderInfo['buyer_account_id'],
                'buyer_account' => self::$_orderInfo['order_conform']['买家名称'],
                'vendor_account_id' => self::$_orderInfo['vendor_account_id'],
                'vendor_id' => self::$_orderInfo['vendor_id'],
                'payment_title' => ($k + 1) . '. ' . $v['名称'],
                'payment_percent' => $v['比例'] * 100,
                'payment_deadline' => strtotime($v['期限']),
                'is_first' => !$k, //是否第一笔支付,, 用于判断扣除 佣金
                'is_in_order' => true,
                'is_settle' => !empty($v['结算']), //是否担保交易
                'deal_account_id' => self::$_orderInfo['deal_account_id'], //经纪人
                'order_commission_deal' => ceil(self::$_orderInfo['order_commission_deal_per'] * self::$_orderInfo['order_conform']['交易总计'] / 10) / 10,
            ));
        }
        foreach (self::$_orderInfo['order_conform']['订单外款项'] as $k => $v) {
            Finance_Payment::createReceive(self::$_orderInfo['buyer_account_id'], -5, self::$_orderInfo['id'], self::$_orderInfo['order_conform']['协议标题'] . ' 订单外款项. ' . $v['名称'], $v['金额'], array(
                'order_no' => self::$_orderInfo['order_no'],
                'agreement_title' => self::$_orderInfo['order_conform']['协议标题'],
                'buyer_account_id' => self::$_orderInfo['buyer_account_id'],
                'buyer_account' => self::$_orderInfo['order_conform']['买家名称'],
                'vendor_account_id' => self::$_orderInfo['vendor_account_id'],
                'vendor_id' => self::$_orderInfo['vendor_id'],
                'payment_title' => '订单外款项. ' . $v['名称'],
                'payment_deadline' => strtotime($v['期限']),
                'is_in_order' => false,
            ));
        }
        self::$_orderInfo['payment'] = Finance_Payment::getListByOrderId(self::$_orderInfo['id'], self::$_orderInfo['create_time3']);
    }

}