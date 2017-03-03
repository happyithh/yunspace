<?php

class App_Api_Broker_Main extends Base
{
    static $access_code = 'yunspace123';

    static function handle()
    {

        switch (Core::$urls['action']) {
            case 'login':
                self::login();
                break;
            case 'login_with_token':
                self::loginWithToken();
                break;
            case 'user_info':
                self::userInfo();
                break;
            case 'user_order_list':
                App_Api_Broker_Order::getUserOrderList();
                break;
            case 'activity_list':
                App_Api_Broker_Event::getEventList();
                break;
            case 'event_info':
                App_Api_Broker_Event::getEventInfoById();
                break;
            case 'event_dressing':
                App_Api_Broker_Event::getEventDressing();
                break;
            case 'order_dressing':
                App_Api_Broker_Order::getOrderDressing();
                break;
            case 'order_info':
                App_Api_Broker_Order::getOrderInfoById();
                break;
            case 'load_more_order_list':
                App_Api_Broker_Order::getLoadMoreOrderList();
                break;
            case 'load_more_event_list':
                App_Api_Broker_Event::getEventList();
                break;
            case 'load_more_event_dress_list':
                App_Api_Broker_Event::loadMoreEventDressList();
                break;
            case 'load_more_order_dress_list':
                App_Api_Broker_Order::loadMoreOrderDressList();
                break;
            case 'get_user_admin_money':
                App_Api_Broker_Account::getUserAdminMoney();
                break;
            case 'get_account_detail_load_more':
                App_Api_Broker_Account::getAccountDetailLoadMore();
                break;
            case 'get_service_list':
                self::get_service_list();
                break;
            case 'get_service_info':
                self::get_service_info();
                break;
            case 'register_send_sms':
                self::registerSendSms();
                break;
            case 'check_phone_code':
                self::checkPhoneCode();
                break;
            case 'register_submit':
                self::registerSubmit();
                break;
            case 'brokerHandleOrder':
                self::brokerHandleOrder();
                break;
            case 'getService':
                App_Api_Broker_Service::getService();
                break;
            case 'getServiceInfo':
                App_Api_Broker_Service::getServiceInfo();
                break;
        }
    }

    static function login()
    {
        $data = array();                           //返回数据
        $request = Func_Input::filter(array(
            'username' => 'string',
            'password' => 'string',
            'device_platform' => '50',
            'device_uuid' => 'string',
            'device_version' => '20',
            'device_model' => 'string',
            'app_version' => 'float',
            'jpush_register_id' => 'string'
        ), $_REQUEST);
        $makePassword = Data_Mysql_Table_Account::makePassword($request['password']);
        $conditions = array(
            'username =? OR phone =? ' => array($request['username'], $request['username'])
        );

        $rs = Data_Mysql_Table_Account::select('id,password,avatar,fullname,username,phone', $conditions);
        if (!empty($rs[0]) && $rs[0]['password'] == $makePassword) {

            $time = time();
            $token = md5($time . $rs[0]['id'] . $makePassword);//时间-用户ID-数据库密码 生成token
            $access_token = md5($time . $rs[0]['id'] . self::$access_code);//用户id-access_code生成access_token
            $data = array(
                'token' => $token,
                'access_token' => $access_token,
                'status' => 'success',
                'user_id' => $rs[0]['id'],
                'login_time' => $time,
                'fullname' => $rs[0]['fullname'],
                'username' => $rs[0]['username'],
                'avatar' => 'http://' . Core::$urls['host'] . Core::$urls['root'] . 'user_center/avatar/' . $rs[0]['id'] . '.jpg'
            );
            $insertLoginData = array(
                'username' => $request['username'],
                'fullname' => $rs[0]['fullname'],
                'user_id' => $rs[0]['id'],
                'token' => $token,
                'device_platform' => $request['device_platform'],
                'device_uuid' => $request['device_uuid'],
                'device_version' => $request['device_version'],
                'device_model' => $request['device_model'],
                'app_version' => $request['app_version'],
                'login_time' => $time,
                'jpush_register_id' => $request['jpush_register_id'],
            );
//            $codition = array(
//                'user_id'=>$rs[0]['id']
//            );
            $doInsert = Data_Mysql_Table_App_Login::update('', $insertLoginData);

        } else {
            $data['status'] = 'failure';
        }
        $result = json_encode($data);
        echo $result;
    }

