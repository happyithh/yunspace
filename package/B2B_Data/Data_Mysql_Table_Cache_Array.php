<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/4/29
 * Time: 17:01
 * 搜索结果储存表
 */
class Data_Mysql_Table_Cache_Array extends Data_Mysql_Table
{
    public $cols = array(
        's_key' => '200',
        's_value' => 'array',
        's_cache_time' => '12',
    );
    public $index = array(
        's_key' => 'p',
        's_cache_time' => 'i',
        's_value' => 'i',
    );
    public $title = array(
        's_key' => '键',
        's_value' => '值',
        's_cache_time' => '时间',
    );

    static function  set($subTable, $key_data, $value, $cacheTime = 3600)
    {
        $key = is_array($key_data) ? json_encode($key_data) : $key_data;
        if (empty($key)) {
            return false;
        }
        $key = md5($key);
        $data = array(
            's_key' => $key,
            's_value' => $value,
            's_cache_time' => time() + intval($cacheTime),
        );
        $status = self::subTable($subTable)->select('id,s_key', array('s_key' => $key));
        if (!empty($status[0]['id'])) {
            $data['id'] = $status[0]['id'];
        }
        self::subTable($subTable)->update($data);
    }

    static function  get($subTable, $key_data)
    {
        $key = is_array($key_data) ? json_encode($key_data) : $key_data;
        if (empty($key)) {
            return false;
        }
        $conditions['s_key'] = md5($key);
        $conditions[] = 's_cache_time >' . time();
        $data = self::subTable($subTable)->select('s_value,s_cache_time', $conditions);
        if (!empty($data[0]['s_value'])) {
            return json_decode($data[0]['s_value'], 1);
        }
        if (date("H") < 4) {
            $r = self::subTable($subTable)->select('count(*) AS c');
            if (!empty($r[0]['c']) && $r[0]['c'] > 10000) {
                self::subTable($subTable)->exec("TRUNCATE {table}");
            }
        }
        return false;
    }
}