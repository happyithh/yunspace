<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/24
 * Time: 10:22
 */
class Web_Vendor_Center_Vendor_Edit extends Base
{

    /*
     * 供应商信息修改
     */
    static function handle()
    {
        //检查是否有修改权限
        Web_Vendor_Center_Product_Edit::handleCheckProductAuth();
        switch (Core::$urls['action']) {
            case 'vendor_edit/submit':
                self::handleVendorEditSubmit();
                break;
            default:
                self::handleVendorEdit();
                break;
        }
    }

    static function handleVendorEdit()
    {
        if (empty($_REQUEST['url_to'])) {
            $_REQUEST['url_to'] = Core::$urls['referer'];
        }
        $request = Func_Input::filter(array(
            'vendor_id' => 'int',
            'reset' => 'int',
        ));
        if (!$request['vendor_id']) {
            Func_Header::back('参数异常,请稍候再试!');
        }
        $data = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('*', array('id' => $request['vendor_id']));
        if (empty($data[0])) {
            $data = Data_Mysql_Table_Vendor_Info::select('*', array('id' => $_REQUEST['vendor_id']));
        }
        if (!empty($data[0])) {
            if (!empty($data[0]['attr'])) {
                $data[0]['attr'] = json_decode($data[0]['attr'], 1);
            }
            if (!empty($data[0]['base_info'])) {
                $data[0]['base_info'] = json_decode($data[0]['base_info'], 1);
            }
            if (!empty($data[0]['media'])) {
                $data[0]['media'] = json_decode($data[0]['media'], 1);
            }
            if (!empty($data[0]['vendor_remarks'])) {
                $data[0]['vendor_remarks'] = json_decode($data[0]['vendor_remarks'], 1);
            }
//            if(!empty($data[0]['categories_id'])){
//                $data[0]['categories_id']=explode(',',$data[0]['categories_id']);
//            }
        }
        //获取该供应商下的空间场地
        $productInfo = self::getProductByVendorId($request['vendor_id'], Data_Config_Site::$staticConfig['space_id']);
        $serviceInfo = self::getProductByVendorId($request['vendor_id'], Data_Config_Site::$staticConfig['space_id'] * -1);
        Tpl_Smarty::assign('productInfo', $productInfo);
        Tpl_Smarty::assign('serviceInfo', $serviceInfo);
        Tpl_Smarty::assign('_data', $data[0]);
        Tpl_Smarty::assign('_vendor_attr', Data_Config_Vendor_Attr::get('attr'));
        Tpl_Smarty::assign('_categories', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::display('vendor_edit.tpl');
    }

    static function handleVendorEditSubmit()
    {
        if (empty($_REQUEST['url_to'])) {
            $_REQUEST['url_to'] = '';
        }
        $request = Func_Input::filter(array(
            'vendor_id' => 'int',
            'data' => 'array',
        ));

        $status = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('status', array('id ' => $request['vendor_id']));

        if (!$request['vendor_id']) {
            Func_Header::back('参数异常,请稍候再试!');
        }
        if (empty($request['data']['vendor_name'])) {
            Func_Header::back('供应商名称不能为空！！');
        }
        if (empty($request['data']['attr']['城市'])) {
            Func_Header::back('城市不能为空！！');
        }
        if (empty($request['data']['attr']['服务行业'])) {
            Func_Header::back('服务行业不能为空！！');
        }
        if (empty($request['data']['attr']['活动类型'])) {
            Func_Header::back('活动类型不能为空！！');
        }
        if (empty($request['data']['attr']['公司规模'])) {
            Func_Header::back('公司规模不能为空！！');
        }
        if (empty($request['data']['des'])) {
            Func_Header::back('供应商介绍不能为空！！');
        }
        $requestData = Func_Input::filter(array(
            'vendor_name' => 'string',
            'des' => 'html',
            'attr' => 'array',
            'base_info' => 'array',
            'categories_id' => 'array',
        ), $request['data']);
        $files = Func_Input::filter(array(
            '公司LOGO' => 'array',
        ), $_FILES);
        //获取供应商信息修改数据
        if (!empty($requestData['vendor_name']) || !empty($requestData['des'])) {
            if (!empty($files['公司LOGO']['name'])) {
                $logo = Func_Upload::image('公司LOGO');
                if (!empty($logo)) {
                    $requestData['logo'] = $logo;
                }
            }
            if (!empty($requestData['attr'])) {
                $requestData['attr_index'] = Data_Mysql_Table_Vendor_Info::attrToIndex($requestData['attr']);
            }
            if (!empty($requestData['categories_id'])) {
                $requestData['categories_id'] = implode(',', $requestData['categories_id']);
            }
            $requestData['status'] = 2;
            $requestData['city'] = $request['data']['attr']['城市'];

            //如果是加盟的供应商
            if (Api_Vendor_Join_IsVendorJoinAccount::check(array('account_id' => Api_Session::user_id()))) {
                unset($requestData['status']);
            }
            //写入数据库
            $r = Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id' => $request['vendor_id']), $requestData);

            if (empty($r[0])) {
                Func_Header::back('操作异常,请稍候再试!');
            }
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '供应商信息修改', '供应商信息修改', $request['vendor_id']);
            Func_Header::to('提交成功，请等待审核!', Core::$urls['root'] . Core::$urls['package'] . Core::$urls['route'] . 'vendor_edit?vendor_id=' . $request['vendor_id']);
        }

    }

    //获取供应商的空间场地和配套服务信息
    static function getProductByVendorId($vendorId, $categoryId)
    {
        $conditions = array();
        $conditions['vendor_id'] = $vendorId;
        $children = Data_Mysql_Table_Product_Category::getChildren(abs($categoryId));
        $children[] = abs($categoryId);
        if ($categoryId > 0) {
            $conditions[] = 'category_id in (' . implode(',', $children) . ')';
        } else {
            $conditions[] = 'category_id not in (' . implode(',', $children) . ')';
        }
        $data = Data_Mysql_Table_Product_Info::select("id,category_id ,vendor_id, product_name", $conditions, '', 99999);
        return $data;
    }

}
