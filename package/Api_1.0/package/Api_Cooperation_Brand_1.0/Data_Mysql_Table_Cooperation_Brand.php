<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/3
 * Time: 15:54
 * 合作品牌
 */
class Data_Mysql_Table_Cooperation_Brand extends Data_Mysql_Table {
   public $cols = array(
       'title' =>'200',  //品牌名称
       'attr' =>'array', //品牌信息
       'des' =>'html',   //简介
       'brand_pic'=>'array', //品牌图片
       'brand_case'=>'array', //品牌案例
       'logo' => '100',    //品牌logo
       'mobile_logo' => '100', //移动端banner
       'content'=>'html',  //品牌详情
       'status'=>'int',  // 0 下线; 1 上线; -1 删除
       'create_time'=>'int',
       'update_time'=>'int',
       'click'=>'int',   // 浏览量
       'is_good'=>'int',
       'type' =>'int',   // 1 品牌管理数据 ; 1 ADM参展申请数据
   );
    public $index = array(
        'title'=>'title',
        'attr'=>'i',
        'status'=>'i',
        'create_time'=>'i',
        'update_time'=>'i',
        'type'=>'i'
    );
}