<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/17
 * Time: 16:42
 */
class Api_Wechat_Ticket_Get_Address extends Api
{
    static function getSendAddress($args)
    {
      $request = Func_Input::filter(array(
            'address_id' => 'int',
        ), $args);
        if(!empty($request['address_id'])){
            $cons['id']=$request['address_id'];
        }else{
            $cons['is_default']=1;
        }
        $cons['status !=?'] = -2;
        $cons['account_id'] = $_SESSION['user']['id'];
        $addr = Data_Mysql_Table_Weixin_Ticket_Address_Info::select('*', $cons, '', 1);
        if (!empty($addr[0])) {
            $ticketAddress = $addr[0];
            return $ticketAddress;
        }else{
            return '';
        }
    }
}