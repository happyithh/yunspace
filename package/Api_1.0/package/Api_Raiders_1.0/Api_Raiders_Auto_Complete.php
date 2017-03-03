<?php

/**
 * Created by PhpStorm.
 * User: yaoli
 * Date: 2015/9/17
 * Time: 11:00
 * 文章自动完成
 */
class  Api_Raiders_Auto_Complete extends Api
{
    static function handle($args=""){

        return self::handleRaidersComplete($args);
    }
    static function handleRaidersComplete($args){
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
        ));
        if (!$request['id'] && !$request['q']) {
            return self::request('error',"","参数错误!");
        }
        if ($request['id']) {
            $rs = Data_Mysql_Table_Raiders_Info::select('id, CONCAT( "[", id, "] ", title) as name', array("id" => $request['id']));
        } else {
            $rs = Data_Mysql_Table_Raiders_Info::select('id, CONCAT( "[", id, "] ", title) as name', array("id like ? OR title like ?" => array($request['q'] . '%', "%".$request['q'] . '%')), '', 10);
        }
        $ajax_arr = array(
            "total_count" => 2,
            "incomplete_results" => false,
            "items" => array(
                array(
                    'id' => 1,
                    'name' => '',
                    'full_name' => ''
                ),
            )
        );
        foreach ($rs as $key => $val) {
            $ajax_arr['items'][$key]['id'] = $val['id'];
            $ajax_arr['items'][$key]['name'] = '';
            $ajax_arr['items'][$key]['full_name'] = $val['name'];
        }
        return self::request('success',$ajax_arr,"返回匹配的文章");
    }

}