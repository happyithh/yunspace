<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/12/16
 * Time: 16:17
 */
class Web_Space_Search_New extends Web_Global
{

    static function handle()
    {
        Tpl_Smarty::assign("nav", 'site');
        if (strstr(Core::$urls['uri'], '/spaces')) {
            $preuri = '/spaces-';  //拿到Uri前缀\
        }
        $uri = str_replace($preuri, '', Func_Url::str_urldecode(Func_String::utf8(Core::$urls['uri'])));     //去除前缀，避免匹配到Action数字
        if(!empty($_REQUEST['keyword'])){
            $_REQUEST['keyword2'] = $_REQUEST['keyword'] ;
            unset($_REQUEST['keyword']);
        }
        if (strstr(Core::$urls['uri'], '/spaces-tags/')) {
            $uri = str_replace('tags/', '', $uri);
            Core::$urls['uri'] = '/space';
        } elseif (strstr(Core::$urls['uri'], '/spaces-tags')) {
            $uri = str_replace('tags', '', $uri);
            Core::$urls['uri'] = '/space';
        }else{
            $uri_arr = explode('?', $uri);
            // 获取前半部分的val值
            if (strstr($uri, 'tags')) {
                $tag_val = !empty(explode('tags/', $uri)[1])?explode('tags/', $uri)[1]:'';
                if (strstr($tag_val, '?')) {
                    $tag_val_1 = explode('?', $tag_val);  // 去除?之后的参数
                    $tag_val = explode('-', $tag_val_1[0]);
                } else {
                    $tag_val = explode('-', $tag_val);
                }
            } else {
                $tag_val = array();
            }
            // 获取前半部分的key值
            if (!empty($uri_arr[0])) {
                if (!empty($tag_val)) {
                    $tag_arr = explode('-', explode('-tags/', $uri)[0]);
                } else {
                    $tag_arr = explode('-', $uri_arr[0]);
                }
            } else {
                $tag_arr = array();
            }

            // 城市处理
            $city = Web_Global::$city_name;
            if(empty($city[$tag_arr[0]])){
               $city_val = 'wod';
                $_REQUEST['city'] = '不限';
            }else{
                $city_val = $tag_arr[0];
                $_REQUEST['city'] = $city[$tag_arr[0]];
                array_shift($tag_arr);

            }

            // 翻转url前面的key，获取位置
            $key =array_flip($tag_arr);

            // 场地类型处理
            $category = Data_Mysql_Table_Spacepedia::getChildrenByCid(112);
            $category = array_flip($category);
            $category_val = 112;
            if(isset($key['category']) && !empty($tag_val[$key['category']])){
                if(!empty($category[$tag_val[$key['category']]])){
                    $category_val = $category[$tag_val[$key['category']]];
                }
                unset($tag_val[$key['category']]);
                unset($tag_arr[$key['category']]);
            }
            $_REQUEST['category'] =$category_val;

            // 面积处理
            if(isset($key['size']) && !empty($tag_val[$key['size']])){
                switch($tag_val[$key['size']]){
                        case '1':
                            $tag_val[$key['size']]='min';
                            break;
                        case '200':
                            $tag_val[$key['size']]='200,500';
                            break;
                        case '500':
                            $tag_val[$key['size']]='500,800';
                            break;
                        case '800':
                            $tag_val[$key['size']]='800,1000';
                            break;
                        case '1000':
                            $tag_val[$key['size']]='1000,2000';
                            break;
                        case '2000':
                            $tag_val[$key['size']]='2000';
                            break;
                    }
            }

            // 显示筛选条件处理
            $request = self::$key_deal;
            foreach($tag_arr as $k=>$v){
                if(!empty($request[$v]) && !empty($tag_val[$k])){
                    $_REQUEST[$request[$v]] = $tag_val[$k];
                }
            }
            array_unshift($tag_arr,$category_val);
            array_unshift($tag_arr,$city_val);

            if(!empty($tag_val)){
                Core::$urls['uri'] = '/space/'.implode('-',$tag_arr).'-tags/'.implode('-',$tag_val);
            }else{
                Core::$urls['uri'] = '/space/'.implode('-',$tag_arr);
            }
        }
        Web_Search_Item_List::getInstance();
        Web_Search_Item_List::display("Web_Static::search/search_list_2.2.tpl");
        die();
    }
    // 参数url标识
    static $key_deal = array(
        '2' => 'business_area',
        '4' => 'admin_area',
        '9' => 'industry_type',
        '49' => 'active_type',
        'people' => 'people_range',
        'size' => 'size_range',
        'outside' => 'is_outside',
        'rank' => 'rank',
        'price' => 'price_range',
    );
}