    static function checkAccessToken()
    {
        $access_token = isset($_REQUEST['access_token']) ? $_REQUEST['access_token'] : '';
        $login_time = isset($_REQUEST['login_time']) ? $_REQUEST['login_time'] : '';
        $make_token = md5($login_time . $_REQUEST['user_id'] . self::$access_code);
        if ($access_token != $make_token) {
            $array = array(
                'msg' => '没有权限访问',
                'status' => -10
            );

            Func_Output::json('error', $array, '没有权限访问');
            die();
        }
    }

    static function loginWithToken()
    {
        $effective_time = 15 * 24 * 60 * 60;//token有效期15天
        $data = array();
        $request = Func_Input::filter(array(
            'user_id' => 'int',
            'token' => 'string',
            'login_time' => 'string'
        ), $_REQUEST);
//        $rs =  Data_Mysql_Table_Account::select('password,fullname,username',array('id'=>$request['user_id']));
//       if($rs){
//           $token = md5($request['login_time'].$request['user_id'].$rs[0]['password']);
////           $access_token = md5($request['user_id'].self::$access_code);
//           if($request['token'] == $token ){
//               $data = array(
//                   'fullname'=>$rs[0]['fullname'],
//                   'username'=>$rs[0]['username'],
//                   'avatar'=>'http://'.Core::$urls['host'].Core::$urls['root'].'user_center/avatar/'.$request['user_id'].'.jpg'
//               );
//               $data['code'] = 1;//token登录成功
//            }else{
//               $data['code'] = 2;//token登录失败
//           }
//       }else{
//           $data['code'] = 3;//数据库获取密码失败
//       }
        $rs = Data_Mysql_Table_App_Login::select('token,login_time,fullname,username', array('user_id' => $request['user_id']));
        $finish_time = $effective_time + $rs[0]['login_time'];
        if (time() <= $finish_time) {
            if ($rs[0]['token'] == $request['token']) {
                $data = array(
                    'status' => 1,//token登录成功
                    'info' => 'token登陆成功',
                    'fullname' => $rs[0]['fullname'],
                    'username' => $rs[0]['username'],
                    'avatar' => 'http://' . Core::$urls['host'] . Core::$urls['root'] . 'user_center/avatar/' . $request['user_id'] . '.jpg'
                );
            } else {
                $data = array(
                    'status' => -2,//token不正确
                    'info' => 'token不正确'
                );
            }
        } else {
            $data = array(
                'status' => -1,//token超期失效
                'info' => 'token超期失效'
            );
        }

        $result = json_encode($data);
        echo $result;
    }

    static function userInfo()
    {
        $user_id = $_REQUEST['user_id'];
        $account = Finance_Account::getAccountInfo($user_id);

        $conditions = array(
            'vendor_account_id' => $user_id,
        );

        $orders = Data_Mysql_Table_Order_Info::select('id, vendor_id,product_id, vendor_id, order_title,order_price, order_price_last, order_status', $conditions, 'order by id desc', 20);
        $orders = Web_User_Center_Order::handleOrderList($orders);
        $i = 0;
        $j = 0;
        $k = 0;
        $m = 0;
        foreach ($orders as $v) {
            if ($v['order_status_text'] == '待审核') {
                $i++;
            }
            if ($v['order_status_text'] == '待签约') {
                $j++;
            }
            if ($v['order_status_text'] == '待支付') {
                $k++;
            }
            if ($v['order_status_text'] == '待结算') {
                $m++;
            }
        }

        $data = array(
            'balance' => $account['balance'],
            'orders' => array(
                '待审核' => $i,
                '待签约' => $j,
                '待支付' => $k,
                '待结算' => $m
            )
        );

        $result = json_encode($data);
        echo $result;
    }

    //加载更多活动
    static function load_more_event_list()
    {
//		 $user_id = $_REQUEST['user_id'];
        $last_id = $_REQUEST['last_id'];
        $condition = array(
            'id > ?' => $last_id
        );
        $activity = Data_Mysql_Table_Event_Info::select('event_name,event_time,attr,status', $condition, '', 10);
        foreach ($activity as $k => &$v) {
            switch ($v['status']) {
                case "0":
                    $v['status'] = "待审核";
                    break;
                case "1":
                    $v['status'] = "进行中";
                    break;
                case "98":
                    $v['status'] = "停用";
                    break;
                case "99":
                    $v['status'] = "已取消";
                    break;
            }

            $v['attr'] = json_decode($v['attr'], true);
            $v['event_time'] = date('Y-m-d H:i:s', $v['event_time']);
        }
        echo json_encode($activity);
        die();
    }

