<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2015/5/12
 * 套餐预订页
 */
Web_Account::handleIsLogin();
Web_Account::handleAccountHasAuth('下单', 1);
//读取产品信息
$request = Func_Input::filter(array('id' => 'int'));
//$request['version'] = intval($request['version']);
if (empty($request['id'])) {
    Func_Header::back('参数错误!');
}
$obj = Web_Product_Set_Info::getInstance();
$obj->id = $request['id'];
//if (!isset($obj->detail[$request['version']])) {
//    Func_Header::back('套餐版本不存在!');
//}
//$obj->detail_selected = $obj->detail[$request['version']];
$_REQUEST = $request;
Web_Product_Set_Info::display('product_set_booking.tpl');