<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/13
 * Time: 09:47
 */
class Web_Message extends Base
{
    //通用验证码
    static function globalAuthCode($phone, $authCode)
    {
        Func_Message::sendSMS($phone, array($authCode), 14467);
    }

    //注册验证码
    static function registerAuthCode($phone, $authCode)
    {
        Func_Message::sendSMS($phone, array(
//        '手机号码验证',
            $authCode,
            5
        ), 13838);
    }

    //用户认证通过
    static function userIdentitySuccess($phone, $name)
    {
        Func_Message::sendSMS($phone, array($name), 14475);
    }

    static function userIdentitySuccessEmail($email, $username)
    {
        $subject = "【云SPACE】您的[{$username}]身份验证已成功，您可随时进行交易。";
        $content = "{$username}您好， 您的[{$username}]身份验证已成功，您可随时进行交易。   -----【云SPACE】";
        Func_Mail::send($email, $subject, $content);
    }

    //用户认证失败
    static function userIdentityFail($phone, $name)
    {
        Func_Message::sendSMS($phone, array($name), 14893);
    }

    static function userIdentityFailEmail($email, $username)
    {
        $subject = "【云SPACE】您的[{$username}]身份验证未通过，请重新检查您的认证信息。";
        $content = "{$username}您好，您的[{$username}]身份验证未通过，请重新检查您的认证信息。   -----【云SPACE】";
        Func_Mail::send($email, $subject, $content);
    }

    //微信售票，订单票号短信
    static function wxEventTicketNum($phone,$eventtitle,$countnum,$ticketnums){
      $rs =   Func_Message::sendSMS(
            $phone,
            array(
                $eventtitle,
                $countnum,
                $ticketnums
            ),
            23793);
        Func_Output::json('success','',"门票信息短信发送成功");
    }

    //新订单通知
    static function newOrderNotice($phone, $orderNo)
    {
        Func_Message::sendSMS($phone, array($orderNo), 14469);
    }

    //新订单通知
    static function newOrderNoticeEmail($email, $username, $orderNo,$noticeContent=array())
    {
        $subject = "【云SPACE】您有一个新的订单，订单编号[{$orderNo}]";
        $content = "{$username}您好，您有一个新的订单:<br/> <br>
                    <strong>{$noticeContent['buyer']} </strong>在 <span style='color: #666;'> {$noticeContent['create_time']} </span>预定了【{$noticeContent['product_name']}】<br/>
                    预定档期:【{$noticeContent['start_time']}--{$noticeContent['end_time']}】；<br>
                    订单编号:【{$orderNo}】；<br/>
                    订单价格: 【{$noticeContent['order_price']}】元
                    请您注意查看并审核。   -----【云SPACE】";
        Func_Mail::send($email, $subject, $content);
    }
    //通过审核通知
    static function orderPending($phone, $orderNo)
    {
        Func_Message::sendSMS($phone, array($orderNo), 14470);
    }

    //通过审核通知
    static function orderPendingEmail($email, $username, $orderNo)
    {
        $subject = "【云SPACE】订单编号[{$orderNo}]已审核通过";
        $content = "{$username}您好,您的订单编号[{$orderNo}]已审核通过。   -----【云SPACE】";
        Func_Mail::send($email, $subject, $content);
    }


    //供应商签约通知
    static function orderVendorSigning($phone, $orderNo)
    {
        Func_Message::sendSMS($phone, array($orderNo), 14471);
    }

    //供应商签约通知
    static function orderVendorSigningEmail($email, $username, $orderNo)
    {
        $subject = "【云SPACE】订单编号[{$orderNo}]供应商已签约";
        $content = "{$username}您好,您的订单编号[{$orderNo}]供应商已签约，请您查阅合同信息，完成交易。   -----【云SPACE】";
        Func_Mail::send($email, $subject, $content);
    }


    //买家签约通知
    static function orderBuyerSigning($phone, $orderNo)
    {
        Func_Message::sendSMS($phone, array($orderNo), 14884);
    }

    //买家签约通知
    static function orderBuyerSigningEmail($email, $username, $orderNo)
    {
        $subject = "【云SPACE】订单编号[{$orderNo}]客户已签约";
        $content = "{$username}您好,您的订单编号[{$orderNo}]客户已签约，订单进入支付流程。   -----【云SPACE】";
        Func_Mail::send($email, $subject, $content);
    }


    //支付即将到期提醒   定时任务  /   每天9点检查
    static function orderPaymentNoticeBefore($phone, $orderNo)
    {
        Func_Message::sendSMS($phone, array($orderNo), 14772);
    }

    //支付即将到期提醒   定时任务  /   每天9点检查
    static function orderPaymentNoticeBeforeEmail($mailList, $subject, $content, $from = '', $fromName = '', $attachment = '')
    {
        Func_Mail::send($mailList, $subject, $content, $from = '', $fromName = '', $attachment = '');
    }

    //支付已经过期提醒   定时任务  /   每天9点检查
    static function orderPaymentNoticeAfter($phone, $orderNo)
    {
        Func_Message::sendSMS($phone, array($orderNo), 14534);
    }

    //支付已经过期提醒   定时任务  /   每天9点检查
    static function orderPaymentNoticeAfterEmail($mailList, $subject, $content, $from = '', $fromName = '', $attachment = '')
    {
        Func_Mail::send($mailList, $subject, $content, $from = '', $fromName = '', $attachment = '');
    }

    //确认邮箱地址
    static function emailConform($email, $username, $authUrl)
    {
        $subject = "【云SPACE】邮箱地址验证";
        $content = "{$username}您好,请在浏览器中打开<a href='{$authUrl}'>{$authUrl}</a>以验证你的邮箱地址。   -----【云SPACE】";

        return Func_Mail::send($email, $subject, $content);

    }

    //供应商签约通知
    static function demandNotice($phone, $demandType)
    {
        Func_Message::sendSMS($phone, array($demandType), 14476);
    }
    //需求提交通知
    static function demandEmail($email,$id)
    {
        $subject = "需求提交邮件提醒";
        $content = "有新的需求，编号[".$id."],请及时联系";

        return Func_Mail::send($email, $subject, $content);
    }
    //新增联系人通知
    static function ContactsEmail($email,$name,$type)
    {
        if($type=='new'){
            $subject = "有新的联系人提醒";
            $content = "有新的联系人，编号[".$name."],请及时联系";
        }else{
            $subject = "联系人[".$name."]信息更新提醒";
            $content = "联系人[".$name."]有新的需求，请及时联系";
        }


        return Func_Mail::send($email, $subject, $content);
    }
    //重置密码通知
    static function  resetPasswordEmail($email,$password){
        $subject = "重置密码提醒";
        $content = "您的密码已重置，密码为：[".$password."],请妥善保管";

        return Func_Mail::send($email, $subject, $content);

    }
    //提现请求成功邮件通知
    static function  CashSuccessEmail($email,$username,$amount){
        $subject ="【".$username."】账户提现请求通知";
        $content = "【".$username."】账户有一笔金额为&nbsp;<font color='#d6255e'><b>￥".$amount."</b></font>&nbsp;的提现请求,请注意查收!";
        return Func_Mail::send($email, $subject, $content);

    }

}