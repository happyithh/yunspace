<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/24
 * Time: 9:26
 * 供应商营销管理后台
 */
class Web_Vendor_Center_Product_Marketing extends Base
{
    static function handle()
    {
        if (Core::$urls['action'] == 'product_marketing') {
            return self::handleProductMarketingList();
        }
        //检查是否有修改权限
        Web_Vendor_Center_Product_Edit::handleCheckProductAuth();
        switch (Core::$urls['action']) {
            case 'product_marketing/online':
                self::handleOnline();
                break;
            case 'product_marketing/update_charges':
                self::handleUpdateCharges();
                break;
            case 'product_marketing/update_set_commission':
                self::handleEditSetCommission();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }

    static function handleProductMarketingList()
    {
        if (empty($_REQUEST['mode'])) {
            $_REQUEST['mode'] = 'space';
        }
        if ($_REQUEST['mode'] == 'set') {

            $list = self::getSetMarketingList();

        } else {
            $list = self::getProductMarketingListByAccount($_SESSION['user']['id'], Data_Config_Site::$staticConfig['space_id'] * ($_REQUEST['mode'] == 'space' ? 1 : -1));
        }

        Tpl_Smarty::assign('data', $list);
        Tpl_Smarty::display('marketing.tpl');
    }

    static function handleOnline()
    {
        $request = Func_Input::filter(array(
            'product_online' => 'int',
            'product_id' => 'int',
        ));
        if ($request['product_id'] && isset($_REQUEST['product_online'])) {
            //更新在新状态
            $r = Data_Mysql_Table_Product_Marketing::update(array(
                'id' => $request['product_id'],
                'status' => $request['product_online'] ? 1 : 0,
            ));
            if (empty($r[0])) {
                echo 'fail';
                die;
            } else {
                echo 'success';
                die;
            }
        }
    }

    static function handleUpdateCharges()
    {
        //获取ajax提交的信息，更新产品的推广成交佣金
        if (isset($_REQUEST['recommend_charges'])) {
            $request = Func_Input::filter(array(
                'recommend_charges' => 'float',
                'product_id' => 'int',
            ));
            if ($request['product_id'] && isset($_REQUEST['recommend_charges'])) {
                $r = Data_Mysql_Table_Product_Marketing::update(array(
                    'id' => $request['product_id'],
                    'recommend_charges' => $request['recommend_charges'] * 100,
                ));
                if (empty($r[0])) {
                    echo 'fail';
                    die;
                } else {
                    echo 'success';
                    die;
                }
            }
        }
    }

    //修改套餐佣金
    static function  handleEditSetCommission()
    {
        $request = Func_Input::filter(array(
            'recommend_charges' => 'int',
            'set_id' => 'int',
        ));
        if (!empty($request['set_id']) && !empty($_REQUEST['recommend_charges'])) {
            $r = Data_Mysql_Table_Product_Marketing::subTable("_set")->update(array(
                'id' => $request['set_id'],
                'recommend_charges' => $request['recommend_charges'] * 100,
            ));
            if ($r[0] > 0) {
                Func_Output::json('success', '', '修改成功！');
            }
        }
        Func_Output::json('error', '', '修改失败，请稍后再试！');
    }

    //获取产品的营销信息
    static function getProductMarketingListByAccount($accountId, $categoryId)
    {
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();
        $conditions = array();
        if ($categoryId) {
            $children = Data_Mysql_Table_Product_Category::getChildren(abs($categoryId));
            $children[] = abs($categoryId);
            if ($categoryId > 0) {
                $conditions[] = '{table}.category_id in (' . implode(',', $children) . ')';
            } else {
                $conditions[] = '{table}.category_id not in (' . implode(',', $children) . ')';
            }
        }
        if (!empty($_REQUEST['search']['title'])) {
            if (is_numeric($_REQUEST['search']['title'])) {
                $conditions['id'] = $_REQUEST['search']['title'] - 99991;
            } else {
                $conditions['product_name'] = $_REQUEST['search']['title'];
            }
        }
        if (!empty($_SESSION['user']['super_vendor'])) {
            $conditions['({prefix}vendor_info.vendor_account_id = ? OR {prefix}vendor_info.vendor_account_id = 0)'] = $accountId;
        } else {
            $conditions['{prefix}vendor_info.vendor_account_id = ?'] = $accountId;
        }
        $conditions['status'] = 1;
        $order = 'ORDER BY {table}.update_time DESC';
        $data = Data_Mysql_Table_Product_Info::page(0, 0,
            "{table}.id as pid, {table}.category_id,  {table}.product_name, {table}.counter_view,  {prefix}vendor_info.vendor_name, t2.*",
            $conditions, $order,
            '{table} LEFT JOIN {prefix}product_marketing as t2 ON {table}.id = t2.id LEFT JOIN {prefix}vendor_info ON {table}.vendor_id = {prefix}vendor_info.id');
        if (!empty($data['rows'])) {
            foreach ($data['rows'] as $k => $v) {
                if (!empty($categories[$v['category_id']][0])) {
                    $data['rows'][$k]['category_name'] = $categories[$v['category_id']][0];
                }
            }
        }
        return $data;
    }

    //获取套餐营销管理
    static function getSetMarketingList()
    {
        if (!empty($_SESSION['user']['super_vendor'])) {
            $conditions['({prefix}vendor_info.vendor_account_id = ? OR {prefix}vendor_info.vendor_account_id = 0)'] = $_SESSION['user']['id'];
        } else {
            $conditions['{prefix}vendor_info.vendor_account_id = ?'] = $_SESSION['user']['id'];
        }
        $conditions['status'] = 1;
        $cols = "{table}.id as pid,{table}.set_name,{table}.category_id,{table}.counter_view,t2.*";
        $table = "{table} LEFT JOIN {prefix}product_marketing_set as t2 ON {table}.id = t2.id LEFT JOIN {prefix}vendor_info ON {table}.vendor_id = {prefix}vendor_info.id";
        $order = "ORDER BY {table}.update_time DESC";
        $category_name = Data_Mysql_Table_Product_Set::$category_name;
        $rs = Data_Mysql_Table_Product_Set::page(0, 0, $cols, $conditions, $order, $table);
//        Data_Mysql_Table_Product_Marketing::subTable("_set")->select(1);
        foreach ($rs['rows'] as $k => $v) {
            $rs['rows'][$k]['category_name'] = $category_name[$v['category_id']];
        }
        return $rs;
    }
}