    static function get_service_list()
    {
        $condition = array(
            'vendor_id' => $_REQUEST['user_id'],
            'status' => 1
        );
        $selectData = array(
            'id', 'product_name', 'addr', 'category_id', 'media', 'des', 'logo'
        );

        if (isset($_REQUEST['last_id'])) {
            $condition['id<?'] = $_REQUEST['last_id'];
        }

        $data = Data_Mysql_Table_Product_Info::select($selectData, $condition, 'ORDER BY id DESC', 15);

        foreach ($data as $k => $v) {
            $data[$k]['media'] = json_decode($data[$k]['media'], true);
            $v['media'] = json_decode($v['media'], 1);
            $data[$k]['des'] = strip_tags($data[$k]['des']);
            if (!empty($v['logo'])) {
                $data[$k]['logo'] = 'http://' . Core::$urls['host'] . Data_Config_Site::displayMedia($v['logo'], 264);
            } else {
                if (isset($v['media'][0])) {
                    $data[$k]['logo'] = 'http://' . Core::$urls['host'] . Data_Config_Site::displayMedia($v['media'][0]['path'], 264);
                }
            }

        }
        $result = json_encode($data);
        echo $result;
    }

    static function get_service_info()
    {
        $service_id = $_REQUEST['service_id'];
        $selectData = array(
            'attr', 'media', 'vendor_id', 'des', 'memo', 'price', 'addr', 'product_name'
        );
        $data = Data_Mysql_Table_Product_Info::select($selectData, array('id' => $service_id));
        $data2 = Data_Mysql_Table_Product_Marketing::select('*', array('id' => $service_id));
        $data[0]['media'] = json_decode($data[0]['media'], true);
        if (!empty($data[0]['media'])) {
            foreach ($data[0]['media'] as $k => $v) {
                $data[0]['media'][$k]['path'] = 'http://' . Core::$urls['host'] . Data_Config_Site::displayMedia($v['path'], 768, '', 1);
            }
        }
        $data[0]['attr'] = json_decode($data[0]['attr'], true);
        $data[0]['marketing'] = '';
        if (isset($data2[0])) {
            $data[0]['marketing'] = $data2[0];
        }
        foreach ($data[0]['attr'] as $k => $v) {
            $newKey = str_replace('基本信息>', '', $k);
            $data[0]['attr'][$newKey] = $v;
            unset($data[0]['attr'][$k]);
        }
        $result = json_encode($data);
        echo $result;
    }
    //注册--发送验证码
    // 参数  手机号
    static function registerSendSms()
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
        ));
        if (!$request['phone']) {
            Func_Return::jsonReturn('', '请输入正确的手机号！！', -1002);
        }
        $table = "{table}  as t1 LEFT JOIN {prefix}account_wechat as t2 ON t1.id = t2.account_id";
        $rs = Data_Mysql_Table_Account::select('t1.id,t1.phone,t1.username,t2.openid', array('t1.phone =?' => $request['phone']), '', 1, $table);
