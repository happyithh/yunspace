<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/3
 * Time: 16:44
 * @微信售票活动列表 前端
 */
class  Api_Wechat_Ticket_Event_List extends Api
{
    /**
     *
     *
     *
     */

//    static function  handle($args = '')
//    {
//        $result = self::getEventList($args);
//        return $result;
//    }

    static function  getEventList($args)
    {
        $request = Func_Input::filter(array(
            "status"=>'int'  //2 已上线开始时间小于当前时间。3 近期要上线开始时间小于当前时间
        ),$args);
        $request['status'] = (isset($request['status']) && is_numeric($request['status'])) ? $request['status'] : 2;

        $conditions =array();
        // 前端已上线
        if( $request['status']== 2){
            //开始时间小于当前时间的
//            $conditions = array(
//                "tb1.start_time < ?"=>time(),
//                'tb1.status= ?'=>1
//            );
            $sqlT ="tb1.start_time <= ? AND tb1.end_time >= ? AND tb1.status = ?";
            $conditionsData = array(time(),time(),1);
        }
        //前端近期上线
        if( $request['status']== 3){
            //开始时间小于当前时间的
//            $conditions = array(
//                "tb1.start_time > ?"=>time(),
//                'tb1.status = ?'=>1
//            );
            $sqlT ="tb1.start_time > ? AND tb1.status = ?";
            $conditionsData = array(time(),1);
         }
        $sql="SELECT tb1.*,tb2.price as low_price,tb2.price_is_score  FROM {table} as tb1 left join (select envent_id,price_is_score,min(CONVERT(price,SIGNED)) as price from {prefix}weixin_ticket_info group by envent_id) as tb2 ON tb1.id=tb2.envent_id   WHERE ".$sqlT."  group by tb1.id  ORDER BY tb1.create_time DESC LIMIT 100";
        $list = Data_Mysql_Table_Weixin_Event_Info::query( $sql, $conditionsData,1);
        if(!empty($list)){
            $result =self::request('success',$list,"返回成功");
            return $result;
        }else{
            $result =self::request('error','',"返回失败，数据为空");
            return $result;
        }
    }


}