<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/30
 * Time: 19:15
 */
$_REQUEST['action'] = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];

class OA_Contact_List
{
    /*
     *@param   type:联系人类型，1=客户，21=供应商
     * @param   isMy:是否是我的联系人  0=公共, 1=我的联系人,  2=部门联系人, 3=组联系人
     * @param   is_urgent:是否紧急联系人，0=普通, 1：紧急，
     * @param   is_ka:是否KA客户，2=标准, 1：KA，
     */
    static function handle($type = 0, $isMy = 0, $is_urgent = 0, $is_ka = 0)
    {

        if ($_REQUEST['action'] == 'get') {
            self::handleGet();
        } elseif ($_REQUEST['action'] == 'remove') {
            self::handleRemove($isMy || $is_urgent);
        } elseif ($_REQUEST['action'] == 'recommend_submit') {
            OA_My_Customer_Account::recommendSubmit();
        } elseif ($_REQUEST['action'] == 'detail') {
            OA_My_Customer_Account::handle($type, 2);
        } elseif ($_REQUEST['action'] == 'vendor') {
            OA_Quantity_Import_Vendors::dealData();
        } else {
            $_REQUEST['is_urgent'] = $is_urgent;
            if (!empty($_REQUEST['id']) || !empty($_REQUEST['contact_id'])) {
                return OA_Contact_Detail::handle($type, $isMy, $is_urgent);
            }
            self::handleList($type, $isMy, $is_urgent, $is_ka);
        }
    }

    static function handleList($type = 0, $isMy = 0, $is_urgent, $is_ka)
    {
        $conditions = array(//            'status' => 1,
        );
        $cols = array(
            '{table}.id', '{table}.username', '{table}.city, {table}.state', '{table}.phone', '{table}.business', '{table}.create_time', '{table}.sub_business', '{table}.company', '{table}.position', '{table}.account_id', '{table}.admin_id as creator_id', '{table}.state', 't2.admin_id', '{table}.new_demand_time', 't3.fullname as admin_name, {table}.vendor_id, {table}.product_name, t4.vendor_name'
        );
        if ($type) {
            $conditions['type'] = $type;
            $_REQUEST['type'] = $type;
        } else {
            unset($cols[2]);
        }
        //取城市
        $city = empty($_REQUEST['city']) ? '' : $_REQUEST['city'];
        if (empty($_REQUEST['city'])) {
            $quota = Api_Administrator_Department_Normal_Api::getMemberInfo($type == 1 ? '销售部' : '市场部', $_SESSION['administrator']['id']);
            if (!empty($quota['city'])) {
                $city = $quota['city'];
            } else {
                $city = '上海';
            }
        }

        //我的联系人
        if ($isMy == 1) {
            $conditions = array('t2.admin_id = ?' => $_SESSION['administrator']['id']);
            Tpl_Smarty::assign('is_my', 1);
        } else {
            if ($isMy == 2) {
                //部门联系人
                $adminInfo = Api_Administrator_Department_Normal_Api::getMemberList($type == 1 ? '销售部' : '市场部', $city, 1);
                if (!empty($adminInfo)) {
                    foreach ($adminInfo as $key => $value) {
                        $admin_ids[] = $value['admin_id'];
                        $admin_name[$value['admin_id']] = $value['fullname'];
                    }
                    Tpl_Smarty::assign('admin_name', $admin_name);
                    $conditions[] = 't2.admin_id in (' . implode($admin_ids, ',') . ')';
                } else {
                    die('请添加部门管理员！！');
                }
                Tpl_Smarty::assign('is_my', 2);
            } elseif ($isMy == 3) {
                //组联系人
                $memberInfo = Api_Administrator_Department_Normal_Api::getMemberInfo($type == 1 ? '销售部' : '市场部', $_SESSION['administrator']['id']);

                if (!empty($memberInfo['id'])) {
                    $teamList = Api_Administrator_Department_Normal_Api::getTeamList($type == 1 ? '销售部' : '市场部', $memberInfo['team_name']);
                } else {
                    die('请添加自身到部门管理员！！');
                }

                foreach ($teamList as $key => $value) {
                    $admin_ids[] = $value['admin_id'];
                    $admin_name[$value['admin_id']] = $value['fullname'];
                }
                Tpl_Smarty::assign('admin_name', $admin_name);
                $conditions[] = 't2.admin_id in (' . implode($admin_ids, ',') . ')';

                Tpl_Smarty::assign('is_my', 3);
            } else {
                $conditions[] = "{table}.new_demand_time<" . (time() - 86400 * 2);
//                $conditions [] = 't2.admin_id IS NULL';
            }
            //紧急联系人
            if ($is_urgent) {
                if ($is_ka == 1) {
                    //获取组负责人信息
                    $adminInfo = Api_Administrator_Department_Normal_Api::getTeamList('销售部', 'KA', $city);
                } elseif ($is_ka == 2) {
                    $adminInfo = Api_Administrator_Department_Normal_Api::getTeamList('销售部', '标准', $city);
                } else {
                    //获取部门负责人信息
                    $adminInfo = Api_Administrator_Department_Normal_Api::getMemberList('销售部', $city, 1);
                }
                $admin = array();
                $admin_ids = array();
                if (!empty($adminInfo)) {
                    foreach ($adminInfo as $k => $v) {
                        $admin_ids[] = $v['admin_id'];
                        $admin[$v['admin_id']] = $v['fullname'];
                    }
                }
                if (!empty($is_ka) && !empty($admin_ids)) {
                    $conditions[] = "{table}.admin_id in (" . implode(',', $admin_ids) . ")";
                }
                //是KA用户
                if ($is_ka == 1) {
                    $conditions['{table}.customer_type = ?'] = 1;
                    $conditions ['t2.admin_id != ?'] = 'NULL';
                } elseif ($is_ka == 2) {
                    $conditions['{table}.customer_type = ?'] = 2;
                    $conditions ['t2.admin_id != ?'] = 'NULL';
                }

                $conditions[] = "({table}.new_demand_time) >=" . (time() - 86400 * 5);
                $conditions['city'] = $city;
                Tpl_Smarty::assign('is_urgent', $is_urgent);
            }
        }
        $table = "{table} LEFT JOIN {prefix}contact_relation as t2 ON {table}.id = t2.contact_id LEFT JOIN {prefix}administrator as t3 ON t2.admin_id = t3.id LEFT JOIN {prefix}vendor_info as t4 ON {table}.vendor_id = t4.id";
        //搜索
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'business' => 'string',
                'sub_business' => 'string',
                'phone' => 'string',
                'username' => 'string',
                'company' => 'string',
                'admin_id' => 'int',
                'city' => 'string',
                'state' => 'int',
            ), $_REQUEST['search']);

           /*if ($search['company']) {
                $search['product_name'] = $search['company'];
            }*/
            if ($search['phone']) {
                $conditions = array();
            } elseif ($search['username'] || $search['company']) {
                $conditions = array();
                if (!$isMy) {
                    $conditions[] = "{table}.new_demand_time<" . (time() - 86400);
                   $conditions [] = 't2.admin_id IS NULL';
                }
            }
