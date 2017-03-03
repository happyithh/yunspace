<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/19
 * Time: 10:45
 */
@$_REQUEST['result_id'] = Func_NumEncode::d($_REQUEST['result_id']);
@$_REQUEST['demand_id'] = Func_NumEncode::d($_REQUEST['demand_id']);
@$sum = Api_Demand_Offer_GetData::getSchemeSum(array('demand_id' => $_REQUEST['demand_id']));
Tpl_Smarty::assign('sum', $sum);

class  Web_Mobile_Demand_Offer
{
    /**
     * 客户中心
     */
    static function  customer()
    {
        Tpl_Smarty::assign('isCustomer', 1);
        //1.用户中心页面
        $action = empty($_REQUEST['action']) ? 'home' : $_REQUEST['action'];
        switch ($action) {
            case 'home':
                self::handleCustomerHome();
                break;
            case 'demand_edit':
                self::handleCustomerDemandEdit();
                break;
        }
    }

    /**
     *  客户中心---首页
     */
    static function  handleCustomerHome()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
        ));
        $demand_data = Api_Demand_Offer_GetData::getDemandOfferByCondition(array(
            'demand_id' => $request['demand_id'],
        ));
        if (empty($demand_data)) {
            Func_Header::back('没有找到需求记录！~');
        }

        $matchSum = Api_Demand_Offer_GetData::getMatchSum(array(
            'demand_id' => $request['demand_id'],
            'offer_id' => $demand_data['id'],
        ));
        Tpl_Smarty::assign('matchSum', $matchSum);
        $sql = "UPDATE {table} SET view_count_c=view_count_c+1 WHERE demand_id=?";
        Data_Mysql_Table_Demand_Offer::query($sql, array($demand_data['demand_id']));

        /**订单质量*/
        $vs = Data_Mysql_Table_Demand_Offer::select("sum(view_count_c) as c_num", array('demand_id =?' => $demand_data['demand_id']));
        $es = Data_Mysql_Table_Demand_Offer_Quantity::select('*', array('demand_id =?' => $demand_data['demand_id']));
        if ($vs[0]['c_num'] == 1 && empty($es[0]['c_num'])) {
            $sql = "UPDATE {table} SET order_quality=order_quality+5 WHERE demand_id=?";
            Data_Mysql_Table_Demand_Offer::query($sql, array($demand_data['demand_id']));
            if (empty($es)) {
                $data = array(
                    'demand_id' => $request['demand_id'],
                    'c_num' => 1
                );
                Data_Mysql_Table_Demand_Offer_Quantity::insert($data);
            } else {
                $data = array(
                    'demand_id' => $request['demand_id'],
                );
                Data_Mysql_Table_Demand_Offer_Quantity::update($data, array('c_num=?' => 1));
            }

        }
        if ($vs[0]['c_num'] == 4 && empty($es[0]['c_num_three'])) {
            $sql = "UPDATE {table} SET order_quality=order_quality+15 WHERE demand_id=?";
            Data_Mysql_Table_Demand_Offer::query($sql, array($demand_data['demand_id']));
            $sql_query = "UPDATE {table} SET c_num_three=c_num_three+1 WHERE demand_id=?";
            Data_Mysql_Table_Demand_Offer_Quantity::query($sql_query, array($demand_data['demand_id']));

        }


        $demand_data['demand_id'] = Func_NumEncode::e($demand_data['demand_id']);

        Tpl_Smarty::assign('demand_offer', $demand_data);

        $schemeList = Api_Demand_Offer_GetOfferRecord::offerRecord(array('demand_id' => $request['demand_id']));

        Tpl_Smarty::assign('schemeList', $schemeList['data']);
        Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v2.0/demand_offer_customer.php.tpl');
    }


    /**
     * 客户修改需求
     */
    static function  handleCustomerDemandEdit()
    {

        $request = Func_Input::filter(array(
            'demand_id' => 'int',

        ), $_REQUEST);
        if (empty($request['demand_id'])) {
            Func_Header::back('请返回重试~');
        }

        $data = Api_Demand_Offer_GetData::getDemandOfferByCondition(array(
            'demand_id' => $request['demand_id'],
            'account_id' => Api_Session::user_id()
        ));
        if (empty($data)) {
            Func_Header::back('需求记录不存在~');
        }

        $option = Data_Demand_Option_Config::all();
        $attr = Data_Config_Vendor_Attr::get('attr');
        $option['活动类型'] = $attr['活动类型'];
        Tpl_Smarty::assign('option', $option);
        $data['demand_id'] = Func_NumEncode::e($data['demand_id']);
        Tpl_Smarty::assign('data', $data);
        Tpl_Smarty::display("Web_Mobile_Static::demand_offer.v2.0/demand_offer_my.php.tpl");


    }


    /**
     * 供应商中心
     */
    static function vendor()
    {

        //1.供应商中心-首页
        $action = empty($_REQUEST['action']) ? 'home' : $_REQUEST['action'];
        Tpl_Smarty::assign('unit', Data_Mysql_Table_Demand_Offer::$_offer_price_unit);

        switch ($action) {
            case 'home':
                self::vendorHome();
                break;
            case 'tags_edit':
                self::tagsEdit();
                break;
            case 'offer_edit':
                self::offerEdit();
                break;
        }

    }

    /**
     *商家首页
     */
    static function  vendorHome()
    {

        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'result_id' => 'int',
        ), $_REQUEST);

        $data = Api_Demand_Offer_GetDataVendor::handle(array(
            'result_id' => $request['result_id'],
            'demand_id' => $request['demand_id']
        ));
        Tpl_Smarty::assign('data', $data['data']);

        $demand = Api_Demand_Offer_GetData::getDemandOfferByCondition(array('demand_id' => $request['demand_id']));
        $sql = "UPDATE {table} SET view_count_v=view_count_v+1 WHERE demand_id=?";
        Data_Mysql_Table_Demand_Offer::query($sql, array($demand['demand_id']));
        $vs = Data_Mysql_Table_Demand_Offer::select("sum(view_count_v) as v_num", array('demand_id =?' => $request['demand_id']));
        $es = Data_Mysql_Table_Demand_Offer_Quantity::select('*', array('demand_id =?' => $request['demand_id']));
        if ($vs[0]['v_num'] == 1 && empty($es[0]['v_num'])) {
            $sql = "UPDATE {table} SET order_quality=order_quality+10 WHERE demand_id=?";
            Data_Mysql_Table_Demand_Offer::query($sql, array($request['demand_id']));
            if (empty($es)) {
                $data = array(
                    'demand_id' => $request['demand_id'],
                    'v_num' => 1
                );
                Data_Mysql_Table_Demand_Offer_Quantity::insert($data);
            } else {
                $data = array(
                    'demand_id' => $request['demand_id'],
                );
                Data_Mysql_Table_Demand_Offer_Quantity::update($data, array('v_num =?' => 1));
            }

        }

        if ($vs[0]['v_num'] == 6 && empty($es[0]['v_num_five'])) {
            $sql = "UPDATE {table} SET order_quality=order_quality+10 WHERE demand_id=?";
            Data_Mysql_Table_Demand_Offer::query($sql, array($request['demand_id']));
            $sql_query = "UPDATE {table} SET v_num_five=v_num_five+1 WHERE demand_id=?";
            Data_Mysql_Table_Demand_Offer_Quantity::query($sql_query, array($request['demand_id']));

        }
        $demand['demand_id'] = Func_NumEncode::e($demand['demand_id']);

        Tpl_Smarty::assign('demand_offer', $demand);
        if ($data['status'] == 1) {
            Tpl_Smarty::assign('newTags', $data['tagsNotHave']);
            Tpl_Smarty::assign('result_id', $data['result_id']);
            Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v2.0/demand_offer_vendorBid.php.tpl');

        } elseif ($data['status'] == 2) {
            Tpl_Smarty::assign('item', $data['item']);
            Tpl_Smarty::assign('result_id', Func_NumEncode::e($request['result_id']));
            Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v2.0/demand_offer_vendor.php.tpl');

        } elseif ($data['status'] == 3) {

            Tpl_Smarty::display('Web_Mobile_Static::demand_offer.v2.0/demand_offer_vendor_unable.php.tpl');

        } else {
            Func_Header::back('需求记录没有找到~~');
        }

    }

    static function  tagsEdit()
    {
        @session_start();

        $request = Func_Input::filter(array(
            'item_id' => 'int',
        ));
        $conditions['phone =? AND id =?'] = array($_SESSION['user']['phone'], $request['item_id']);

        $data = Data_Mysql_Table_Space_Item::select('id,tags', $conditions);
        if (empty($data[0])) {
            Func_Header::back('不存在的商品~');
        }
        $rs = $data[0];

        $rs['tags'] = Data_Mysql_Table_Demand_Tag::convertVal(json_decode($rs['tags'], 1));
        Tpl_Smarty::assign('data', $rs);

        Tpl_Smarty::assign('tags_recommend', Data_Mysql_Table_Demand_Tag::getRandTags());

        $_REQUEST['result_id'] = Func_NumEncode::e($_REQUEST['result_id']);
        Tpl_Smarty::display("Web_Mobile_Static::demand_offer.v2.0/demand_offer_removeMk.php.tpl");
    }

    /**
     * 报价修改
     */
    static function  offerEdit()
    {
        @session_start();

        $request = Func_Input::filter(array(
            'result_id' => 'int',
            'demand_id' => 'int',
        ));
        $data = Api_Demand_Offer_GetDataVendor::getOfferEditData(array(
            'result_id' => $request['result_id'],
            'demand_id' => $request['demand_id']
        ));
        if (!empty($data['offer'])) {
            Tpl_Smarty::assign('data', $data['data']);
            Tpl_Smarty::assign('offer', $data['offer']);
            Tpl_Smarty::assign('result_id', $data['result_id']);

            Tpl_Smarty::display("Web_Mobile_Static::demand_offer.v2.0/demand_offer_vendor_edit.tpl");
        }

    }
}