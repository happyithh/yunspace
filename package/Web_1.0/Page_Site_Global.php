<?php

/**
 * Created by PhpStorm.
 * User: 赵志超
 * Date: 15-4-29
 * Time: 下午7:46
 */
class Page_Site_Global extends Page_Base
{
    static $cacheTime = 3600;

    /*
     * 获取标签Id
     */
    static function tags()
    {
        return array(
//            '城市' => Data_Mysql_Table_Tags::getTagsId('基本信息>城市'),
//            '面积' => Data_Mysql_Table_Tags::getTagsId('基本信息>面积'),
//            '适合活动类型' => Data_Mysql_Table_Tags::getTagsId('基本信息>适合活动类型'),
//            '所属商圈' => Data_Mysql_Table_Tags::getTagsId('基本信息>所属商圈'),
//            '行政区域' => Data_Mysql_Table_Tags::getTagsId('基本信息>行政区域'),
//            '轨道交通' => Data_Mysql_Table_Tags::getTagsId('基本信息>轨道交通'),
//            '停车位' => Data_Mysql_Table_Tags::getTagsId('基本信息>停车位'),
//            '层高' => Data_Mysql_Table_Tags::getTagsId('基本信息>层高'),
//            '供电量' => Data_Mysql_Table_Tags::getTagsId('基本信息>供电量'),
//            '人数上限' => Data_Mysql_Table_Tags::getTagsId('基本信息>人数上限'),
//            '餐饮配套' => Data_Mysql_Table_Tags::getTagsId('基本信息>餐饮配套'),
//            '面积' => Data_Mysql_Table_Tags::getTagsId('基本信息>面积'),
//            '使用面积' => Data_Mysql_Table_Tags::getTagsId('基本信息>使用面积'),
//            '服务行业类型' => Data_Mysql_Table_Tags::getTagsId('基础信息>服务行业类型'),
//            '演出范围' => Data_Mysql_Table_Tags::getTagsId('基础信息>演出范围'),
            '城市' => 46,
            '适合活动类型' => 49,
            '所属商圈' => 2,
            '行政区域' => 4,
            '轨道交通' => 3,
            '停车位' => 5,
            '层高' => 6,
            '供电量' => 7,
            '人数上限' => 8,
            '餐饮配套' => 51,
            '面积' => 50,
            '使用面积' => 10,
            '服务行业类型' => 9,
            '演出范围' => 36,
        );
    }

    static function tagsName($name)
    {
        $tags = self::tags();
        return $tags[$name];
    }


    static function set(
        $key_data,
        $value,
        $cacheTime = 3600
    ) {
        $key = is_array($key_data) ? json_encode($key_data) : $key_data;
        if (empty($key)) {
            return false;
        }
        $key = md5($key);
        $data = array(
            's_key' => $key,
            's_value' => $value,
            's_cache_time' => time() + intval($cacheTime),
        );
        $status = Data_Mysql_Table_Cache_Array::select('id,s_key',
            array('s_key' => $key));
        if (!empty($status[0]['id'])) {
            $data['id'] = $status[0]['id'];
        }
        Data_Mysql_Table_Cache_Array::update($data);

    }

    static function get($key_data)
    {

        $key = is_array($key_data) ? json_encode($key_data) : $key_data;
        if (empty($key)) {
            return false;
        }
        $conditions['s_key'] = md5($key);
        $conditions[] = 's_cache_time >' . time();
        $data = Data_Mysql_Table_Cache_Array::select('s_value,s_cache_time',
            $conditions);
        if (!empty($data[0]['s_value'])) {
            return json_decode($data[0]['s_value'], 1);
        }
        return false;
    }

//    static function displayMedia($media, $width = '', $height = '', $stamp = '')
//    {
//        if (!$width || strpos($media, '://')) {
//            return $media;
//        }
//        $width .= '_' . intval($height);
//        if ($stamp) {
//            $width .= '_' . $stamp;
//        }
//        $p = strpos($media, 'upload/');
//        if ($p === false) {
//            return $media;
//        }
//        if (empty($_REQUEST['is_local_env'])) {
//            return 'http://s2.yunspace.com.cn/uploads/' . $width . '/' . str_replace(array('//'), array('/',), substr($media, $p + 7));
//        } else {
//            return Core::$urls['root'] . 'uploads/' . $width . '/' . str_replace(array('//'), array('/',), substr($media, $p + 7));
//        }
//    }

