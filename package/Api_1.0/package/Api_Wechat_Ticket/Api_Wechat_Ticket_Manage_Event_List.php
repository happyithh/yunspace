<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/3
 * Time: 16:44
 * @微信售票活动列表
 */
class  Api_Wechat_Ticket_Manage_Event_List extends Api
{
    /**
     *
     *
     *
     */
//
//    static function  handle($args = '')
//    {
//        $result = self::getEventList($args);
//        return $result;
//    }

    static function  getEventList($args)
    {
        $request = Func_Input::filter(array(
            "status"=>'int'  //-2 彻底删除   -1 回收站  0 下线    1 上线  ( 2 已上线开始时间小于当前时间。3 近期要上线开始时间小于当前时间 99)
        ),$args);
        $request['status'] = (isset($request['status']) && is_numeric($request['status'])) ? $request['status'] : '';

        $conditions =array();
        // 前端已上线
        if( !empty($request['status'])){
            //开始时间小于当前时间的
            $conditions = array(
                'status'=>$request['status']
            );
        }
        $list = Data_Mysql_Table_Weixin_Event_Info::page(0, 10, "*", $conditions, 'ORDER BY update_time DESC');
        if(!empty($list['rows'])){
            $result =self::request('success',$list,"返回成功");
            return $result;
        }else{
            $result =self::request('error','',"返回失败，数据为空");
            return $result;
        }
    }


}