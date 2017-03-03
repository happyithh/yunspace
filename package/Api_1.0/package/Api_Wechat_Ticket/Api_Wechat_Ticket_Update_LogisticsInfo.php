<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/18
 * Time: 13:54
 */
class Api_Wechat_Ticket_Update_LogisticsInfo extends Api
{
    static function updateLogisticsInfo($args){
         $request =Func_Input::filter(array(
             'id'=>'int',
             'logisticsInfo'=>'array',
             'addressInfo'=>'array',
         ),$args);
        if(!empty($request['id'])){
            $rs = Data_Mysql_Table_Weixin_Ticket_Order_Info::select('id,logisticsInfo,addressInfo',array('id'=>$request['id']));
            if(empty($rs[0])){
                return self::request('error','','此订单不存在！');
            }
            if(!empty($request['logisticsInfo'])&&!empty($request['addressInfo'])){
                $res = Data_Mysql_Table_Weixin_Ticket_Order_Info::update(array('id'=>$request['id']),array('logisticsInfo'=>$request['logisticsInfo'],'addressInfo'=>$request['addressInfo']));
            }
            if(!empty($res)){
                return self::request('success',$res,'物流及收货信息修改成功！');
            }else{
                return self::request('error','','物流及收货信息修改失败！');
            }
        }
    }
}