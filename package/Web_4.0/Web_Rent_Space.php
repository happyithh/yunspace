<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2015/10/22
 * Time: 09:30
 * 一键租场地
 */
class  Web_Rent_Space extends Web_Global
{
    function seo()
    {
        return array(
            '网页标题' => '【云SPACE－商业空间短租平台】一键租场地_发布会场地_路演场地_年会场地_场地出租_场地租赁平台',
            '网页简介'=>"云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定",
            '网页关键词'=>"云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地",
        );
    }

    //获取发布会案例信息
    function getPublicCaseList(){
        return self::getCaseList("发布会");
    }
    //获取派对案例信息
    function getPartyCaseList(){
        return self::getCaseList("派对");
    }
    //获取酒会案例信息
    function getWineCaseList(){
        return self::getCaseList("酒会");
    }
    //获取会议案例信息
    function getMeetingCaseList(){
        return self::getCaseList("会议");
    }
    static function getCaseList($type){
        $data=array();
        switch($type){
            case "发布会":
                $condition["category_id"]=20;
                break;
            case "派对":
                $condition["category_id"]=5;
                break;
            case "酒会":
                $condition["category_id"]=21;
                break;
            case "会议":
                $condition["category_id"]=24;
                break;
            default:
                $condition["category_id"]=20;
                break;
        }
        $condition['status']=1;
        $data=Data_Mysql_Table_Raiders_Info::select('id,title,logo',$condition,"ORDER BY update_time DESC",8);
        return $data;
    }
}