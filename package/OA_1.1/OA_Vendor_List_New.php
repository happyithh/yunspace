<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-9-21
 * Time: 上午10:51
 */
class OA_Vendor_List_New{
    static function handle($type=0){
        $action = empty($_REQUEST['action']) ? "list" : $_REQUEST['action'];
        switch($action){
            case "list":
                self::vendorList($type);
                break;
            case 'detail':
                OA_My_Customer_Account_New::handle();
                break;
            default:
                Func_Header::notFound();

        }
    }

    //获取供应商列表
    static function vendorList($type=0){
        $conditions=array();
        if($type==1){
            $conditions['admin_id']=$_SESSION['administrator']['id'];
        }elseif($type==2){
            $conditions['attr_index']['城市']=$_COOKIE['city'];
        }
//        q($conditions);
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'admin_id' => 'int',
                'start_time' => 'string',
                'end_time' => 'string',
                'category_id' => 'int',
                'city'=>'string'
            ), $_REQUEST['search']);
            if (!empty($search['city'])) {
                $conditions['attr_index']['城市'] = $search['city'];
            }
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['{table}.id = ?'] = $search['title'];
                } else {
                    $conditions['vendor_name'] = $search['title'];
                }
            }
            if (!empty($search['admin_id'])) {
                $conditions['{table}.admin_id = ?'] = $search['admin_id'];
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
        $vendor = Data_Mysql_Table_Vendor_Info::subTable('_update')->page(0, 0, "*", $conditions, "ORDER BY update_time DESC");
        if (!empty($vendor['rows'])) {
            foreach ($vendor['rows'] as $key => $value) {
                if (!empty($value['categories_id'])) {
                    $vendor['rows'][$key]['attr'] = json_decode($value['attr'],1);
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
        $vendor_info = Data_Config_Vendor_Attr::all();
        $city = $vendor_info['attr']['城市'];
        // 搜索tab
        if (!empty($search)) {
            $searchKey = array_keys($search);
            $searchValue = array_values($search);
            $searchNum = count($search);
            $urls = '';
            for ($i = 0; $i < $searchNum; $i++) {
                $urls .= 'search[' . $searchKey[$i] . ']=' . $searchValue[$i] . '&';
            }
            Tpl_Smarty::assign('urls', $urls);
        }
        Tpl_Smarty::assign('city', $city);
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('_data', $vendor);
        Tpl_Smarty::assign('handle_type', $handle_type);
        Tpl_Smarty::assign('categoryInfo', Data_Mysql_Table_Product_Category::getInfoCache());
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign('is_admin', Admin_Authority::checkUrl('operation_new/all_vendor_new', 0));
        Tpl_Smarty::display('OA_Static', 'vendor_list_new/vendor_list_new.tpl');
    }
}