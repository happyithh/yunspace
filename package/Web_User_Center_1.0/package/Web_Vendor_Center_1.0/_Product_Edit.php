<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/3/24
 * Time: 10:22
 */
class Web_Vendor_Center_Product_Edit extends Base
{
    static function handle()
    {
        //检查是否有修改权限
        if (Core::$urls['action'] != "product_edit/schedule" && Core::$urls['action'] != "product_edit/add_schedule") {
            self::handleCheckProductAuth();
        }
        switch (Core::$urls['action']) {
            case 'product_edit/online':
                self::handleProductOnline();
                break;
            case 'product_edit/refresh':
                self::handleProductRefresh();
                break;
            case 'product_edit/delete_recover':
                self::handleProductStatus();
                break;
            case 'product_edit/get_vendor_categories':
                self::handleGetVendorCategories();
                break;
            case 'product_edit/get_category_attr':
                self::handleGetCategoryAttr();
                break;
            case 'product_edit/submit':
                self::handleProductEditSubmit();
                break;
            case 'product_edit/schedule':
                self::handleSchedule();
                break;
            case 'product_edit/add_schedule':
                self::handelAddScheduleSubmit();
                break;
            case 'product_edit/case_online':
                self::handleCaseOnline();
                break;
            case 'product_edit/delete_auction':
                self::handledelauction();
                break;
            case 'product_edit/case':
                self::handlcase();
                break;
            default:
                self::handleProductEdit();
                break;
        }
    }

