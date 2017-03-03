<?php

/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/8/4
 * Time: 13:41
 */

class OA_Vendor_Candidate
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? "vendor_candidate_list" : $_REQUEST['action'];
        if ($action == 'vendor_candidate_list') {
            if (!empty($_REQUEST['del']) && $_REQUEST['del'] == 1) {
                self::ajaxDelVendorCandidate();
            } else {
                self::handleVendorCandidateList();
            }
        } elseif ($action == 'check') {
            if (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'repeat') {
                self::handleVendorCandidateRepeat();
            } elseif (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'less') {
                self::handleVendorCandidateLess();
            } elseif (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'invalid') {
                self::handleVendorCandidateInvalid();
            } elseif (!empty($_REQUEST['vendor_auto_complete'])) {
                self::handleVendorAutoComplete();
            } else {
                self:: handleCheck();
            }
        } elseif ($action == 'detail') {
            self::handleVendorCandidateDetail();
        } elseif ($action == 'is_submit') {
            self::handleIsSubmit();
        } elseif ($action == 'quickCreate') {
            self::createProductByVendorId();
        } elseif ($action == 'product_detail') {
            self::handleProductDetail();
        } elseif ($action == 'vendor_detail') {
            self::handleVendorDetail();
        }
    }

    //供应商产品候选数据列表
    static function handleVendorCandidateList()
    {
//        q($_SESSION);
        $conditions = array();
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'from_where' => 'string',
                'status' => 'int',
                'create_end_time' => 'string',
                'create_start_time' => 'string',
                'update_end_time' => 'string',
                'update_start_time' => 'string',
                'username' => 'string',
                'num' => 'int',
                'city' => 'string'
            ), $_REQUEST['search']);
//            q($search);

            //来源筛选
            if (!empty($search['from_where'])) {
                $conditions['from_where'] = $search['from_where'];
            }
            //操作人筛选
            if (!empty($search['username'])) {
                $conditions['username'] = $search['username'];
            }
            //搜索城市
            if (!empty($search['city'])) {
                $conditions['city'] = $search['city'];
                $conditions['product_name'] = $search['city'];
                $conditions['product_addr'] = $search['city'];
            }
