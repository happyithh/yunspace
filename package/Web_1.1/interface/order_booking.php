<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/8/4
 * Time: 10:00
 * 订单预订
 */
Web_Account::handleIsLogin();
Web_Account::handleAccountHasAuth('下单', 1);
// 开始预订
$request = Func_Input::filter(array('id' => 'int','booking_type'=>'int'));
if (!$request['id']) {
    Func_Header::back('参数错误!');
}
$data=array();
if($request['booking_type']==1){
    //产品预订
    $oProduct = Web_Product_Info::getInstance();
    $oProduct->id = $request['id'];
    $data = $oProduct->productInfo;
}elseif($request['booking_type']==2){
    //套餐预订
    $oProductSet = Web_Product_Set_Info::getInstance();
    $oProductSet->id = $request['id'];
    $data = $oProductSet->info;
}else{
    Func_Header::notFound();
}
//获取供应商信息
$vendorInfo=Web_Product_Info::getVendorInfo($data['vendor_id']);

//获取时间区间
//for($h=0;$h<24;$h++){
//    $hours[]=(strlen($h)==1)?("0".$h).":00":$h.":00";
//}
//Tpl_Smarty::assign('hours', $hours);
Tpl_Smarty::assign('data', $data);
Tpl_Smarty::assign('booking_type', $request['booking_type']);
Tpl_Smarty::assign('vendor',$vendorInfo);
Tpl_Smarty::display('Web_Static', 'order/order_booking.tpl');


