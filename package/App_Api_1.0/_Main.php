<?php

class App_Api_Main extends Base
{
    static $access_code = 'yunspace123';

    static function handle()
    {
//        $action = Core::$urls['action'];
//        if($action != 'login' && $action != 'login_with_token' && $action!='register_send_sms'&& $action!='check_phone_code' && $action!='register_submit'){
//            self::checkAccessToken();
//        }
        switch (Core::$urls['action']) {
            case 'login':
                self::login();
                break;
            case 'user_order_list':
                self::user_order_list();
                break;
            case 'order_info':
                self::order_info();
                break;
            case 'login_with_token':
                self::login_with_token();
                break;
            case 'user_info':
                Api_Session::user_info();
                break;
            case 'load_more_order_list':
                self::load_more_order_list();
                break;
            case 'get_service_list':
                self::get_service_list();
                break;
            case 'get_service_info':
                self::get_service_info();
                break;
            case 'get_contacts':
                self::get_contacts();
                break;
            case 'get_messages_content':
                self::get_messages_content();
                break;
            case 'send_message':
                self::send_message();
                break;
            case 'get_message_by_heart_beat':
                self::get_message_by_heart_beat();
                break;
            case 'get_user_admin_money':
                self::get_user_admin_money();
                break;
            case 'get_account_detail_load_more':
                self::get_account_detail_load_more();
                break;
            case 'register_send_sms':
                self::register_send_sms();
                break;
            case 'check_phone_code':
                self::check_phone_code();
                break;
            case 'register_submit':
                self::register_submit();
                break;
            case 'vendorHandleOrder':
                self::vendorHandleOrder();
                break;
            case 'getProductScheduleOne':
                self::getProductScheduleOne();
                break;
            case 'getVendorProductScheduleAll':
                self::getVendorProductScheduleAll();
                break;
            case 'addProductScheduleOne':
                self::addProductScheduleOne();
                break;
            case 'deleteProductScheduleOne':
                self::deleteProductScheduleOne();
                break;
        }
    }

