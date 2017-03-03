<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/3
 * Time: 16:44
 * @订单详情前台
 */
@session_start();
class  Api_Wechat_Ticket_Event_Info extends Api
{
    /**
     *
     *
     *
     */

//    static function  handle()
//    {
//        $result = self::getEventInfo($_REQUEST);
//        return $result;
//    }

    static function  getEventInfo($args)
    {
        $request = Func_Input::filter(array(
            "event_id"=>'int', //
        ),$args);
        if(empty($request['event_id'])){
            $result =self::request('error','',"参数传递错误");
            return $result;
        }
        //要判断登录
        $conditions =array(
            "id"=>$request['event_id'],
        );
        //订单信息
        $rs = Data_Mysql_Table_Weixin_Event_Info::select("*",$conditions,'',1);
        if(empty($rs[0]) || empty($rs[0]['id'])){
            $result =self::request('error','',"该活动不存在");
            return $result;
        }else{
            $result =self::request('success',$rs[0],"返回失败，数据为空");
            return $result;
        }
    }


}