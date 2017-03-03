<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/22
 * Time: 18:36
 * 广告
 */
class Data_Mysql_Table_Pa extends Data_Mysql_Table
{
    public $cols = array(
        'rank' => 'int',  // 排列顺序
        'site_id' => 'int', // 广告位ID
        'city' => '50', // 投放城市
        'price' => '200',  // 广告价格
        'company' => '200',  // 投放公司
        'contact' => '100',  // 联系人
        'phone'=>'11', // 联系电话
        'email' => 'email',  // 联系邮箱
        'advertising_title'=>'100',  // 广告标题
        'advertising_link'=>'300', //广告链接
        'content'=>'500',  // 广告内容
        'note'=>'500',  // 备注
        'path'=>'300',//图片路径
        'status'=>'int',  // 状态 1 上架 -1 下架
        'default_adver'=>'int',  // 默认广告 0 否 1 是
        'click_counter'=>'int', //浏览量
        'display_counter'=>'int', //展示量
        'start_time' => 'int', // 广告有效期 开始时间
        'end_time' => 'int', // 广告有效期 结束时间
        'update_time'=>'int',
        'create_time'=>'int',

    );
    public $index = array(
        'default_adver,rank' => 'i',  // 排列顺序
        'city' => 'i', // 投放城市
        'company' => 'i',  // 投放公司
        'phone'=>'i', // 联系电话
        'status'=>'i',  // 状态 1 上架 2 下架
        'start_time,end_time' => 'i', // 广告有效期 开始时间
    );
    public $title = array(
        'rank' => '排列顺序',  // 排列顺序
        'type_id' => '广告类型ID', // 广告类型ID
        'site'=>'广告位置',  // 广告位置
        'city' => '投放城市', // 投放城市
        'price' => '广告价格',  // 广告价格
        'company' => '投放公司',  // 投放公司
        'contact' => '联系人',  // 联系人
        'phone'=>'联系电话', // 联系电话
        'email' => '联系邮箱',  // 联系邮箱
        'advertising_title'=>'广告标题',  // 广告标题
        'advertising_link'=>'广告链接', //广告链接
        'content'=>'广告内容',  // 广告内容
        'note'=>'备注',  // 备注
        'status'=>'状态',  // 状态 1 上架 2 下架

    );
    static function getSize()
    {
        $res = Data_Mysql_Table_Pa_Site::select('id,site', '', '', 999);
        return $res;
    }
}