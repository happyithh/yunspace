<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/26
 * Time: 16:24
 */
class Data_Mysql_Table_Search_Space_Item extends Data_Mysql_Table
{
    public $cols = array(
        'item_id' => 'int',  // 子空间ID
        'baike_id' => 'int',  // 百科ID
        'baike_item_name' => '200', // 百科+子空间名称
        'city' => '20',      // 城市
        'logo' => '200',      // 子空间logo
        'baike_des'=>'text',
        'baike_logo' => '200',
        'baike_mobile_logo' => '200',
        'item_media' => 'array',
        'order_index'=> 'int',  // 指数
        'tags_new' => '200',  //空间标签
        'past_case' => 'text', //过往案例/适合活动
        'is_outside' => 'int', //是否户外
        'contacts' => '50', // 子空间联系人
        'phone' => '11',        // 联系电话
        'category_id' => 'int',
        'facility' => 'string',  //配套设施
        'addr' => 'string',
        'min_people' => 'int',   // 最小容纳人数
        'max_people' => 'int',   // 最大容纳人数
        'parking_space' => 'string', //停车位
        'level' => 'int',   //   默认为0 A:4 B:3 C:0 D:-1 E:-2
        'size' => 'int',  // 空间面积
        'click'=>'int',  //浏览量
        'item_status' => 'int',
        'baike_status' => 'int',
        'baike_update_time' => 'int',
        'item_update_time' => 'int',
        'item_create_time'=>'int',
        'update_time' => 'int',
        'baike_min_people'=>'int', // 百科下最小容纳量
        'baike_max_people'=>'int', // 百科下最大容纳量
        'baike_min_size'=>'int', // 百科下最小面积
        'baike_max_size'=>'int', // 百科下最大面积
        'item_count'=>'int' ,  // 百科下的空间总数
        'min_price'=>'int', // 百科下的最低价
        'max_price'=>'int', // 百科下的最高价
        'min_price_B'=>'int', // 百科下的最低价（换算后的平均价格）
        'max_price_B'=>'int', // 百科下的最高价（换算后的平均价格）
        'price_unit'=>'50', // 价格单位
//        'active_type'=>'string',  // 适合活动类型
        'geo_lat' => 'int',
        'geo_lng' => 'int',
        'attr'=>'array',  // 行政区域、所属商圈、活动类型、行业类型信息
        'type_level'=>'int', //场地级别 2:核心场地 3:自营场地 0:其他
        'business_area'=>'200',  //所属商圈，单独拿出来
        'item_min_price'=>'int', //子空间老数据下的最小价格
        'item_max_price'=>'int', //子空间老数据下的最大价格
        'item_price_unit'=>'', //子空间老数据下的价格单位
    );
    public $index = array(
        'item_id' => 'u',  // 子空间ID
        'baike_id' => 'i',  // 百科ID
        'baike_item_name,addr,business_area' => 'title', // 子空间名称
        'city' => 'i',      // 城市
        'area' => 'i',      // 区域
        'facility' => 'attr',  //配套设施
        'category_id' => 'i',
//        'addr' => 'title',
        'size' => 'i',
        'baike_size' => 'i',
        'item_status' => 'i',
        'baike_status' => 'i',
        'tags_new' => 'attr',  //空间标签
        'contain_person' => 'i',  // 容纳人数
        'parking_space' => 'i',
        'past_case' => 'title', //过往案例/适合活动
        'is_outside' => 'i', //是否户外
        'contacts' => 'title', // 子空间联系人
        'phone' => 'i',        // 联系电话
        'order_index'=>'i',
        'click'=>'i',
        'baike_update_time' => 'i',
        'item_update_time' => 'i',
        'update_time' => 'i',
        'min_people' => 'i',
        'max_people' => 'i',
        'item_count'=>'i' ,  // 百科下的空间总数
        'attr'=>'attr',
        'type_level'=>'i', //场地级别 2:核心场地 1:自营场地 0:其他
    );

    // 配套设施
    static $facility = array(
        14 => '卫手间',
        13 => '化妆间',
        12 => '休息室',
        17 => '空调暖气',
        18 => '网路WIFI',
        19 => '货运电梯',
        20 => '投影LED',
        21 => '灯光音响',
    );

