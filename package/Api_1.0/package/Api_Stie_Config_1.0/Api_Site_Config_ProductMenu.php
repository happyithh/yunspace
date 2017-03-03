<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/21
 * Time: 13:47
 */
class Api_Site_Config_ProductMenu extends Api
{

    //获取所有菜单
    static function  getMenu()
    {
        $allCategory = Data_Mysql_Table_Product_Category::getTreeCache();
        $topCategory = $allCategory[0];
        unset($allCategory[0]);
//        $allAttr['超值套餐'] = array_values(Data_Mysql_Table_Product_Set::$category_name);
        $allMenu = array();
        foreach ($allCategory as $key => $val) {
            foreach ($val as $k => $v) {
                if ($v) {
                    $allMenu[$topCategory[$key]][$k] = $v;
                }
            }
        }
        $newMenu = array(
            '空间场地' => $allMenu['空间场地'],
            '硬体搭建' => $allMenu['硬体搭建'],
            '设备租赁' => $allMenu['设备租赁'],
            '多媒体制作' => $allMenu['多媒体制作'],
            '演出人力' => $allMenu['演出人力'],
            '物料制作' => $allMenu['物料制作'],
            '外烩餐饮' => $allMenu['外烩餐饮'],
        );
        return $newMenu;
    }
}