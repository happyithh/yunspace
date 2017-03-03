<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/27
 * Time: 00:20
 */
class OA_Account_Identity extends Base
{
    static function handle($accountType = 1)
    {

        $action = empty($_REQUEST['action']) ? 'listUnaccepted' : $_REQUEST['action'];
        switch ($action) {
            case 'listAccepted':
                self:: handleListAccepted($accountType);
                break;
            case 'listUnaccepted':
                self:: handleListUnaccepted($accountType);
                break;
            case 'listAll':
                self:: handleListAll($accountType);
                break;
            case 'listReject':
                self:: handleListReject($accountType);
                break;
            case 'info':
                self:: handleUserIdentityInfo($accountType);
                break;
            case 'info_show':
                self::handleVendorIdentityInfoShow($accountType);
                break;
            case 'reject':
                self:: handleUserIdentityReject();
                break;
            case 'pass':
                self:: handleUserIdentityPass();
                break;
            case 'vendor_auto_complete':
                self::handleVendorAutoComplete();
                break;
        }
    }

    static function handleListAccepted($accountType = 1)
    {
        if (!empty($_REQUEST['search'])) {
            $_REQUEST['search']['title'] = trim($_REQUEST['search']['title']);
            if (!empty($_REQUEST['search']['title'])) {
                $conditions = self::handleSearch();
                $sea_url = '&search[title]=' . $_REQUEST['search']['title'];
                Tpl_Smarty::assign('urls', $sea_url);
            }
        }
        $conditions['identity_time>?'] = 0;
        $rs = Data_Mysql_Table_Account::page(0, 15, '*', $conditions, 'ORDER BY id DESC');//, 'account_type' => $accountType
        $table_head = array('手机', '用户名', '邮箱', '全名');
        $page_name = '已审核用户';

        Tpl_Smarty::assign('table_head', $table_head);
        Tpl_Smarty::assign('page_nav', 'yet');
        Tpl_Smarty::assign('page_name', $page_name);
        Tpl_Smarty::assign('_data', $rs);
        Tpl_Smarty::display('OA', 'account_identity_info_list.tpl');
    }

    static function handleListUnaccepted($accountType = 1)
    {
        if (!empty($_REQUEST['search'])) {
            $_REQUEST['search']['title'] = trim($_REQUEST['search']['title']);
            if (!empty($_REQUEST['search']['title'])) {
                $conditions = self::handleSearch();
                $sea_url = '&search[title]=' . $_REQUEST['search']['title'];
                Tpl_Smarty::assign('urls', $sea_url);
            }
        }
        $conditions['identity_time <? '] = -2;
//        Data_Mysql_Table_Account::debug(1);
        $rs = Data_Mysql_Table_Account::page(0, 15, '*', $conditions);
        $page_name = '未审核用户';
        $table_head = array('手机', '用户名', '邮箱', '全名');

        Tpl_Smarty::assign('table_head', $table_head);
        Tpl_Smarty::assign('page_nav', 'notYet');
        Tpl_Smarty::assign('page_name', $page_name);
        Tpl_Smarty::assign('_data', $rs);
        Tpl_Smarty::display('OA', 'account_identity_info_list.tpl');
    }

    static function handleListAll($accountType = 1)
    {
        $conditions = array();
        if (!empty($_REQUEST['search'])) {
            $_REQUEST['search']['title'] = trim($_REQUEST['search']['title']);
            if (!empty($_REQUEST['search']['title'])) {
                $conditions = self::handleSearch();
                $sea_url = '&search[title]=' . $_REQUEST['search']['title'];
                Tpl_Smarty::assign('urls', $sea_url);
            }
        }
        $rs = Data_Mysql_Table_Account::page(0, 15, '*', $conditions);
        $page_name = '全部用户';
        $table_head = array('手机', '用户名', '邮箱', '全名');

        Tpl_Smarty::assign('table_head', $table_head);
        Tpl_Smarty::assign('page_nav', 'all');
        Tpl_Smarty::assign('page_name', $page_name);
        Tpl_Smarty::assign('_data', $rs);
        Tpl_Smarty::display('OA', 'account_identity_info_list.tpl');
    }

    static function handleListReject($accountType = 1)
    {
        if (!empty($_REQUEST['search'])) {
            $_REQUEST['search']['title'] = trim($_REQUEST['search']['title']);
            if (!empty($_REQUEST['search']['title'])) {
                $conditions = self::handleSearch();
                $sea_url = '&search[title]=' . $_REQUEST['search']['title'];
                Tpl_Smarty::assign('urls', $sea_url);
            }
        }
        $conditions['identity_time '] = -1;
        $rs = Data_Mysql_Table_Account::page(0, 15, '*', $conditions);
        foreach ($rs['rows'] as $k => $v) {
            $this_identity = json_decode($rs['rows'][$k]['attr'], true);
            $rs['rows'][$k]['rejectReason'] = $this_identity['new_identity']['rejectReason'];
        }
        $page_name = '已拒绝用户';
        $table_head = array('手机', '用户名', '邮箱', '全名');
        Tpl_Smarty::assign('table_head', $table_head);
        Tpl_Smarty::assign('page_nav', 'rejected');
        Tpl_Smarty::assign('page_name', $page_name);
        Tpl_Smarty::assign('_data', $rs);
        Tpl_Smarty::display('OA', 'account_identity_info_list.tpl');
    }

