<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-12-8
 * Time: 下午7:53
 */
class Web_Global extends Page_Base
{
    //一键租场地url生成
    static function createRentSpaceUrl()
    {
         return "http://" . Core::$urls['host'] . "/space_library?action=form";
    }
    //场地库url
    static function spaceLibraryUrl(){
        if ($_REQUEST['is_local_env']) {
            return "http://" . Core::$urls['host'] . "/space_library";
        } else {
            return "http://yunspace.com.cn";
        }
    }

    /*
    * 通过OA后台标签46获取所有的城市
    * $is_all 返回值是否需要“全国”  0 不需要  1需要
    */
    static function getAllCities($is_all=0)
    {
        $categoryInfo=Data_Mysql_Table_Tags::getInfoCache();
        $city_id=Page_Site_Global::tagsName("城市");
        if(empty($city_id)){
            return array();
        }
        $city_arr=$categoryInfo[$city_id];
        if(empty($city_arr)){
            return array();
        }
        $arr1 = $city_arr['tags_value'];
        foreach($arr1 as $k=>$v){
            if(empty($is_all) && $v=="全国"){
                unset($arr1[$k]);
            }
        }
        return $arr1;
     }


    static function cityShow()
    {
        $_REQUEST['cities1'] = array_slice($_REQUEST['cities'], 0, 4, 1);
        $_REQUEST['cities2'] = array_slice($_REQUEST['cities'], 4, 100, 1);
        $city_key = empty($_COOKIE['city_key']) ? 'sh' : $_COOKIE['city_key'];
        if (!isset($_REQUEST['cities1'][$city_key]) && $city_key) {
            $_REQUEST['cities1'][$city_key] = $_REQUEST['cities2'][$city_key];
        }
    }

    static function catIsSpace($cid)
    {
        $category_space = Data_Mysql_Table_Spacepedia::getChildren(112);
        $category_space[] = 112;
        return in_array($cid, $category_space);

    }

    static function isWechat()
    {
        return strpos($_SESSION['HTTP_USER_AGENT'], 'MicroMessenger') > 0;
    }

    static function isLogin()
    {
        if (!empty($_SESSION['access_url'])) {
            if (strpos(Core::$urls['path'], $_SESSION['access_url']) === false) {
                unset($_SESSION['user'], $_SESSION['access_url']);
                Func_Header::to($msg, Core::$urls['root'] . 'user_center/login?url_back=' . Core::$urls['uri']);
            }
        }
        if (empty($_SESSION['user']['id'])) {
            if(Core::$urls['host']=='m.yunspace.com.cn'){
                Func_Header::to($msg, Core::$urls['root'] . 'user_center/');
            }else{
                Func_Header::to($msg, Core::$urls['root'] . 'user_center/login?url_back=' . Core::$urls['uri']);
            }
        }
        //如果有正在待审核的实名认证信息, 则查询数据库看看是否有变更
        if (!empty($_SESSION['user']['attr']['new_identity']) && !isset($_SESSION['user']['attr']['new_identity']['rejectReason'])) {
            $r = Data_Mysql_Table_Account::select('id, fullname, attr', array('id' => $_SESSION['user']['id'], 'identity_time>-2'));
            if (!empty($r[0]['id'])) {
                $_SESSION['user']['fullname'] = $r[0]['fullname'];
                $_SESSION['user']['attr'] = json_decode($r[0]['attr'], 1);
            }
        }
        if (!empty($_COOKIE['unid'])) {
            Data_Mysql_Table_Dwz_Record::updataRecord(); //更新通过分享url点击的记录
        }
    }
    public static $city_name =
        array(
            'bj' => '北京',
            'sh' => '上海',
            'gz' => '广州',
            'sz' => '深圳',
            'cd' => '成都',
            'hz' => '杭州',
            'nj' => '南京',
            'suzhou' => '苏州',
            'chongqing' => '重庆',
            'wuhan' => '武汉',
            'xian' => '西安',
            'changsha' => '长沙',
            'nanchang' => '南昌',
            'guiyang' => '贵阳',
            'dalian' => '大连',
            'jinan' => '济南',
            'qingdao' => '青岛',
            'yantai' => '烟台',
            'xiameng' => '厦门',
            'taiyuan' => '太原',
            'kunming' => '昆明',
            'dali' => '大理',
            'lijiang' => '丽江',
            'tengchong' => '腾冲',
            'xsbn' => '西双版纳',
        );
    static function cities(){
        return self::$city_name;
    }

    //获取活动类型（调取后台全局标签的活动类型）
    static function getActiveType()
    {
        $active = Data_Mysql_Table_Case_Keywords::getActiveName();
        return $active;
    }
    static    function isWorkTime(){
       return Api_Holiday::isWorkTime();
    }
}

Api_Track_Create::create();