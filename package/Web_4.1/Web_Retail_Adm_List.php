<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/9/20
 * Time: 15:47
 *
 * 零售ADM数据列表
 */
class Web_Retail_Adm_List extends Web_Global{
    function seo(){
        return array(
            '网页标题' => '2016ADM亚洲设计管理论坛暨生活创新展云SPACE联合承办',
            '网页关键词' => 'ADM，2016ADM，亚洲设计管理论坛，生活创新展，云SPACE，联合承办',
            '网页简介' => '云space作为ADM的战略合作伙伴，2016ADM活动承办方，将携手ADM共同引领未来科技生活的潮流与方向。',
        );
    }
    function admList(){
        $data =  Api_Retail_Adm_List::admList();
        return $data['data'];
    }
}