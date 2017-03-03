<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/11/9
 * Time: 15:30
 */

class Data_Mysql_Table_Annual_Meeting  extends Data_Mysql_Table{

      public  $cols = array(
          'space_name' => '200',                //场地名
          'item_name' => '200',                 //空间名
          'space_info' => '200',            //场地简介
          'space_des'=>'html',      //c场地详情
          'list_img'=>'string',     //列表图片
          'recommend_img'=>'string',    //推荐图片
          'info_img'=>'array',      //详情图片轮播
          'category'=>'string',//分类
          'status'=>'tinyint',  //状态
          'start_time'=>'string',   //开始时间
          'end_time'=>'string',     //结束时间
          'old_price'=>'string',       //原价
          'new_price'=>'string',        //yun价格
          'remarks'=>'string',      //价格备注
          'start_seat'=>'int',      //最少桌数
          'max_seat'=>'int',        //最多桌数
          'annual_des'=>'html',     //套餐详情
          'book_des'=>'html',       //预定须知
          'create_time'=>'int',
          'update_time'=>'int',
          'city'=>'string',         //城市
          'addr'=>'string',         //地址
          'geo_lat' => 'int',
          'geo_lng' => 'int',
          'area'=>'int',
          'is_outside'=>'int',
          'admin_id'=>'int',        //最后修改人id
          'admin_name'=>'string'//最后修改人姓名
      );
    public $index = array(
        'space_name' => 'i',
        'item_name' => 'i',
    );
} 