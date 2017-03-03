<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/12/16
 * Time: 16:17
 */
class Web_Space_Search extends Web_Global
{

    static function handle()
    {
        Tpl_Smarty::assign("nav", 'site');
        self::urlToCity();
        self::putTagsInRequest();
        Web_Search_Space_New::display('Web_Static::search/search_list_1.0.tpl');
        die();
    }

    static function urlToCity()
    {
        $request = explode('/', Core::$urls['path']);
        $cityKey = explode('-', $request[1]);
        if (array_key_exists($cityKey[1], self::$city_name)) {
            $_REQUEST['city_key'] = $cityKey[1];
        }
    }


    static function putTagsInRequest()
    {
        /***
         * city :城市
         * size：面积
         * 49：活动类型
         * 9：行业类型
         *4：行政区域
         */
        $preuri = '/spaces-';  //拿到Uri前缀
        $uri = str_replace($preuri, '', Func_Url::str_urldecode(Core::$urls['uri']));     //去除前缀，避免匹配到Action数字
        $uri_arr = explode('?', $uri);      //标签显示过滤掉Uri中的面积 ?size_range=200
        $uri_arr = explode('/', $uri_arr[0]);
//        q($uri_arr);
        $tag_arr = explode('-', $uri_arr[0]);
//        preg_match_all('/-(49|9|4|2+)+/i', $uri, $tag_nos);
        if (array_key_exists($tag_arr[0], self::$city_name)) {
            array_shift($tag_arr);
        }
        array_pop($tag_arr);
        $ch_arr = explode('-', $uri_arr[1]);
        if (!empty($uri_arr[2]) && preg_match("/([\x{4e00}-\x{9fa5}]+)/u", $uri_arr[2])) {     //匹配中文  颁奖晚会/盛典
            $chs_arr = array_slice($uri_arr, 1, 2);
            $chs = implode('/', $chs_arr);
            $ch_arr = explode('-', $chs);
        }

        $ch_chars = array_map(function ($val) {
            $val= trim(Func_String::utf8(urldecode(trim($val))));
//            $val= Func_String::RemoveXSS($val);
            return $val;
        }, $ch_arr);
        if (count($tag_arr) < count($ch_chars)) {
            if (count($ch_chars) > 0) {
                $_REQUEST['keyword'] = array_pop($ch_chars);
            }
            $ch_chars = array_slice($ch_chars, 0, count($tag_arr));
        }
        $tag_array = @array_combine($tag_arr, $ch_chars);
        if ($tag_array) {
            foreach ($tag_array as $k => $v) {
                switch ($k) {
                    case 'size':
                        $_REQUEST['size_range'] = $v;
                        break;
                    case 49:
                        $_REQUEST['filter'][49] = Func_String::utf8($v);
                        break;
                    case 4:
                        if (isset($_REQUEST['city_key'])) {
                            $_REQUEST['filter'][4] = Func_String::utf8($v);
                        }
                        break;
                    case 9:
                        $_REQUEST['filter'][9] = Func_String::utf8($v);
                        break;
                    case 'category':
                        $_REQUEST['category_id'] = Data_Mysql_Table_Spacepedia::getCategoryId(Func_String::utf8($v));
                        break;
                }
            }
        }
//        $last_path = end($uri_arr);
//        if ($last_path != $_COOKIE['city_key']) {
//            if (!empty($uri_arr[1])) {    //进入空间场地页面，没有选择全部
//                $ch_arr = explode('-', $uri_arr[1]);
//                if (!empty($uri_arr[2]) && preg_match("/([\x{4e00}-\x{9fa5}]+)/u", $uri_arr[2])) {     //匹配中文  颁奖晚会/盛典
//                    $chs_arr = array_slice($uri_arr, 1, 2);
//                    $chs = implode('/', $chs_arr);
//                    $ch_arr = explode('-', $chs);
//                }
//                $_REQUEST['keyword'] = array_pop($ch_arr);
//                $ch_chars = array_map(function ($val) {
//                    return trim(Func_String::utf8(urldecode(trim($val))));
//                }, $ch_arr);
//
//            }
//        }
//
//        preg_match_all('/-(49|9|4|2+)+/i', $uri, $tag_nos);
//        if (!empty($tag_nos[1]) && !empty($ch_chars)) {
//            // $request['activity']         活动类型[49]
//            // $request['industry']         适合行业[9]
//            // $request['adminarea']	    行政区域[4]
//            // $request['businesscircle']   商圈[2]
//            $ch_chars = array_filter($ch_chars);    //删除空元素
//            $tag_array = @array_combine($tag_nos[1], $ch_chars);
//            if ($tag_array) {
//                foreach ($tag_array as $tag_no => $tag_name) {
//                    if (empty($tag_name)) {
//                        unset($tag_array[$tag_no]);
//                    } else {
//                        $_REQUEST['filter'][$tag_no] = Func_String::utf8($tag_name);
//                    }
//                }
//            }
//        }

    }

}