<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/16
 * Time: 16:23
 * 完善商品报价匹配信息
 */
class Api_Demand_Offer_Match_Space_Archives_Update extends Api
{

    /**
     * @param $item_id
     * @通知数+1 和更新最后一次通知时间
     */
    static function  NoticeUpdate($item_id)
    {
        $sql = "UPDATE {table} SET notice_sum = notice_sum+1, notice_last_time=? WHERE item_id =?";
        Data_Mysql_Table_Demand_Match_Space_Archives::query($sql, array(time(), $item_id));
    }

    /**
     * @param $item_id
     * 响应数+1 和同学最后一次报价时间
     */
    static function  ResponseUpdate($item_id)
    {
        $sql = "UPDATE {table} SET response_sum = response_sum+1 , scheme_last_time =? WHERE item_id =?";
        Data_Mysql_Table_Demand_Match_Space_Archives::query($sql, array(time(), $item_id));
    }


}
