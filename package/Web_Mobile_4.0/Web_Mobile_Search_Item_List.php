<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/7/4
 * Time: 14:09
 *
 * 子空间搜索 移动端
 */
class Web_Mobile_Search_Item_List extends Web_Global{

    function seo()
    {
        // 暂时放着
        return array(
            '网页标题' => '相关空间,全国活动场地库-【云SPACE】',
            '网页关键词' => '云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地',
            '网页简介' => '云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定',
        );
    }

    // 子空间搜索列表数据
    static function getItemList(){
        $data = Api_Search_Mobile_Get_Item_List::getItemList();
        return $data;
    }

    /**
     *
     * 搜索需要显示的数据
    **/
    // 用途关键词
    static function getActiveName(){
        $active = Data_Mysql_Table_Case_Keywords::getActiveName();
        return $active;
    }
    // 面积区间
    function getSize()
    {
        $size = array(
            1 => '小于200m²',
            200 => '200-500m²',
            500 => '500-800m²',
            800 => '800-1000m²',
            1000 => '1000-2000m²',
            2000 => '2000m²以上',
        );
        return $size;
    }
    //场地类型
    function getCategory()
    {
        $category = Data_Mysql_Table_Spacepedia::getChildrenByCid(112);
        return $category;
    }
}