    static function handleUserIdentityInfo($accountType = 1)
    {
        $userId = $_REQUEST['id'];
        $data = Data_Mysql_Table_Account::select('*', array('id' => $userId));
        //查看该账户下是否已经绑定供应商
        $vendor = Data_Mysql_Table_Vendor_Info::select("id,vendor_name", array('vendor_account_id' => $userId));
        if (!empty($vendor[0]['id'])) {
            Tpl_Smarty::assign('bind_vendor', $vendor[0]['id']);
        }
        $info = json_decode($data[0]['attr'], true);
        if ($accountType == 21) {
            $rs = Data_Mysql_Table_Vendor_Info::select('id, vendor_name,vendor_account_id', array(
                'vendor_name' => empty($info['new_identity']['data']['公司名称']) ? $info['new_identity']['data']['真实姓名'] : $info['new_identity']['data']['公司名称']
            ), '', 5);
            Tpl_Smarty::assign('vendors', $rs);
        }
        $reason = array(
            '证件不全', '资历不够', '其他原因'
        );
        $page_name = '用户审核';
        Tpl_Smarty::assign('rejectreason', $reason);
        Tpl_Smarty::assign('user_id', $userId);
        Tpl_Smarty::assign('page_name', $page_name);
        Tpl_Smarty::assign('data', $info['new_identity']['data']);
        Tpl_Smarty::assign('files', $info['new_identity']['files']);
        Tpl_Smarty::display('OA', 'account_identity_info.tpl');
    }

