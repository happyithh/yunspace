<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/3
 * Time: 15:54
 * 品牌入驻表单
 */
class Data_Mysql_Table_Brand_Form extends Data_Mysql_Table {
   public $cols = array(
       'company' =>'200',  //公司名称
       'brand' =>'200', //品牌名称
       'mode' =>'50',   //开店方式
       'number'=>'int', //开店数量
       'contacts'=>'50', //联系人
       'phone' => '11',    //联系电话
       'status'=>'int',  // 0 正常;-1 删除
       'create_time'=>'int',
       'update_time'=>'int',
   );
    public $index = array(
        'company,brand,contacts'=>'title',
        'mode'=>'i',
        'number'=>'i',
        'phone'=>'i',
        'status'=>'i',
        'create_time'=>'i',
        'update_time'=>'i'
    );
}