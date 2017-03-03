<?php
$action = Core::$urls['action'];
if ($_SERVER['REMOTE_ADDR'] != '127.0.0.1' && $_SERVER['REMOTE_ADDR'] != '::1' && strpos($_SERVER['HTTP_HOST'], '.c')) {


    if ($action != 'retrieve_password_one' && $action != 'retrieve_password_three' && $action != 'login' && $action != 'login_with_token' && $action != 'register_send_sms' && $action != 'check_phone_code' && $action != 'register_submit') {

        Api_Session::checkToken();
    }
    App_Api_Vendor_Main_V2::handle();
} else {
    App_Api_Vendor_Main_V2::handle();
}