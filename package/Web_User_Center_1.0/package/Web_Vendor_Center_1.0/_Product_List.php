<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/24
 * Time: 10:22
 */
class Web_Vendor_Center_Product_List extends Base
{
    static function handle()
    {
        //获取当前账户的供应商信息
        $vendorInfo = self::getVendorListByAccount($_SESSION['user']['id']);
        if (empty($vendorInfo)) {
            Func_Header::notFound();
        }
        Tpl_Smarty::assign('vendor', $vendorInfo);
        switch (Core::$urls['action']) {
            case 'product/service':
                $_REQUEST['mode'] = 'service';
                $categoryInfo = self::getProductListByAccount($_SESSION['user']['id'], Data_Config_Site::$staticConfig['space_id'] * -1);
                Tpl_Smarty::assign('data', $categoryInfo);
                break;
            case 'product/recycle':
                $_REQUEST['mode'] = 'recycle';
                $categoryInfo = self::getProductListByAccount($_SESSION['user']['id'], '', -1);
                Tpl_Smarty::assign('data', $categoryInfo);
                break;
            case 'product/set_recycle':
                $_REQUEST['mode'] = 'set_recycle';
                $setList = self::getSetListByAccount($_SESSION['user']['id'], -1);
                Tpl_Smarty::assign('data', $setList);
                break;
//            case 'product/vendor':
//                $_REQUEST['mode'] = 'vendor';
////                $_REQUEST['vendor_id']=$vendorInfo['id'];
////                $vendorInfo = self::getVendorListByAccount($_SESSION['user']['id']);
//                Tpl_Smarty::assign('data', $vendorInfo);
//                break;
            case 'product/set':
                $_REQUEST['mode'] = 'set';
                $setInfo = self::getSetListByAccount($_SESSION['user']['id'], 0);
                Tpl_Smarty::assign("category_name", Data_Mysql_Table_Product_Set::$category_name);
                Tpl_Smarty::assign('data', $setInfo);
                break;
            default:
                $_REQUEST['mode'] = 'space';
                $productInfo = self::getProductListByAccount($_SESSION['user']['id'], Data_Config_Site::$staticConfig['space_id']);
                Tpl_Smarty::assign('data', $productInfo);
                break;
        }
        Tpl_Smarty::assign('time_4hour', time() - 3600 * 4);
        Tpl_Smarty::display('service.tpl');
    }

    //获取该账户下绑定的供应商的空间场地和配套服务信息(有分页)
    static function getProductListByAccount($accountId, $categoryId = 0, $status = 0)
    {
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();
        $conditions = array();
        if ($categoryId) {
            $children = Data_Mysql_Table_Product_Category::getChildren(abs($categoryId));
            $children[] = abs($categoryId);
            $cIds = implode(',', $children);
            if ($categoryId > 0) {
                $conditions[] = '{table}.category_id in (' . $cIds . ')';
            } else {
                $conditions[] = '{table}.category_id not in (' . $cIds . ')';
            }
        }
        //是否是供应商加盟
        if (Api_Vendor_Join_IsVendorJoinAccount::check(array('account_id' => $accountId))) {
            if ($status == -1) {
                return false;
            }
            return Api_Vendor_Join_GetProductInfoPage::getPage(array('account_id' => $accountId,
                'category_ids' => empty($cIds) ? 0 : $cIds,
                'categoryId' => $categoryId,
                'status' => $status));
        }
        if ($status == -1) {
            $conditions[] = '{table}.status = ' . $status;
        } else {
            $conditions[] = '{table}.status >= 0';
        }
        if (!empty($_REQUEST['search']['title'])) {
            if (is_numeric($_REQUEST['search']['title'])) {
                $conditions['id'] = $_REQUEST['search']['title'];
            } else {
                $conditions['product_name'] = $_REQUEST['search']['title'];
            }
        }
        if (!empty($_SESSION['user']['super_vendor'])) {
            $conditions['({prefix}vendor_info_update.vendor_account_id = ? OR {prefix}vendor_info_update.vendor_account_id = 0)'] = $accountId;
        } else {
            $conditions['{prefix}vendor_info_update.vendor_account_id = ?'] = $accountId;
        }

        $order = 'ORDER BY {table}.update_time DESC';
        $data = Data_Mysql_Table_Product_Info::subTable('_update')->page(0, 0,
            "{table}.id ,{table}.refuse_reason,{table}.category_id,  {table}.product_name, {table}.status, {table}.counter_view, {table}.update_time, {table}.status as update_status,{prefix}product_info.status, {prefix}vendor_info_update.vendor_name",
            $conditions, $order,
            '{table} LEFT JOIN {prefix}product_info ON {table}.id={prefix}product_info.id LEFT JOIN {prefix}vendor_info_update ON {table}.vendor_id = {prefix}vendor_info_update.id');
        if (!empty($data['rows'])) {
            foreach ($data['rows'] as $k => $v) {
                if (!empty($categories[$v['category_id']][0])) {
                    $data['rows'][$k]['category_name'] = $categories[$v['category_id']][0];
                }
            }
        }
        return $data;
    }