    static function uploadHost()
    {
        if (empty($_REQUEST['is_local_env'])) {
            $host = "http://master.yunspace.com.cn";
        } else {
            $host = "http://yun.bb"; //可根据需要自行设置
        }
        return $host;
    }

    static function displayMedia(
        $media,
        $width = '',
        $height = '',
        $stamp = '',
        $del = ''
    ) {
        if (strpos($media, '://')) {
            if (strpos($media,
                '://www.yunspace.com.cn/upload/image/')) {
                return self::displayMedia(substr($media,
                    26), $width, $height, $stamp, $del);
            }
            return $media;
        }
        if (substr($media, 0, 4) == 'thc_') {
            $del = 'thc';
            $media = substr($media, 4);
        }
        if (!$width) {
            $path = explode('/', $media);
            $oldPath = Core::virtualPath('upload/') . $path[2] . "/" . $path[3];
            $img_info = getimagesize($oldPath);
            $width = $img_info[0];
            $height = $img_info[1];
        }

        $width .= '_' . intval($height);
        if ($stamp || $stamp == 0) {
            $width .= '_' . $stamp;
        }
        if ($del) {
            $width .= '_' . $del;
        }
        $p = strpos($media, 'upload/');
        if ($p === false) {
            return $media;
        }
        if (empty($_REQUEST['is_local_env'])) {
            return '/uploads/' . $width . '/' . str_replace(array('//'),
                array('/',), substr($media, $p + 7));
        } else {
            return Core::$urls['root'] . 'uploads/' . $width . '/' . str_replace(array('//'),
                array('/',), substr($media, $p + 7));
        }

    }

    static function displayLogo(
        $path,
        $width = '100',
        $height = '100',
        $stamp = ''
    ) {
        if (empty($path)) {
            $path = '/package/Web_1.0/interface/assets/public/nopic1.jpg';
        }
        if (strpos($path, '://')) {
            return $path;
        }
        $width .= '_' . intval($height);
        if ($stamp) {
            $width .= '_' . $stamp;
        }
        $p = strpos($path, 'upload/');
        if ($p === false) {
            return $path;
        }
        if (empty($_REQUEST['is_local_env'])) {
            return '/uploads/' . $width . '/' . str_replace(array('//'),
                array('/',), substr($path, $p + 7));
        } else {
            return Core::$urls['root'] . 'uploads/' . $width . '/' . str_replace(array('//'),
                array('/',), substr($path, $p + 7));
        }
    }


    static public $space_id = 112;

    static public $YunSpaceLogo = '/package/Web_1.0/interface/assets/img/logo_a.png';

    static function urlToCity()
    {
        $cityKey = explode('-', Core::$urls['action']);
        if (array_key_exists($cityKey[0],
            $_REQUEST['cities'])) {
            setcookie('city',
                $_REQUEST['cities'][$cityKey[0]],
                time() + 60 * 60 * 24 * 30,
                '/');        //更新城市
            setcookie('city_key', $cityKey[0],
                time() + 60 * 60 * 24 * 30,
                '/');        //更新城市
            $_COOKIE['city'] = $_REQUEST['cities'][$cityKey[0]];
            $_COOKIE['city_key'] = $cityKey[0];
        }
    }

