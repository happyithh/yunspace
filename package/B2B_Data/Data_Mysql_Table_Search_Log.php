<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/7
 * Time: 18:46
 */
class Data_Mysql_Table_Search_Log extends Data_Mysql_Table
{
    public $cols = array(
        'search_title' => '500',
        'search_time' => 'int',
        'result_time' => 'int',
        'date_time' => '100',
    );
    public $index = array(
        'create_time' => 'i',
        'search_title' => 'i',
//        'search_time' => 'i',
        'result_time' => 'i',
    );
    public $title = array(
        'search_title' => '搜索的内容',
        'search_time' => '搜索次数',
        'result_time' => '搜索到的结果',
        'date_time' => '搜索时间',    //具体到哪一天
    );

    //生成搜索日志
    static function searchLog($search_title, $filter, $search_total)
    {
//        $conditions['date_time'] = date('Y-m-d',time());
//        $conditions['search_title'] = $search_title;
//        $se = Data_Mysql_Table_Search_Log::page(0,15,'*',$conditions);
//        $data['date_time']=$conditions['date_time'];
//        $data['result_time']=$search_total;
//        $data['search_title']=$search_title;
//
//        if(empty($se['rows'])){
//
//           $data['search_time'] = 1;
//           $res = Data_Mysql_Table_Search_Log::insert($data);
//            return true;
//        }else{
//            $data['search_time']=$se['rows'][0]['search_time'] + 1;
//            $res =  Data_Mysql_Table_Search_Log::update($conditions,$data);
//            return true;
//        }
    }
}
