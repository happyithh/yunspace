<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Config_Site extends Data_Config
{
    static $staticConfig = array(
        'space_id' => 112,
        'video_id' => 108,
        'has_schedule' => array(112 => 1, 113 => 1, 114 => 1, 115 => 1, 116 => 1, 117 => 1, 118 => 1, 119 => 1, 120 => 1, 121 => 1, 122 => 1, 123 => 1, 124 => 1,),
    );
    public $all = array(
        'seo' => array(
            'homepage' => array(
                "网页标题" => '【云·SPACE－商业空间短租平台】{city0}活动场地_年会场地_场地租赁_秀场商场_找场地上云SPACE',
                "网页简介" => '云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定',
                "网页关键词" => '云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地',
            ),
            'service_package' => array(
                "网页标题" => '{city}{category_name}_活动场地 - {page} - {keywords}【云SPACE－商业空间短租平台】',
                "网页简介" => '',
                "网页关键词" => '{keywords}',
            ),
            'space_map' => array(
                "网页标题" => '找{city}活动场地，场地租赁上云SPACE',
                "网页简介" => '',
                "网页关键词" => '{keywords}',
            ),

            /**
             * city 城市
             * category_name    导航分类名字
             * businesscircle_name  所属商圈
             * adminarea_name   行政区域
             * industry_name    适合行业
             * activity_name    活动类型
             * exercise_yard    活动场地
             * site_lease       场地租赁
             * site_rental      场地出租
             */
            'service_list' => array(
                "网页标题" => '{city}{businesscircle_name}{adminarea_name}{industry_name}{activity_name}{category_name}{exercise_yard},{site_lease},{site_rental} - 云·SPACE',
                "网页简介" => '',
                "网页关键词" => '{keywords}',
            ),
            'service_info' => array(
                "网页标题" => '{product_name} - {city}{category_name}【云SPACE－商业空间短租平台】',
                "网页简介" => '{des}',
                "网页关键词" => '{keywords}',
            ),
            'vendor_info' => array(
                "网页标题" => '{vendor_name} - {city}{category_name}【云SPACE－商业空间短租平台】',
                "网页简介" => '{des}',
                "网页关键词" => '{keywords}',
            ),
            'set_info' => array(
                "网页标题" => '{set_name} - {city}{category_name}【云SPACE－商业空间短租平台】',
                "网页简介" => '{des}',
                "网页关键词" => '{keywords}',
            ),
            'raiders_info' => array(
                "网页标题" => '{title} - {category_name}【云SPACE－商业空间短租平台】',
                "网页简介" => '{des}',
                "网页关键词" => '{keywords}',
            ),
            'raiders' => array(
                "网页标题" => '{category_name} - 活动攻略_活动案例_活动资讯【云SPACE－商业空间短租平台】',
                "网页简介" => '{des} - {category_name}',
                "网页关键词" => '{keywords} - {category_name}',
            ),
            'activity_strategy_info' => array(
                "网页标题" => '{title} - {category_name}【云SPACE－商业空间短租平台】',
                "网页简介" => '{des}',
                "网页关键词" => '{keywords}',
            ),
            'activity_strategy' => array(
                "网页标题" => '{category_name} - 活动攻略_活动案例_活动资讯【云SPACE－商业空间短租平台】',
                "网页简介" => '{category_name} -  云发现【云SPACE－商业空间短租平台】',
                "网页关键词" => '{category_name} ,云发现',
            ),
            'winchance' => array(
                "网页标题" => '{title}',
                "网页简介" => '{des}',
                "网页关键词" => '{keywords}',
            ),
            'help' => array(
                "网页标题" => '{title} - {category} - 帮助中心【云SPACE－商业空间短租平台】',
                "网页简介" => '{contents}',
                "网页关键词" => '{keywords}',
            ),
            'login' => array(
                "网页标题" => '登录云·SPACE-【云·SPACE－商业空间短租平台】提供{city0}活动场地_购物中心_秀场_商场_找活动场地上云·SPACE',
                "网页简介" => '云·SPACE是全国最大最专业的活动场地预订、租赁平台。为您提供全国及{city}的活动场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定',
                "网页关键词" => '云SPACE,{city}活动场地,购物中心,秀场,商场,购物中心,路演,发布会,品牌推广',
            ),
            'register' => array(
                "网页标题" => '注册云·SPACE-【云·SPACE－商业空间短租平台】提供{city0}活动场地_购物中心_秀场_商场_找活动场地上云·SPACE',
                "网页简介" => '云·SPACE是全国最大最专业的活动场地预订、租赁平台。为您提供全国及{city}的活动场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定',
                "网页关键词" => '云SPACE,{city}活动场地,购物中心,秀场,商场,购物中心,路演,发布会,品牌推广',
            ),
        ),
        'service_list' => array(
            'page_num' => 12,
            'space_id' => 112,
        )
    );


    static function seo($page, $data = '')
    {
        Api_Track_Create::create();

        $allSeo = Data_Config_Site::getInstance()->all['seo'];
        if (!empty($allSeo[$page])) {

            $filter_tags = Func_Input::filter(array(
                'filter' => 'array',
            ), $_REQUEST);

            if (!empty($filter_tags['filter'])) {
                $tag_kyes = array(
                    2 => 'businesscircle_name',
                    4 => 'adminarea_name',
                    9 => 'industry_name',
                    49 => 'activity_name',
                );

                $tags = $filter_tags['filter'];
                foreach ($tags as $tagk => $tagv) {   //绑定tags里面的值
                    if(!empty($tag_kyes[$tagk])){
                        $tag_key = $tag_kyes[$tagk];
                        $tags[$tag_key] = $tagv;
                    }
                    unset($tags[$tagk]);
                }
                $data = array_merge($data, $tags);
            }

            /**
             * city 城市
             * category_name    导航分类名字
             * businesscircle_name  所属商圈
             * adminarea_name   行政区域
             * industry_name    适合行业
             * activity_name    活动类型
             * exercise_yard    活动场地
             * site_lease       场地租赁
             * site_rental      场地出租
             */
            $replace = array(array(), array());
            if (!empty($data)) {
                $data = Func_Input::filter(array(
                    'set_name' => 'string',
                    'title' => 'string',
                    'category_name' => 'string',
                    'product_name' => 'string',
                    'vendor_name' => 'string',
                    'des' => 'string',
                    'attr' => 'array',
                    'attr_new' => 'array',
                    'attr_index' => 'array',
                    'keywords' => 'string',
                    'category' => 'string',
                    'contents' => 'string',
                    'businesscircle_name' => 'string',
                    'adminarea_name' => 'string',
                    'industry_name' => 'string',
                    'activity_name' => 'string',
                ), $data);

                if (empty(Tpl_Smarty::$tplVars['nav_index']) || Tpl_Smarty::$tplVars['nav_index']->value != 2) {       //空间场地
                    $data = array_merge($data, array(
                        'exercise_yard' => '活动场地',
                        'site_lease' => '年会场地',
                        'site_rental' => '场地租赁',
                    ));
                } else { //配套服务
                    $data = array_merge($data, array(
                        'exercise_yard' => '活动配套服务',
                        'site_lease' => '活动搭建',
                        'site_rental' => '演员演出',
                    ));
                }
            }
            $data['city'] = !empty($_COOKIE['city']) ? $_COOKIE['city'] : '上海';
            if (!empty($data['attr_new']['46'])) {
                $data['city'] = $data['attr_new']['46'];
            }
            if (!empty($data['attr']['46'])) {
                $data['city'] = $data['attr']['46'];
            }
            if (!empty($data['attr_index']['城市'])) {
                $data['city'] = $data['attr_index']['城市'];
            }
            if(Core::$urls['route']!='city/'){
                $data['city0']= '提供全国';
            }else{
                $data['city0']= $data['city'].'首页,提供'.$data['city'];
            }
            $data['page'] = !empty($_REQUEST['dp']) ? $_REQUEST['dp'] : '';
            unset($data['attr'], $data['attr_new'], $data['attr_index']);



            if (!empty($data['category_name']) && in_array($data['category_name'], array('空间场地', '全部服务'))) {
                //清空导航的默认值
                $data['category_name'] = null;
            }

            if (!empty($data['category_name'])) {
                $data['exercise_yard'] = '_'.$data['exercise_yard'] ;
            }

            foreach ($data as $k => $v) {
                $replace[0][] = "{{$k}}";
                $replace[1][] = $v;
            }
            $seo = $allSeo[$page];
            if (!empty($replace[0])) {
                foreach ($seo as $k => $v) {
                    $seo[$k] = str_replace($replace[0], $replace[1], $v);
                    $seo[$k] = trim(str_replace('&nbsp;', '', strip_tags($seo[$k])));
                }
            }

        } else {
            $seo = array(
                "网页标题" => $page . ' -【云·SPACE－商业空间短租平台】',
                "网页简介" => $data,
            );
        }
        $seo['网页简介'] = mb_substr($seo['网页简介'], 0, 240, 'utf-8') . '...';
        Tpl_Smarty::assign('__seo', $seo);
        self::cityShow();
    }

    static function cityShow()
    {
        $_REQUEST['cities1'] = array_slice($_REQUEST['cities'], 0, 4, 1);
        $_REQUEST['cities2'] = array_slice($_REQUEST['cities'], 4, 100, 1);
        $city_key = empty($_COOKIE['city_key']) ? 'sh' : $_COOKIE['city_key'];
        if (!isset($_REQUEST['cities1'][$city_key]) && $city_key) {
            if(!empty($_REQUEST['cities2'][$city_key])){
                $_REQUEST['cities1'][$city_key] =$_REQUEST['cities2'][$city_key];
            }
        }
    }

    static function isSpace($id)
    {
        return self::$staticConfig['space_id'] == $id;
    }

    static function isVideo($id)
    {
        return self::$staticConfig['video_id'] == $id;
    }

    static function hasSchedule($id)
    {
        return !empty(self::$staticConfig['has_schedule'] [$id]);
    }

    static function displayMedia($media, $width = '', $height = '', $stamp = '')
    {
        return call_user_func_array('tplDisplayMedia', func_get_args());
    }

    static function avatar($uid, $size = 180)
    {
        return Core::$urls['root'] . 'user_center/avatar/' . $uid . "_{$size}.jpg";
    }
}

/**
 *  定义模板函数
 */
function tplDisplayShortAttrName($k)
{
    $p = strpos($k, '>');
    return $p ? substr($k, $p + 1) : $k;
}

function tplDisplayMedia($media, $width = '', $height = '', $stamp = '')
{
    if (!$width || strpos($media, '://')) {
        return $media;
    }
    $width .= '_' . intval($height);
    if ($stamp) {
        $width .= '_' . $stamp;
    }
    $p = strpos($media, 'upload/');
    if ($p === false) {
        return $media;
    }
    return Core::$urls['root'] . 'uploads/' . $width . '/' . str_replace(array('//'), array('/',), substr($media, $p + 7));
}