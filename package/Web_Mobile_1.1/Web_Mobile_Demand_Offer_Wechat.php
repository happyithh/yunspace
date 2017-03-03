<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/28
 * Time: 16:38
 */
@$_REQUEST['demand_id'] = Func_NumEncode::d($_REQUEST['demand_id']);

class Web_Mobile_Demand_Offer_Wechat
{
    static function handleCustomer()
    {
        Tpl_Smarty::assign('isCustomer', 1);

        $action = @$_REQUEST['action'];
        switch ($action) {
            case 'detail':
                self::handleCustomerDemandDetail();
                break;
            default:
                self::handleCustomerHome();
                break;
        }
    }

    static function  handleCustomerHome()
    {
        $data = Api_Demand_Offer_GetListByCondition::handle(array(
            'action' => 'customer',
            'status' => @$_REQUEST['status']
        ));
        Tpl_Smarty::assign('data', $data['data']);
        Tpl_Smarty::display("Web_Mobile_Static::demand_offer.v2.0/wechat/customer_home.php.tpl");

    }

    /**
     *
     * 需求报价详情页
     */
    static function handleCustomerDemandDetail()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',

        ));
        $sum = Api_Demand_Offer_GetData::getSchemeSum(array('demand_id' => $request['demand_id']));
        Tpl_Smarty::assign('sum', $sum);
        Tpl_Smarty::assign('demand_title', '我收到的场地报价(共' . intval($sum) . '份)');
        $demand_offer = Api_Demand_Offer_GetData::getDemandOfferByCondition(array(
            'demand_id' => $request['demand_id'],
            'account_id' => Api_Session::user_id(),
        ));
        if (empty($demand_offer)) {
            Func_Header::back('需求记录没有找到！');
        }

        $schemeList = Api_Demand_Offer_GetOfferRecord::offerRecord(array('demand_id' => $request['demand_id']));

        Tpl_Smarty::assign('schemeList', $schemeList['data']);
        $demand_offer['demand_id'] = Func_NumEncode::e($demand_offer['demand_id']);
        Tpl_Smarty::assign('demand_offer', $demand_offer);

        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v2.0/wechat/customer_demand_detail.php.tpl');
    }

    /***
     * 供应商
     */
    static function  handleVendor()
    {
        $action = empty($_REQUEST['action']) ? 'home' : $_REQUEST['action'];
        switch ($action) {
            case 'home':
                self::handleVendorHome();

                break;
        }
    }

    static function  handleVendorHome()
    {
        $data = Api_Demand_Offer_GetListByCondition::handle(array(
            'action' => 'vendor',
            'status' => @$_REQUEST['status'],
            'search' => @$_REQUEST['search']
        ));

        $start_time = 1443628800;
        $allTime = array();
        while ($start_time < time()) {
            $allTime[date('Y', $start_time)][] = date('m', $start_time);
            $start_time = strtotime('+1 month', $start_time);
        }
        krsort($allTime);
        Tpl_Smarty::assign('allTime', $allTime);
        Tpl_Smarty::assign('reported_count', @$data['reported_count']);
        Tpl_Smarty::assign('data', $data['data']);
        Tpl_Smarty::display("Web_Mobile_Static::demand_offer.v2.0/wechat/vendor_home.php.tpl");

    }


}