//        if (!empty($rs[0]) && ($rs[0]['username'] != $rs[0]['phone'])) {
//            Func_Return::jsonReturn('', '该手机号已被注册', -2001);
//        }

        if (!empty($rs[0]['id']) && (empty($rs[0]['openid']) || $rs[0]['username'] != $rs[0]['phone'])) {
            Func_Return::jsonReturn('', ($rs[0]['phone'] == $request['phone'] ? '手机号码 ' : '用户名') . '已被注册,如有问题请致电400-056-0599', -2001);
        }
        $code = rand(100000, 999999);
        $token = md5($code . $request['phone']);
        //'手机号码验证',
        $sta = Func_Message::sendSMS($request['phone'], array(
            $code,
            6
        ), 13838);
        $backData = array(
            'token' => $token,
            'code' => $code
        );
        Func_Return::jsonReturn($backData, '发送成功！', 1);

    }

    static function checkPhoneCode()
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'token' => 'string',
            'code' => 'int'
        ));

        $token = md5($request['code'] . $request['phone']);
        $data = '';
        if ($token == $request['token']) {
            $data = array(
                'status' => 1,
                'des' => '验证成功'
            );
        } else {
            $data = array(
                'status' => -1001,
                'des' => '验证失败'
            );
        }
        $result = json_encode($data);
        echo $result;
    }

    //注册--提交用户信息
    //参数    手机号，用户名，密码。
    static function  registerSubmit()
    {
        $_REQUEST['username'] = trim($_REQUEST['username']);
        $_REQUEST['phone'] = trim($_REQUEST['phone']);
        $request = Func_Input::filter(array(
            'username' => 'string',
            'phone' => 'phone',
        ));
        if (strlen($_REQUEST['username']) > 50) {
            Func_Return::jsonReturn('', '用户名不能太长！', 0);
        }
        if (strlen($_REQUEST['username']) < 3) {
            Func_Return::jsonReturn('', '用户名不能太短！', 0);
        }
        if (empty($_REQUEST['password']) || empty($_REQUEST['rpassword']) || $_REQUEST['password'] != $_REQUEST['rpassword']) {
            Func_Return::jsonReturn('', '密码必须填写，且两次输入必须一致！', 0);
        }
        if (strlen($_REQUEST['password']) < 8) {
            Func_Return::jsonReturn('', '密码不能小于8个字符！', 0);
        }
//        $rs = Data_Mysql_Table_Account::select('id, phone', array('username = ? OR phone = ?' => array($request['username'], $request['phone'])));

        $table = "{table}  as t1 LEFT JOIN {prefix}account_wechat as t2 ON t1.id = t2.account_id";
        $rs = Data_Mysql_Table_Account::select('t1.id,t1.phone,t1.username,t2.openid', array('t1.phone =? ' => $request['phone']), '', 1, $table);

        if (!empty($rs[0]['id']) && (empty($rs[0]['openid']) || $rs[0]['username'] != $rs[0]['phone'])) {
            Func_Return::jsonReturn('', ($rs[0]['phone'] == $request['phone'] ? '手机号码 ' : '用户名') . '已被注册,如有问题请致电400-056-0599', 0);
        }
        $data = array(
            'fullname' => $_REQUEST['username'],
            'phone' => $_REQUEST['phone'],
            'username' => $_REQUEST['username'],
            'attr' => array(
                'register_ip' => Func_Input::ip(),
                'email' => '',
                'phone' => $_REQUEST['phone'],
                '服务领域' => 0
            ),
            'account_type' => 21,
            'password' => Data_Mysql_Table_Account::makePassword($_REQUEST['password']),
            'register_time' => time(),
        );
        if (!empty($rs[0]['openid'])) {
            $add = Data_Mysql_Table_Account::update(array('id =?' => $rs[0]['id']),
                array('password =?' => Data_Mysql_Table_Account::makePassword($_REQUEST['password']),
                    'username' => $_REQUEST['username']));
            if ($add[0] > 0) {
                Func_Return::jsonReturn('', '您已经成功注册云·SPACE通行账号，经纪人服务已开通', 1);
            } else {
                Func_Return::jsonReturn('', '您已经注册过云·SPACE通行账号，但是经纪人服务开通未成功，请联系客服400-056-0599', 1);
            }
        } else {
            $add = Data_Mysql_Table_Account::insert($data);
            if (empty($add[0])) {
                Func_Return::jsonReturn('', '注册失败，如果出现多次未注册成功请联系我们400-056-0599', 0);
            }
            $data['id'] = $add[0];
            Func_Return::jsonReturn($data, '您已成功注册云·SPACE通行证账号，经纪人服务已开通！', 1);
        }
    }

    static function  brokerHandleOrder()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',        //订单ID
            'user_id' => 'int',   //用户id
            'status' => 'int'     //1：同意 ，2：拒绝
        ), $_REQUEST);
        if (empty($request['id']) || empty($request['user_id']) || empty($request['status'])) {
            Func_Return::jsonReturn('', '参数错误', -1001);
        }
        if ($request['status'] == 1) {
            $status = 5;
        } elseif ($request['status'] == 2) {
            $status = 6;
        }
        if (empty($status)) {
            Func_Return::jsonReturn('', '不正确的状态！', 2);
        }
        $where['id'] = $request['id'];
        $where['order_status'] = 0;
        $where['status'] = 1;
        $rs = Data_Mysql_Table_Order_Info::select('id,vendor_account_id,order_status,status', $where);
        if (!empty($rs[0]['id']) && $rs[0]['vendor_account_id'] == $request['user_id']) {
            $updateData = array(
                'order_status' => $status,
                'create_time2' => time(),
            );
            $r = Data_Mysql_Table_Order_Info::update($rs[0]['id'], $updateData);
            if (!empty($r[0])) {
                Func_Return::jsonReturn($r, '处理成功！', 1);

            } else {
                Func_Return::jsonReturn('', '处理失败！', 0);
            }
        } else {
            Func_Return::jsonReturn('', '操作异常请稍后再试', 3);
        }
    }
}