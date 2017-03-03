<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/14
 * Time: 19:35
 */
class Data_Mysql_Table_Integral_Record extends Data_Mysql_Table
{
    public $cols = array(
        'demand_id' => 'int',
        'account_id' => 'int',
        'integral' => 'int',
        'intro' => '100', //事项
        'create_time' => 'int',
    );

    public $index = array(
        'integral,intro' => 'i'
    );

//    /**
//     * @param $min
//     * @param $max
//     * @param $type
//     * @return int
//     *处理价格所对应的积分
//     */
//    static function  handlePriceIntegral($min, $max, $type = '')
//    {
//        if ($max <= 20000 && ($min < $max)) {
//            $integral = 10;
//        } elseif ($min >= 20000 && $max <= 50000 && ($min < $max)) {
//
//            $integral = 20;
//
//        } elseif ($min >= 50000 && $max <= 100000 && ($min < $max)) {
//            $integral = 30;
//        } elseif ($min >= 100000) {
//
//            $integral = 50;
//
//        } elseif ($max != 0 && $max <= 50000) {
//            $integral = 20;
//        } elseif ($max != 0 && $min <= 50000) {
//            $integral = 30;
//        } else {
//            $integral = 1;
//        }
//        switch ($type) {
//            case '一键租场地':
//                $integral = $integral + 20;
//                break;
//
//        }
//        return $integral;
//
//    }

    /**
     * @param $min
     * @param $max
     * @param string $type
     * @return int
     * 积分处理
     * 1. 以最大价格计算最接近的积分
     * 2、 2万 以下就是1积分
     */
    static function handlePriceIntegral($min, $max, $type = '')
    {
        if ($max < $min) {
            $max = $min;
        }
        if ($max > 20000) {
            //存放积分
            $arrVal = array(20000 => 10, 30000 => 20, 50000 => 30, 100000 => 50, 200000 => 60);
            //匹配key
            $arrKey = array(20000, 30000, 50000, 100000, 200000);
            $count = count($arrKey);
            for ($i = 0; $i < $count; $i++) {
                $arr2[] = abs($max - $arrKey[$i]);
            }
            $min_a = min($arr2);
            for ($i = 0; $i < $count; $i++) {
                if ($min_a == $arr2[$i]) {
                    $key = $arrKey[$i];
                }
            }
            $integral = $arrVal[$key];
        } else {
            $integral = 10;
        }

        switch ($type) {
            case '一键租场地':
                $integral = $integral + 20;
                break;
        }
        return $integral;
    }

}