//            if($search['admin_id']){
//
//            }else{

            foreach ($search as $k => $v) {
                if ($v) {
                    if ($k == 'admin_id') {
                        $conditions ["t2.admin_id = ?"] = $search['admin_id'];
                    } else {
                        if($k == 'company'){
                            $conditions[]="({table}.product_name like '%".$v."%' or {table}.".$k." like '%".$v."%')";
                        }else {

                            if($k == 'username'){
                                $conditions[] ="{table}." . $k . " like '%".$v."%'";
                            }else {
                                $conditions["{table}." . $k . "= ?"] = $v;
                            }
                        }
                    }
                }
            }

//            }

        }


        if ($is_urgent) {
            Tpl_Smarty::assign('_adminInfo', $admin);
        }
     //   Data_Mysql_Table_Contact_Library::debug();
        $rs = Data_Mysql_Table_Contact_Library::page(0, 15, $cols, $conditions, 'ORDER BY {table}.new_demand_time DESC, {table}.id DESC', $table);
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign('my_admin_id', $_SESSION['administrator']['id']);//用于判断是否是我创建的联系人
        Tpl_Smarty::assign('_data', $rs);
        Tpl_Smarty::assign('state', Data_Mysql_Table_Contact_Library::$state);
        Tpl_Smarty::assign('is_admin', Admin_Authority::checkUrl(Core::$urls['route'] . 'contact_urgent_list', 0));
        Tpl_Smarty::display('OA', 'contacts/contact_list.tpl');
    }

    static function  handleGet()
    {

        $request = Func_Input::filter(array(
            'id' => 'int',
        ));
        if (!$request['id']) {
            Func_Header::back('参数异常!');
        }
        $rs = Data_Mysql_Table_Contact_Library::select('{table}.id, {table}.type, t2.admin_id', array('id' => $request['id']), '', 1, '{table} LEFT JOIN {prefix}contact_relation as t2 ON {table}.id = t2.contact_id');
        if (empty($rs[0]['id'])) {
            Func_Header::back('参数异常!');
        }
        if ($rs[0]['admin_id']) {
            Func_Header::back('该联系人已被领取!');
        }
        $contactInfo = $rs[0];
        $quota = Api_Administrator_Department_Normal_Api::getMemberInfo($contactInfo['type'] == 1 ? '销售部' : '市场部', $_SESSION['administrator']['id']);
        if (empty($quota['id'])) {
            Func_Header::back('您尚未拥有本部门联系人配额!');
        }
        if ($quota['quota_now'] >= $quota['quota_today']) {
            Func_Header::back('您的领取数量已超过每日限额！！');
        }
        $rs = Data_Mysql_Table_Contact_Relation:: insert(array(
            'contact_id' => $contactInfo['id'],
            'admin_id' => $_SESSION['administrator']['id'],
            'allocate_time' => time(),
        ));
        $rs3 = Api_Administrator_Department_Normal_Api::updateMemberInfo(array('id' => $quota['id'], 'quota_now' => $quota['quota_now'] + 1, 'reset_time' => $quota['reset_time']));
        if ($rs[0] && $rs3) {
            Func_Header::to(' 领取成功！！', Core::$urls['referer']);
        } else {
            Func_Header::back('领取失败！请重试');
        }
    }

    static function  handleRemove($isAdmin = 0)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'admin_id' => 'int',
        ));
        $r = Data_Mysql_Table_Contact_Relation::delete(array(
            'contact_id' => $request['id'],
            'admin_id' => $isAdmin ? $request['admin_id'] : $_SESSION['administrator']['id'],
        ));
        if ($r[0]) {
            Func_Header::to(' 释放成功！！', Core::$urls['referer']);
        } else {
            Func_Header::back('释放失败！请重试');
        }
    }
}