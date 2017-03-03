<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-5-5
 * Time: 下午6:20
 */
class OA_Department_Vendor_List
{
    static function handle($department = 0, $is_team = 0, $is_check = 0)
    {
        $action = empty($_REQUEST['action']) ? "vendor_list" : $_REQUEST['action'];
        if ($action == 'vendor_list') {
            self::handleVendorList($department, $is_team, $is_check);
        } elseif ($action == 'detail') {
            OA_My_Customer_Account::handle(21, 2);
        } elseif ($action == 'ajax_user_json') {
            OA_Contact_Detail::handleGetAccountToJson();
        }
        if ($department < 2) {

            switch ($action) {
                case 'waiting':
                    self::handleWaitingList();
                    break;
                case'check_product':
                    self::handleAuditProduct();
                    break;
                case'check_vendor':
                    self::handleAuditVendor();
                    break;
                case 'check_case':
                    self::handleAuditCase();
                    break;
                case 'check_set':
                    self::handleAuditSet();
                    break;
            }
        }
    }

    static function handleVendorList($department, $is_team, $is_check = 0)
    {
        $_REQUEST['department'] = $department;
        $conditions = array();

        //获取市场部下的所有管理员信息
        $admin_ids = array();
        $admin = array();
        $city = empty($_REQUEST['city']) ? '' : $_REQUEST['city'];
        if (empty($_REQUEST['city'])) {
            $quota = Api_Administrator_Department_Normal_Api::getMemberInfo('市场部', $_SESSION['administrator']['id']);
            if (!empty($quota['city'])) {
                $city = $quota['city'];
            } else {
                $city = '上海';
            }
        }
        if ($is_team) {
            $memberInfo = Api_Administrator_Department_Normal_Api::getMemberInfo('市场部', $_SESSION['administrator']['id']);
            if (!empty($memberInfo)) {
                $adminInfo = Api_Administrator_Department_Normal_Api::getTeamList('市场部', $memberInfo['team_name'], $city);
            } else {
                die('请添加自身到部门管理员！！');
            }
        } elseif (!empty($department)) {
            $adminInfo = Api_Administrator_Department_Normal_Api::getMemberList('市场部', $city, 1);
        } else {
            $adminInfo = Api_Administrator_Department_Normal_Api::getMemberList('市场部', '', 1);
        }
        if (!empty($adminInfo)) {
            foreach ($adminInfo as $key => $value) {
                $admin_ids[] = $value['admin_id'];
                $admin[$value['admin_id']] = $value['fullname'];
                Tpl_Smarty::assign('_adminInfo', $admin);
            }
        }
        $conditions['vendor_account_id != ?'] = 0;
        if (!empty($department) && $department != 2) {
            $conditions[] = '{prefix}contact_relation.admin_id in (' . implode(',', $admin_ids) . ")";
        } elseif (!empty($department) && $department == 2) {
            $conditions['{prefix}contact_relation.admin_id = ?'] = $_SESSION['administrator']['id'];
        }

        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'admin_id' => 'int',
                'start_time' => 'string',
                'end_time' => 'string',
                'city' => 'string',
                'category_id' => 'int',
                'create_by_quick' => 'int',
            ), $_REQUEST['search']);
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['vendor_name'] = $search['title'];
                }
            }
            //搜索是否为快速创建或批量导入
//            if (isset($search['create_by_quick'])) {
//                $conditions['create_by_quick'] = $search['create_by_quick'];
//            }
            if (!empty($search['admin_id'])) {
                $conditions['{prefix}contact_relation.admin_id = ?'] = $search['admin_id'];
            }
            if (!empty($search['category_id'])) {
                $children = Data_Mysql_Table_Product_Category::getChildren($search['category_id']);
                $children[] = $search['category_id'];
                $conditions[] = '{table}.categories_id in (' . implode(',', $children) . ')';
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['{table}.create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['{table}.create_time < ?'] = strtotime($search['end_time']);
            }
        }
        if(!empty($_REQUEST['create_type'])){
            $create_type=Func_Input::filter(array(
                'create_type'=>'string'
            ),$_REQUEST);

            if($create_type['create_type']=='quick'){
                $conditions['{table}.create_by_quick =?'] = 1;
            }
            if($create_type['create_type']=='other'){
                $conditions['{table}.create_by_quick !=?'] = 1;
            }
        }

        if ($is_check) {
            $conditions[] = '{table}.status IN (2,4)';
        }

        //根据不同的标签来分别调用全部，待审核，通过审核，审核拒绝的供应商列表
        $handle_type = empty($_REQUEST['handle_type']) ? 'all' : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "waiting":
                $conditions['{table}.status = ? '] = 2;
                break;
            case "online":
                $conditions['{table}.status = ? '] = 1;
                break;
            case "offline":
                $conditions['{table}.status = ? '] = 0;
                break;
            case "reject":
                $conditions['{table}.status = ? '] = 3;
                break;
            case "all":
                break;
        }

