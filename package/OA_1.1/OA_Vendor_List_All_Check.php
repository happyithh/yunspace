<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-9-24
 * Time: 下午4:33
 */
class OA_Vendor_List_All_Check
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? "vendor_list" : $_REQUEST['action'];

        switch ($action) {
            case "vendor_list":
                self::handleVendorList();
                break;
            case "detail":
                OA_My_Customer_Account_New::handle();
                break;
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

    static function handleVendorList()
    {
        $conditions = array();
        //按周查询
        $is_monday = date("Y-m-d", (strtotime('-' . 0 . ' Monday'))) == date('Y-m-d', time()) ? 0 : 1;
        for ($i = 0; $i <= 4; $i++) {
            $j = $is_monday + $i;
            $weeks[] = date("Y-m-d", strtotime('-' . $j . ' Monday')) . ' -- ' . date("Y-m-d", strtotime('-' . $i . ' Sunday'));
        }
//        q(strtotime('2015-09-11'.'20:10:10'));
        Tpl_Smarty::assign('weeks', $weeks);
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'admin_id' => 'int',
                'start_time' => 'string',
                'end_time' => 'string',
                'update_start_time' => 'string',
                'update_end_time' => 'string',
                'city' => 'string',
                'category_id' => 'int',
                'weeks' => 'string',
                'update_weeks' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['vendor_name'] = $search['title'];
                }
            }
            if (!empty($search['admin_id'])) {
                $conditions['admin_id'] = $search['admin_id'];
            }
            if (!empty($search['category_id'])) {
                $children = Data_Mysql_Table_Product_Category::getChildren($search['category_id']);
                $children[] = $search['category_id'];
                $conditions[] = 'categories_id in (' . implode(',', $children) . ')';
            }
            // 创建时间
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time'].'00:00:00') > strtotime($search['end_time'].'23:59:59')) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['create_time between ? and ?'] = array(strtotime($search['start_time'].'00:00:00'), strtotime($search['end_time'].'23:59:59'));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['create_time > ?'] = strtotime($search['start_time'].'00:00:00');
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['create_time < ?'] = strtotime($search['end_time'].'23:59:59');
            }
            // 更新时间
            if (!empty($search['update_start_time']) && !empty($search['update_end_time'])) {
                if (strtotime($search['update_start_time'].'00:00:00') > strtotime($search['update_end_time'].'23:59:59')) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['update_time between ? and ?'] = array(strtotime($search['update_start_time'].'00:00:00'), strtotime($search['update_end_time'].'23:59:59'));
                }
            } elseif (!empty($search['update_start_time']) && empty($search['update_end_time'])) {
                $conditions['update_time > ?'] = strtotime($search['update_start_time'].'00:00:00');
            } elseif (empty($search['update_start_time']) && !empty($search['update_end_time'])) {
                $conditions['update_time < ?'] = strtotime($search['update_end_time'].'23:59:59');
            }
            // 以周为单位查询
            if (!empty($search['weeks'])) {
                $arr = explode('--', $search['weeks']);
                $conditions['create_time between ? and ?'] = array(strtotime($arr[0] . '00:00:00'), strtotime($arr[1] . '23:59:59'));
            }
            if (!empty($search['update_weeks'])) {
                $arr1 = explode('--', $search['update_weeks']);
                $conditions['update_time between ? and ?'] = array(strtotime($arr1[0] . '00:00:00'), strtotime($arr1[1] . '23:59:59'));
            }
        }

        $handle_type = empty($_REQUEST['handle_type']) ? 'all' : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "quick":
                $conditions['create_by_quick '] = 1;
                break;
            case "other":
                $conditions['create_by_quick != ? '] = 1;
                break;
            case "all":
                break;
        }
        $conditions[] = 'status IN (2,4)';
        //获取待审核的供应商信息
        $vendor = Data_Mysql_Table_Vendor_Info::subTable('_update')->page(0, 0, "*", $conditions, "ORDER BY update_time DESC");
        // 如果正常创建为空，则默认显示所有
        if (empty($vendor['rows'])) {
            unset($conditions['create_by_quick != ? ']);
            $handle_type = empty($_REQUEST['handle_type']) ? 'all' : $_REQUEST['handle_type'];
            switch ($handle_type) {
                case "quick":
                    $conditions['create_by_quick '] = 1;
                    break;
                case "other":
                    $conditions['create_by_quick != ? '] = 1;
                    break;
                case "all":
                    break;
            }
            $vendor = Data_Mysql_Table_Vendor_Info::subTable('_update')->page(0, 0, "*", $conditions, "ORDER BY update_time DESC");
        }
        if (!empty($vendor['rows'])) {
            foreach ($vendor['rows'] as $key => $value) {
                if (!empty($value['categories_id'])) {
                    $vendor['rows'][$key]['category_arr'] = explode(',', $value['categories_id']);
                    $vendor['rows'][$key]['vendor_name'] = preg_replace('/\|.*/', '', $value['vendor_name']);
                }
            }
        }
        $adminInfo = Api_Administrator_Department_Normal_Api::getMemberList('市场部', '', 1);
        if (!empty($adminInfo)) {
            foreach ($adminInfo as $key => $value) {
                $admin_ids[] = $value['admin_id'];
                $admin[$value['admin_id']] = $value['fullname'];
                Tpl_Smarty::assign('_adminInfo', $admin);
            }
        }
        // 搜索tab
        if(!empty($search)){
            $searchKey=array_keys($search);
            $searchValue=array_values($search);
            $searchNum=count($search);
            $urls='';
            for($i=0;$i<$searchNum;$i++){
                $urls .='search['.$searchKey[$i].']='.$searchValue[$i].'&';
            }
            Tpl_Smarty::assign('urls',$urls);
        }
        Tpl_Smarty::assign('_data', $vendor);
        Tpl_Smarty::assign('handle_type', $handle_type);
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign('categoryInfo', Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::display('OA_Static', 'vendor_list_new/vendor_list_check.tpl');
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
        Tpl_Smarty::assign('is_first_check', Api_Vendor_isFirstCheck::isFirstCheck(array('vendor_id' => $_REQUEST['vendor_id'])));

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