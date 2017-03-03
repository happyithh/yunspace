<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-9-23
 * @我的供应商---套餐产品
 */
class OA_My_Customer_Handle_Product_Set
{

    static function  handle()
    {
        if(empty($_REQUEST['vendor_id'])){
            Func_Header::back('参数缺失！');
        }
        if(empty($_REQUEST['set_id'])){
            if (!empty($_REQUEST['is_submit'])) {
                self::handleProductSetFormSubmit();
            }else{
                self::handleProductSetList();
            }
        }else{
            if (!empty($_REQUEST['is_submit'])) {
                self::handleProductSetFormSubmit();
//            } elseif (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'case') {
//                self::handleCaseShow();
//            } elseif (!empty($_REQUEST['is_submit_case'])) {
//                self::handleProductSetCaseForm();
//            } elseif (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'caseshow') {
//                self::handleSetCase();
            } elseif (!empty($_REQUEST['is_submit_deliver'])) {
                OA_My_Customer_Handle_Product::handleSubmitDeliver();
            }elseif(!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type']=="deliver"){
                OA_My_Customer_Handle_Product::handleDeliverEdit();
            } else {
                self::handleProductSetFormOfEdit();
            }
        }
    }

    /**
     * @套餐列表
     */
    static function  handleProductSetList()
    {
        $conditions = array();
        //搜索框传过来的ID或者套餐名称
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'category_id' => 'int',
            ), $_REQUEST['search']);
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['set_name'] = $search['title'];
                }
            }
            //服务分类筛选
            if (!empty($search['category_id'])) {
                $conditions['category_id'] =$search['category_id'] ;
            }
        }
        $productInfo = Api_Vendor_Get_All_List::getSetListByVendorId($_REQUEST['vendor_id'],$conditions);

        Tpl_Smarty::assign('_categories', Data_Mysql_Table_Product_Set::$category_name);
        Tpl_Smarty::assign("category_name", Data_Mysql_Table_Product_Set::$category_name);
        Tpl_Smarty::assign('productInfo', $productInfo);

    }

    static function  getIdFromUrl($url)
    {
        if (preg_match_all('/\/([\d]+)\.html/i', $url, $a)) {
            return $a[1][0];
        } else {
            return intval($url);
        }
    }

    /*
    *展示套餐产品信息
    */
    static function handleProductSetFormOfEdit()
    {
        if (empty($_REQUEST['set_id'])) {
            Func_Header::back('参数错误！');
        }
        $data = Data_Mysql_Table_Product_Set::subTable('_update')->select('*', array('id' => $_REQUEST['set_id']), '', 1);
        $_data = Data_Mysql_Table_Product_Set::subTable('_update')->rowFormat($data[0]);
        $_data['id'] = $data[0]['id'];
        Tpl_Smarty::assign('_data', $_data);
        Tpl_Smarty::assign("category_name", Data_Mysql_Table_Product_Set::$category_name);
        //获取活动类型和行业标签
        Tpl_Smarty::assign('_attrs', Data_Config_Vendor_Attr::get('attr'));
    }

    static function handleSetCase()
    {
        if (empty($_REQUEST['set_id'])) {
            Func_Header::back('参数错误！');
        }
        $data = Data_Mysql_Table_Product_Set::subTable('_update')->select('*', array('id' => $_REQUEST['set_id']), '', 1);
        $_data = Data_Mysql_Table_Product_Set::subTable('_update')->rowFormat($data[0]);
        $case_rs=Api_Case_List_And_Info::getCaseList($_REQUEST['set_id'],'update',"set");
        if(empty($case_rs['status'])){
            Func_Header::back($case_rs['msg']);
        }
        Tpl_Smarty::assign('_data', $_data);
        Tpl_Smarty::assign('_case', $case_rs['data']);
    }

    /*
       *添加/修改套餐产品信息
       */
    static function handleProductSetFormSubmit()
    {
        $set_rs=Api_Product_Set_Submit::handle();
        if(empty($set_rs["status"])){
            Func_Header::back($set_rs['msg']);
        }else{
            Func_Header::to(' 正在审核中，您现在可以继续添加案例，showtime的机会哦！', Core::$urls['path'] . '?action=detail&tab=' . $_REQUEST['tab'] . '&vendor_id=' . $_REQUEST['vendor_id']);
        }
    }


    /*
     *获取供应商下的所有套餐信息
     */
    static function getVendorProductSetAll($vendorId)
    {
        $categories = Data_Mysql_Table_Product_Category::getInfoCache();

        $conditions = array();
        if (!empty($categoryId)) {
            $children = Data_Mysql_Table_Product_Category::getChildren(abs($categoryId));
            $children[] = abs($categoryId);
            if ($categoryId > 0) {
                $conditions[] = '{table}.category_id in (' . implode(',', $children) . ')';
            } else {
                $conditions[] = '{table}.category_id not in (' . implode(',', $children) . ')';
            }
        }
        //搜索框传过来的ID或者套餐名称
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'category_id' => 'int',
            ), $_REQUEST['search']);
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['id'] = $search['title'];
                } else {
                    $conditions['set_name'] = $search['title'];
                }
            }
            if (!empty($search['category_id'])) {
                $conditions['category_id'] = $search['category_id'];
            }
        }

        $conditions['{table}.vendor_id = ?'] = $vendorId;
        $conditions['{table}.status >= ? '] = 0;
        $table = "{table} LEFT JOIN {prefix}product_info ON {table}.id = {prefix}product_info.id LEFT JOIN {prefix}vendor_info ON {prefix}vendor_info.id = {table}.vendor_id LEFT JOIN {prefix}product_set AS t3 ON {table}.id = t3.id";
        $cols = "{table}.id,{table}.set_name,{table}.category_id,t3.status,{table}.status as update_status,{table}.update_time,{table}.refuse_reason";
        $data = Data_Mysql_Table_Product_Set::subTable('_update')->page(0, 0, $cols, $conditions, "ORDER BY {table}.update_time  DESC", $table);

        if (!empty($data['rows'])) {
            foreach ($data['rows'] as $k => $v) {
                if (!empty($categories[$v['category_id']][0])) {
                    $data['rows'][$k]['category_name'] = $categories[$v['category_id']][0];
                    //preg_replace('/\|.*/','',$data[0]['product_name']);
                    $data['rows'][$k]['set_name'] = preg_replace('/\|.*/', '', $v['set_name']);
                }
            }
        }
        return $data;
    }

    /*
     *@获取案例相关信息
*/
    static function handleCaseShow()
    {
        $caseInfo=array();
        if (empty($_REQUEST['set_id'])) {
            Func_Header::back('参数错误! ');
        }
        //获取当前套餐信息
        $product = Data_Mysql_Table_Product_Set::subTable('_update')->select('id, set_name as product_name, vendor_id', array('id' => $_REQUEST['set_id']));
        if (empty($product[0]['id'])) {
            Func_Header::back('参数错误! ');
        }
        Tpl_Smarty::assign('_product', $product[0]);
        //获取活动类型和行业标签
        Tpl_Smarty::assign('_attrs', Data_Config_Vendor_Attr::get('attr'));
        if(!empty($_REQUEST['case_id'])){
            $case_rs=Api_Case_List_And_Info::getCaseInfo("update",$_REQUEST['case_id']);
            if(empty($case_rs['status'])){
                Func_Header::back($case_rs["msg"]);
            }
            $caseInfo=$case_rs['data'];
        }

        Tpl_Smarty::assign('_data',$caseInfo );
    }

    /*
     *@ 套餐
     *@添加或修改案例
     */
    static function handleProductSetCaseForm()
    {
        $request = Func_Input::filter(array(
            'set_id' => 'int',
            'case_id' => 'int',
            'vendor_id' => 'int',
            'data' => 'array',
        ));
        if(empty($request['set_id'])){
            Func_Header::back('参数缺失！');
        }
        $case_rs=Api_Case_Submit::handle();
        if(empty($case_rs['status'])){
            Func_Header::back($case_rs['msg']);
        }else{
            Func_Header::to('  操作成功，正在审核!', Core::$urls['path'] . '?action=detail&tab=' . $_REQUEST['tab'] . '&handle_type=caseshow' . '&set_id=' . $_REQUEST['set_id'] . '&vendor_id=' . $request['vendor_id']);
        }
    }

    /*
     *获取套餐下的所有活动案例
     */
    static function getCaseById($setId)
    {
        //读取案例
        $case = Data_Mysql_Table_Event_Case::subTable('_update')->page(0, 5, '{table}.id,{table}.case_name,{table}.des,{table}.media,{table}.status,{prefix}event_info.event_name,{prefix}event_info.id as event_id', array(
            'product_set_id' => $setId,
        ), '', '{table} LEFT JOIN {prefix}event_info ON {table}.event_id = {prefix}event_info.id');
        if (!empty($case['rows'])) {
            foreach ($case['rows'] as $k => $v) {
                if (!empty($v['media'])) {
                    $v['media'] = json_decode($v['media'], 1);
                    $case['rows'][$k]['attr'] = $v['media'][0];
                    $case['rows'][$k]['media'] = $v['media'][1];
                } else {
                    $case['rows'][$k]['attr'] = json_decode($v['attr'], 1);
                }
                $case['rows'][$k]['event_name'] = '[' . $v['event_id'] . ']&nbsp;' . $v['event_name'];
            }
        }
        return $case;
    }

}