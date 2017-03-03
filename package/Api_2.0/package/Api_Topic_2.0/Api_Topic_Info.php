<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 16-1-18
 * Time: 上午11:54
 */
class Api_Topic_Info extends Api{

    //获取ID获取专题信息
    static function getTopicInfoById($id,$condition=array()){
        $return=array();
        $condition['id']=$id;
        $rs=Data_Mysql_Table_Topic::select('*',$condition);
        if(!empty($rs[0])){ 
            $return=$rs[0];
        }
        return $return;
    }

    //根据名称获取专题信息
    static function getTopicInfoByUrlName($name,$condition=array()){
        $return=array();
        $condition['topic_url']=$name;
        $rs=Data_Mysql_Table_Topic::select('*',$condition);
        if(!empty($rs[0])){ 
            $return=$rs[0];
        }
        return $return;
    }

    //根据专题场地id获取专题下的场地信息
    static function getTopicSpaceInfoBytsid($id,$condition=array()){
        $return=array();
        $condition['id']=$id;
        $rs=Data_Mysql_Table_Topic_Space::select('*',$condition);
        if(!empty($rs[0])){ 
            if(!empty($rs[0]['activity_type'])){
                $activity_type=explode(",",$rs[0]['activity_type']);
                unset($rs[0]['activity_type']);
                $rs[0]['activity_type']=$activity_type;
            }
            $return=$rs[0];
        }
        return $return;
    }

}