    // 空间标签
    static $tags_new = array(
        1 => '交通便利',
        2 => '露台',
        3 => '游乐',
        4 => '江景',
        5 => '草坪',
        6 => '花园',
        7 => '建筑风格',
        8 => '游泳池',
        9 => '烧烤',
        10 => '住宿',
//        11 => '露台',
        12 => '餐饮',
        13 => '亲子',
        14 => '广场',
        15 => '音乐厅',
        16 => '篮球馆',
        17 => '无柱',
        18 => '水上舞台',
        19 => '试驾场地',
        20 => '世博园区',
    );

    //行业类型
    static $industry_attr = array(
        "通用",
        "医药",
        "IT类",
        "工业类",
        "公益事业",
        "教育",
        "通讯",
        "游戏",
        "动漫",
        "旅游",
        "影视",
        "时尚",
        "文体娱乐",
        "音乐",
        "政府"
    );

    // 获取行政区域
    static function getArea($condition){
//        Data_Mysql_Table_Search_Space_Item::debug(1);
        $attr = Data_Mysql_Table_Search_Space_Item::select('attr',$condition,'GROUP BY baike_id ORDER BY baike_update_time DESC',200);
        if(!empty($attr)){
            foreach($attr as $k=>$v){
                $att= json_decode($v['attr'],1);
                $attrNew['行政区域'][] = $att['行政区域'];
            }

            $attrNew['行政区域'] = array_filter($attrNew['行政区域']);
            // 过滤只有1-2个场地的行政区域
            foreach(array_count_values($attrNew['行政区域']) as $k=>$v){
                if($v<=2){
                    if(isset(array_keys($attrNew['行政区域'],$k)[1])){
                        unset($attrNew['行政区域'][array_keys($attrNew['行政区域'],$k)[1]]);
                    }
                    unset($attrNew['行政区域'][array_keys($attrNew['行政区域'],$k)[0]]);

                }
            }
            $attrNew['行政区域'] = array_count_values($attrNew['行政区域']);
            uasort($attrNew['行政区域'], 'cmp');
            $attrNew['行政区域'] = array_keys($attrNew['行政区域']);
            return $attrNew;
        }
    }
    // 获取所属商圈
    static function getBusinessArea($condition){
        $attr = Data_Mysql_Table_Search_Space_Item::select('attr',$condition,'GROUP BY baike_id ORDER BY baike_update_time DESC',300);
        if(!empty($attr)){
            foreach($attr as $k=>$v){
                $att= json_decode($v['attr'],1);
                if(strstr($att['所属商圈'],',')){
                    $att['所属商圈'] = explode(',',$att['所属商圈']);
                }
                $businessArea[] = $att['所属商圈'];
            }
            $businessArea = array_filter($businessArea);
            $attrNew['所属商圈'] = array();
            if(!empty($businessArea)){
                foreach($businessArea as $k=>$v){
                    if(is_array($v)){
                        foreach($v as $vv){
                            $attrNew['所属商圈'][] = $vv;
                        }
                    }else{
                        $attrNew['所属商圈'][] = $v;
                    }
                }
                // 过滤只有1-2个场地的商圈
                foreach(array_count_values($attrNew['所属商圈']) as $k=>$v){
                    if($v<=2){
                        if(isset(array_keys($attrNew['所属商圈'],$k)[1])){
                            unset($attrNew['所属商圈'][array_keys($attrNew['所属商圈'],$k)[1]]);
                        }
                        unset($attrNew['所属商圈'][array_keys($attrNew['所属商圈'],$k)[0]]);

                    }
                }
                $attrNew['所属商圈'] = array_count_values($attrNew['所属商圈']);
                uasort($attrNew['所属商圈'], 'cmp');
            }
            $attrNew['所属商圈'] = array_keys($attrNew['所属商圈']);
            return $attrNew;
        }
    }

}
// 按数量多少排序
function cmp($a,$b){
    if ($a == $b) {
        return 0;
    }
    return ($a < $b) ? 1 : -1;
}

