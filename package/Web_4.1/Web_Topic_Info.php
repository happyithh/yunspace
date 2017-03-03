<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2016/05/19
 * Time: 16:11
 * 专题
 */

class  Web_Topic_Info extends Web_Global
{
    function seo()
    {
        if(!empty($this->info['seo_title'])){
            $title=$this->info['seo_title'].$this->info['topic_name'].'-云SPACE';
        }else{
            $title=$this->info['topic_name'] . '_专题|云SPACE';
        }
        if(!empty($this->info['seo_keywords'])){
            $keywords=$this->info['seo_keywords'].",".$this->space_name;
        }else{
            
            $keywords=$this->info['topic_name'] .",".$this->space_name;
        }
        return array(
            '网页标题' => $title,
            '网页关键词' => $keywords,
            '网页简介' => $this->info['topic_des'],
        );
    }

    function topic_url()
    {
        $action = Func_Url::str_urldecode(Func_String::utf8(Core::$urls['action']));
        if(empty($action)){
            Func_Header::notFound();
        }
        return $action;

    }

    function space_name(){
        $space_name='';
        foreach ($this->spaceList as $k => $v) {
            $space_arr[]=$v['space_name'];
        }
        if(!empty($space_arr)){
            $space_name=implode(",",$space_arr);
        }
        return $space_name;
    }

    /*
     * 获取专题信息
     */
    function info()
    {
        $condition['status = ?'] = 1;
        $topicInfo = Api_Topic_Info::getTopicInfoByUrlName($this->topic_url,$condition);
        if (empty($topicInfo)) {
            Func_Header::notFound();
        }
        return $topicInfo;

    }

    /*
    * 获取该专题下所有上线的场地
    */
    function spaceList(){
        $spaceList=array();
        if($this->info['id']){
            $condition['{table}.status = ?'] = 1;
            $condition['{prefix}topic.status = ?'] = 1;
            $spaceList=Api_Topic_List::getTopicSpaceListByTid($this->info['id'],$condition,0,0,30);
        }
        return $spaceList;
    }

    function firstSpace(){
        if($this->spaceList){
            return $this->spaceList[0];
        }
        return array();
    }
    function otherSpace(){
        if($this->spaceList){
           unset($this->spaceList[0]);
           return $this->spaceList;
        }
        return array();
    }

    //更新专题浏览量
    function updateCountView(){
        Data_Mysql_Table_Topic::query('UPDATE {table} SET count_view = count_view +? WHERE id = ?',array(1,$this->info['id']));
    }
}