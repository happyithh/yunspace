<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/2
 * Time: 14:38
 */
Web_Account::handleIsLogin();
Web_Account::handleAccountHasAuth('下单', 1);
/**
 * 开始预订
 */
//读取产品信息
$request = Func_Input::filter(array('id' => 'int'));
if (!$request['id']) {
    Func_Header::back('参数错误!');
}
$rs = Data_Mysql_Table_Product_Info::select('*', array('id' => $request['id'], 'status' => 1));
if (empty($rs[0]['id'])) {
    Func_Header::notFound();
}
$productInfo = $rs[0];
$productInfo['attr'] = json_decode($productInfo['attr'], 1);
$productInfo['price'] = $productInfo['price'] / 100;
//档期处理
Tpl_Smarty::assign('has_schedule', Data_Config_Site::hasSchedule($productInfo['category_id']));

//读取供应商信息
$rs = Data_Mysql_Table_Vendor_Info::select('id, vendor_name, base_info, attr, media, des', array('id' => $productInfo['vendor_id']));
if (!empty($rs[0]['id'])) {
    $productInfo['vendor'] = $rs[0];
    $productInfo['vendor']['base_info'] = json_decode($productInfo['vendor']['base_info'], 1);
    $productInfo['vendor']['attr'] = json_decode($productInfo['vendor']['attr'], 1);
}
Tpl_Smarty::assign('info', $productInfo);
Tpl_Smarty::assign('_vendor_attr', Data_Config_Vendor_Attr::all());
Tpl_Smarty::display('Web', 'booking.tpl');