    //返回给页面拼接后的URL
    static function concatUrlTags($tag_no, $tag_name = '')
    {
        $tag_nos = array();
        $ch_chars = array();
        $tag_array = array();
        $uri_a = urldecode(Core::$urls['path']);
        $uri_a = str_replace("\"><", '', $uri_a);
        $uri_a = str_replace("'", '', $uri_a);
        $uri_a = str_replace(">", '', $uri_a);
        $uri_a = str_replace("<", '', $uri_a);
        Core::$urls['path'] = urlencode($uri_a);
        $preuri = '/' . Core::$urls['route'] . $_COOKIE['city_key'] . '-' . Core::$urls['action'];  //拿到Uri前缀
        $uri = str_replace($preuri, '',
            urldecode(Core::$urls['path']));     //去除前缀，避免匹配到Action数字
        $suburi = $_COOKIE['city_key'] . '-' . Core::$urls['action'];

        $tag_name = self::urlEncodeTags(Func_String::utf8(trim($tag_name)));   //URL加密每个标签名
        if (strpos(urldecode($tag_name),
                '/') !== false
        ) {    //颁奖晚会/盛典
            list($tagl, $tagr) = explode('/',
                urldecode($tag_name));    //取出两边,加密后再拼接
            $tag_name = self::urlEncodeTags(Func_String::utf8(trim($tagl))) . '/' . self::urlEncodeTags(Func_String::utf8($tagr));
        }

        $uri_arr = explode('?',
            $uri);      //标签显示过滤掉Uri中的面积 ?size_range=200
        $uri_arr = explode('/', $uri_arr[0]);
        $last_path = end($uri_arr);
        if ($last_path != $_COOKIE['city_key']) {     //不是空间场地初始页面
            $ch_chars = explode('-', $uri_arr[1]);

            if (!empty($uri_arr[2]) && preg_match("/([\x{4e00}-\x{9fa5}]+)/u",
                    $uri_arr[2])
            ) {     //匹配中文  颁奖晚会/盛典
                $chs_arr = array_slice($uri_arr, 1, 2);
                $chs = implode('/', $chs_arr);
                $ch_chars = explode('-', $chs);
            }
            $ch_chars = array_filter($ch_chars);    //过滤已删除的空元素

        }

        preg_match_all('/-(49|9|4|2+)+/i', $uri,
            $tag_nos);     //匹配标签编号
        // preg_match_all("/([\x{4e00}-\x{9fa5}]+)/u", $uri, $ch_chars);

        if (!empty($tag_nos[1]) && !empty($ch_chars) && sizeof($tag_nos[1]) == sizeof($ch_chars)) {
            $tag_array = array_combine($tag_nos[1],
                $ch_chars);  //排序
        }

        if (!empty($tag_array)) {
            $tag_array = array_map(function ($tname) {
                if (strpos(urldecode($tname),
                        '/') !== false
                ) {    //颁奖晚会/盛典
                    list($tagl, $tagr) = explode('/',
                        urldecode($tname));    //取出两边,加密后再拼接
                    $tag_n = self::urlEncodeTags(Func_String::utf8(trim($tagl))) . '/' . self::urlEncodeTags(Func_String::utf8($tagr));
                } else {
                    $tag_n = self::urlEncodeTags(Func_String::utf8(trim($tname)));   //加密uri内的tag名
                }
                return $tag_n;
            }, $tag_array);
        }

        if (empty($tag_name)) {
            unset($tag_array[$tag_no]);     //移除已选条件
            unset($tag_no);
        }

        if (!empty($tag_array)) {
            $tag_keys = array_keys($tag_array);
            $tag_vals = array_values($tag_array);

            if ($tag_no == $tag_keys[0] && count($tag_keys) <= 1) {    //如果在同一个组标签内

                $suburi .= '-' . $tag_no . '-tags';  //拼接新的标签号
                $suburi .= '/' . $tag_name;

            } elseif (in_array($tag_no,
                    $tag_keys) && count($tag_keys) > 1
            ) {     //选择多个条件

                $tag_array[$tag_no] = $tag_name;    //替换新选中的值
                $tk = array_keys($tag_array);
                $tv = array_values($tag_array);
                $suburi .= '-' . implode('-',
                        $tk) . '-tags';
                $suburi .= '/' . implode('-', $tv);


            } else {    //不在同一个组标签内

                if (empty($tag_no) && empty($tag_name)) {
                    //修复多一个 - 号
                    $suburi .= '-' . implode('-',
                            $tag_keys) . '-tags';
                    $suburi .= '/' . implode('-',
                            $tag_vals);
                } else {
                    $suburi .= '-' . implode('-',
                            $tag_keys) . '-' . $tag_no . '-tags';
                    $suburi .= '/' . implode('-',
                            $tag_vals) . '-' . $tag_name;
                }

            }
        } elseif (empty($tag_no) && empty($tag_name)) {

            $suburi = $suburi;      //如果移除全部条件，就清空tag

        } else {

            $suburi .= '-' . $tag_no . '-tags';
            $suburi .= '/' . $tag_name;

        }

        if (!empty($_REQUEST['size_range'])) {
            $suburi .= (strpos($suburi,
                    '?') ? '&size_range=' : '?size_range=') . intval($_REQUEST['size_range']);        //绑定已选的场地面积
        }
        if (!empty($_REQUEST['orderBy'])) {
            $suburi .= (strpos($suburi,
                    '?') ? '&orderBy=' : '?orderBy=') . intval($_REQUEST['orderBy']);        //绑定已选的场地面积
        }
        return $suburi;

    }

