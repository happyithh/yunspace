<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-12-29
 * Time: 下午8:09
 */
Class Api_Baike_Article_Count{
    static function updateAricleCountBySpaceIds($space_ids){
        if(!is_array($space_ids)){
            $space_ids=array($space_ids);
        }
        //更新场地百科的文章数目为0
        $condition[]="space_id in (".implode(",",$space_ids).")";
        Data_Mysql_Table_Baike_Statistical::update($condition,array("article_sum "=>0));
    }
}