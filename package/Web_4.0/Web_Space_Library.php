<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2016/03/08
 * Time: 10:45
 * @场地库
 */
class  Web_Space_Library extends Web_Global
{

    function seo()
    {
        if ($_COOKIE['city']) {
            $title = '【云SPACE－商业空间短租平台】提供' . $_COOKIE['city'] . '活动场地_商业空间_商业地产_商业地产策划_商业地产公司';
        } else {
            $title = '【云SPACE－商业空间短租平台】提供上海活动场地_商业空间_商业地产_商业地产策划_商业地产公司';
        }
        return array(
            '网页标题' => $title,
            '网页简介' => "云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定",
            '网页关键词' => "云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地",
        );
    }

    //热门城市定义
    static $hot_city = array(
        '上海',
        '北京',
        '广州',
        '深圳',
        '成都'
    );

    function  BeyondDefaultCity()
    {
        if (in_array($_COOKIE['city'], self::$hot_city)) {
            return false;
        }
        return $_COOKIE['city'];
    }

    function getConditionsCity()
    {
        $request = Func_Input::filter(array(
            'city' => 'string'
        ), $_REQUEST['search']);
        $request['city'] = trim($request['city']);

//        if (in_array($request['city'], self::$hot_city)) {
//            return $request['city'];
//        } else {
//            if (in_array($_COOKIE['city'], self::$hot_city)) {
//                return $_COOKIE['city'];
//            }
//        }
        if (!empty($request['city'])) {
            return $request['city'];
        }
        if (!empty($_COOKIE['city'])) {
            return $_COOKIE['city'];
        }

        return '上海';

    }

    //秀场展馆
    function getShowSpace()
    {
        $show = array();
        $city = $this->getConditionsCity();

        return self::getSpaceList(113, $city);

    }

    //商业广场
    function getBusinessSpace()
    {
        $business = array();
        $city = $this->getConditionsCity();
        return self::getSpaceList(114, $city);

    }

    //高端会所
    function getClubSpace()
    {
        $club = array();
        $city = $this->getConditionsCity();
        return self::getSpaceList(119, $city);

    }

    //会务中心
    function getMeetingSpace()
    {
        $meeting = array();
        $city = $this->getConditionsCity();
        return self::getSpaceList(121, $city);

    }

    //餐厅酒吧
    function getBarSpace()
    {
        $bar = array();
        $city = $this->getConditionsCity();

        return self::getSpaceList(118, $city);


    }

    //获取满足条件的场地列表
    static function getSpaceList($type, $city = '')
    {
        $data = array();
        switch ($type) {
            case 113:
                $condition["category_id"] = 113;
                break;
            case 114:
                $condition["category_id"] = 114;
                break;
            case 119:
                $condition["category_id"] = 119;
                break;
            case 121:
                $condition["category_id"] = 121;
                break;
            case 118:
                $condition["category_id"] = 118;
                break;
            default:
                $condition["category_id"] = 113;
                break;
        }
        if (!empty($city)) {
            $condition['city'] = $city;
        }
        $condition['status'] = 1;
        $condition['logo != ?'] = '';
        $data = Data_Mysql_Table_Spacepedia_Search::select("id,space_name,logo,des", $condition,
            'ORDER BY order_index DESC,update_time DESC', 7);
        return $data;
    }


}