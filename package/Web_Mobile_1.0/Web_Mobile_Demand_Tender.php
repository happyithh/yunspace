<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/9/1
 * Time: 10:45
 */

Tpl_Smarty::assign('__user', Api_Session::user_info());
Web_Account::handleIsLogin('');

class  Web_Mobile_Demand_Tender
{

    /**
     * 客户中心
     */
    static function  customer()
    {
        //1.用户中心页面
        $action = empty($_REQUEST['action']) ? 'home' : $_REQUEST['action'];
        switch ($action) {

            case 'home':
                self::handleCustomerHome();
                break;
            case 'ajaxLoadMore':
                self::CustomerAjaxLoadMore();
                break;
            case 'close':
                self::CustomerAjaxClose();
                break;
        }

    }

    /**
     *  客户中心---首页
     */
    static function  handleCustomerHome()
    { 
        if(!isset($_COOKIE['is_one'])){
            $_COOKIE['is_one']=1;
        }
        $request = Func_Input::filter(array(
            'tender_id' => 'int',
            'demand_id' => 'int',
        ));
        $request['account_id'] = Api_Session::user_id();
        $demand_tender = Api_Demand_Tender_GetData::getDemandTenderByCondition(array(
            'account_id' => $request['account_id'],
            'demand_id' => $request['demand_id'],
            'id' => $request['tender_id']));
        if (empty($demand_tender)) {
            Func_Header::back('没有找到相关信息，请刷新重试~');
        }
        Tpl_Smarty::assign('demand_tender', $demand_tender);
        $schemeList = Api_Demand_Tender_GetData::getBidRecord(array('tender_id' => $demand_tender['id']));

        Tpl_Smarty::assign('schemeList', $schemeList);
        Tpl_Smarty::display('Web_Mobile_Static::demand_tender.v1.0/demand_tender_customer.php.tpl');
    }

    static function  CustomerAjaxLoadMore()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'last_id' => 'int',
            'tender_id' => 'int',
        ));

        Tpl_Smarty::assign('schemeList', Api_Demand_Tender_GetData::getBidRecord(
            array(
                'tender_id' => $request['tender_id'],
                'last_id' => $request['last_id'],
            )));
        $tpl = Tpl_Smarty::fetch('Web_Mobile_Static::/demand_tender.v1.0/inc/inc.scheme_list.tpl');
        if ($tpl) {
            Func_Output::json('success', $tpl, '成功');
        }
        Func_Output::json('error', '', '没有数据');

    }

    static function  CustomerAjaxClose()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'tender_id' => 'int',
        ));
        $update = array();
        Data_Mysql_table_Demand_Tender::update($update);
    }

    /**
     * 供应商中心
     */
    static function vendor()
    {
        //1.供应商中心-首页
        $action = empty($_REQUEST['action']) ? 'home' : $_REQUEST['action'];
        switch ($action) {
            case 'home':
                self::handleVendorHome();
                break;
            case 'close':
                self::handleVendorClose();
                break;
        }

    }

    /**
     *
     * 供应商首页
     */
    static function  handleVendorHome()
    {
        @session_start();
        Api_Session::checkToken(1);
        $request = Func_Input::filter(array(
            'tender_id' => 'int',
            'demand_id' => 'int',
        ));
        //日志
        Api_Log_Create::handle(array(
            'class' => get_called_class(),
            'func' => __FUNCTION__,
            'tender_id' => $request['tender_id'],
            'behavior' => '商家打开连接' . Core::$urls['uri'],
        ));
        if (empty($_SESSION['user']['id']) || (empty($request['tender_id']) && empty($request['demand_id']))) {
            Func_Header::back('请返回页面重新打开');
        }
        $demand_tender = Api_Demand_Tender_GetData::getDemandTenderByCondition(
            array(
                'id' => $request['tender_id'],
                'demand_id' => $request['demand_id']));
        Tpl_Smarty::assign('demand_tender', $demand_tender);

        $is_exist = Data_Mysql_table_Demand_Tender_Scheme::select('id', array(
            'tender_id=?' => $demand_tender['id'],
            'vendor_account_id=?' => $_SESSION['user']['id']));

        //已经存在
        if (!empty($is_exist[0])) {

            $scheme = Api_Demand_Tender_GetData::getBidRecord(array(
                'vendor_account_id' => $_SESSION['user']['id'],
                'tender_id' => $demand_tender['id'],
                'num' => 1
            ));
            Tpl_Smarty::assign('scheme', $scheme[0]);
            Tpl_Smarty::display('Web_Mobile_Static::demand_tender.v1.0/demand_tender_vendor.php.tpl');
        } else {
            //提交报价
            Tpl_Smarty::assign('product', Api_Product_Search_GetListByVendor::getSpace(array('account_id' => $_SESSION['user']['id'])));
            Tpl_Smarty::display('Web_Mobile_Static::demand_tender.v1.0/demand_tender_vendorBid.php.tpl');
        }

    }


    /**
     * 供应商中心 --关闭
     *
     */
    static function  handleVendorClose()
    {
        /**
         * TODO::供应商关闭会影响到下次推荐排名会受到影响  ，
         */

    }


}