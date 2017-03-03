<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/5/16
 * Time: 14:32
 */
class Web_Article_Classify extends Web_Global
{
    function seo()
    {
        if (!empty($this->getLeftMenuAndSeo[$this->handleAction()])) {
            $seo = $this->getLeftMenuAndSeo[$this->handleAction()];
        }
        if (!empty($seo)) {
            return array(
                '网页标题' => $seo['seo'] . "【云SPACE】",
                '网页关键词' => $seo['keyword'],
                '网页简介' => $seo['intro'],
            );
        } else {
            return array(
                '网页标题' => '商业空间_商业活动最前沿资讯,优质深度的活动资讯_活动攻略_城市活动_IP活动【云SPACE】',
                '网页关键词' => '云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地',
                '网页简介' => '云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定'
            );
        }
    }

    function handleAction()
    {

        $action_arr = explode('/', Core::$urls['action']);
        $type = substr($action_arr[0], 0, -5);

        switch ($type) {
            //空间
            case 112:
                return 112;
                break;
            //文创
            case 200:
                return 200;
                break;
//            //零售   暂且用咨询
            case 400:
                return 400;
                break;
//            //发现
            case 300 :
                return 300;
                break;
            default:
                return 0;
        }

    }

    function getArticleList()
    {
        if (!empty($_REQUEST['page'])) {
            $page = intval($_REQUEST['page']);
        } else {
            $page = 0;
        }
        $condition['status=?'] = 1;
        $space_category = $this->getSpaceCategory();
        if ($space_category) {
            $condition['baike_cid'] = $space_category;
        }
        $search = Func_Input::filter(array(
            'category' => 'int'
        ), $_REQUEST['search']);
        if (!empty($search['category']) && $search['category'] != 30) {
            $c_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($search['category']);
            $condition[] = "category_id IN (" . implode(',', $c_id) . ")";
        } elseif ($search['category'] == 30) {
            $condition['category_id =?'] = 30;
        } else {
            $condition['category_id !=?'] = 30;
        }
        $order = "ORDER BY create_time DESC";
        $data = Data_Mysql_Table_Raiders_Info::page($page, 10, '*', $condition, $order);
        $rs = $data['rows'];
        foreach ($rs as $k => $val) {
            if ($val['img_set']) {
                $img_set = explode(',', $val['img_set']);
                $rs[$k]['img_set0'] = $img_set[0];
                $rs[$k]['img_set1'] = $img_set[1];
                $rs[$k]['img_set2'] = $img_set[2];
            }
        }
        $data['rows'] = $rs;
        return $data;
    }


    /**
     * 获取空间下的类目
     */
    function  getSpaceCategory()
    {
        if ($this->handleAction() == 112) {
            $space_c_id = Data_Mysql_Table_Spacepedia::getChildrenByCid(112);
            $ids[] = 112;
            $ids = array_keys($space_c_id);
            return implode(',', $ids);
        }
        //文创
        if ($this->handleAction() == 200) {
            return 200;
        }
        //发现
        if ($this->handleAction() == 300) {
            return 300;
        }
        //零售
        if ($this->handleAction() == 400) {
            return 400;
        }
        return false;
    }

    function getType()
    {
        return $this->handleAction();

    }

    /**
     * @return bool|int|string
     *  文章的分类
     */
    function  getArticleClass()
    {
        return Data_Mysql_Table_Raiders_Info::getCategoryClass();
    }

    /**
     * @return array|mixed
     * 获取最新文章
     */
    function  isNewArticle()
    {
        $condition['status'] = 1;
//        $condition['id != ?'] = $this->id;
        $condition['create_time >?']=time()-(3600*24*7);
        $rs = Data_Mysql_Table_Raiders_Info::select('*', $condition,
            'ORDER BY counter_view DESC ', 5);
        return $rs;
    }

