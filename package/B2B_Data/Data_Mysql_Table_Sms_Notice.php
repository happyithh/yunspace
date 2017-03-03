<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/6/18
 * Time: 11:12
 */

/**
 * 短信通知设置
 *
 */
class Data_Mysql_Table_Sms_Notice extends Data_Mysql_Table
{
    public $cols = array(
        'name' => '200',
        'contact' => '200',
        'city' => '20',
        'status' => 'int',
        'create_time' => 'int',
        'update_time' => 'int',
        'cancel_time' => 'int',
    );
    public $index = array(
        'city' => 'i',
        'name' => 'i'
    );
    public static $noticeType = array(
        '1' => '默认',
        '3' => '办活动',
        '4' => '整体方案',
        '5' => '订单转发',
        '6' => '供应商加盟',
        '7' => '实地看场',
        '8' => '预约咨询',
        '9' => '客户人工服务',
        '10' => '供应商人工客服',
        '11' => '客服部',
        '12' => '销售部',
        '13' => '市场部',
        '14' => '销售部KA客户通知',
        '15' => '销售部标准客户通知',
        '16' => '邮件地址',
        '17' => '财务部',
        '18' => '产品档期查询',
        '19' => '套餐档期查询',
    );

    static function getNotice($type, $city)
    {
        $res = Data_Mysql_Table_Sms_Notice::select("*",array('name =?'=>$type,'city =?'=>$city,'status =?'=>1));
        if (!empty($res)) {
            return $res[0]['contact'];
        } else {
            return false;
        }
    }
}