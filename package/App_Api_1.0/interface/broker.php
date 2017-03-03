<?php
$action = Core::$urls['action'];

//if ($_SERVER['REMOTE_ADDR'] != '127.0.0.1' && $_SERVER['REMOTE_ADDR'] != '::1' && strpos($_SERVER['HTTP_HOST'], '.c')) {
if ($action != 'login' && $action != 'login_with_token' && $action != 'register_send_sms' && $action != 'check_phone_code' && $action != 'register_submit') {
    App_Api_Broker_Main::checkAccessToken();
}
App_Api_Broker_Main::handle();
//} else {
//    App_Api_Broker_Main::handle();
//}