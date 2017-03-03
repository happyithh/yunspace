<?php

/**
 * Created by PhpStorm.
 * User: yaoli
 * Date: 2015/10/19
 * Time: 10:40
 *  场地百科自动完成（文章页自动完成）
 */
class  Api_Baike_Auto_Complete extends Api
{
    static function handle($args=""){

        return self::handleBaikeComplete($args);
    }
    static function handleBaikeComplete($args){


        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
        ));
        if (!$request['id'] && !$request['q']) {
            return false;
        }
        if ($request['id']) {
            $rs = Data_Mysql_Table_Spacepedia::select('id, space_name as name', array("id" => $request['id'],"status"=>1));
        } else {
            $rs = Data_Mysql_Table_Spacepedia::select('id, space_name as name', array("(id like ? OR space_name like ?)" => array($request['q'] . '%', $request['q'] . '%'),"status"=>1), '', 5);
        }

        foreach ($rs as $key => $val) {
            $ajax_arr['results'][$key]['id'] = $val['id'];
            $ajax_arr['results'][$key]['name'] = $val['name'];
        }
        return $ajax_arr;
    }

}