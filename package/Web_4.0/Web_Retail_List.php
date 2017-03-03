<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/4
 * Time: 14:42
 * 零售页面数据处理
 */
class Web_Retail_List extends Web_Global{
//    function seo(){
//        return array(
//            '网页标题'=>'零售短租-【云SPACE】',
//            '网页关键词'=>'云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地',
//            '网页简介'=>'云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定'
//        );
//    }
    function information(){
        $data = Api_Retail_Information_List::InformationList();
        return $data;
    }
    function cooperationBrand(){
        $data = Api_Retail_Cooperation_Brand_List::brandList();
        return $data;
    }


}