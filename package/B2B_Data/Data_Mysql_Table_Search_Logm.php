<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/6/10
 * Time: 19:46
 */
class Data_Mysql_Table_Search_Logm extends Data_Mysql_Table
{
    public $cols = array(
        'search_title' => '500',
        'search_time' => 'int',
        'search_type' => '100',
        'date_time' => '100',
    );
    public $index = array(
        'search_title' => 'i',
        'search_type' => 'i',
        'date_time' => 'i',
    );
    public $title = array(
        'search_title' => '搜索的内容',
        'search_time' => '搜索次数',
        'date_time' => '搜索时间',    //具体到哪一天
    );

    //生成搜索日志
    /***
     * @param $search_title
     * @param $filter
     * @param $search_total
     */
    static function searchLog($search_title,$search_type='')
    {
       $result = self::lib_replace_end_tag($search_title);
        if(!$result){
            return false;
        }
        $condition['search_title'] =$search_title;
        $condition['date_time'] = date("Y-m-d");
        $condition['search_type'] = $search_type;
        $rs = Data_Mysql_Table_Search_Logm::select("id",$condition);
        if($rs){
            Data_Mysql_Table_Search_Logm::query("UPDATE {table} SET search_time=search_time+1  WHERE id=?",$rs[0]['id']);
        }else{
            $condition['search_time'] = 1;
            $condition['search_type'] = $search_type;
            Data_Mysql_Table_Search_Logm::insert($condition);
        }
    }
    static  function hotSearchList($search_type=''){
        if(!empty($search_type)){
           $con =  "search_type=".$search_type;
        }else{
            $con ='';
        }
        $list = Data_Mysql_Table_Search_Logm::query("SELECT search_title,search_type,SUM(search_time) as search_times FROM {table} WHERE ".$con."GROUP BY search_title ORDER BY search_times DESC LIMIT 10 ",'',1);
        return $list;
    }
    static function lib_replace_end_tag($str)
    {
        if (empty($str)) return false;
        $partten =self::$partten;
        foreach($partten as $k=>$v){
            if(stripos($str,$v)===FALSE){
                continue;
            }else{
                return false;
            }
        }
        return true;

    }
    static $partten = array(
        '/',
        "\\",
        "&gt",
        "&lt",
        "script",
        "<script>",
        "</script>",
        "alert",
        "select",
        "join",
        "union",
        "where",
        "insert",
        "delete",
        "update",
        "like",
        "drop",
        "create",
        "modify",
        "rename",
        "alter",
        "cas",
        "and",
        "or",
        "&",
        "%",
        "(",
        ")",
        ">",
        "<",
        "[",
        "]",
        ".",
        " ",
        "    ",
        "&",
        "'",
        "<br />",
        "css",
    );
}