    //获取该账户下绑定的供应商信息
    static function getVendorListByAccount($accountId)
    {
        $vendorInfo = array();
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();
        $conditions = array();
        $order = 'ORDER BY update_time DESC';
        if (!empty($_SESSION['user']['super_vendor'])) {
            $conditions['({table}.vendor_account_id = ? OR {table}.vendor_account_id = 0)'] = $accountId;
        } else {
            $conditions['vendor_account_id'] = $accountId;
        }
        if (!empty($_REQUEST['search']['title'])) {
            if (is_numeric($_REQUEST['search']['title'])) {
                $conditions['id'] = $_REQUEST['search']['title'];
            } else {
                $conditions['vendor_name'] = $_REQUEST['search']['title'];
            }
        }
        $data = Data_Mysql_Table_Vendor_Info::subTable('_update')->select("{table}.id , {table}.categories_id, {table}.vendor_name, {table}.attr, {table}.update_time, {table}.status", $conditions, $order);
        if (!empty($data[0])) {
            $vendorInfo = $data[0];
            $vendorInfo['attr'] = json_decode($vendorInfo['attr'], 1);
            $categoriesId = explode(',', $vendorInfo['categories_id']);
            foreach ($categoriesId as $k => $v) {
                unset($categoriesId[$k]);
                if (!empty($categories[$v][0])) {
                    $categoriesId[$k] = $categories[$v][0];
                }
            }
            $vendorInfo['attr']['服务范围'] = implode(',', $categoriesId);
        }

        //如果为空去检查一下供应商加盟表
        if (empty($vendorInfo)) {
            return Api_Vendor_Join_IsVendorJoinAccount::check(array('account_id' => $accountId));
        }
        return $vendorInfo;
    }


    /*
     *获取该账户下绑定的供应商的套餐列表
     */
    static function getSetListByAccount($accountId, $status = 0)
    {

        //是否是供应商加盟
        if (Api_Vendor_Join_IsVendorJoinAccount::check(array('account_id' => $accountId))) {
            return false;
        }

        $productSet = array();
        $conditions = array();
        if ($status == -1) {
            $conditions[] = '{table}.status = ' . $status;
        } else {
            $conditions[] = '{table}.status >= 0';
        }
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
            ), $_REQUEST['search']);
            //名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($search['title'])) {
                    $conditions['{table}.id = ?'] = $search['title'];
                } else {
                    $conditions['{table}.set_name = ?'] = $search['title'];
                }
            }
        }
        $conditions['{prefix}vendor_info.vendor_account_id = ?'] = $accountId;
        $productSet = Data_Mysql_Table_Product_Set::subTable('_update')->page(0, 20, '{table}.id,{table}.set_name,{table}.refuse_reason,{table}.schedule_product_id,{table}.vendor_id,{table}.status as update_status,{table}.category_id,{prefix}product_set.status', $conditions, 'ORDER BY {table}.update_time DESC', '{table} LEFT JOIN {prefix}product_set ON {table}.id={prefix}product_set.id LEFT JOIN {prefix}vendor_info ON {table}.vendor_id={prefix}vendor_info.id');
        return $productSet;
    }


}