    static function login()
    {
        $data = array();//返回数据
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

//        if (strpos($request['username'], '@')) {
//             $username = explode('@',$request['username']);
//             $request['username'] = $username[1];
//        }

        $makePassword = Data_Mysql_Table_Account::makePassword($request['password']);
        $conditions = array(
            'username =? OR email =? OR phone =? ' => array($request['username'], $request['username'], $request['username'])
        );
        $rs = Data_Mysql_Table_Account::select('id,password,fullname,username,phone', $conditions);
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
                'info' => '没有权限访问',
                'status' => -10
            );
            echo(json_encode($array));
            die();
        }
    }

    static function login_with_token()
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


    static function user_order_list()
    {
        $request = Func_Input::filter(array(
            'user_id' => 'int',
        ), $_REQUEST);
        $condition = array(
            'vendor_account_id' => $request['user_id'],
            'order_status >=0'
        );
        $status = Data_Mysql_Table_Order_Info::$order_status_tpl;
        $rs = Data_Mysql_Table_Order_Info::select('order_no,update_time,id,order_title,order_status,vendor_account_id', $condition, 'ORDER BY id DESC', 15);
        $data = array();
        if ($rs) {
            $data = $rs;
            foreach ($data as $k => $v) {
                $data[$k]['order_status_text'] = $status[$data[$k]['order_status']];
                $data[$k]['update_time'] = date("Y-m-d h:i:s", $data[$k]['update_time']);
            }
        }

//        $data['order_detail'] = json_decode($data['order_detail']);
        $result = json_encode($data);
        echo $result;

    }

    static function order_info()
    {
        $order_id = $_REQUEST['order_id'];
        $status = Data_Mysql_Table_Order_Info::$order_status_tpl;
        $rs = Data_Mysql_Table_Order_Info::select('order_no,order_title,start_time,order_status,buyer_account_id,create_time', array('id' => $order_id));
        $rs[0]['order_status_text'] = $status[$rs[0]['order_status']];
        $rs[0]['start_time'] = date("Y-m-d h:i:s", $rs[0]['create_time']);
        $rs2 = Data_Mysql_Table_Account::select('phone,username', array('id' => $rs[0]['buyer_account_id']));
        $data = array_merge($rs[0], $rs2[0]);
        $result = json_encode($data);
        echo $result;
    }

    static function user_info()
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

    static function load_more_order_list()
    {
        $user_id = $_REQUEST['user_id'];
        $last_id = $_REQUEST['last_id'];
        $condition = array(
            'vendor_account_id' => $user_id,
            'order_status >=0',
            'id < ?' => $last_id
        );

        $status = Data_Mysql_Table_Order_Info::$order_status_tpl;
        $rs = Data_Mysql_Table_Order_Info::select('order_no,update_time,id,order_title,order_status,vendor_account_id', $condition, 'ORDER BY id DESC', 10);
        $data = array();
        if ($rs) {
            $data = $rs;
            foreach ($data as $k => $v) {
                $data[$k]['order_status_text'] = $status[$data[$k]['order_status']];
                $data[$k]['update_time'] = date("Y-m-d h:i:s", $data[$k]['update_time']);
            }
        }

//       $data['order_detail'] = json_decode($data['order_detail']);
        $result = json_encode($data);
        echo $result;
    }

    static function get_service_list()
    {
//        $user_id = 0;

        $condition = array(
            'vendor_account_id' => $_REQUEST['user_id']
        );
        $rs = Data_Mysql_Table_Vendor_Info::select('id', $condition);
        $data = array();
        if (isset($rs[0])) {
            $condition2 = array(
                'vendor_id' => $rs[0]['id'],
                //            'status'=>1
            );
            $selectData = array(
                'id', 'product_name', 'addr', 'category_id', 'media', 'des', 'logo'
            );

            if (isset($_REQUEST['last_id'])) {
                $condition2['id<?'] = $_REQUEST['last_id'];
            }

            $data = Data_Mysql_Table_Product_Info::select($selectData, $condition2, 'ORDER BY id DESC', 15);

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
        }
        $result = json_encode($data);
        echo $result;

    }

    static function get_service_info()
    {
        $service_id = $_REQUEST['service_id'];
        $selectData = array(
            'attr', 'media', 'vendor_id', 'des', 'memo', 'price', 'addr', 'product_name', 'id'
        );
        $data = Data_Mysql_Table_Product_Info::select($selectData, array('id' => $service_id));
        $data2 = Data_Mysql_Table_Product_Marketing::select('*', array('id' => $service_id));
        $data[0]['media'] = json_decode($data[0]['media'], true);
        $data[0]['price'] = abs($data[0]['price'] / 100);
        if (!empty($data[0]['media'])) {
            foreach ($data[0]['media'] as $k => $v) {
                $data[0]['media'][$k]['path'] = 'http://' . Core::$urls['host'] . Data_Config_Site::displayMedia($v['path'], 768, '', 1);
            }
        }

        if (!empty($data[0]['attr'])) {
            $data[0]['attr'] = json_decode($data[0]['attr'], true);
            foreach ($data[0]['attr'] as $k => $v) {
                $newKey = str_replace('基本信息>', '', $k);
                $data[0]['attr'][$newKey] = $v;
                unset($data[0]['attr'][$k]);
            }
        }

        $data[0]['marketing'] = '';
        if (isset($data2[0])) {
            $data[0]['marketing'] = $data2[0];
        }


//        q($data);
        $result = json_encode($data);
        echo $result;
    }

    static function get_contacts()
    {
//        $request = Func_Input::filter(array(
//            'user_id'=>'int',
//            'last_id'=>'int'
//        ),$_REQUEST);

        $user_id = $_REQUEST['user_id'];
        $conditions = array(
            '(m.to_account_id = ? OR m.from_account_id=?)' => array($user_id, $user_id),
//            'm.from_account_id <> ?'=>$user_id,
        );

        if (isset($_REQUEST['last_id'])) {
            $conditions['m.send_time < ?'] = $_REQUEST['last_id'];
        }
//        $conditions['m.to_account_id = ?'] =$user_id;
        $conditions[] = '1 GROUP BY a.id ';
        $data = Data_Mysql_Table_Account::select('a.id, a.username, MAX(m.send_time) AS send_time, MAX(m.read_time) AS read_time, m.from_account_id, m.to_account_id, sum(read_time=0) as c ', $conditions, ' ORDER BY m.send_time DESC', 35, '{prefix}account AS a
        LEFT JOIN {prefix}message AS m ON (m.from_account_id = a.id or m.to_account_id=a.id)');
        foreach ($data as $k => $v) {
            if ($data[$k]['id'] == $user_id) {
                unset($data[$k]);
            } else {
                $data[$k]['c'] = (int)$data[$k]['c'];
                $data[$k]['avatar'] = 'http://' . Core::$urls['host'] . Core::$urls['root'] . 'user_center/avatar/' . $v['id'] . '.jpg';
                $data[$k]['real_send_time'] = $v['send_time'];
                $data[$k]['send_time'] = Func_Time::format($v['send_time']);
            }

        }
        $result = json_encode(array_values($data));
        echo $result;
    }

    static function get_messages_content()
    {
        $request = Func_Input::filter(array(
            'from_id' => 'int',
            'user_id' => 'int',
            'first_id' => 'int',
        ), $_REQUEST);
        $conditions = array(
            '(from_account_id = ? and to_account_id = ?) or (to_account_id = ? and from_account_id = ?)' => array(
                $request['from_id'], $request['user_id'], $request['from_id'], $request['user_id']
            )
        );
        $updateData = array(
            'read_time' => time(),
        );
        Data_Mysql_Table_Message::update($conditions, $updateData);

        $conditions1 = array(
            '((from_account_id = ? and to_account_id=?) or (to_account_id = ? and from_account_id=?))' => array($request['from_id'], $request['user_id'], $request['from_id'], $request['user_id'])
        );

        //查看更多消息
        if ($request['first_id']) {
            $conditions1[' m.id <?'] = $request['first_id'];
        }

        $data = Data_Mysql_Table_Message::select('m.id,m.from_account_id,a.username,m.message,m.send_time,m.to_account_id', $conditions1, 'ORDER BY m.send_time DESC', 15, '{table} AS m
        LEFT JOIN {prefix}account AS a ON m.from_account_id = a.id');
        if (empty($data)) {
            $data = array();
        } else {
            foreach ($data as $k => $v) {
                $data[$k]['send_format_time'] = Func_Time::format($v['send_time']);
                $data[$k]['avatar'] = 'http://' . Core::$urls['host'] . Core::$urls['root'] . 'user_center/avatar/' . $v['from_account_id'] . '.jpg';
                if ($data[$k]['from_account_id'] == $request['user_id']) {
                    $data[$k]['is_my'] = 1;
                }
            }
            $data = array_reverse($data);
        }

//        q($data);

        $result = json_encode($data);
        echo $result;

    }

    static function send_message()
    {
        $request = Func_Input::filter(array(
            'to_id' => 'int',
            'user_id' => 'int',
            'message' => 'string'
        ), $_REQUEST);

        $insertData = array(
            'from_account_id' => $request['user_id'],
            'to_account_id' => $request['to_id'],
            'send_time' => time(),
            'message' => $request['message'],
        );

        $rs = Data_Mysql_Table_Message::insert($insertData);

        $backData = array();
        if ($rs[0]) {
            $insertData['send_my_time'] = date('H:i:s', $insertData['send_time']);
//            $insertData['send_format_time'] = Func_Time::format($insertData['send_time']);
            $backData = $insertData;

            $backData['id'] = $rs[0];
            $backData['avatar'] = 'http://' . Core::$urls['host'] . Core::$urls['root'] . 'user_center/avatar/' . $request['user_id'] . '.jpg';
        } else {

        }
        $result = json_encode($backData);
        echo $result;
    }

    static function get_message_by_heart_beat()
    {
        $request = Func_Input::filter(array(
            'from_id' => 'int',
            'user_id' => 'int',
            'last_id' => 'int'
        ), $_REQUEST);

//        $conditions = array(
//            'from_account_id' => $request['from_id']
//        );
//        $data = array(
//            'read_time' => time(),
//        );
//        Data_Mysql_Table_Message::update($conditions, $data);

        $conditions1 = array(
            '((from_account_id = ? and to_account_id=?) or (to_account_id = ? and from_account_id=?))' => array(
                $request['from_id'], $request['user_id'], $request['from_id'], $request['user_id']
            ),
            'm.id > ' . $request['last_id'] . ''
        );

        $data = Data_Mysql_Table_Message::select('m.id,m.from_account_id,a.username,m.message,m.send_time,m.to_account_id', $conditions1, 'ORDER BY m.send_time DESC', 15, '{table} AS m
        LEFT JOIN {prefix}account AS a ON m.from_account_id = a.id');

        foreach ($data as $k => $v) {
            $data[$k]['send_time'] = date('H:i:s', $data[$k]['send_time']);
            $data[$k]['avatar'] = 'http://' . Core::$urls['host'] . Core::$urls['root'] . 'user_center/avatar/' . $v['from_account_id'] . '.jpg';
            if ($data[$k]['from_account_id'] == $request['user_id']) {
                $data[$k]['is_my'] = 1;
            }
        }

        $data = array_reverse($data);
        $result = json_encode($data);
        echo $result;
    }

    //用户钱包
    static function  get_user_admin_money()
    {
        if (empty($_REQUEST['user_id'])) {
            Func_Return::jsonReturn('', '缺少参数', -1001);
        }
        $account = Finance_Account::getAccountInfo($_REQUEST['user_id']);

        if (empty($account)) {
            Func_Return::jsonReturn('', '您需要实名认证之后才能开通我的钱包账户，请登录云·sapce官网进行实名认证！', -2);
        }

        if (isset($_REQUEST['date'])) {
            $date = strtotime($_REQUEST['date']);
            $accountDetail = Finance_Account::getDetailList($_REQUEST['user_id'], $date);
        } else {
            $accountDetail = Finance_Account::getDetailList($_REQUEST['user_id']);
        }
        foreach ($accountDetail as $k => $v) {
            $accountDetail[$k]['create_time'] = Date('Y-m-d H:i', $v['create_time']);
        }
        $data['account'] = $account;
        $data['account_detail'] = $accountDetail;
        $totalAmount = array(0, 0);
        foreach ($accountDetail as $v) {
            if ($v['amount'] > 0) {
                $totalAmount[0] += $v['amount'];
            } else {
                $totalAmount[1] -= $v['amount'];
            }
        }
        $totalAmount[0] = Finance_Account::amountFormat($totalAmount[0]);
        $totalAmount[1] = Finance_Account::amountFormat($totalAmount[1]);
        $data['total_amount'] = $totalAmount;
        $dates = array();
        $timeNow = time();
        do {
            $dates[] = date("Y-m", $timeNow);
            $timeNow -= 86400 * 30;
        } while ($timeNow > '1425279172');
        $data['dates'] = $dates;
        Func_Return::jsonReturn($data, '成功获取', 1);
    }
    //获取账户交易列表---加载更多
    //参数    用户id , limit=0,10
    static function get_account_detail_load_more()
    {
        if (empty($_REQUEST['user_id'])) {
            Func_Return::jsonReturn('', '缺少参数！', -1001);
        }
        if (empty($_REQUEST['page'])) {
            $limit = '0,9';
        } else {
            $srart = ($_REQUEST['page'] - 1) * 10;
            $end = ($_REQUEST['page']) * 10 - 1;
            $limit = "$srart,$end";
        }
        $accountDetail = Finance_Account::getDetailList($_REQUEST['user_id'], '', '', $limit);
        $data['account_detail'] = $accountDetail;
        Func_Return::jsonReturn($data, '获取成功！', 1);
    }
    //注册--发送验证码
    // 参数  手机号
    static function register_send_sms()
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
        ));
        if (!$request['phone']) {
            Func_Return::jsonReturn('', '请输入正确的手机号！！', -1002);
        }
        $rs = Data_Mysql_Table_Account::select('id', array('phone =?' => $request['phone']));
        if (!empty($rs[0])) {
            Func_Return::jsonReturn('', '该手机号已被注册', -2001);
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

    static function check_phone_code()
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
    static function  register_submit()
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
        $rs = Data_Mysql_Table_Account::select('id, phone', array('username = ? OR phone = ?' => array($request['username'], $request['phone'])));
        if (!empty($rs[0]['id'])) {
            Func_Return::jsonReturn('', ($rs[0]['phone'] == $request['phone'] ? '手机号码 ' : '用户名') . '已被注册！', 0);
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
        $add = Data_Mysql_Table_Account::insert($data);
        if (empty($add[0])) {
            Func_Return::jsonReturn('', '注册失败！', 0);
        }
        $data['id'] = $add[0];
        Func_Return::jsonReturn($data, '注册成功！', 1);

    }

    static function  vendorHandleOrder()
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

    /*
     * @获取一个供应商的所有产品档期
     */
    static function  getVendorProductScheduleAll()
    {

        $request = Func_Input::filter(array(
            'user_id' => 'int'
        ));
        if (empty($request['user_id'])) {
            Func_Return::jsonReturn('', '参数错误', -1001);
        }
        $table = "{table} LEFT JOIN {prefix}vendor_info ON {table}.id = {prefix}vendor_info.vendor_account_id";

        $vendor = Data_Mysql_Table_Account::select('{prefix}vendor_info.id ', array('{table}.id =?' => $request['user_id']), '', 1, $table);
        if (empty($vendor[0]['id'])) {
            Func_Return::jsonReturn('', '没有找到该供应商信息！', -1002);
        }
        $product = Data_Mysql_Table_Product_Info::select('id', array('status >?' => 0, 'vendor_id=?' => $vendor[0]['id']), '', 20);
        if (empty($product)) {
            Func_Return::jsonReturn('', '没有找到该供应商的产品信息！', -1003);
        }
        $ids = array();
        foreach ($product as $key => $val) {
            if (empty($val['id']) || $val['id'] == 0) {
                unset ($product[$key]);
            }
            $ids[] = $val['id'];
        }
        $condition = "product_id IN ( " . implode(',', $ids) . ") AND  status = 1";
        $data = Data_Mysql_Table_Product_Schedule::select('*', $condition, '', 99);

        if (empty($data)) {
            Func_Return::jsonReturn('', '没有查到相关数据', 1);
        }
        Func_Return::jsonReturn($data, '查询成功', 1);

    }

    /*
     * @获取一个产品的档期
     */
    static function  getProductScheduleOne()
    {
        $json = array();
        $request = Func_Input::filter(array(
            'product_id' => 'int'
        ));
        if (empty($request['product_id'])) {
            Func_Return::jsonReturn('', '参数错误', -1001);
        }
        $data = Data_Mysql_Table_Product_Schedule::select('*', array('product_id =?' => $request['product_id'], 'status=?' => 1), '', 20);
        foreach ($data as $k => $v) {
            if ($v['status'] == '1') {
                $json[$k]['id'] = $v['id'];
                $json[$k]['start'] = date('Y-m-d', $v['start_time']);
                $json[$k]['end'] = date('Y-m-d', $v['end_time'] + 86400);
//                $json[$k]['rendering'] = 'background';
                if ($v['color'] == "") {
                    $json[$k]['color'] = '#00c3c3';
                } else {
                    $json[$k]['color'] = $v['color'];
                }
                $json[$k]['des'] = $v['des'];
            }
            if ($v['status'] == '2') {
                $json[$k]['id'] = $v['id'];
                $json[$k]['start'] = date('Y-m-d', $v['start_time']);
                $json[$k]['end'] = date('Y-m-d', $v['end_time'] + 86400);
//                $json[$k]['rendering'] = 'background';
                $json[$k]['color'] = '#999';
                $json[$k]['des'] = $v['des'];
            }
        }
        if (empty($json)) {
            Func_Return::jsonReturn('', '没有查到相关数据', 2);
        }
        Func_Return::jsonReturn($json, '查询成功', 1);

    }

    /*
     *@ 添加一个产品档期
     *
     */
    static function  addProductScheduleOne()
    {
        $request = Func_Input::filter(array(
            'user_id' => 'int',
            'product_id' => 'int',
            'start_time' => 'string',       //2015-05-27
            'end_time' => 'string',
            'des' => 'string',              //档期文案。
            'color' => 'string'
        ));

//        Func_Return::jsonReturn($request,'添加失败',-1);
//        die();
        if (empty($request['product_id']) || empty($request['start_time']) || empty($request['end_time'])) {
            Func_Return::jsonReturn('', '缺少参数', -1001);
        }
        $condition['id'] = $request['product_id'];
        $condition['{prefix}vendor_info.vendor_account_id =?'] = $request['user_id'];
        $table = "{table} LEFT JOIN {prefix}vendor_info ON {table}.vendor_id={prefix}vendor_info.id";
        $productInfo = Data_Mysql_Table_Product_Info::select('{table}.id', $condition, '', 1, $table);

        if (empty($productInfo[0]['id'])) {
            Func_Return::jsonReturn('', '没有找到相关产品信息', -1002);
        }
        $data = array(
            'product_id' => $request['product_id'],
            'vendor_account_id' => $request['user_id'],
            'start_time' => strtotime($request['start_time']),
            'end_time' => strtotime($request['end_time']),
            'des' => $request['des'],
            'color' => $request['color'],
            'status' => 1,
        );
        if ($data['end_time'] < $data['start_time']) {
            Func_Return::jsonReturn('', '结束时间小于开始时间', -1003);
        }
        $rs = Data_Mysql_Table_Product_Schedule::insert($data);
        if (empty($rs[0])) {
            Func_Return::jsonReturn('', '添加失败', -1);
        }
        Func_Return::jsonReturn('', '添加成功', 1);
    }


    /*删除产品档期*/
    static function deleteProductScheduleOne()
    {
        $request = Func_Input::filter(array(
            'id' => 'int'
        ));
        $conditions = array(
            'id' => $request['id']
        );
        $data = Data_Mysql_Table_Product_Schedule::delete($conditions);
        if ($data) {
            Func_Return::jsonReturn('', '删除成功', 1);
        } else {
            Func_Return::jsonReturn('', '删除失败', 1);
        }
    }

    static function jsonReturn($data, $info = '', $status = '')
    {
        header('Content-Type:application/json; charset=utf-8');
        $array = array(
            'data' => $data,
            'info' => $info,
            'status' => $status
        );
        exit(json_encode($array));
    }


}