//        q($conditions);
        //获取部门供应商信息
        $cols = array('{table}.id as vendor_id', '{table}.vendor_name', '{table}.categories_id', '{table}.status', '{table}.vendor_account_id', '{table}.status', '{table}.create_time', '{table}.update_time', '{table}.count_product', '{table}.create_by_quick', '{prefix}contact_library.business', '{prefix}contact_relation.admin_id, {prefix}contact_relation.contact_id as crc_id,  {prefix}contact_relation.admin_id as cra_id');
        $order = 'GROUP BY {table}.id ORDER BY {table}.update_time DESC';
        $vendor = Data_Mysql_Table_Vendor_Info::subTable('_update')->page(0, 0, $cols, $conditions, $order,
            '{table} LEFT JOIN {prefix}contact_library ON {table}.vendor_account_id = {prefix}contact_library.account_id LEFT JOIN {prefix}contact_relation ON {prefix}contact_library.id = {prefix}contact_relation.contact_id');
        if (!empty($vendor['rows'])) {
            foreach ($vendor['rows'] as $key => $value) {
                if (!empty($value['categories_id'])) {
                    $vendor['rows'][$key]['category_arr'] = explode(',', $value['categories_id']);
                    $vendor['rows'][$key]['vendor_name'] = preg_replace('/\|.*/', '', $value['vendor_name']);
                }
            }
        }

        Tpl_Smarty::assign('create_type', empty($create_type['create_type'])?'all':$create_type['create_type']);
        Tpl_Smarty::assign('_data', $vendor);
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign('categoryInfo', Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::display('OA', 'department_vendor_list.tpl');
    }

    /*
     *获取该供应商下所有待审核的项
     */
    static function handleWaitingList()
    {
        if (empty($_REQUEST['vendor_id'])) {
            Func_Header::back('参数错误！！');
        }
        //获取该供应商的信息
        $vendor = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,vendor_name,status,create_by_quick', array('id' => $_REQUEST['vendor_id']));
        if (empty($vendor[0])) {
            Func_Header::back('供应商不存在！！');
        }
       Tpl_Smarty::assign('is_first_check', Api_Vendor_isFirstCheck::isFirstCheck(array('vendor_id'=>$_REQUEST['vendor_id'])));

        $vendor[0]['vendor_name'] = preg_replace('/\|.*/', '', $vendor[0]['vendor_name']);
        $waiting_product = self::getWaitingCheckProduct($_REQUEST['vendor_id']);
        $waiting_case = self::getWaitingCheckCase($_REQUEST['vendor_id']);
        $waiting_set = self::getWaitingCheckSet($_REQUEST['vendor_id']);
        //判断供应商下是否有待审核的产品
        if ((!empty($waiting_case[0]['status']) && $waiting_case[0]['status'] == 2) || (!empty($waiting_product[0]['status']) && $waiting_product[0]['status'] == 2) || (!empty($waiting_set[0]['status']) && $waiting_set[0]['status'] == 2)) {
            if ($vendor[0]['status'] != 2) {
                Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id' => $_REQUEST['vendor_id']), array('status' => 4));
            }
        } else {
            if ($vendor[0]['status'] == 4) {
                Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id' => $_REQUEST['vendor_id']), array('status' => 1));
            }
        }
        $vendorInfo = $vendor[0];
        $vendorInfo['admin_name'] = empty($_REQUEST['admin_name']) ? '' : $_REQUEST['admin_name'];
        Tpl_Smarty::assign('product', $waiting_product);
        Tpl_Smarty::assign('productSet', $waiting_set);
        Tpl_Smarty::assign('case', $waiting_case);
        Tpl_Smarty::assign('vendorInfo', $vendorInfo);
        Tpl_Smarty::display('OA_Static::vendor_check/vendor_waiting_check_list.tpl');

    }

    /*
     *审核产品接口
     */
    static function handleAuditProduct()
    {
        OA_Check_Product_Info::handle();
    }

    /*
      *审核套餐接口
      */
    static function handleAuditSet()
    {
        OA_Check_Set::handle();
    }

    /*
     *审核供应商接口
     */
    static function handleAuditVendor()
    {
        OA_Check_Vendor_Info::handle();
    }

    /*
     *审核案例接口
     */
    static function handleAuditCase()
    {
        OA_Check_Case_Info::handle();
    }

    /*
     *获取所有待审核的产品信息
     */
    static function getWaitingCheckProduct($vendorId)
    {
        $productInfo = array();
        if (empty($vendorId)) {
            Func_Header::back('参数错误！！');
        }
        $conditions[] = "status in (0,1,2)";
        $conditions['vendor_id'] = $vendorId;
        $productInfo = Data_Mysql_Table_Product_Info::subTable('_update')->select('id,product_name,vendor_id,status,create_by_quick', $conditions, 'ORDER BY status DESC', 10);
//        foreach($productInfo )
        return $productInfo;
    }

    /*
     *获取所有待审核的套餐信息
     */
    static function getWaitingCheckSet($vendorId)
    {
        $productInfo = array();
        if (empty($vendorId)) {
            Func_Header::back('参数错误！！');
        }
        $conditions[] = "status in (0,1,2)";
        $conditions['vendor_id'] = $vendorId;
        $productInfo = Data_Mysql_Table_Product_Set::subTable('_update')->select('id,set_name,vendor_id,status', $conditions, 'ORDER BY status DESC', 10);

        return $productInfo;

    }

    /*
    *获取所有待审核的案例信息
    */
    static function getWaitingCheckCase($vendorId)
    {
        $caseInfo = array();
        if (empty($vendorId)) {
            Func_Header::back('参数错误！！');
        }
        $conditions[] = "status in (0,1,2)";
        $conditions['vendor_id'] = $vendorId;
        $caseInfo = Data_Mysql_Table_Event_Case::subTable('_update')->select('id,case_name,vendor_id,status', array('vendor_id' => $vendorId), 'ORDER BY status DESC', 10);
        return $caseInfo;
    }
}