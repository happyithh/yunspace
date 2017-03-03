<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15/7/22
 * Time: 11:41
 * @活动需求选项
 */
class Data_Demand_Option_Config extends Data_Config
{
    /**
     * @var array
     * 消息系统  需求管理 用到了
     *
     *
     *
     */
    public $all = array(
        'people' => array(
            1 => '50人以下',
            2 => '50-100人',
            3 => '100-300人',
            4 => '300-500人',
            5 => '500人以上',
        ),
        'budget' => array(
            1 => '1万以下',
            2 => '1-5万',
            3 => '5-10万',
            4 => '10-20万',
            5 => '20-50万',
            6 => '50万以上',
        ),
        'demand_type' => array(
            '场地套餐',
            '空间场地',
            '配套服务',
            '供应商加盟',
        ),
    );
}
