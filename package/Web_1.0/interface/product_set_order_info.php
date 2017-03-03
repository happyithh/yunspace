<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15/5/13
 * 订单详情
 */
Web_Account::handleIsLogin();
/**
 * 处理上传
 */
if (Core::$urls['action'] == 'upload') {
    Admin_Upload::handleUploadGlobal(100);
    die();
}
//判断子账号权限
if (!empty($_REQUEST['tab'])) {

}
/**
 * 处理订单信息
 */
$orderNo = strtoupper(Core::$urls['action']);
if (!$orderNo) {
    Func_Header::notFound();
}
Web_Product_Set_Order_Info::handle($orderNo);
Web_Product_Set_Order_Info::handleTab();

/**
 * 如果是在签约阶段
 */
//Web_Product_Set_Order_Info::handleStep2();

/**
 * 如果已经签约
 */
Web_Product_Set_Order_Info::handleStep3();
$orderInfo=Web_Product_Set_Order_Info::$_orderInfo;
//$products=$orderInfo['order_detail']['products'];
//$total_price=0;
//foreach($products as $k=>$v){
//    $total_price+=$v['price'];
//}
//获取支付信息
$paymentInfo=array();
$is_transfer=0;
$payment_info=Data_Mysql_Table_Order_Payment::select('*',array('order_id'=>$orderInfo['id']),'',10);
if(!empty($payment_info)){
    foreach($payment_info as $k=>$v){
        $v['payment_info']=json_decode($v['payment_info'],1);
        $paymentInfo[$v['payment_id']]=$v;
        if($v['payment_method']=='银行转账'){
            $is_transfer=1;
        }
    }
}

Data_Config_Site::seo('套餐订单详情: [' . Web_Product_Set_Order_Info::$_orderInfo['order_no'] . '] ' . Web_Product_Set_Order_Info::$_orderInfo['order_title']);
Tpl_Smarty::assign('__user', $_SESSION['user']);
Tpl_Smarty::assign('orderinfo',$orderInfo);
Tpl_Smarty::assign('productSet', $orderInfo['order_detail']['set_info']);
Tpl_Smarty::assign('detail', $orderInfo['order_detail']['detail_data']);
Tpl_Smarty::assign('days', $orderInfo['order_detail']['days']);
//Tpl_Smarty::assign('total_price',$total_price );
Tpl_Smarty::assign('paymentInfo',$paymentInfo );
Tpl_Smarty::assign('is_transfer',$is_transfer );
Tpl_Smarty::display('Web', 'product_set_order_info.tpl');