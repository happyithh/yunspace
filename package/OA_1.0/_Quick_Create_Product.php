<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-6-2
 * Time: 上午11:42
 */
class OA_Quick_Create_Product
{
    static function handle()
    {
        $_REQUEST['action'] = empty($_REQUEST['action']) ? 'show' : $_REQUEST['action'];
        if (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'is_submit') {
            self::handleIsSubmit();
        } elseif (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'exists') {
            self::checkVendorNameExists();
        } elseif (!empty($_REQUEST['action']) && $_REQUEST['action'] == 'quickCreate') {
            self::createProductByVendorId();
        } elseif (!empty($_REQUEST['vendor_auto_complete'])) {
            self::handleVendorAutoComplete();
        } else {
            self::handleFormShow();
        }
    }

    static function handleFormShow()
    {
        $vendor_info = Data_Config_Vendor_Attr::all();
        $contacts_city = $vendor_info['attr']['城市'];
        unset($vendor_info['attr']['城市']);
        Tpl_Smarty::assign('_contacts_city', $contacts_city);
        Tpl_Smarty::assign('_vendor_attr', $vendor_info);
        Tpl_Smarty::assign('_categories', Data_Mysql_Table_Product_Category::getTreeCache());
        Tpl_Smarty::assign('categoryInfo', Data_Mysql_Table_Product_Category::getInfoCache());
        if (!empty($_REQUEST['category_id'])) {
            Tpl_Smarty::assign('_tags_info', Data_Mysql_Table_Product_Category::getTagsInfo($_REQUEST['category_id']));
        }
        Tpl_Smarty::display('OA', 'quick_create/quick_create_product.tpl');
    }

    static function handleIsSubmit()
    {
        //接受数据
        $request_contacts = Func_Input::filter(array(
            'username' => 'string',
            'phone' => 'phone',
            'business' => 'string',
            'sub_business' => 'string',
            'city' => 'string',
            'company' => 'string',
        ), $_REQUEST['data_c']);
        $request_vendor = Func_Input::filter(array(
            'vendor_name' => 'string',
            'addr' => 'string',
            'categories_id' => 'string',
            'attr' => 'array',
            'base_info' => 'array',
            'des' => 'string',
            'type' => '21',
        ), $_REQUEST['data_v']);
//        $request_product = Func_Input::filter(array(
//            'product_name' => 'string',
//            'price' => 'int',
//            'hide_price' => 'int',
//            'addr' => 'string',
//            'product_size' => 'string',
//            'category_id' => 'int',
//            'des' => 'string',
//            'media' => 'array',
//            'attr_new' => 'array',
//        ), $_REQUEST['data_p']);

        if (empty($request_contacts['username'])) {
            Func_Header::back('联系人姓名必须正确填写!');
        }
        if (empty($request_contacts['phone'])) {
            preg_match_all('/^(0(10|21|22|23|[1-9][0-9]{2})(-|))?[0-9]{7,8}$/', $_REQUEST['data_c']['phone'], $tel);
            if (!empty($tel[0][0])) {
                $request_contacts['phone'] = $tel[0][0];
            } else {
                Func_Header::back('请正确输入手机号/固定电话！');
            }
        }
        if (empty($request_contacts['business']) || empty($request_contacts['city'])) {
            Func_Header::back('业务类型和城市必须填写！');
        }

        if (empty($request_vendor['vendor_name'])) {
            Func_Header::back('供应商名称不能为空！');
        }
        if (empty($request_contacts['company'])) {
            $request_contacts['company'] = $request_vendor['vendor_name'];
        }
        if (empty($request_vendor['attr']['城市'])) {
            $request_vendor['attr']['城市'] = $request_contacts['city'];
            if (empty($request_vendor['attr']['城市'])) {
                Func_Header::back('供应商城市项必须填写!');
            }
        }
        $request_vendor['city'] = $request_contacts['city'];
        if(!empty($request_vendor['attr'])){
            $request_vendor['attr_index'] = Data_Mysql_Table_Vendor_Info::attrToIndex($request_vendor['attr']);
        }
        if (empty($_REQUEST['data_p']['attr_new'][46])) {
            $_REQUEST['data_p']['attr_new'][46] = $request_vendor['attr']['城市'];
        }
        $request = Api_Product_Submit::handle($table="update",$_REQUEST,$type='check');
        if($request['status']==0) {
            Func_Header::back($request['msg']);
        }
        //创建账号和联系人
        $rs_contacts = self::setContactsByData($request_contacts);
        //创建供应商
        $request_vendor['vendor_account_id'] = $rs_contacts;
        $rs_vendor = self::setVendorByData($request_vendor);
        //创建产品
        $_REQUEST['data_p']['vendor_id'] = $rs_vendor;
        $_REQUEST['data_p']['create_by_quick'] = 1;
//        $rs_product = self::setProductByData($request_product);
        $rs_product = Api_Product_Submit::handle($table="update",$_REQUEST,$type='submit');
        Func_Header::to(' 正在审核中，您现在可以继续添加案例，showtime的机会哦！', Core::$urls['path']);
    }

