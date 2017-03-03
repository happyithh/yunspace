<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/7/4
 * Time: 10:50
 *
 * 匹配移动端搜索框 用途标题（活动案例）
 */
class Api_Search_Case_Title_Handle extends Api
{

    static function handle(){
        // 安全处理 防止频繁访问（最后写）
        return self::getCaseName($_REQUEST);
    }
    static function getCaseName($args){
        $request = Func_Input::filter(array(
            'q'=>'string',
        ),$args);
        if(empty($request['q'])){
            return self::request('error','','没有搜索内容');
        }
        $conditions[] = 'case_name LIKE "%'.trim($request['q']).'%"';
        $data = Data_Mysql_Table_Case_Keywords::select('case_name',$conditions,'',6);
        $data_new = array();
        if(!empty($data)){
            foreach($data as $k=>$v){
                $data_new[] = $v['case_name'];
            }
        }
        return self::request('success',$data_new,'');
    }
}