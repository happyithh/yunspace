<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/2/3
 * Time: 16:48
 * 获取文章列表
 */
class Api_Article_List_New extends Api{
    static function handle(){
        return self::getArticleList($_REQUEST);
    }
    static function getArticleList($args){
//        Data_Mysql_Table_Raiders_Info::debug(1);
        $data = Data_Mysql_Table_Raiders_Info::page(0,10,'id,title,logo,counter_view,counter_praise,author,create_time',array('status'=>1),'ORDER BY create_time DESC');
        if(!empty($data['rows'])){
            foreach($data['rows'] as $k=>$v){
                $data['rows'][$k]['id'] = Func_NumEncode::e($v['id']);
            }
            return self::request('success',$data['rows'],'数据获取成功！');
        }else{
            return self::request('success',$data['rows'],'没有更多数据！');
        }
    }
}