    static function handleCheckProductAuth()
    {
        if (!empty($_SESSION['user']['super_vendor'])) {
            return true;
        }

        $request = Func_Input::filter(array(
            'product_id' => 'int',
            'vendor_id' => 'int',
            'set_id' => 'int',
        ));
        if (Api_Vendor_Join_IsVendorJoinAccount::check(array('account_id' => $_SESSION['user']['id']))) {
            return true;
        }
        if ($request['product_id']) {
            $r = Data_Mysql_Table_Product_Info::select('{table}.id, t2.vendor_account_id', array(
                'id' => $request['product_id'],
                't2.vendor_account_id = ?' => $_SESSION['user']['id']
            ), '', 1, '{table} LEFT JOIN {prefix}vendor_info_update as t2 ON t2.id = {table}.vendor_id');
            if (empty($r[0])) {
                $r = Data_Mysql_Table_Product_Info::subTable('_update')->select('{table}.id, t2.vendor_account_id', array(
                    'id' => $request['product_id'],
                    't2.vendor_account_id = ?' => $_SESSION['user']['id']
                ), '', 1, '{table} LEFT JOIN {prefix}vendor_info_update as t2 ON t2.id = {table}.vendor_id');
                if (empty($r[0])) {
                    Func_Header::notFound();
                }
            }
        }
        if ($request['set_id']) {
            $r = Data_Mysql_Table_Product_Set::select('{table}.id, t2.vendor_account_id', array(
                'id' => $request['set_id'],
                't2.vendor_account_id = ?' => $_SESSION['user']['id']
            ), '', 1, '{table} LEFT JOIN {prefix}vendor_info_update as t2 ON t2.id = {table}.vendor_id');
            if (empty($r[0])) {
                $r = Data_Mysql_Table_Product_Set::subTable('_update')->select('{table}.id, t2.vendor_account_id', array(
                    'id' => $request['set_id'],
                    't2.vendor_account_id = ?' => $_SESSION['user']['id']
                ), '', 1, '{table} LEFT JOIN {prefix}vendor_info_update as t2 ON t2.id = {table}.vendor_id');
                if (empty($r[0])) {
                    Func_Header::notFound();
                }
            }
        }
        if ($request['vendor_id']) {
            $r = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id', array(
                'id' => $request['vendor_id'],
                'vendor_account_id = ?' => $_SESSION['user']['id']
            ));
            if (empty($r[0])) {
                $r = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id', array(
                    'id' => $request['vendor_id'],
                    'vendor_account_id = ?' => $_SESSION['user']['id']
                ));
                if (empty($r[0])) {
                    Func_Header::notFound();
                }
            }
        }
    }

    static function handleProductOnline()
    {
        if (isset($_REQUEST['product_online'])) {
            $request = Func_Input::filter(array(
                'product_online' => 'int',
                'product_id' => 'int',
            ));
            if (!$request['product_id']) {
                die('fail');
            }
            //更新在线状态
            $r = Data_Mysql_Table_Product_Info::query("UPDATE {table} SET status = ? WHERE id = ?", array(
                $request['product_online'] ? 1 : 0,
                $request['product_id']
            ), 1);
            $r_search = Data_Mysql_Table_Product_Search::query("UPDATE {table} SET status = ? WHERE id = ?", array(
                $request['product_online'] ? 1 : 0,
                $request['product_id']
            ), 1);
            Core::log('online_offline_product2', $request['product_id'], $request['product_online'], $_SESSION['user']['id']);
            if (empty($r[0]) || empty($r_search[0])) {
                echo 'fail';
            } else {
                echo 'success';
            }
            die;
        }
    }

    static function handleProductRefresh()
    {
        if (isset($_REQUEST['product_id'])) {
            $request = Func_Input::filter(array(
                'product_id' => 'int',
            ));
            if (!$request['product_id']) {
                die('fail');
            }
            //更新在新状态
            $r = Data_Mysql_Table_Product_Info::query("UPDATE {table} SET update_time = ? WHERE id = ? AND update_time < ?", array(
                time(),
                $request['product_id'],
                time() - 3600 * 4,
            ), 1);
            if (empty($r[0])) {
                echo 'fail';
            } else {
                echo 'success';
            }
            die;
        }
    }

    static function handleProductStatus()
    {
        if (isset($_REQUEST['product_id'])) {
            $request = Func_Input::filter(array(
                'product_id' => 'int',
                'product_status' => 'int',
            ));
            if (!$request['product_id']) {
                die('fail');
            }
            $rs = Data_Mysql_Table_Product_Info::handleDelete($request['product_id'], $request['product_status'] ? $request['product_status'] : -1);
            if ($rs) {
                echo 'success';
            } else {
                echo 'fail';
            }
        }
    }

    /*
    * 添加,更新或删除空间场地或配套服务
    */
    static function handleProductEdit()
    {
        $category = Data_Mysql_Table_Product_Category::getInfoCache();
        $request = Func_Input::filter(array(
            'product_id' => 'int',
            'vendor_id' => 'int',
            'reset' => 'int',
        ));

        if (empty($_REQUEST['url_to'])) {
            $_REQUEST['url_to'] = Core::$urls['referer'];
        }
        if (!empty($request['product_id'])) {

            if (Api_Vendor_Join_IsVendorJoinAccount::check(array('account_id' => $_SESSION['user']['id']))) {
                Tpl_Smarty::assign('is_vendor_join', 1);
                $data = Data_Mysql_Table_Product_Info::subTable('_update')->select('*', array('id' => $request['product_id']));

            } else {
                $data = Data_Mysql_Table_Product_Info::subTable('_update')->select('*', array('id' => $request['product_id']));
                if (empty($data[0])) {
                    $data = Data_Mysql_Table_Product_Info::select('*', array('id' => $request['product_id']));
                }
            }

            if (!empty($data[0])) {
                if (!empty($category[$data[0]['category_id']]['tags_info'])) {
                    $data[0]['tags_info'] = $category[$data[0]['category_id']]['tags_info'];
                }
                if (!empty($data[0]['attr'])) {
                    $data[0]['attr'] = json_decode($data[0]['attr'], 1);
                }
                if (!empty($data[0]['attr_new'])) {
                    $data[0]['attr_new'] = json_decode($data[0]['attr_new'], 1);
                }
                if (!empty($data[0]['media'])) {
                    $data[0]['media'] = json_decode($data[0]['media'], 1);
                }
                if (!empty($data[0]['price'])) {
                    $data[0]['price'] = $data[0]['price'] / 100;
                }
                if (!empty($category[$data[0]['category_id']]['tags_info'])) {
                    $data[0]['tags_info'] = $category[$data[0]['category_id']]['tags_info'];
                }
            }
            $eventInfo = self::getCaseById($request['product_id']);
            Tpl_Smarty::assign('_data', $data[0]);
            Tpl_Smarty::assign('_event', $eventInfo);
        } else {
            Tpl_Smarty::assign('_data', array(
                'vendor_id' => $request['vendor_id'],
            ));
            $data[0]['vendor_id'] = $request['vendor_id'];
        }
        //获取可选供应商
        $vendorInfo = Data_Mysql_Table_Vendor_Info::subTable('_update')->select("id, categories_id, vendor_name", array(
            'vendor_account_id =? OR id = ?' => array(
                $_SESSION['user']['id'],
                $data[0]['vendor_id']
            )
        ), '', 20);
        if (empty($vendorInfo)) {
            Func_Header::back('无可用供应商信息!');
        }
        Tpl_Smarty::assign('_tags_tree', Data_Mysql_Table_Tags::getTreeCache());
        Tpl_Smarty::assign('_tags_info', Data_Mysql_Table_Tags::getInfoCache());
        Tpl_Smarty::assign('vendorInfo', $vendorInfo);


        Tpl_Smarty::display('product_edit.tpl');
    }