    function  getLeftMenuAndSeo()
    {
        return array(
            0 => array(
                'name' => '首页',
                'icon' => 'classify_icon_home',
                'selected' => 'classify_icon_home_active',
                'seo' => '商业空间_商业活动最前沿资讯,优质深度的活动资讯_活动攻略_城市活动_IP活动',
                'keyword' => '云SPACE,商业空间,活动资讯,活动攻略,活动案例,活动方案,活动策划,营销活动',
                'intro' => '云SPACE是国内首家集场地、文创IP项目的展示、管理、交易为一体的商业空间服务平台，提供从活动空间到活动内容的综合解决方案。公司总部位于上海，在北京、广州、深圳、成都等主要城市设立分支机构。截至2016年5月，公司在长沙、厦门、武汉、昆明等15个区域设立了城市合伙人，平台上线场地近5万家，覆盖全国24个城市。',
            ),
            112 => array(
                'name' => '空间',
                'icon' => 'classify_icon_space',
                'selected' => 'classify_icon_space_active',
                'seo' => '商业空间_商业活动最前沿资讯,极具个性化视角的精选分享',
                'keyword' => '云SPACE,商业空间,商业地产,场地推荐,活动资讯,场地资讯,活动策划',
                'intro' => '云SPACE被誉为中国首家商业地产空间AirBnb，我们为品牌方、广告公司、文化机构甚至个人方便地找到特色场地举办活动。并且帮助场地方提高闲置空间的使用率，利用短租降低商业地产库存，进行资产盘活',
            ),
            200 => array(
                'name' => '文创',
                'icon' => 'classify_icon_cultural',
                'selected' => 'classify_icon_cultural_active',
                'seo' => '商业空间结合IP品牌跨界联动,动漫IP_亲子IP_主题活动_线下娱乐项目',
                'keyword' => '云SPACE,商业空间,文创,IP,动漫IP,亲子IP,亲子活动,商场人气,商场引流方案',
                'intro' => '云SPACE凭借强大的文创项目资源,打破传统格局,将文创,艺术,动漫,卡通,电影,市集,体验,游戏,展览,场景,时尚,活动,生活以及品牌文化带进商场,与商业体态结合,跨界联动,提升商场人气',

            ),
            400 => array(
                'name' => '零售',
                'icon' => 'classify_icon_retail',
                'selected' => 'classify_icon_retail_active',
                'seo' => '商业零售短租_品牌游击店_临时商店_快闪店_零售新业态',
                'keyword' => '云SPACE,快闪店,体验店,showroom,集合店,店中店,DP点,商铺短租,零售卖场,零售场地',
                'intro' => '云SPACE是全球商业零售短租平台，连接全球强体验的创新消费场景。聚合品牌及内容、空间、设计、执行、运营等多方资源，引入创新或联合、独立打造多元多品类的强体验场景，将众多消费场景进行线上线下多维运营分发，运用大数据支持，将消费场景落地到匹配的商业空间，共享商业经济创新消费场景，推动商业繁荣',

            ),
            300 => array(
                'name' => '发现',
                'icon' => 'classify_icon_find',
                'selected' => 'classify_icon_find_active',
                'seo' => '发现活动,快闪店_众创空间_老建筑改造_淘宝集市_showroom',
                'keyword' => '云SPACE,商业空间,快闪店,众创空间,老建筑改造,淘宝集市,showroom',
                'intro' => '云SPACE是国内首家活动空间服务平台，我们为品牌方、广告公司、文化机构甚至个人方便地找到特色场地举办活动。并且帮助场地方提高闲置空间的使用率，利用短租降低商业地产库存，进行资产盘活'
            )
        );
    }


    function getCategory()
    {
        $category = Data_Mysql_Table_Raiders_Info::$category_name;
        if (!empty($category)) {
            foreach ($category as $k => $v) {
                if ($v['id'] != 12 && $v['parent'] != 12 && $v['parent'] == 0) {
                    $catagoryName[$v['id']] = $v['name'];
                }
            }
            return $catagoryName;
        }

    }

} 