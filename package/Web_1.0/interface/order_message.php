<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/2
 * Time: 18:43
 */
Web_Account::handleIsLogin();
$orderNo = Core::$urls['action'];
if (!$orderNo) {
    Func_Header::notFound();
}
if ($orderNo == 'upload') {
    Admin_Upload::handleUploadGlobal(100);
    die();
}
Web_Order_Info::handle($orderNo);
$r = Data_Mysql_Table_Order_Info::select('id, buyer_account_id, vendor_account_id, vendor_id, order_no', array(
    'order_no = ?' => $orderNo,
));
if (empty($r[0]['id'])) {
    Func_Header::notFound();
}
$orderInfo = Web_Order_Info::$_orderInfo;

/*
 * 过滤ajax请求的字段
 * 添加到数据库
 */


switch ($_REQUEST['action']) {
    case 'getMessage':
        Message_Ctl:: getMessage($orderInfo);
        break;
    case 'postMessage':
        Message_Ctl:: postMessage($orderInfo);
        break;
    case 'getMessageNotFirstTime':
        Message_Ctl:: loadMessageNotFirstTime($orderInfo);
    default:
        break;
}

class Message_Ctl
{


    static function getMessage($orderInfo)
    {

        $conditions = array(
            'order_id' => $orderInfo['id']
        );

        $message = Data_Mysql_Table_Message::select('id,from_account_id, to_account_id, message,order_id,send_time,from_username', $conditions, 'ORDER BY id DESC', 10);
        foreach ($message as $k => $v) {
            $message[$k]['send_time'] = date('Y-m-d H:i:s', $message[$k]['send_time']);
        }
        echo json_encode($message);
        die();

    }

    static function  postMessage($orderInfo)
    {
        $request = Func_Input::filter(array(
            'message' => 'string',
        ));
        $to_account_id = $_SESSION['user']['id'] == $orderInfo['vendor_account_id'] ? $orderInfo['buyer_account_id'] : $orderInfo['vendor_account_id'];
        $insertData = array(
            'from_account_id' => $_SESSION['user']['id'],
            'to_account_id' => $to_account_id,
            'send_time' => time(),
            'message' => $request['message'],
            'order_id' => $orderInfo['id'],
            'from_username' => $_SESSION['user']['username']
        );
        if ($_SESSION['user']['id'] == $orderInfo['buyer_account_id']) {
            $insertData['to_account_id'] = $orderInfo['vendor_account_id'];
        }
        if ($_SESSION['user']['id'] == $orderInfo['vendor_account_id']) {
            $insertData['to_account_id'] = $orderInfo['buyer_account_id'];
        }
        $rs = Data_Mysql_Table_Message::insert($insertData);
        if ($rs) {
            $insertData['send_time'] = date('Y-m-d H:i:s', $insertData['send_time']);
            $backData = $insertData;
            $backData['id'] = $rs[0];
        } else {
            $backData = '';
        }

        echo json_encode($backData);
        die();
    }

    static function loadMessageNotFirstTime($orderInfo)
    {
        $lastId = $_REQUEST['lastId'];
        $conditions = array(
            'id > ' . $lastId . '',
            'order_id' => $orderInfo['id']
        );
        $message = Data_Mysql_Table_Message::select('id,from_account_id, to_account_id, message,order_id,send_time,from_username', $conditions, 'ORDER BY id ASC', 10);
        foreach ($message as $k => $v) {
            $message[$k]['send_time'] = date('Y-m-d H:i:s', $message[$k]['send_time']);
        }
        echo json_encode($message);
        die();
    }
}