//活动案例
    static function handlcase()
    {
        $category = Data_Mysql_Table_Product_Category::getInfoCache();
        $request = Func_Input::filter(array(
            'product_id' => 'int',
        ));
        if (!empty($request['product_id'])) {
            $data = Data_Mysql_Table_Product_Info::subTable('_update')->select('*', array('id' => $request['product_id']));
        }
        Tpl_Smarty::assign('_data', $data[0]);
        $eventInfo = self::getCaseById($request['product_id']);
        Tpl_Smarty::assign('_event', $eventInfo);
        Tpl_Smarty::display('product_case.tpl');
    }

    static function handleGetVendorCategories()
    {
        $request = Func_Input::filter(array(
            'vendor_id' => 'int',
        ));
        //获取供应商的分类信息
        if ($request['vendor_id']) {
            $r = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,categories_id', array(
                'id' => $request['vendor_id']
            ));
            if (!empty($r[0]['categories_id'])) {
                $categories = explode(',', $r[0]['categories_id']);
            } elseif ($_SESSION['user']['super_vendor']) {
                $categories = array(Data_Config_Site::$staticConfig['space_id']);
            } else {
                echo 'error';
                die;
            }
            $categoryInfo = Data_Mysql_Table_Product_Category::getInfoCache();
            $categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
            $data = array();
            foreach ($categories as $cv) {
                if (!empty($categoryInfo[$cv][3])) {
                    $data[$categoryTree[0][$categoryInfo[$cv][3]]][$cv] = $categoryInfo[$cv][0];
                } elseif (!empty($categoryTree[0][$cv])) {
                    $data[$categoryTree[0][$cv]] = $categoryTree[$cv];
                }
            }
            if (!empty($data[$categoryTree[0][Data_Config_Site::$staticConfig['space_id']]])) {
                $data[$categoryTree[0][Data_Config_Site::$staticConfig['space_id']]] = $categoryTree[Data_Config_Site::$staticConfig['space_id']];
            }
            if ($data) {
                echo json_encode($data);
                die;
            } else {
                echo 'error';
                die;
            }
        }
    }

    static function handleGetCategoryAttr()
    {
//        $json = array();
        $tags_info = array();
        if (!empty($_REQUEST['category_attr'])) {
            Core::output('');
            $request = Func_Input::filter(array('category_id' => 'int', 'jsoncallback' => 'string'));
            $tags_info = Data_Mysql_Table_Product_Category::getTagsInfo($request['category_id']);
//            if (!empty($tags_info)) {
//                foreach ($tags_info as $key => $value) {
//                    foreach ($value as $vk => $vv) {
////                        $json[$key][$vk]['parent_name']=$key;
//                        $json[$vk]['name'] = $key . ">" . $vv['tags_name'];
//                        $json[$vk]['tags_id'] = $vk;
//                        $tags_value = empty($vv['tags_value']) ? "" : $vv['tags_value'];
//                        $json[$vk]['values'] = $tags_value;
//                    }
//                }
//            }
//            $json = json_encode($json);
            $json = json_encode($tags_info);
            echo "{$request['jsoncallback']}({$json})";
            die;
        }
    }

    static function handleProductEditSubmit()
    {
//        Api_Product_Submit::handle($table="update",$_REQUEST);
//        $request = Func_Input::filter(array(
//            'id' => 'int',
//            'product_id' => 'int',
//            'hide_price' => 'int',
//            'data' => 'array',
//        ));
//
//        if (empty($request['data']['product_name'])) {
//            Func_Header::back('产品名称不能为空！！');
//        }
//        if (!empty($request['data']['price']) && !(is_numeric($request['data']['price']))) {
//            Func_Header::back('价格填写必须为数字！！');
//        }
//        if (empty($request['data']['des'])) {
//            Func_Header::back('文字介绍不能为空！！');
//        }
//        if (empty($request['data']['attr_new']['46'])) {
//            Func_Header::back('城市不能为空！！');
//        }
//
//        if (!empty($request['data']['attr_new']['计价单位']) && (empty($request['data']['attr_new']['计价下限']) || empty($request['data']['attr_new']['计价上限']))) {
//            Func_Header::back('订购数量的上下限不能为空！');
//        }
//        if (!empty($request['data']['attr_new']['计价下限']) && !empty($request['data']['attr_new']['计价上限']) && $request['data']['attr_new']['计价下限'] > $request['data']['attr_new']['计价上限']) {
//            Func_Header::back('请正确填写订购数量的上下限！');
//        }
//        if (!empty($request['data']['price'])) {
//            if (!empty($request['hide_price'])) {
//                $request['data']['price'] *= -100;
//            } else {
//                $request['data']['price'] *= 100;
//            }
//        } else {
//            $request['data']['price'] = 0;
//        }
//        if (!empty($request['data']['media'])) {
//            unset($request['data']['media']['$$']);
//            $request['data']['media'] = array_values($request['data']['media']);
//            $request['data']['media_num'] = count($request['data']['media']);
//            foreach ($request['data']['media'] as $mk => $mv) {
//                //主图
//                if (empty($request['data']['logo'])) {
//                    $request['data']['logo'] = $mv['path'];
//                }
//                if (strpos($mv['tags'], '@主图') !== false) {
//                    $request['data']['logo'] = $mv['path'];
//                    break;
//                }
//            }
//        }
//        $request['data']['status'] = 2;
//        $request['data']['order_lv'] = 0;
//        //根据提交的category_id来确定是空间场地space还是配套服务service
//        $category_array = Data_Mysql_Table_Product_Category::getTreeCache();
//        $_space_id = array_keys($category_array[112]);
//
//        $_service_id = array_keys($category_array[2]);
//        if(in_array($request['data']['category_id'],$_space_id)) {
//            $product_to = 'space';
//        }
//        if(in_array($request['data']['category_id'],$_service_id)) {
//            $product_to = 'service';
//        }
//
//        //如果是加盟的供应商
//        if (!empty($request['product_id']) && Api_Vendor_Join_IsVendorJoinAccount::check(array('account_id' => $_SESSION['user']['id']))) {
//            //创建操作日志
//            $rs = Data_Mysql_Table_Product_Info::subTable('_update')->update(array('id' => $request['product_id']), $request['data']);
//            if ($rs[0] > 0) {
//
//                Func_Header::to(' 正在审核中，您现在可以继续添加案例，showtime的机会哦！', empty($request['url_to']) ? Core::$urls['root'] . Core::$urls['package'] . Core::$urls['route'] . 'product/'.$product_to : $request['url_to']);
//            }
//            Func_Header::to('操作错误！！');
//        }
//
//        if (!empty($request['product_id'])) {
//            //创建操作日志
//            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '修改产品信息', '修改产品信息', $request['product_id']);
//            $rs = Data_Mysql_Table_Product_Info::subTable('_update')->update(array('id' => $request['product_id']), $request['data']);
//        } else {
//            $rs = Data_Mysql_Table_Product_Info::subTable('_update')->insert($request['data']);
//            //创建操作日志
//            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '添加产品', '添加产品', $rs[0]);
//        }
//        if ($rs[0] > 0) {
//            //更改所属供应商的状态
//            Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id = ? and status != ?' => array($request['data']['vendor_id'], 2)), array('status' => 4));
//            Func_Header::to(' 正在审核中，您现在可以继续添加案例，showtime的机会哦！', empty($request['url_to']) ? Core::$urls['root'] . Core::$urls['package'] . Core::$urls['route'] . 'product/'.$product_to : $request['url_to']);
//        }
//        Func_Header::to('操作错误！！');




        $_REQUEST['data']['order_lv'] = 0;
        //根据提交的category_id来确定是空间场地space还是配套服务service
        $category_array = Data_Mysql_Table_Product_Category::getTreeCache();
        $_space_id = array_keys($category_array[112]);

        $_service_id = array_keys($category_array[2]);
        if(in_array($_REQUEST['data']['category_id'],$_space_id)) {
            $product_to = 'space';
        }
        if(in_array($_REQUEST['data']['category_id'],$_service_id)) {
            $product_to = 'service';
        }

        $rs = Api_Product_Submit::handle($table='update',$_REQUEST);
        if($rs['status']==0) {
            Func_Header::back($rs['msg']);
        }
        //如果是加盟的供应商
        if (!empty($_REQUEST['product_id']) && Api_Vendor_Join_IsVendorJoinAccount::check(array('account_id' => $_SESSION['user']['id']))) {
            //创建操作日志
            if (!empty($rs['data']) && $rs['data'] > 0) {
                Func_Header::to(' 正在审核中，您现在可以继续添加案例，showtime的机会哦！', Core::$urls['root'] . Core::$urls['package'] . Core::$urls['route'] . 'product/' . $product_to);
            }
            Func_Header::to('操作错误！！');
        }
        if (!empty($_REQUEST['product_id'])) {
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], $_SESSION['administrator']['id'], '修改产品信息', '修改产品信息', $_REQUEST['product_id']);
        } else {
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], $_SESSION['administrator']['id'], '添加产品', '添加产品', $rs['data']);
        }
        if ($rs['data'] > 0) {
            //更改所属供应商的状态
            Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id = ? and status != ?' => array($_REQUEST['data']['vendor_id'], 2)), array('status' => 4));
            Func_Header::to(' 正在审核中，您现在可以继续添加案例，showtime的机会ha！', Core::$urls['root'] . Core::$urls['package'] . Core::$urls['route'] . 'product/' . $product_to);
        }
        Func_Header::to('操作错误！！');
    }



    /*
    *获取产品下的所有活动案例
    */
    static function getCaseById($productId)
    {
        //读取案例
        $case = Data_Mysql_Table_Event_Case::subTable('_update')->page(0, 5, '{table}.id,{table}.case_name,{table}.des,{table}.media,{table}.status,{prefix}event_info.event_name,{prefix}event_info.id as event_id', array(
            'product_id' => $productId,
        ), '', '{table} LEFT JOIN {prefix}event_info ON {table}.event_id = {prefix}event_info.id');
        if (!empty($case['rows'])) {
            foreach ($case['rows'] as $k => $v) {
                if (!empty($v['media'])) {
                    $v['media'] = json_decode($v['media'], 1);
                    $case['rows'][$k]['attr'] = $v['media'][0];
                    $case['rows'][$k]['media'] = $v['media'][1];
                } else {
                    $case['rows'][$k]['attr'] = @json_decode($v['attr'], 1);
                }
                $case['rows'][$k]['event_name'] = "[" . $v['event_id'] . "]" . $v['event_name'];
            }
        }
        return $case;
    }

    static function handleSchedule()
    {
        $request = Func_Input::filter(array(
            'product_id' => 'int',
            'set_id' => 'int',
        ));
        if (empty($request['product_id'])) {
            Func_Header::back('缺少参数！');
        }
        $data = Data_Mysql_Table_Product_Schedule::select('*', array('status > ? ' => 0, 'product_id =?' => $request['product_id']), '', 999);
        if (empty($_SESSION['user']['id'])) {
            Func_Header::back('请先登录！');
        }

        if (!empty($request['set_id'])) {
            $cols = "{table}.vendor_name,{table}.vendor_account_id,{prefix}product_info.id,{prefix}product_info.vendor_id,{prefix}product_info.product_name";
            $table = "{table} LEFT JOIN {prefix}product_info ON {table}.id = {prefix}product_info.vendor_id";
            $Info = Data_Mysql_Table_Vendor_Info::subTable('_update')->select($cols, array(
                '{prefix}product_info.id =? ' => $request['product_id']
            ), '', 1, $table);
        } else {
            $cols = "{table}.vendor_name,{prefix}product_info.id,{prefix}product_info.vendor_id,{prefix}product_info.product_name";
            $table = "{table} LEFT JOIN {prefix}product_info ON {table}.id = {prefix}product_info.vendor_id";
            $Info = Data_Mysql_Table_Vendor_Info::subTable('_update')->select($cols, array(
                '{table}.vendor_account_id =?' => $_SESSION['user']['id'],
                '{prefix}product_info.id =? ' => $request['product_id']
            ), '', 1, $table);
        }


        if (empty($Info[0]['id'])) {
            Func_Header::back('产品信息不存在！');
        }
        foreach ($data as $k => &$v) {
            if ($v['status'] == '1' && empty($v['color'])) {
                $v['color'] = "#3A87AD";
            }
            if ($v['status'] == '2' && empty($v['color'])) {
                $v['color'] = "#c6072b";
            }
        }
        Tpl_Smarty::assign('Info', $Info[0]);
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::assign('sta', Data_Mysql_Table_Product_Schedule::$status);
        Tpl_Smarty::assign('order', Data_Mysql_Table_Order_Info::$order_status_tpl);
        Tpl_Smarty::display('product_schedule.tpl');
    }

    static function handelAddScheduleSubmit()
    {
        $request = Func_Input::filter(array(
            'start_time' => 'string',
            'end_time' => 'string',
            'product_id' => 'int',
            'des' => 'string',
            'status' => 'int',
            'color' => "string"
        ));
        if (empty($request['product_id']) || empty($request['start_time']) || empty($request['end_time'])) {
            Func_Header::back('缺少参数！');
        }
        $data = array(
            'start_time' => strtotime($request['start_time']),
            'end_time' => strtotime($request['end_time']),
            'des' => $request['des'],
            'product_id' => $request['product_id'],
            'vendor_account_id' => $_SESSION['user']['id'],
            'status' => 1,
            'color' => $request['color']
        );
        if ($data['end_time'] < $data['start_time']) {
            Func_Header::back('请正确的选择起止时间！');
        }
//       $isCheck =  Data_Mysql_Table_Product_Info::select('id',array('id =?'=>$request['product_id'],'vendor_id =?'=>$_SESSION['user']['vendor_id']));
//        if(empty($isCheck[0])){
//            Func_Header::back('您要添加档期的产品信息不存在！');
//        }
        $rs = Data_Mysql_Table_Product_Schedule::insert($data);
        if (!empty($rs[0])) {
            Func_Header::to('添加档期成功！', Core::$urls['root'] . Core::$urls['package'] . Core::$urls['route'] . 'product/space');
        }
        Func_Header::back('添加失败！请稍后再试！');

    }

    /*
     *活动案例状态更改
     */
    static function handleCaseOnline()
    {
        Core::output('');
        if (isset($_REQUEST['case_online'])) {
            $request = Func_Input::filter(array(
                'case_online' => 'int',
                'case_id' => 'int',
            ));
            if (!$request['case_id']) {
                die('fail');
            }
            //更新在线状态
            $r = Data_Mysql_Table_Event_Case::query("UPDATE {table} SET status = ? WHERE id = ?", array(
                $request['case_online'] ? 1 : 0,
                $request['case_id']
            ), 1);
            $r_update = Data_Mysql_Table_Event_Case::query("UPDATE {table}_update SET status = ? WHERE id = ?", array(
                $request['case_online'] ? 1 : 0,
                $request['case_id']
            ), 1);
            if (empty($r[0]) || empty($r_update)) {
                echo 'fail';
            } else {
                echo 'success';
            }
            die;
        }
    }

    /*
     * 【删除档期】
     */
    static function handledelauction()
    {
        if (isset($_REQUEST['id'])) {
            $request = Func_Input::filter(array(
                'id' => 'int',
                'status' => 'int',
            ));
            if (!$request['id']) {
                die('fail');
            }

            $conditions['id'] = $request['id'];
            $table = "{table}";
            $data['status'] = '-1';
            $rs = Data_Mysql_Table_Product_Schedule::update($conditions, $data, '', $table);
            if ($rs) {
                echo 'success';
            } else {
                echo 'fail';
            }
        }
    }
}