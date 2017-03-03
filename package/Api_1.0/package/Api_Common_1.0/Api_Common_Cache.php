<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/30
 * Time: 11:12
 */
class Api_Common_Cache extends Api{
    static function handle(){
        $request = Func_Input::filter(array(
            'subTable' => 'string',
            'token'=>'string'
        ), $_REQUEST);
        if(isset($request['subTable'])&& $request['subTable']=='html_cache'&&!empty($request['token'])&&$request['token']=='e702784057ca97c9b08cc948b8d4e979'){
            return self::clearCache($request);
        }else{
            return self::request('error', '', "参数错误！");
        }
    }
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
        $status = Data_Mysql_Table_Cache::subTable('_'.$subTable)->select('id,s_key', array('s_key' => $key));
        if (!empty($status[0]['id'])) {
            $data['id'] = $status[0]['id'];
        }
        Data_Mysql_Table_Cache::subTable('_'.$subTable)->update($data);
    }

    static function  get($subTable, $key_data)
    {
        $key = is_array($key_data) ? json_encode($key_data) : $key_data;
        if (empty($key)) {
            return false;
        }
        $conditions['s_key'] = md5($key);
        $conditions[] = 's_cache_time >' . time();
        $data = Data_Mysql_Table_Cache::subTable('_'.$subTable)->select('s_value,s_cache_time', $conditions);
        if (!empty($data[0]['s_value'])) {
            return $data[0]['s_value'];
//            return json_decode($data[0]['s_value'], 1);
        }
        if (date("H") < 4) {
            $r = Data_Mysql_Table_Cache::subTable('_'.$subTable)->select('count(*) AS c');
            if (!empty($r[0]['c']) && $r[0]['c'] > 10000) {
                Data_Mysql_Table_Cache::subTable('_'.$subTable)->exec("TRUNCATE {table}");
            }
        }
        return false;
    }
    static  function clearCache($args){
        $request = Func_Input::filter(array(
            'subTable' => 'string',
        ), $args);
        if(empty($request['subTable'])){
            $result = self::request('error', '', "参数错误！");
            return $result;
        }
        $subTable = $request['subTable'];
        Data_Mysql_Table_Cache::subTable('_'.$subTable)->exec("TRUNCATE {table}");
        $result = self::request('success', '', "清除全部缓存成功！");
        return $result;
    }
    static  function clearCacheByKey($args){
        $request = Func_Input::filter(array(
            'subTable' => 'string',
            's_key' => 'string',
        ), $args);
        if(empty($request['subTable']) || empty($request['s_key'])){
            $result = self::request('error', '', "参数错误！");
            return $result;
        }
        $subTable = $request['subTable'];
        $s_key = md5($request['s_key']);
        Data_Mysql_Table_Cache::subTable('_'.$subTable)->exec("DELETE FROM {table} WHERE s_key='".$s_key."'");
        $result = self::request('success', '', "清除缓存成功！");
        return $result;
    }
}