    static function putTagsInRequest()
    {
        $uri_a = urldecode(Core::$urls['uri']);
        $uri_a = str_replace("\"><", '', $uri_a);
        $uri_a = str_replace("'", '', $uri_a);
        $uri_a = str_replace(">", '', $uri_a);
        $uri_a = str_replace("<", '', $uri_a);
        Core::$urls['uri'] = urlencode($uri_a);
        $preuri = '/' . Core::$urls['route'] . $_COOKIE['city_key'] . '-' . Core::$urls['action'];  //拿到Uri前缀
        $_REQUEST['category_id'] = Core::$urls['action'];
        $uri = str_replace($preuri, '',
            urldecode(Core::$urls['uri']));     //去除前缀，避免匹配到Action数字
        $uri_arr = explode('?',
            $uri);      //标签显示过滤掉Uri中的面积 ?size_range=200
        $uri_arr = explode('/', $uri_arr[0]);
        $last_path = end($uri_arr);

        if ($last_path != $_COOKIE['city_key']) {
            if (!empty($uri_arr[1])) {    //进入空间场地页面，没有选择全部
                $ch_arr = explode('-', $uri_arr[1]);

                if (!empty($uri_arr[2]) && preg_match("/([\x{4e00}-\x{9fa5}]+)/u",
                        $uri_arr[2])
                ) {     //匹配中文  颁奖晚会/盛典
                    $chs_arr = array_slice($uri_arr, 1, 2);
                    $chs = implode('/', $chs_arr);
                    $ch_arr = explode('-', $chs);
                }

                $ch_chars = array_map(function ($val) {
//                    $val = Func_String::RemoveXSS($val);
                    return trim(Func_String::utf8(urldecode(trim($val))));
                }, $ch_arr);

            }
        }

        preg_match_all('/-(49|9|4|2+)+/i', $uri, $tag_nos);
        if (!empty($tag_nos[1]) && !empty($ch_chars)) {
            // $request['activity']         活动类型[49]
            // $request['industry']         适合行业[9]
            // $request['adminarea']	    行政区域[4]
            // $request['businesscircle']   商圈[2]
            $ch_chars = array_filter($ch_chars);    //删除空元素
            $tag_array = @array_combine($tag_nos[1],
                $ch_chars);
            if ($tag_array) {
                foreach ($tag_array as $tag_no => $tag_name) {
                    if (empty($tag_name)) {
                        unset($tag_array[$tag_no]);
                    } else {
                        $_REQUEST['filter'][$tag_no] = Func_String::utf8($tag_name);
                    }
                }
            }
        }
    }

    static function urlEncodeTags($tname)
    {
        return (urlencode($tname) == $tname) ? $tname : urlencode($tname);
    }
}