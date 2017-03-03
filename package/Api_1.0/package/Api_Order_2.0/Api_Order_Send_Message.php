<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-7-10
 * Time: 下午3:09
 * 订单邮件通知
 */
class Api_Order_Send_Message extends Api
{
    /*
     * 新订单发通知
     * @param   $vendorAccountId:注册账户ID
     * @param   $order_no:订单编号
     * @return null
    */
    static function sendNotice($order_no,$vendorAccountId=0,$noticeContent){
        if (!$vendorAccountId) {
            //通知超级供应商账号的手机号码, 和客服
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('username' => 'vendor'));
        } else {
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('id' => $vendorAccountId));
        }
        if (!empty($vendorInfo[0]['phone'])) {
            Web_Message::newOrderNotice($vendorInfo[0]['phone'], $order_no);
        }
        //获取 产品/套餐名称
        if(isset($noticeContent['product_id']) && !empty($noticeContent['product_id'])){
            $product_name = Data_Mysql_Table_Product_Info::select('product_name',array('id'=>$noticeContent['product_id']));
            if(!empty($product_name[0])){
                $noticeContent['product_name'] = $product_name[0]['product_name'];
            }
        }
        if(isset($noticeContent['product_set_id']) && !empty($noticeContent['product_set_id'])){
            $product_name = Data_Mysql_Table_Product_Set::select('set_name',array('id'=>$noticeContent['product_set_id']));
            if(!empty($product_name[0])){
                $noticeContent['product_name'] = $product_name[0]['set_name'];
            }
        }
        if (!empty($vendorInfo[0]['email'])) {
            Web_Message::newOrderNoticeEmail($vendorInfo[0]['email'], $vendorInfo[0]['username'], $order_no,$noticeContent);
        }
    }

    /*
     * @ 订单审核通过通知
     * @param   $buyer_account_id:买家账户ID
     * @param   $order_no:订单编号
     * @ return null
     */

    static function sendPendingMsg($order_no,$buyer_account_id=0){
        //发短消息和邮件通知采购方订单已审核
        if (!$buyer_account_id) {
            //通知超级供应商账号的手机号码, 和客服
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('username' => 'vendor'));
        } else {
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('id' => $buyer_account_id));
        }
        if (!empty($vendorInfo[0]['phone'])) {
            Web_Message::orderPending($vendorInfo[0]['phone'], $order_no);
        }
        if (!empty($vendorInfo[0]['email'])) {
            Web_Message::orderPendingEmail($vendorInfo[0]['email'], $vendorInfo[0]['username'], $order_no);
        }
    }

    /*
     * @ 发短消息和邮件通知采购方供应商已完善合同并签约
     * @param   $buyer_account_id:买家账户ID
     * @param   $order_no:订单编号
     * @ return null
     */
    static function sendVendorAssignMsg($order_no,$buyer_account_id=0){
        if (!$buyer_account_id) {
            //通知超级供应商账号的手机号码, 和客服
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('username' => 'vendor'));
        } else {
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('id' => $buyer_account_id));
        }
        if (!empty($vendorInfo[0]['phone'])) {
            Web_Message::orderVendorSigning($vendorInfo[0]['phone'], $order_no);
        }
        if (!empty($vendorInfo[0]['email'])) {
            Web_Message::orderVendorSigningEmail($vendorInfo[0]['email'], $vendorInfo[0]['username'], $order_no);
        }

    }

    /*
     * @ 发短消息和邮件通知供应商采购方已签约
     * @param   $vendor_account_id:买家账户ID
     * @param   $order_no:订单编号
     * @ return null
     */
    static function sendBuyerAssignMsg($order_no,$vendor_account_id=0){
        if (!$vendor_account_id) {
            //通知超级供应商账号的手机号码, 和客服
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('username' => 'vendor'));
        } else {
            $vendorInfo = Data_Mysql_Table_Account::select("username,phone,email", array('id' => $vendor_account_id));
        }
        if (!empty($vendorInfo[0]['phone'])) {
            Web_Message::orderBuyerSigning($vendorInfo[0]['phone'], $order_no);
        }
        if (!empty($vendorInfo[0]['email'])) {
            Web_Message::orderBuyerSigningEmail($vendorInfo[0]['email'], $vendorInfo[0]['username'], $order_no);
        }
    }

}