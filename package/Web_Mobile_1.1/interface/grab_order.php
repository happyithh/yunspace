<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/10
 * Time: 18:31
 * 抢单
 */
/**
 *  基于旧的 OA 系统销售分配
 * 1.抢单
 *          1.1未抢单
 *          1.2已抢单
 * 2.积分
 * 3.公告
 * 4.新建订单
 */
session_start();

//去销售微信号登录
if (empty($_SESSION['user'])) {
    $_SESSION['url_back'] = 'http://' . Core::$urls['host'] . Core::$urls['uri'] . '';
    Wechat_Oauth_Sale::handle();
}
if (!Api_Administrator_CheckByPhone::goCheck(array('phone' => @$_SESSION['user']['phone']))) {
    Func_Header::back('对不起，您的手机号没有绑定相关账户!如果您是销售请到后台->个人资料绑定手机号！');
}
//验证销售所在城市
if (empty($_COOKIE['GRAB_CITY'])) {
    $adminInfo = Api_Administrator_getBaseInfo::getAdminInfoByPhone(array('phone' => $_SESSION['user']['phone']));
    if (!empty($adminInfo['city'])) {
        $city = $adminInfo['city'];
        setcookie('GRAB_CITY', $city, time() + 3600 * 24 * 7);

    } else {
        Func_Header::back('您的账户信息不完善~请至后台完善！');

    }
}
$is_new_msg = Data_Mysql_Table_LiveChat_Message_Recent::select('is_notice', array('to_account_id=? AND from_account_id=?' => array($_SESSION['user']['id'], '-1')));
if (!empty($is_new_msg[0])) {
    Tpl_Smarty::assign('is_new_msg', $is_new_msg[0]);

} else {
    Data_Mysql_Table_LiveChat_Message_Recent::update(array(
        'to_account_id' => $_SESSION['user']['id'],
        'from_account_id' => '-1',
        'from_name' => '系统消息',
        'update_time' => time(),
        'message' => '系统公告',
        'total' => '1',
        'is_notice' => 1,
    ));
}
switch (Core::$urls['action']) {

    //分配
    case 'allot':
        Web_Mobile_Grab_Order::handleLeaderAllot();
        break;
    //积分
    case 'credit':
        Web_Mobile_Grab_Order::handleCredit();
        break;
    //公告
    case 'notice':
        Web_Mobile_Grab_Order::handleNotice();
        break;
    //新建
    case 'create':
        Web_Mobile_Grab_Order::handleOrderCreate();
        break;
    //抢单
    default:
        Web_Mobile_Grab_Order::handleGrabOrder();

}


