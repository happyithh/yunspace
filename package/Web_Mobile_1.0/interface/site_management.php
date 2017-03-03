<?php
/**
 * Created by PhpStorm.
 * User: bll
 * Date: 15/11/25
 * Time: 下午1:25
 */
@session_start();
Core::$urls['action'] = explode('/',Core::$urls['action']);
switch (Core::$urls['action'][0]) {
    case  "":
        //APP请求
        if (!empty($_REQUEST['token']) && !empty($_REQUEST['user_id'])) {
            Api_Session::user_info();
            $_SESSION['token'] = $_REQUEST['token'];
            Tpl_Smarty::assign('token',$_SESSION['token']);
            Tpl_Smarty::assign('user_id',$_SESSION['user']['id']);
        } elseif (empty($_SESSION['user']['id']) || empty($_SESSION['openid'])) {
//            $_SESSION['openid'] = 'okykjuMi5PHL4H9mT7uh4M8FBOwQ';
            $_SESSION['url_back'] = 'http://' . Core::$urls['host'].Core::$urls['path'];
            Wechat_Oauth_Manager::handle();
            if(empty($_SESSION['openid'])) {
                Func_Header::back('请在微信客户端打开链接');
            }
        }
        //$_SESSION['openid'] = 'okykjuCyTWO2iCB6OmuJTQvs7YKA';
//        $_SESSION['url_back'] = 'http://' . Core::$urls['host'].Core::$urls['path'];
//        if(empty($_SESSION['user']['id']) || empty($_SESSION['openid'])) {
//            Wechat_Oauth_Manager::handle();
//        }
//        if(empty($_SESSION['openid'])) {
//            Func_Header::back('请在微信客户端打开链接');
//        }
        /**
         * 检测session中的phone下是否有子空间;
         *微信授权不管是什么手机都会将phone放入session中，但是这个phone下可能没有子空间，登录后会出现underfined;
         */
        $conditions['phone = ?'] = $_SESSION['user']['phone'];
        $rs_a = Data_Mysql_Table_Space_Item::select('id',$conditions);
        $rs_b = Data_Mysql_Table_Space_Assign::select('id',$conditions);
        if(empty($rs_a) && empty($rs_b)) {
            if(!empty($_SESSION['token'])) {
                $url_to = Core::$urls['root'] .''. Core::$urls['package']. rtrim(Core::$urls['route'],'/').'/changdi_rent'.'?token='.$_SESSION['token'].'&user_id='.$_SESSION['user']['id'];
            } else {
                $url_to = Core::$urls['root'] .''. Core::$urls['package']. rtrim(Core::$urls['route'],'/').'/changdi_rent';
            }
            Func_Header::to('该手机号还没有注册为场地管家，可以点击“我有空间场地要出租”申请注册',$url_to);
        }

        $rs_name = Api_Demand_Product_Name::handle(array('phone' => $_SESSION['user']['phone']));
        $item_info = $item_ids = $yixiang = $yuding = array();
        if (!empty($rs_name['data'])) {
            foreach ($rs_name['data'] as $k => $v) {
                $item_info[$v['id']] = $v['item_name'];
            }
            foreach ($item_info as $k => $v) {
                $item_ids[] = $k;
            }
            $item_info = array_unique($item_info);
            $rs_list = Api_Demand_Product_List::handle(array('item_id' => $item_ids[0]));
            foreach ($rs_list['data']['data'] as $k => $v) {
                if ($v['status'] == 1) {
                    $yixiang[] = $rs_list['data']['data'][$k];
                } elseif (!empty($v['status']) && $v['status'] !== 1) {
                    $yuding[] = $rs_list['data']['data'][$k];
                }
            }
            $item_name = reset($item_info);
            Tpl_Smarty::assign('item_name', $item_name);
            foreach ($item_info as $k => $v) {
                if ($v == $item_name) {
                    $item_id = $k;
                    Tpl_Smarty::assign('item_id', $item_id);
                }
            }
            Tpl_Smarty::assign('action',trim(Core::$urls['route'],'/'));
            Tpl_Smarty::assign('item_info', array_unique($item_info));
            Tpl_Smarty::assign('_data', $rs_list['data']);
            Tpl_Smarty::assign('yixiang', $yixiang);
            Tpl_Smarty::assign('yuding', $yuding);
        }
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_management.tpl');
        break;
    case is_numeric(Core::$urls['action'][0]):
        if (empty($_SESSION['user'])) {
            Func_Header::to('','http://' . Core::$urls['host'] .'/'. Core::$urls['package']. trim(Core::$urls['route'],'/'));
        }
        $rs_name = Api_Demand_Product_Name::handle(array('phone' => $_SESSION['user']['phone']));
        $item_info = $yixiang = $yuding = array();
        if (!empty($rs_name['data'])) {
            foreach ($rs_name['data'] as $k => $v) {
                $item_info[$v['id']] = $v['item_name'];
            }
            $rs_list = Api_Demand_Product_List::handle(array('item_id' => intval(Core::$urls['action'][0])));
            foreach ($rs_list['data']['data'] as $k => $v) {
                if ($v['status'] == 1) {
                    $yixiang[] = $rs_list['data']['data'][$k];
                } elseif (!empty($v['status']) && $v['status'] !== 1) {
                    $yuding[] = $rs_list['data']['data'][$k];
                }
            }
            foreach ($item_info as $k => $v) {
                if (Core::$urls['action'][0] == $k) {
                    $item_name = $v;
                    Tpl_Smarty::assign('item_name', $item_name);
                }
            }
            Tpl_Smarty::assign('action',trim(Core::$urls['route'],'/'));
            @Tpl_Smarty::assign('token',$_SESSION['token']);
            Tpl_Smarty::assign('user_id',$_SESSION['user']['id']);
            Tpl_Smarty::assign('item_id', Core::$urls['action'][0]);
            Tpl_Smarty::assign('item_info', array_unique($item_info));
            Tpl_Smarty::assign('_data', $rs_list['data']);
            Tpl_Smarty::assign('yixiang', $yixiang);
            Tpl_Smarty::assign('yuding', $yuding);
        }
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_management.tpl');
        break;
    case "schedule":
        if (empty($_SESSION['user'])) {
            header("Location:http://" . Core::$urls['host'] .'/'. Core::$urls['package']. trim(Core::$urls['route'],'/'));
        }
        $rs_name = Api_Demand_Product_Name::handle(array('phone' => $_SESSION['user']['phone']));
        $item_info = $item_ids = $yixiang = $yuding = array();
        if (!empty($rs_name['data'])) {
            foreach ($rs_name['data'] as $k => $v) {
                $item_info[$v['id']] = $v['item_name'];
            }

            foreach ($item_info as $k => $v) {
                $item_ids[] = $k;
            }
            foreach ($item_info as $k => $v) {
                if(empty(Core::$urls['action'][1])) {
                    Core::$urls['action'][1] =$item_ids[0];
                }
                if (Core::$urls['action'][1] == $k) {
                    $item_name = $v;
                    Tpl_Smarty::assign('item_name', $item_name);
                }
            }
            Tpl_Smarty::assign('action',trim(Core::$urls['route'],'/'));
            @Tpl_Smarty::assign('token',$_SESSION['token']);
            Tpl_Smarty::assign('user_id',$_SESSION['user']['id']);
            Tpl_Smarty::assign('item_id', Core::$urls['action'][1]);
            $rs_list = Api_Demand_Product_List_Byid::handle(array('item_id' => Core::$urls['action'][1]));
            Tpl_Smarty::assign('_data', $rs_list['data']);
            Tpl_Smarty::assign('item_info', array_unique($item_info));
        }
        Tpl_Smarty::assign('status',Data_Mysql_Table_Product_Demand::$status);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/schedule.tpl');
        break;
    case "schedule_info":
        if (empty($_SESSION['user'])) {
            header("Location:http://" . Core::$urls['host'] .'/'. Core::$urls['package']. trim(Core::$urls['route'],'/'));
        }
        if (!empty(Core::$urls['action'][1])) {
            $demand_product_id = Core::$urls['action'][1];
            $rs = Api_Demand_Product_Detail::handle(array('id'=>$demand_product_id));
//            q($rs);
            @Tpl_Smarty::assign('_data',$rs['data'][0]);
        }
        if(!empty($_REQUEST['action']) && $_REQUEST['action'] == 'edit') {
            Tpl_Smarty::assign('action',$_REQUEST['action']);
        }
        $rs_name = Api_Demand_Product_Name::handle(array('phone' => $_SESSION['user']['phone']));
        $item_info = array();
        if (!empty($rs_name['data'])) {
            foreach ($rs_name['data'] as $k => $v) {
                $item_info[$v['id']] = $v['item_name'];
            }
        }
        Tpl_Smarty::assign('item_info',array_unique($item_info));
        Tpl_Smarty::assign('status',Data_Mysql_Table_Product_Demand::$status);
        Tpl_Smarty::assign('from_where',Data_Mysql_Table_Product_Demand::$from_where);
        Tpl_Smarty::assign('activity_type',Data_Mysql_Table_Product_Demand::$activity_type);
        Tpl_Smarty::assign('company_type',Data_Mysql_Table_Product_Demand::$company_type);
        Tpl_Smarty::assign('per_price',Data_Mysql_Table_Product_Demand::$per_price);
        Tpl_Smarty::assign('per_other_price',Data_Mysql_Table_Product_Demand::$per_other_price);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/schedule_info.tpl');
        break;
    case "schedule_create":
        if (empty($_SESSION['user'])) {
            header("Location:http://" . Core::$urls['host'] .'/'. Core::$urls['package']. trim(Core::$urls['route'],'/'));
        }
        $rs_name = Api_Demand_Product_Name::handle(array('phone' => $_SESSION['user']['phone']));
        $item_info = array();
        if (!empty($rs_name['data'])) {
            foreach ($rs_name['data'] as $k => $v) {
                $item_info[$v['id']] = $v['item_name'];
            }
        }
//        q(Data_Mysql_Table_Product_Demand::$from_where);
        Tpl_Smarty::assign('item_info',array_unique($item_info));
        Tpl_Smarty::assign('status',Data_Mysql_Table_Product_Demand::$status);
        Tpl_Smarty::assign('from_where',Data_Mysql_Table_Product_Demand::$from_where);
        Tpl_Smarty::assign('activity_type',Data_Mysql_Table_Product_Demand::$activity_type);
        Tpl_Smarty::assign('company_type',Data_Mysql_Table_Product_Demand::$company_type);
        Tpl_Smarty::assign('per_price',Data_Mysql_Table_Product_Demand::$per_price);
        Tpl_Smarty::assign('per_other_price',Data_Mysql_Table_Product_Demand::$per_other_price);
        Tpl_Smarty::display('Web_Mobile_Static::site_management/schedule_info_create.tpl');
        break;
    case "changdi_rent":
//        if (!empty($_SESSION['space_user'])) {
//            header("Location:http://" . Core::$urls['host'] .'/'. Core::$urls['package']. rtrim(Core::$urls['route'],'/'));
//        }
        Tpl_Smarty::display('Web_Mobile_Static::site_management/changdi_rent.tpl');
        break;
}
