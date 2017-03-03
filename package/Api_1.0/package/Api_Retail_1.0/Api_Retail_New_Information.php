<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/4
 * Time: 17:08
 * 品牌合作内页-》最新资讯
 */
class Api_Retail_New_Information extends Api{
    static function newInformation($args=array()){
        $conditions['status = ?']=1;
//        $conditions['baike_category_id=?']=400;
        $conditions['baike_cid']=400;
        $conditions['space_ids =?'] =10644;
        if(isset($args['id']) && !empty($args['id'])){
            $conditions['id !=?'] =$args['id'];
        }
        $data = Data_Mysql_Table_Raiders_Info::select('id,title',$conditions,'ORDER BY create_time DESC',8);
        return $data;
    }
}