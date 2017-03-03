<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/19
 * Time: 16:13
 * @超时订单通知供应商
 */
class Api_Vendor_Notice_OverTimeOrder extends Api
{
    /**
     * @param $array = array(
     *      'account_id'=>'',
     *      'order_no'=>'',
     *      'email'=>'',            //如果是多个邮箱用  ;  分隔
     *
     * );
     */

    static function  notice($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'order_no' => 'string',
            'email' => 'string',
        ), $args);
        if (empty($request['account_id']) && empty($request['email'])) {
            return false;
        }
        $title = '超时订单关闭通知';

        $content = '您好:<br/>   您在云Space的订单' . $request['order_no'] .
            '，因未及时响应采购方，订单已因超时关闭，请后续及时关注云Space的信息。如有疑问可拨打400-056-0599。';

        if (!empty($request['account_id'])) {

            $account = Api_Account_GetBaseInfo::getBaseInfoById(array('account_id' => $request['account_id']));
            if ($account['email']) {
                Func_Mail::send($account['email'], $title, $content);
            }
        } elseif (!empty($request['email'])) {

            Func_Mail::send($request['email'], $title, $content);
        }

        return true;

    }

}