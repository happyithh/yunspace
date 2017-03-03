<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/4
 * Time: 16:12
 * 品牌合作详情
 */
class Web_Retail_Cooperation_Brand_Detail extends Web_Global
{
    function seo()
    {
        return array(
            '网页标题' => $this->detail['title'] . ' -【云SPACE】',
            '网页关键词' => '云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地',
            '网页简介' => '云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定'
        );
    }

    function id()
    {
        $action = Core::$urls['action'];
        $act = explode('/', $action);
        $id = Func_NumEncode::d(substr($act[1], 0, -5));
        return $id;
    }

    function detail()
    {
        $args['id'] = $this->id;
        $detail = Api_Retail_Cooperation_Brand_Detail::detail($args);
        return $detail[0];
    }

    function newInformation()
    {
        $data = Api_Retail_New_Information::newInformation();
        return $data;
    }

    function updateClick()
    {
        Data_Mysql_Table_Cooperation_Brand::query("UPDATE {table} SET click=click+1 WHERE id=" . $this->id);
    }

    function recommend()
    {
        $data = Api_Retail_Cooperation_Brand_List::brandList();
        $recommend = array();
        foreach ($data as $k => $v) {
            if ($v['id'] == $this->id) {
                unset($data[$k]);
            } else {
                if (count($recommend) < 5) {
                    $recommend[] = $data[$k];
                }
            }
        }
        return $recommend;
    }

    function qualitySpace()
    {
        $category_id = Data_Mysql_Table_Spacepedia::getChildren(112);
        $conditions[] = "category_id IN (".implode(',',$category_id).")";
        $conditions['logo !=?'] = '';
        $conditions['status =?'] =1;
        $data = Data_Mysql_Table_Spacepedia::select('id,space_name,logo',$conditions,'ORDER BY create_time DESC',3);
        return $data;
    }
}