<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/26
 * Time: 16:24
 *
 * 搜索时使用的经纬度缓存表
 */
class Data_Mysql_Table_Search_Lat_Lng extends Data_Mysql_Table
{
    public $cols = array(
        's_key'=>'string',
        's_value'=>'html',
        'status'=>'int',  // 0:百度地图给的经纬度 1:内部经纬度
        'update_time'=>'int',  // 若更新时间大于10天，则重新存数据
        'create_time'=>'int'
    );
    public $index = array(
        's_key'=>'u',
        's_value'=>'i',
        'status'=>'i',  // 0:百度地图给的经纬度 1:内部经纬度
        'update_time'=>'i',  // 若更新时间大于10天，则重新存数据
    );

    // 获取经纬度
    static function get($key){
        $condition['s_key'] = md5($key);
        $data = Data_Mysql_Table_Search_Lat_Lng::select('*',$condition,'',1);
        if(!empty($data[0])){
            $value = json_decode($data[0]['s_value'],1);
            $data[0]['lat'] = $value['lat'];
            $data[0]['lng'] = $value['lng'];
            return $data[0];
        }
    }

    // 写入经纬度
    static function set($key,$value,$status){
        $data['s_key'] = md5($key);
        $data['s_value'] = json_encode($value);
        $data['status'] = $status;
        $data['update_time'] = time();
        $data['create_time'] = time();
        Data_Mysql_Table_Search_Lat_Lng::insert($data);
    }

    // 更新经纬度
    static function setUpdate($key,$value,$id){
        $data['s_key'] = md5($key);
        $data['s_value'] = json_encode($value);
        $data['update_time'] = time();
        Data_Mysql_Table_Search_Lat_Lng::update(array('id'=>$id),$data);
    }

}