    /*
     *ajax更换供应商
     */
    static function handleVendorAutoComplete()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'q' => 'string',
        ));
        if (!$request['q']) {
            die('参数错误!');
        }
        $rs = Data_Mysql_Table_Vendor_Info::select('id, CONCAT( "[", id, "] ", vendor_name) as name', array("(id like ? OR vendor_name like ?) AND vendor_account_id = ? " => array($request['q'] . '%', $request['q'] . '%', 0)), '', 5);
        $ajax_arr = array(
            "total_count" => 2,
            "incomplete_results" => false,
            "items" => array(
                array(
                    'id' => 1,
                    'name' => '',
                    'full_name' => ''
                ),
            )
        );
        foreach ($rs as $key => $val) {
            $ajax_arr['items'][$key]['id'] = $val['id'];
            $ajax_arr['items'][$key]['name'] = '';
            $ajax_arr['items'][$key]['full_name'] = $val['name'];
        }
        echo json_encode($ajax_arr);
        die();
    }

    static function handleUserIdentityReject()
    {
        $userId = $_REQUEST['id'];
        $rejectReason = $_REQUEST['rejectReason'];
        $attr = Data_Mysql_Table_Account::select('attr', array('id' => $userId));
        $data = $attr[0]['attr'];
        $innerAttr = json_decode($data, true);
        $innerAttr['new_identity']['rejectReason'] = $rejectReason;
        $rs = Data_Mysql_Table_Account::update(array('id' => $userId), array('identity_time=-1', 'attr' => $innerAttr));

        if ($rs[0]) {
            //发送邮件给供应商账户
            //OA_Account_Check::refuseMailtoAccount($userId,$rejectReason);
            //创建该账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($userId, $_SESSION['administrator']['id'], '账户认证被拒绝', '用户认证');
            Func_Header::to("已拒绝", Core::$urls['path'] . '?action=listReject');
        } else {
            Func_Header::to("拒绝失败！请重试", Core::$urls['path'] . '?action=listUnaccepted');
        }
    }

    static function handleUserIdentityPass()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'vendor_id' => 'int',
            'bind_vendor' => 'int',
        ));
        $userId = $request['id'];
        $userInfo = Data_Mysql_Table_Account::select('username,phone,email,attr,identity_time,account_type', array('id' => $userId));
        $data = $userInfo[0]['attr'];

        $innerAttr = json_decode($data, true);
        if ($request['vendor_id']) {
            //更新供应商绑定的账户信息
            //TODO: 这里有更新 vendor_info 的 vendor_account_id
//            Data_Mysql_Table_Vendor_Info::update(array('id' => $request['vendor_id']), array('vendor_account_id' => $userId));
//            Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id' => $request['vendor_id']), array('vendor_account_id' => $userId));
            //更新订单中的vendor_account_id
            $order_condition['vendor_id'] = $request['vendor_id'];
            $order_condition[] = '( vendor_account_id = 0 or vendor_account_id = 4 )';//超级账户或账户为0
            Data_Mysql_Table_Order_Info::update($order_condition, array('vendor_account_id' => $userId));
        }
        $innerAttr['identity'] = $innerAttr['new_identity'];
        $fullname = empty($innerAttr['new_identity']['data']['公司名称']) ? $innerAttr['new_identity']['data']['真实姓名'] : $innerAttr['new_identity']['data']['公司名称'];
        unset($innerAttr['new_identity']);
        $rightTime = $userInfo[0]['identity_time'] * -1;
        $updateData = array('attr' => $innerAttr, 'identity_time' => $rightTime, 'fullname' => $fullname);
        if ($request['vendor_id'] || $request['bind_vendor']) {
            $updateData['account_type'] = 21;
        }
        $rs = Data_Mysql_Table_Account::update(
            array('id' => $userId),
            $updateData
        );
        if ($rs[0]) {
            if (!empty($userInfo[0]['phone'])) {
                Web_Message::userIdentitySuccess($userInfo[0]['phone'], $userInfo[0]['username']);
            }
            if (!empty($userInfo[0]['email'])) {
                Web_Message::userIdentitySuccessEmail($userInfo[0]['email'], $userInfo[0]['username']);
            }
            //创建该账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($userId, $_SESSION['administrator']['id'], '账户审核通过', '账户审核');
            Func_Header::to(" 审核已通过", Core::$urls['path'] . '?action=listAccepted');

        } else {
            if (!empty($userInfo[0]['phone'])) {
                Web_Message::userIdentityFail($userInfo[0]['phone'], $userInfo[0]['username']);
            }
            if (!empty($userInfo[0]['email'])) {
                Web_Message::userIdentityFailEmail($userInfo[0]['email'], $userInfo[0]['username']);
            }
            Func_Header::to("审核失败！请重试", Core::$urls['path'] . '?action=listUnaccepted');
        }
    }

    //  搜索

    static function handleSearch()
    {
        $search = Func_Input::filter(array(
            'title' => 'string',
        ), $_REQUEST['search']);
        //名称或ID筛选
        if (!empty($search['title'])) {
            if (is_numeric($_REQUEST['search']['title'])) {
//                $conditions["id"] = $search['title'];
                $conditions = array(
                    " (id=? or username like ? or phone=?)" => array($search['title'], '%'.$search['title'].'%', $search['title'])
                );
            } else {
                $conditions = array(
                    " (username=? or fullname like ? or email=?)" => array($search['title'], '%'.$search['title'].'%', $search['title'])
                );
            }
        }

        //认证状态筛选
        //"identity":{"identity_type":2,"
//        if (!empty($search['identity_type'])) {
//            if (is_numeric($search['identity_type'])) {
//                $conditions = array(
//                    " (id=? or username=? or phone=?)" => array($search['title'], $search['title'], $search['title'])
//                );
//            }
//        }
        return $conditions;
    }

    static function handleVendorIdentityInfoShow($accountType = 1)
    {
        $userId = $_REQUEST['id'];
        $data = Data_Mysql_Table_Account::select('*', array('id' => $userId));
        //查看该账户下是否已经绑定供应商
        $vendor = Data_Mysql_Table_Vendor_Info::select("id,vendor_name", array('vendor_account_id' => $userId));
        if (!empty($vendor[0]['id'])) {
            Tpl_Smarty::assign('bind_vendor', $vendor[0]['id']);
        }
        $info = json_decode($data[0]['attr'], true);

        if ($accountType == 21) {
            //判断是否是新认证用户
            if(! empty($info['new_identity'])){
                $rs = Data_Mysql_Table_Vendor_Info::select('id, vendor_name,vendor_account_id', array(
                    'vendor_name' => empty($info['new_identity']['data']['公司名称']) ? $info['new_identity']['data']['真实姓名'] : $info['new_identity']['data']['公司名称']
                ), '', 5);
                Tpl_Smarty::assign('data', $info['new_identity']['data']);
                Tpl_Smarty::assign('files', $info['new_identity']['files']);
            } elseif(! empty($info['identity'])) {      ////判断是否是已认证用户
                $rs = Data_Mysql_Table_Vendor_Info::select('id, vendor_name,vendor_account_id', array(
                    'vendor_name' => empty($info['identity']['data']['公司名称']) ? $info['identity']['data']['真实姓名'] : $info['identity']['data']['公司名称']
                ), '', 5);
                Tpl_Smarty::assign('data', $info['identity']['data']);
                Tpl_Smarty::assign('files', $info['identity']['files']);
            }else{
                $rs = array();
            }

            Tpl_Smarty::assign('vendors', $rs);
        }
//        $reason = array(
//            '证件不全', '资历不够', '其他原因'
//        );
        $page_name = '用户信息';
//        Tpl_Smarty::assign('rejectreason', $reason);
        Tpl_Smarty::assign('user_id', $userId);
        Tpl_Smarty::assign('page_name', $page_name);

        Tpl_Smarty::display('OA', 'account_identity_info_show.tpl');
    }
}