<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/11
 * Time: 16:07
 */
class Data_Mysql_Table_Grab_Order extends Data_Mysql_Table
{
    public $cols = array(
        'sale_phone' => '15',            //销售手机号        9 代表报价系统
        'status' => 'tinyint',              //默认 0   关闭 -n
        'step' => 'int',
        'customer_phone' => '15', //客户手机           demand 表中的 phone
        'one_notice' => 'int',      //第一次通知时间
        'two_notice' => 'int',      //第二次通知时间
        'three_notice' => 'int',     // 第三次通知时间
        'four_notice' => 'int',       //第四次 给 客户发送短信
        'one_open' => 'int',
        'two_open' => 'int',
        'three_open' => 'int',
        'four_open' => 'int',
        'gather_offer_time' => 'int',     //收集报价
        'create_time' => 'int',
        'allot_time' => 'int',  //分配时间
        'update_time' => 'int',
        'is_holiday' => 'tinyint'
    );

    public $index = array(
        'sale_phone' => 'i',
        'create_time,status' => 'i',
        'is_holiday,status' => 'i',

    );
    public $title = array(
        '' => '需求ID'

    );

    /**
     * @param $data
     * @return mixed
     * 格式化数据
     */
    static function  format($data)
    {
        if (empty($data)) {
            return false;
        }
        foreach ($data as $key => $val) {
            if (empty($val['demand'])) {
                unset($data[$key]);
                continue;
            }
            $data[$key]['step'] = intval($val['step']);
            $demand = json_decode($val['demand'], 1);
            $data[$key]['demand'] = $demand;
            $data[$key]['end_time'] = ($val['create_time'] + 1200) - time();
            //分配剩余时间
            $data[$key]['end_allot_time'] = ($val['create_time'] + 4800) - time();
            $data[$key]['nick_phone'] = substr(@$val['phone'], 0, 3) . '****' . substr(@$val['phone'], 7, 10);
            $data[$key]['nick_username'] = mb_substr(@$demand['联系人'], 0, 1, 'utf-8') . '**';
            if (!empty($val['demand_create_time'])) {
                $data[$key]['demand_create_time'] = date('Y-m-d H:i', $val['demand_create_time']);
            }
            if (!empty($val['backup_demand'])) {
                $data[$key]['backup_demand'] = json_decode($val['backup_demand'], 1);
            }
            if (empty($demand['公司名称'])) {

                $data[$key]['demand']['公司名称'] = '暂无';
            }
            if (empty($demand['活动人数'])) {
                $data[$key]['demand']['活动人数'] = '暂无';
            }
            $day = false;
            //处理档期显示
            if (!empty($demand['结束时间'])) {
                $day = (strtotime(@$demand['结束时间']) - strtotime(@$demand['开始时间'])) / 86400;
                if ($day == 0) {
                    $day = 1;
                }
                $data[$key]['day'] = $day;
            }

            if (empty($day)) {
                $data[$key]['schedule'] = '自行协商';
            } else {
                $data[$key]['schedule'] = $day . '天,' . @$demand['开始时间'] . '至' . @$demand['结束时间'];
            }
            $priceString = '';
            if (!empty($val['price_up'])) {
                $priceString = $priceString . '￥' . $val['price_up'];
            }
            if (!empty($val['price_up']) && !empty($val['price_down'])) {
                $priceString = $priceString . '-';
            }
            if (!empty($val['price_down'])) {
                $priceString = $priceString . '￥' . $val['price_down'];
            }
            if (empty($priceString)) {
                $priceString = '面议';
            }
            $data[$key]['price'] = $priceString;
            unset($priceString);
            //标签处理  销售的私单标注  啥啥啥的
            if (!empty($val['mark_tags'])) {
                $mark_tags = $val['mark_tags'];
                $data[$key]['mark_tags'] = array();
                $tags_array = explode('|', $mark_tags);
                foreach ($tags_array as $k => $val) {
                    $data[$key]['mark_tags'][$val] = true;
                }
            }
        }
        return $data;
    }
} 