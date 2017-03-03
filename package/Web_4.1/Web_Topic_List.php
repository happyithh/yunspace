<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2016/05/19
 * Time: 16:11
 * 专题列表页
 */

class  Web_Topic_List extends Web_Global
{
    function seo()
    {
        $title="【云SPACE－商业空间短租平台】提供全国活动场地_发布会场地_场地租赁_活动资讯_找场地上云SPACE";
        $keywords="快闪店,商业空间,场地,活动场地,北京活动场地,上海活动场地,场地租赁,会议场地,上海会议场地,年会场地";
        $des="云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定";
        return array(
            '网页标题' => $title,
            '网页关键词' => $keywords,
            '网页简介' => $des,
        );
    }

    /*
     * 获取上线的专题列表
     */
    function topicList()
    {
        $condition['status = ?'] = 1;
        $topicList= Api_Topic_List::getTopicList($condition,1,0,12);
        if (empty($topicList)) {
            Func_Header::notFound();
        }
        return $topicList;

    }
}