<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 16-6-22
 * Time: 下午14:54
 * 脚本文件
 */
class Api_Import_New extends Api{

    //如果product_info名称存在与百科表中，更新product_info的have_space字段
    static function updateProductHaveSpace($id){
        $condition["id > ?"]=$id;
        $condition["status"]=1;
        $data=Data_Mysql_Table_Product_Info::select('id,product_name',$condition,'',100);
        if(empty($data)){
            q("已结束");
        }
        foreach($data as $k=>$v){
            $id=$v['id'];
            $rs=Data_Mysql_Table_Spacepedia::select('id',array('space_name = ?'=>$v['product_name'],'status'=>1));
            if(!empty($rs[0]['id'])){
                Data_Mysql_Table_Product_Info::query("update {table} set have_space = ? where id = ?",array(1,$v['id']));
            }
        }
        return $id;
    }
    
}