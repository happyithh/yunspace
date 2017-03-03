<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 16-1-18
 * Time: 上午11:54
 */
class Api_Topic_List extends Api{

    //获取专题列表
    static function getTopicList($condition=array(),$page=0,$page_num=0,$page_size=20,$limit=10){
        $rs=array();
        $cols='*';
        $table='{table}';
        $order='ORDER BY update_time DESC';
        if(!empty($page)){
            $rs=Data_Mysql_Table_Topic::page($page_num,$page_size,$cols,$condition,$order,$table);

        }else{
            $rs=Data_Mysql_Table_Topic::select($cols,$condition,$order,$limit,$table);
        }
        return $rs;
    }

    //获取某个专题下的所有场地信息
    static function getTopicSpaceListByTid($topic_id,$condition=array(),$page=0,$page_num=0,$page_size=20,$limit=20){
        $condition['{table}.topic_id = ?']=$topic_id;
        $rs=array();
        $cols='{table}.*,{prefix}topic.topic_name,{prefix}topic.topic_url,{prefix}spacepedia.space_name as real_space_name';
        $table='{table} LEFT JOIN {prefix}topic ON {table}.topic_id = {prefix}topic.id LEFT JOIN {prefix}spacepedia on {table}.space_id = {prefix}spacepedia.id';
        $order='ORDER BY {table}.update_time DESC';
        if(!empty($page)){
            $rs=Data_Mysql_Table_Topic_Space::page($page_num,$page_size,$cols,$condition,$order,$table);
        }else{
            $rs=Data_Mysql_Table_Topic_Space::select($cols,$condition,$order,$limit,$table);
        }
        return $rs;
    }

    //获取首页推荐的专题列表,首页默认是4个
    static function getHomeTopicList($limit=4){
        $rs=array();
        $condition['status']=1;
        $condition['is_home']=1;
//        $rs=array();
        $cols='*';
        $table="{table}";
        $order='ORDER BY is_home DESC,update_time DESC';
        $rs=Data_Mysql_Table_Topic::select($cols,$condition,$order,$limit,$table);
        return $rs;
    }
}