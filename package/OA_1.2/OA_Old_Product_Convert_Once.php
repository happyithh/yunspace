<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 16-3-14
 * Time: 下午2:26
 * 一键转换旧场地为场地百科
 */

//转换中间表，用完可删除
class Data_Mysql_Table_Convert_Temp extends Data_Mysql_Table{
    public $cols = array(
        'space_id'=>'int',              // 百科ID
        'space_name'=>'100',              // 百科名称
        'product_id'=>'int',              // 产品ID
        'product_name'=>'100',              // 产品名称
        'create_time'=>'int',
    );
    public $index=array(
        'space_id'=>'u',
        'product_id'=>'u',
        'space_name,product_name'=>'title',
    );
}

class OA_Old_Product_Convert_Once{
      static function handle(){
          $action=empty($_REQUEST['action'])?"list":$_REQUEST['action'];
          switch($action){
              case "list":
                  self::getConvertList();
                  break;
              case "convert":
                  $msg=OA_Import_New::convertOldProduct();
                  Tpl_Smarty::assign('msg',$msg);
                  self::getConvertList();
                  break;
          }
      }

    //获取转换列表
    static function getConvertList(){
        $condition=array();
        if(!empty($_REQUEST['title'])){
//            $condition[]='(space_name = "'.$_REQUEST['title'].'" OR product_name = "'.$_REQUEST['title'].'")';
            $condition['space_name']=$_REQUEST['title'];
            $condition['product_name']=$_REQUEST['title'];
        }
        $data=Data_Mysql_Table_Convert_Temp::page(0,20,'*',$condition,'ORDER BY create_time DESC');
        Tpl_Smarty::assign('_data',$data);
        Tpl_Smarty::display('OA_Static',"spacepedia/convert_once.tpl");
    }

}