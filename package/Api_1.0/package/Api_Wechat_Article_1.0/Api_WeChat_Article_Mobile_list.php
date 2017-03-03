<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/14
 * Time: 15:24
 *
 * 微信文章列表
 *
 */
class Api_WeChat_Article_Mobile_list extends Api{
    static function handle(){
       return self::articleList();
    }
   static function articleList(){
        $condition[]="status IN (0,1,2)";
        $condition['is_bad <?'] = 2;
//       q($condition);
//       Data_Masql_Table_WeChat_Article::debug(1);
        $data = Data_Masql_Table_WeChat_Article::page(0,15,'*',$condition,'ORDER BY article_time DESC');
        return $data;
    }
}