<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/26
 * Time: 22:05
 */
ini_set("auto_detect_line_endings", true);
set_time_limit(0);

class B2B_Admin_Import
{
    static function importVendor()
    {
        $c = 0;
        $csvFiles = glob(dirname(__FILE__) . '/_Import/vendor*');
        foreach ($csvFiles as $file) {
            $handle = fopen($file, 'r');
            while ($r = fgetcsv($handle, 1024, ';')) {
                $r = explode('||||', Func_String::utf8(implode('||||', $r)));
                $cid = intval($r[0]);
                if ($cid) {
                    $cids = explode('|', $r[0]);
                    foreach ($cids as $k => $v) {
                        $cids[$k] = intval($v);
                    }
                    $data = array(
                        'vendor_name' => trim($r[3]),
                        'categories_id' => implode(',', $cids),
                        'base_info' => array(
                            '公司电话' => trim($r[4]),
                            '公司传真' => trim($r[5]),
                            '主要联系人' => trim($r[6]),
                            '联系方式' => strtr(trim($r[7]), '|', ','),
                        ),
                        'attr' => array(
                            '服务范围' => strtr(trim($r[1]), '|', ','),
                            '城市' => strtr(trim($r[2]), '|', ','),
                        ),
                        'attr_index' => array(
                            '服务范围' => strtr(trim($r[1]), '|', ','),
                            '城市' => strtr(trim($r[2]), '|', ','),
                        )
                    );
                    $r = Data_Mysql_Table_Vendor_Info::insert($data);
                    if ($r[0]) {
                        $c++;
                    }
                }
            }
            fclose($handle);
            if ($c > 10) {
                @rename($file, str_replace("vendor-", '__vendor-', $file));
            }
        }
        q("成功导入{$c}条记录.", $csvFiles);
    }

    static function importProduct()
    {
        $c = $j = 0;
        $csvFiles = glob(dirname(__FILE__) . '/_Import/product*');
        foreach ($csvFiles as $file) {
            $handle = fopen($file, 'r');
            $category_id = intval(substr(basename($file), 8));
            while ($r = fgetcsv($handle, 4096, ';')) {
                $j++;
                $r = explode('||||', Func_String::utf8(implode('||||', $r)) . '||||||||||||||||||||');
                if ($j > 1) {
                    $vendorData = array(
                        'vendor_name' => trim($r[1]),
                        'categories_id' => $category_id,
                        'base_info' => array(
                            '公司地址' => trim($r[0]) . ' ' . trim($r[14]) . ' ' . trim($r[15]),
                            '主要联系人' => trim($r[16]),
                            '联系方式' => strtr(trim($r[18]), ';', ','),
                        ),
                        'attr' => array(
                            '城市' => strtr(trim($r[0]), ';', ','),
                        ),
                        'attr_index' => array(
                            '城市' => strtr(trim($r[0]), ';', ','),
                        )
                    );
                    if (empty($vendorData['vendor_name'])) {
                        continue;
                    }
                    $rs = Data_Mysql_Table_Vendor_Info::insert($vendorData);
                    if (!empty($rs[0])) {
                        $vendorId = $rs[0];
                    } else {
                        $rs = Data_Mysql_Table_Vendor_Info::select("id", array("vendor_name = ?" => $vendorData['vendor_name']), '', 1);
                        if (empty($rs)) {
                            continue;
                        }
                        $vendorId = $rs[0]['id'];
                    }
                    $data = array(
                        'vendor_id' => $vendorId,
                        'product_name' => trim($r[1]),
                        'category_id' => $category_id,
                        'price' => ($r[3] ? intval($r[3]) : intval($r[2])) * 100,
                        'addr' => trim($r[15]),
                        'attr' => array(
                            '城市' => trim($r[0]),
                            '市场价' => intval($r[2]),
                            '价格单位' => '元/天',
                            '基本信息>所属商圈' => strtr(trim($r[9]), ';', ','),
//                            '基本信息>轨道交通' => '',
                            '基本信息>行政区域' => strtr(trim($r[14]), ';', ','),
                            '基本信息>停车位' => intval($r[10]),
//                            '基本信息>层高' => strtr(trim($r[2]), ';', ','),
//                            '基本信息>供电量' => strtr(trim($r[2]), ';', ','),
                            '基本信息>人数上限' => intval($r[6]),
                            '基本信息>面积' => intval($r[5]),
                            '基本信息>适合活动类型' => strtr(trim($r[7]), ';', ','),
                            '基本信息>餐饮配套' => strtr(trim($r[11]), ';', ','),
                        ),
                        'des' => trim($r[12]),
                        'memo' => "设备配置:{$r[8]}\n\n特殊说明:{$r[13]}\n\n备注:{$r[17]}",
                    );
                    $data['attr_index'] = Data_Mysql_Table_Product_Info::attrToIndex($data['attr']);
                    $r = Data_Mysql_Table_Product_Info::insert($data);
                    if ($r[0]) {
                        $c++;
                    }
                }
            }
            fclose($handle);
            if ($c > 10) {
                @rename($file, str_replace("vendor-", '__vendor-', $file));
            }
        }
        q("成功导入{$c}条记录.", $csvFiles);
    }

    static function importEvent()
    {
        $citys = array(
            '上海市' => '上海',
            '北京市' => '北京',
            '广东省' => '广州',
            '浙江省' => '杭州',
            '四川省' => '成都',
            '深圳市' => '深圳',
        );
        $sql = "SELECT * FROM casestudy LEFT JOIN product ON  product.product_id=casestudy.space_id LEFT JOIN provider ON provider.provider_id = casestudy.provider_id LIMIT 1000";
        $dh = Data_Mysql_Table_Product_Info::query($sql);
        $rs = $dh->fetchAll();
        if (!empty($rs)) {
            foreach ($rs as $r) {
                $attr = array(
                    '类型' => $r['event_type'],
                    '品牌' => $r['event_brand'],
                    '省份' => $r['Province'],
                    '城市' => !empty($r['product_city']) ? $r['product_city'] : $r['City'],
                );
                if (!empty($citys[$attr['省份']])) {
                    $attr['城市'] = $citys[$attr['省份']];
                }
                $media = explode(';', $r['event_picurl']);
                foreach ($media as $k => $v) {
                    $media[$k] = array('path' => 'http://www.yunspace.com.cn/upload/image/' . $v);
                }
                $i = rand(50, 150);
                $data = array(
                    'category_id' => 0,
                    'event_name' => $r['event_name'],
                    'event_time' => strtotime(strtr($r['event_date'], '.', '-')),
                    'addr' => !empty($r['provider_addess']) ? $r['provider_addess'] : $r['product_add'],
                    'logo' => "http://www.yunspace.com.cn/upload/image/small_index_casestudy_{$r['event_id']}.jpg",
                    'attr' => $attr,
                    'attr_index' => $attr,
                    'media_num' => count($media),
                    'media' => $media,
                    'des' => $r['event_text'],
                    'counter_view_index' => $i,
                    'counter_view' => $i,
                    'create_time' => $r['updateTime'],
                    'status' => 1,
                );
                if (!$data['event_time']) {
                    $data['event_time'] = $r['updateTime'];
                }
                $event = Data_Mysql_Table_Event_Info::insert($data);
                if ($event[0]) {
                    Data_Mysql_Table_Event_Case::insert(array(
                        'event_id' => $event[0],
                        'case_name' => $data['event_name'],
                        'product_name' => $r['product_name'],
                        'vendor_name' => $r['provider_name'],
                    ));
                }
            }
        }
    }
} 