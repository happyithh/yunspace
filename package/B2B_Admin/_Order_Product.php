<?php

class B2B_Admin_Order_Product
{
    static $map = array(
        '适合活动类型' => array(
            '宴会' => '宴会会议',
            '聚餐' => '宴会会议',
            'party' => '主题派对',
            '发布会' => '商业发布',
            '700座位' => '演出戏剧',
            '演出，戏剧' => '演出戏剧',
            '画展' => '展览展示',
            '派对' => '主题派对',
            '会议' => '宴会会议',
            '表演' => '演场演出',
            '高端宴请' => '宴会会议',
            '年会' => '晚会年会',
            '品牌发布会/SHOW' => '商业发布',
            '派对/沙龙' => '主题派对',
            '拍摄/片场' => '文体娱乐',
            '展览/展会' => '展览展示',
            '论坛/培训' => '会议会务',
            '演出/戏剧' => '演场演出',
            '如：品牌发布会' => '商业发布',
            '汽车发布会' => '商业发布',
            '颁奖典礼' => '颁奖晚会/盛典',
            '企业年会' => '晚会年会',
            '' => '',
            '' => '',
        ),
        '上海' => array(
            '黄浦区' => '1', '徐汇区' => '1', '长宁区' => '1', '静安区' => '1', '普陀区' => '1', '闸北区' => '1', '虹口区' => '1', '杨浦区' => '1', '闵行区' => '1', '宝山区' => '1', '嘉定区' => '1', '浦东新区' => '1', '金山区' => '1', '松江区' => '1', '青浦区' => '1', '奉贤区' => '1'
        ),
        '北京' => array(
            '东城区' => '1', '西城区' => '1', '朝阳区' => '1', '海淀区' => '1', '丰台区' => '1', '石景山区' => '1', '门头沟区' => '1', '房山区' => '1', '大兴区' => '1', '通州区' => '1', '顺义区' => '1', '昌平区' => '1', '平谷区' => '1', '怀柔区' => '1', '密云县' => '1', '延庆县' => '1'
        ),
        '广州' => array(
            '越秀区' => '1', '东山区' => '1', '海珠区' => '1', '荔湾区' => '1', '天河区' => '1', '白云区' => '1', '黄埔区' => '1', '芳村区' => '1', ' 番禺区' => '1', '花都区' => '1'
        ),
        '成都' => array(
            '锦江区' => '1', '青羊区' => '1', '金牛区' => '1', '武侯区' => '1', '成华区' => '1', '高新区' => '1', '龙泉驿区' => '1', '温江区' => '1', '新都区' => '1', '青白江区' => '1', '双流县' => '1'
        ),
        '杭州' => array(
            '上城区' => '1', '下城区' => '1', '江干区' => '1', '拱墅区' => '1', '西湖区' => '1', '滨江区' => '1', '萧山区' => '1', '余杭区' => '1'
        ),
        '深圳' => array(
            '罗湖区' => '1', '福田区' => '1', '南山区' => '1', '盐田区' => '1', '宝安区' => '1', '龙岗区' => '1', '光明区' => '1', '坪山区' => '1', '龙华区' => '1', '大鹏区' => '1'
        )
    );
    static  function changeSize(){
        $rs = Data_Mysql_Table_Product_Info::select('*',99999999);
        foreach ($rs as $r) {
            $attr = json_decode($r['attr'], 1);
            //餐饮
            if (!empty($attr['基本信息>面积'])) {
                Data_Mysql_Table_Product_Info::update($r['id'], array(
                    'product_size' => $attr['基本信息>面积'],
                ));
            }
        }
    }
    static function handle()
    {
        $request = Func_Input::filter(array(
            'start_id' => 'int',
        ));
        $request['start_id'] or $request['start_id'] = 0;
        set_time_limit(0);
        $num = 1000;
        $attrHuoDong = Data_Config_Vendor_Attr::get('attr');
        $attrHuoDong = array_fill_keys($attrHuoDong['活动类型'], 1);
        $rs = Data_Mysql_Table_Product_Info::select('id, attr', array('id>?' => $request['start_id'], 'id<=?' => $request['start_id'] + $num), '', $num);
        foreach ($rs as $r) {
            $attr = json_decode($r['attr'], 1);
            //餐饮
            if (!empty($attr['基本信息>餐饮配套']) && $attr['基本信息>餐饮配套'] != '无') {
                $attr['基本信息>餐饮配套'] = '有';
            }
            //行政区域
            if (!empty($attr['城市']) && !empty($attr['基本信息>行政区域']) && empty(self::$map[$attr['城市']][$attr['基本信息>行政区域']])) {
                if (isset(self::$map[$attr['城市']][$attr['基本信息>行政区域'] . '区'])) {
                    $attr['基本信息>行政区域'] .= '区';
                } else {
                    unset($attr['基本信息>行政区域']);
                }
            }
            //乱码
            foreach ($attr as $k => $v) {
                if (strpos($v, '?') !== false) {
                    unset($attr[$k]);
                }
            }
            if (!(empty($attr['适合活动类型']))) {
                $attr['基本信息>适合活动类型'] = empty($attr['基本信息>适合活动类型']) ? $attr['适合活动类型'] : $attr['基本信息>适合活动类型'] . ',' . $attr['适合活动类型'];
                unset($attr['适合活动类型']);
            }
            //活动类型
            if (!empty($attr['基本信息>适合活动类型'])) {
                $tmp = explode(',', str_replace(array('、', ' ', '，'), ',', $attr['基本信息>适合活动类型']));
                foreach ($tmp as $k => $v) {
                    $v = trim($v);
                    if (!$v || is_numeric($v)) {
                        unset($tmp[$k]);
                    } else {
                        if (empty($attrHuoDong[$v])) {
                            if (empty(self::$map['适合活动类型'][$v])) {
                                if (strpos($v, '展') !== false) {
                                    $tmp[$k] = '展览展示';
                                    continue;
                                } elseif (strpos($v, '发布') !== false) {
                                    $tmp[$k] = '商业发布';
                                    continue;
                                } elseif (strpos($v, '演出') !== false || strpos($v, '表演') !== false || strpos($v, '戏剧') !== false || strpos($v, '音乐') !== false) {
                                    $tmp[$k] = '演场演出';
                                    continue;
                                } elseif (strpos($v, '促销') !== false || strpos($v, '商务') !== false) {
                                    $tmp[$k] = '商业发布';
                                    continue;
                                } elseif (strpos($v, '宴') !== false || strpos($v, '餐') !== false) {
                                    $tmp[$k] = '宴会会议';
                                    continue;
                                } elseif (strpos($v, '媒体') !== false || strpos($v, '选秀') !== false) {
                                    $tmp[$k] = '文体娱乐';
                                    continue;
                                } elseif (strpos($v, '派对') !== false || strpos($v, '沙龙') !== false || strpos($v, '聚会') !== false || strpos($v, '婚') !== false) {
                                    $tmp[$k] = '主题派对';
                                    continue;
                                }
                                unset($tmp[$k]);
                            } else {
                                $tmp[$k] = self::$map['适合活动类型'][$v];
                            }
                        } else {
                            $tmp[$k] = $attrHuoDong[$v];
                        }
                    }
                }
                $attr['基本信息>适合活动类型'] = implode(',', array_unique($tmp));
            }
//            q($attr);
            Data_Mysql_Table_Product_Info::update($r['id'], array(
                'attr' => $attr,
                'attr_index' => Data_Mysql_Table_Product_Info::attrToIndex($attr),
            ));
        }
        if (!empty($rs)) {
            Func_Header::to('', Core::$urls['path'] . '?start_id=' . ($request['start_id'] + $num));
        }
    }
}