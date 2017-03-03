<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/11/5
 * Time: 16:49
 */
class Api_Demand_Offer_Check_Offer_Admin extends Api
{
    static function  handle($args = '')
    {
        $type = isset($_REQUEST['type']) ? $_REQUEST['type'] : 0;
        switch ($type) {
            case 0:
                return self::allot($args);
                break;
            case 1;
                return self::released($args);
                break;
            case 2:
                return self::complete($args);
                break;

        }
//        return self::allot($args);
    }

    static function  allot($args)
    {
        $request = Func_Input::filter(array(
            'offer_id' => 'int',
            'demand_id' => 'int',
        ), $args);
        if (empty($request['offer_id']) || empty($request['demand_id'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数的合法性！');
        }
        @session_start();
        if (empty($_SESSION['administrator']) || !isset($_SESSION['administrator']['id'])) {
            return self::request('error', '', '登录信息错误！请重新登录！');
        }
        $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $_SESSION['administrator']['id']));
        if (!empty($administratorAccount['account_id'])) {
            $account_id = $administratorAccount['account_id'];
        } else {
            return self::request('error', '', '没有负责人的帐户信息');
        }

        $data = array(
            'admin_id=?' => $_SESSION['administrator']['id'],
            'receive_time' => time(),
        );

        $demand_up = Data_Mysql_Table_Demand_Offer::update(array('id =?' => $request['offer_id']), $data);
        if ($demand_up[0] == 0) {
            return Api::request('error', '', '领取失败');
        }

        Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '领取报价信息', $_SESSION['administrator']['username'] . '领取报价,id' . $request['offer_id'], $request['offer_id']);

        return Api::request('success', '', '  领取成功');


    }

    static function  released($args)
    {
        $request = Func_Input::filter(array(
            'offer_id' => 'int',
            'demand_id' => 'int',
        ), $args);
        if (empty($request['offer_id']) || empty($request['demand_id'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数的合法性！');
        }
        @session_start();
        if (empty($_SESSION['administrator']) || !isset($_SESSION['administrator']['id'])) {
            return self::request('error', '', '登录信息错误！请重新登录！');
        }
        $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $_SESSION['administrator']['id']));
        if (!empty($administratorAccount['account_id'])) {
            $account_id = $administratorAccount['account_id'];
        } else {
            return self::request('error', '', '没有负责人的帐户信息');
        }

        $data = array(
            'admin_id=?' => 0,
            'receive_time' => 0,
        );

        $demand_up = Data_Mysql_Table_Demand_Offer::update(array('id =?' => $request['offer_id']), $data);
        if ($demand_up[0] == 0) {
            return Api::request('error', '', '释放失败');
        }

        Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '释放报价信息', $_SESSION['administrator']['username'] . '释放报价,id' . $request['offer_id'], $request['offer_id']);

        return Api::request('success', '', '  释放成功');


    }

    static function  complete($args)
    {
        $request = Func_Input::filter(array(
            'offer_id' => 'int',
            'demand_id' => 'int',
            'offer_status' => 'int',
            'reason' => 'string'
        ), $args);
        if (empty($request['offer_id']) || empty($request['demand_id']) || empty($request['offer_status'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数的合法性！');
        }
        @session_start();
        if (empty($_SESSION['administrator']) || !isset($_SESSION['administrator']['id'])) {
            return self::request('error', '', '登录信息错误！请重新登录！');
        }
        $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $_SESSION['administrator']['id']));
        if (!empty($administratorAccount['account_id'])) {
            $account_id = $administratorAccount['account_id'];
        } else {
            return self::request('error', '', '没有负责人的帐户信息');
        }
        $contact_people = Data_Mysql_Table_Contact_Library::select('id', array('phone =?' => $administratorAccount['phone']));
        if (empty($contact_people[0])) {
            $demand_data = Data_Mysql_Table_Demand::select('*', array('phone=?' => $administratorAccount['phone']));
            $demand = Data_Mysql_Table_Demand::rowFormat($demand_data[0]);
            $contact = array(
                'username' => $demand['demand']['联系人'],
                'phone' => $demand['phone'],
                'city' => $demand['city'],
//                'business' => $demand['demand']['业务类型'],
//                'sub_business' => $demand['demand']['业务子类'],
                'company' => $demand['demand']['公司名称'],
                'type' => 1,
                'customer_type' => 1,
                'create_time' => time(),
                'account_id' => $demand['account_id'],
            );
            $status = Data_Mysql_Table_Contact_Library::update($contact);
            if ($status[0] > 0) {
                $contact_people[0]['id'] = $status[0];
            } else {
                Func_Header::back('联系人不存在！');
            }
        }

        $data = array(
            'status=?' => $request['offer_status'],
            'reason' => empty($request['reason']) ? '' : $request['reason'],
        );
        if (!empty($request['offer_status'])) {
            if($request['offer_status'] == 4){

                $reason='完成/'.(empty($request['reason']) ? '' : $request['reason']);
            }
            if($request['offer_status'] == -1){

                $reason='关闭/'.(empty($request['reason']) ? '' : $request['reason']);
            }
        }
        $content = array(
            'contact_id' => $contact_people[0]['id'],

            'content' => $reason,
            'admin_id' => $_SESSION['administrator']['id'],
            'admin_name' => $_SESSION['administrator']['username'],
            'time' => time(),

        );
        $demand_up = Data_Mysql_Table_Demand_Offer::update(array('id =?' => $request['offer_id']), $data);
        if ($demand_up[0] == 0) {
            return Api::request('error', '', '结束失败');
        }

        $rs = Data_Mysql_Table_Contact_Record::insert($content);
        if ($rs[0] == 0) {
            return Api::request('error', '', '结束失败');
        }

        Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '结束报价信息', $_SESSION['administrator']['username'] . '结束报价,id' . $request['offer_id'], $request['offer_id']);

        return Api::request('success', '', '  结束成功');


    }
}