//            q($conditions);
            //入库时间筛选
            if (!empty($search['create_start_time']) && !empty($search['create_end_time'])) {
                if (strtotime($search['create_start_time']) > strtotime($search['create_end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.create_time between ? and ?'] = array(strtotime($search['create_start_time']), strtotime($search['create_end_time']));
                }
            } elseif (!empty($search['create_start_time']) && empty($search['create_end_time'])) {
                $conditions['{table}.create_time > ?'] = strtotime($search['create_start_time']);
            } elseif (empty($search['create_start_time']) && !empty($search['create_end_time'])) {
                $conditions['{table}.create_time < ?'] = strtotime($search['create_end_time']);
            }
            //操作时间筛选
            if (!empty($search['update_start_time']) && !empty($search['update_end_time'])) {
                if (strtotime($search['update_start_time']) > strtotime($search['update_end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['{table}.update_time between ? and ?'] = array(strtotime($search['update_start_time']), strtotime($search['update_end_time']));
                }
            } elseif (!empty($search['update_start_time']) && empty($search['update_end_time'])) {
                $conditions['{table}.update_time > ?'] = strtotime($search['update_start_time']);
            } elseif (empty($search['update_start_time']) && !empty($search['update_end_time'])) {
                $conditions['{table}.update_time < ?'] = strtotime($search['update_end_time']);
            }
        }
        //tab标签筛选状态
        $handle_type = empty($_REQUEST['handle_type']) ? 'waiting' : $_REQUEST['handle_type'];
        switch ($handle_type) {
            case "pass":
                $conditions['{table}.status = ? '] = 1;
                break;
            case "repeat":
                $conditions['{table}.status = ? '] = 2;
                break;
            case "waiting":
                $conditions['{table}.status = ? '] = 3;
                break;
            case "invalid":
                $conditions['{table}.status = ? '] = 4;
                break;
            case "less":
                $conditions['{table}.status = ? '] = 5;
                break;
        }

        //数据分组
        if(!empty($_REQUEST['num'])) {
            if($_REQUEST['num'] == 20){
                $conditions['id%20 = ? '] = 0;
            }else{
                $conditions['id%20 = ? '] = $_REQUEST['num'];
            }
        }

        if (!empty($_REQUEST['search'])) {
            $search_url = '&search[create_start_time]='.$search['create_start_time'].'&search[create_end_time]='.$search['create_end_time'].'&search[update_start_time]='.$search['update_start_time'].'&search[update_end_time]='.$search['update_end_time'].'&search[username]='.$search['username'];
            Tpl_Smarty::assign('urls', $search_url);
        }

        $cols = array('id,product_name,vendor_name,username,create_time,update_time,status,from_where');
        $order = 'ORDER BY {table}.update_time DESC';
        $candidate = Data_Mysql_Table_Vendor_Candidate::page(0, 0, $cols, $conditions, $order, '{table}');

        if(!empty($_REQUEST['num'])) {
            Tpl_Smarty::assign('num', $_REQUEST['num']);
        }
        Tpl_Smarty::assign('handle_type', $handle_type);
        Tpl_Smarty::assign('_data', $candidate);
        Tpl_Smarty::display('OA_Static', 'vendor_candidate/vendor_candidate_list.tpl');
    }


    //审核处理该条数据（即改变此数据的状态）
    static function handleCheck()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！');
        }
        $data = Data_Mysql_Table_Vendor_Candidate::select('*', array('id' => $_REQUEST['id']), '', 1);
        $conditions_p = array();
        $conditions_v = array();
        if (!empty($data[0]['product_name'])) {
//            $conditions_p[] = "{table}.product_name like '%" . $data[0]['product_name'] . "%'";
            $conditions_p['product_name'] = $data[0]['product_name'];
            $rs_p = Data_Mysql_Table_Product_Info::subtable('_update')->select('{table}.id,{table}.product_name,{table}.create_time,{prefix}vendor_info_update.id as vendor_id,{prefix}vendor_info_update.vendor_name', $conditions_p, '', 5, '{table} LEFT JOIN {prefix}vendor_info_update ON {table}.vendor_id={prefix}vendor_info_update.id');
        }
        if (!empty($data[0]['vendor_name'])) {
//            $conditions_v[] = "{table}.vendor_name like '%" . $data[0]['vendor_name'] . "%'";
            $conditions_v['vendor_name'] = $data[0]['vendor_name'];
            $rs_v = Data_Mysql_Table_Vendor_Info::subtable('_update')->select('*', $conditions_v, '', 5, '{table}');
        }
        if (!empty($rs_p)) {
            Tpl_Smarty::assign('p_data', $rs_p);
        }
        if (!empty($rs_v)) {
            Tpl_Smarty::assign('v_data', $rs_v);
        }
        Tpl_Smarty::assign('_data', $data);

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
        Tpl_Smarty::assign('num', $_REQUEST['num']);
        Tpl_Smarty::display('OA_Static', 'vendor_candidate/vendor_candidate_check.tpl');
    }

    //详细信息展示页面
    static function handleVendorCandidateDetail()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！');
        }
        $data = Data_Mysql_Table_Vendor_Candidate::select('*', array('id' => $_REQUEST['id']), '', 1);
        $data[0]['product_media'] = json_decode($data[0]['product_media'], true);
        $data[0]['product_attr_new'] = json_decode($data[0]['product_attr_new'], true);
        $qian=array(" ","　","\t","\n","\r");
        $hou=array("",",","","","");
        $data[0]['product_attr_new'] = str_replace($qian,$hou,$data[0]['product_attr_new']);
        Tpl_Smarty::assign('_data', $data);

        self::handleVendorCandidatePass();
    }

    //提交数据
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
            Func_Header::back('联系人名称必须正确填写!');
        }
        if (empty($request_contacts['phone'])) {
            //preg_match_all('/^(0(10|21|22|23|[1-9][0-9]{2})(-|))?[0-9]{7,8}$/', $_REQUEST['data_c']['phone'], $tel);
            preg_match_all('/^((0\d{2,3}-\d{6,8}(-\d+)?)|(1[35847]\d{9}))$/', $_REQUEST['data_c']['phone'], $tel);
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
        if (empty($request_vendor['attr']["城市"])) {
            $request_vendor['attr']["城市"] = $request_contacts['city'];
        }
        if (empty($_REQUEST['data_p']['attr_new'][46])) {
            $_REQUEST['data_p']['attr_new'][46] = $request_vendor['attr']['城市'];
        }
        $request = Api_Product_Submit::handle($table="update",$_REQUEST,$type='check');
        if($request['status']==0) {
            Func_Header::back($request['msg']);
        }
        //创建账号和联系人
        $rs_contacts = OA_Quick_Create_Product::setContactsByData($request_contacts);
        //创建供应商
        $request_vendor['vendor_account_id'] = $rs_contacts;
        $request_vendor['create_by_quick'] = 3;
        $rs_vendor = OA_Quick_Create_Product::setVendorByData($request_vendor);
        //创建产品
        $_REQUEST['data_p']['vendor_id'] = $rs_vendor;
        $_REQUEST['data_p']['order_lv'] = '-1';
        $_REQUEST['data_p']['create_by_quick'] = 2;
//        $rs_product = OA_Quick_Create_Product::setProductByData($request_product);
        $rs_product = Api_Product_Submit::handle($table="update",$_REQUEST,$type='submit');
        if (!empty($rs_contacts) && !empty($rs_vendor) && !empty($rs_product)) {
            //将vendor_candidate表中对应的数据状态更改为已处理status=1
            Data_Mysql_Table_Vendor_Candidate::update(array('id' => $_REQUEST['id']), array('status' => '1','username' => $_SESSION['administrator']['username']));
        }
        Func_Header::to(' 正在审核中，您现在可以继续添加案例，showtime的机会哦！', Core::$urls['path'].'?num='.$_REQUEST['num']);
    }

    //接受并处理该条候选数据
    static function handleVendorCandidatePass()
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
        Tpl_Smarty::assign('num',$_REQUEST['num']);
        Tpl_Smarty::display('OA_Static', 'vendor_candidate/inc/quick_create_vendorcandidate.tpl');
    }


    //标记此数据为重复
    static function handleVendorCandidateRepeat()
    {
//        q(Core::$urls['path']);
        $request = Func_Input::filter(array(
            'id' => 'int',
            'num' => 'int',
        ));
        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        //更新数据的状态
        $condition = array('id' => $_REQUEST['id']);
        $data = array(
            'status' => 2,
            'username' =>$_SESSION['administrator']['username'],
            'update_time' =>time(),
        );
        $update_rs = Data_Mysql_Table_Vendor_Candidate::update($condition, $data);
        if (!empty($update_rs)) {
            Func_Header::to(' 标记成功！', Core::$urls['path'].'?num='.$request['num']);
        }
        Func_Header::back('标记失败，请重试！');
    }

    //标记此数据不完整
    static function handleVendorCandidateLess()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'num' => 'int',
        ));
        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        //更新数据的状态
        $condition = array('id' => $_REQUEST['id']);
        $data = array(
            'status' => 5,
            'username' =>$_SESSION['administrator']['username'],
            'update_time' =>time(),
        );
        $update_rs = Data_Mysql_Table_Vendor_Candidate::update($condition, $data);
        if (!empty($update_rs)) {
            Func_Header::to(' 标记成功！', Core::$urls['path'].'?num='.$request['num']);
        }
        Func_Header::back('标记失败，请重试！');
    }

    //标记此数据为无效
    static function handleVendorCandidateInvalid()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'num' => 'int',
        ));
        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        //更新数据的状态
        $condition = array('id' => $_REQUEST['id']);
        $data = array(
            'status' => 4,
            'username' =>$_SESSION['administrator']['username'],
            'update_time' =>time(),
        );
        $update_rs = Data_Mysql_Table_Vendor_Candidate::update($condition, $data);
        if (!empty($update_rs)) {
            Func_Header::to(' 标记成功！', Core::$urls['path'].'?num='.$request['num']);
        }
        Func_Header::back('标记失败，请重试！');
    }

    //ajax删除一一条数据
    static function ajaxDelVendorCandidate()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int'
        ));
        if (empty($request['id'])) {
            Func_Output::json('error', '', '缺少参数！');
        }
        $conditions['id'] = $request['id'];

        $rs = Data_Mysql_Table_Vendor_Candidate::delete($conditions, '{table}');
        if ($rs[0] > 0) {
            Func_Output::json('success', '', ' 删除成功');
        }
        Func_Output::json('error', '', '删除失败');
    }


    //为已有供应商快速创建产品
    static function createProductByVendorId()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'category_id' => 'int',
            'vendor_id' => 'int',
            'id' => 'int',
        ));
        if (empty($request['category_id']) || empty($request['vendor_id'])) {
            Func_Output::json('error', '', '参数错误！！');
        }
        $data = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id,vendor_name,vendor_account_id,categories_id', $request['vendor_id']);
        if (empty($data[0])) {
            Func_Output::json('error', '', '供应商不存在！！');
        } elseif (empty($data[0]['vendor_account_id'])) {
            Func_Output::json('error', '', '请先绑定该供应商的账户!');
        }
        //根据id查出vendor_candidate表中此id的数据
        $product_data = Data_Mysql_Table_Vendor_Candidate::select('*', $request['id']);

        //将vendor_candidate表中查到的关于product_info的产品数据插入到product_info_update表中
        $p_data = array(
            'vendor_id' => $request['vendor_id'],
            'category_id' => $request['category_id'],
            'admin_id' => $_SESSION['administrator']['id'],
            'status' => 2,

            //和产品相关的数据
            'product_name' => empty($product_data[0]['product_name']) ? '' : $product_data[0]['product_name'],
            'addr' => empty($product_data[0]['product_addr']) ? '' : $product_data[0]['product_addr'],
            'price' => empty($product_data[0]['product_price']) ? '' : $product_data[0]['product_price'],
            'product_size' => empty($product_data[0]['product_size']) ? '' : $product_data[0]['product_size'],
            'des' => empty($product_data[0]['product_des']) ? '' : $product_data[0]['product_des'],
            'attr_new' => empty($product_data[0]['product_attr_new']) ? '' : $product_data[0]['product_attr_new'],
            'media' => empty($product_data[0]['product_media']) ? '' : $product_data[0]['product_media'],
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
            Data_Mysql_Table_Vendor_Candidate::update(array('id' => $request['id']), array('status' => '1','username' =>$_SESSION['administrator']['username']));
            $return = array('account_id' => $data[0]['vendor_account_id'], 'product_id' => $rs_p[0]);
            Func_Output::json('success', $return, '创建产品成功！！');
        }
    }


    //供应商自动查询
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


    static function handleProductDetail()
    {

        if (empty($_REQUEST['product_id'])) {
            Func_Header::back('参数错误！');
        }
        $category = Data_Mysql_Table_Product_Category::getInfoCache();
        $data = Data_Mysql_Table_Product_Info::subTable('_update')->select('*', array('id' => $_REQUEST['product_id']), 'ORDER BY update_time DESC');
        if (empty($data)) {
            $data = Data_Mysql_Table_Product_Info::select('*', array('id' => $_REQUEST['product_id']));
        }
        if (!empty($data)) {
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
        }
//        q($data[0]);
        Tpl_Smarty::assign('_tags_info', Data_Mysql_Table_Product_Category::getTagsInfo($data[0]['category_id']));
        Tpl_Smarty::assign('_category', $category);
        Tpl_Smarty::assign('_data', $data[0]);

        Tpl_Smarty::display('OA_Static', 'vendor_candidate/product_detail.tpl');
    }


    static function handleVendorDetail()
    {

        if (!empty($_REQUEST['vendor_id'])) {
            $data = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('*', array('id' => $_REQUEST['vendor_id']));
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
                if (!empty($data[0]['categories_id'])) {
                    $data[0]['categories_id'] = explode(',', $data[0]['categories_id']);
                }
            }
//            q($data);

            Tpl_Smarty::assign('_data', $data[0]);

            //获取供应商下已完成的订单信息
            $complete_order = 0;
            $orderInfo = Data_Mysql_Table_Order_Info::page(0, 0, '{prefix}account.username,{table}.order_no,{table}.order_complete,{table}.product_id,{table}.vendor_id', array('vendor_id' => $_REQUEST['vendor_id']), 'ORDER BY {table}.update_time desc', '{table} LEFT JOIN {prefix}account ON {table}.buyer_account_id = {prefix}account.id');
            if (!empty($orderInfo['rows'])) {
                foreach ($orderInfo['rows'] as $key => $value) {
                    $orderInfo['rows'][$key]['order_complete'] = json_decode($value['order_complete'], 1);
                }
                $total_order = $orderInfo['page']['dt'];//总订单量
                Tpl_Smarty::assign('total_order', $total_order);
                $complete = Data_Mysql_Table_Order_Info::select('count(*) as c', array('vendor_id' => $_REQUEST['vendor_id'], 'order_status' => 90));
                $complete_order = 0;
                if (!empty($complete)) {
                    $complete_order = $complete[0]['c'];//已完成订单量
                }
            }
            Tpl_Smarty::assign('_vendor_attr', Data_Config_Vendor_Attr::all());
            Tpl_Smarty::assign('_categories', Data_Mysql_Table_Product_Category::getTreeCache());
            Tpl_Smarty::assign('complete_order', $complete_order);
            Tpl_Smarty::assign('orderInfo', $orderInfo);
            Tpl_Smarty::display('OA_Static', 'vendor_candidate/vendor_detail.tpl');
        }
    }
}