    //创建联系人和账号
    static function setContactsByData($request_contacts = array())
    {
        //1.判断账号是否存在且是否绑定供应商
        $account_exists = Data_Mysql_Table_Account::select('id,phone', array('phone' => $request_contacts['phone']));
        if (!empty($account_exists[0])) {
            $account_id = $account_exists[0]['id'];
            $vendors = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,vendor_account_id,vendor_name', array('vendor_account_id' => $account_id));
            if (!empty($vendors[0])) {
                Func_Header::back('该手机号已绑定供应商【' . $vendors[0]['vendor_name'] . '】');
            }
        } else {
            //2.创建账号
            $username = empty($request_contacts['company']) ? $request_contacts['username'] : $request_contacts['company'];
            $account_name_exists = Data_Mysql_Table_Account::select('id,username', array('username' => $username));
            $account_insert = array(
                'fullname' => empty($request_contacts['company']) ? $request_contacts['username'] : $request_contacts['company'],
                'phone' => $request_contacts['phone'],
                'username' => empty($account_name_exists[0]) ? $username : $username . $request_contacts['phone'],
                'attr' => array(
                    'register_ip' => Func_Input::ip(),
                    'email' => '',
                    'phone' => $request_contacts['phone']
                ),
                'account_type' => 21,
                'password' => Data_Mysql_Table_Account::makePassword($request_contacts['phone']),
                'register_time' => time(),
                'admin_id' => $_SESSION['administrator']['id'],
            );
            $rs_account = Data_Mysql_Table_Account::insert($account_insert);
            if (empty($rs_account[0])) {
                Func_Header::back('创建帐号失败,请联系管理员!');
            }
            $account_id = $rs_account[0];
        }

        //3.判断该联系人是否已存在
        $contacts_exists = Data_Mysql_Table_Contact_Library::select('id,phone,account_id', array('phone' => $request_contacts['phone']));
        if (!empty($contacts_exists[0])) {
            if (empty($contacts_exists[0]['account_id'])) {
                Data_Mysql_Table_Contact_Library::update($contacts_exists[0]['id'], array('account_id' => $account_id, 'new_demand_time' => 0));
                //创建该账户的操作日志
                Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '联系人【' . $contacts_exists[0]['id'] . '】绑定账户成功', '联系人绑定账号', $contacts_exists[0]['id']);
            }
        } else {
            //4.创建联系人
            $request_contacts['account_id'] = $account_id;
            $request_contacts['type'] = 21;
            $request_contacts['customer_type'] = 0;
            $request_contacts['new_demand_time'] = 0;
            $rs_contacts = Data_Mysql_Table_Contact_Library::insert($request_contacts);
            if (empty($rs_contacts[0])) {
                Func_Header::back('创建联系人失败,请联系管理员!');
            }
            //创建该账户的操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '联系人【' . $rs_contacts[0] . '】绑定账户成功', '联系人绑定账号', $rs_contacts[0]);
        }
        if (empty($account_id)) {
            Func_Header::back('未知错误1！！');
        }
        return $account_id;
    }

    //创建供应商
    static function setVendorByData($request_vendor = array())
    {
        if(!empty($request_vendor['create_by_quick']) && $request_vendor['create_by_quick'] == 3) {
            $request_vendor['create_by_quick'] = 3;
        }else{
            $request_vendor['create_by_quick'] = 1;
        }
        //$request_vendor['create_by_quick'] = 1;
        $request_vendor['status'] = 2;
        $request_vendor['admin_id'] = $_SESSION['administrator']['id'];
        $rs_vendor = Data_Mysql_Table_Vendor_Info::subTable('_update')->insert($request_vendor);
        if (empty($rs_vendor[0])) {
            Func_Header::back('创建供应商失败,请联系管理员!');
        }
        if (empty($rs_vendor[0])) {
            Func_Header::back('未知错误2！！');
        }
        return $rs_vendor[0];
    }

    //创建产品
    static function setProductByData($request_product = array())
    {
        $request_product['create_by_quick'] = 1;
        $request_product['status'] = 2;
        $request_product['admin_id'] = $_SESSION['administrator']['id'];
        if (!empty($request_product['price'])) {
            if (!empty($request_product['hide_price'])) {
                $request_product['price'] *= -100;
            } else {
                $request_product['price'] *= 100;
            }
        }
        if (!empty($request_product['media'])) {
            unset($request_product['media']['$$']);
            $request_product['media'] = array_values($request_product['media']);
            $request_product['media_num'] = count($request_product['media']);
            foreach ($request_product['media'] as $mk => $mv) {
                //主图
                if (empty($request_product['logo'])) {
                    $request_product['logo'] = $mv['path'];
                }
                if (strpos($mv['tags'], '@主图') !== false) {
                    $request_product['logo'] = $mv['path'];
                    break;
                }
            }
        }
        $rs_product = Data_Mysql_Table_Product_Info::subTable('_update')->insert($request_product);
        if (empty($rs_product[0])) {
            Func_Header::back('创建产品失败,请联系管理员!');
        }
        if (empty($rs_product[0])) {
            Func_Header::back('未知错误3！！');
        }
        return $rs_product[0];
    }

    /*
     *判断供应商名称是否已存在
     */
    static function checkVendorNameExists()
    {
        Core::output('');
        if (empty($_REQUEST['vendor_name'])) {
            Func_Output::json('error', '', '供应商名称不能为空');
        }
        $conditions['vendor_name = ?'] = $_REQUEST['vendor_name'];
        $rs = Data_Mysql_Table_Vendor_Info::select('id,vendor_name', $conditions);
        if (!empty($rs[0])) {
            Func_Output::json('error', '', '供应商名称已存在');
        }
        Func_Output::json('success', '', '输入正确！');

    }

    /*
     *为已有供应商快速创建产品
     */
    static function createProductByVendorId()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'category_id' => 'int',
            'vendor_id' => 'int',
            'product_name' => 'string'
        ));
        if (empty($request['category_id']) || empty($request['product_name']) || empty($request['vendor_id'])) {
            Func_Output::json('error', '', '参数错误！！');
        }
        $data = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,vendor_name,vendor_account_id,categories_id', $request['vendor_id']);
        if (empty($data[0])) {
            Func_Output::json('error', '', '供应商不存在！！');
        } elseif (empty($data[0]['vendor_account_id'])) {
            Func_Output::json('error', '', '请先绑定该供应商的账户!');
        }
        //创建产品
        $p_data = array(
            'product_name' => $request['product_name'],
            'vendor_id' => $request['vendor_id'],
            'category_id' => $request['category_id'],
            'admin_id' => $_SESSION['administrator']['id'],
            'status' => 2,
        );
        $rs_p = Data_Mysql_Table_Product_Info::subTable('_update')->insert($p_data);
        //更新供应商的categories_id 和状态
        if (!empty($data[0]['categories_id'])) {
            $category_arr = explode(',', $data[0]['categories_id']);
            array_push($category_arr, $request['category_id']);
            $category_arr = array_unique($category_arr);
            $categories = implode(',', $category_arr);
        } else {
            $categories = $request['category_id'];
        }
        $rs_v = Data_Mysql_Table_Vendor_Info::subTable('_update')->query('UPDATE {table} SET status =? , categories_id = ? where id= ?', array(2, $categories, $request['vendor_id']), 1);
        if (empty($rs_p[0])) {
            Func_Output::json('error', '', '创建产品失败！！');
        } else {
            $return = array('account_id' => $data[0]['vendor_account_id'], 'product_id' => $rs_p[0]);
            Func_Output::json('success', $return, '创建产品成功！！');
        }
    }

    /*
     *供应商自动查询
     */
    static function handleVendorAutoComplete()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
        ));
        if (!$request['id'] && !$request['q']) {
            die('参数错误!');
        }
        if ($request['id']) {
            $rs = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id, CONCAT( "[", id, "] ", vendor_name) as name', array("id = ? and status >= ?" => array($request['id'], 0)));
        } else {
            $rs = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id, CONCAT( "[", id, "] ", vendor_name) as name', array("(id like ? OR vendor_name like ?) and status >= ?" => array($request['q'] . '%', $request['q'] . '%', 0)), '', 5);
        }
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

}