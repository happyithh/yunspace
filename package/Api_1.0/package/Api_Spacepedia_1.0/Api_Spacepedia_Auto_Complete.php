<?php

/**
 * Created by PhpStorm.
 * User: yaoli
 * Date: 2015/10/19
 * Time: 10:40
 *  场地百科自动完成
 */
class  Api_Spacepedia_Auto_Complete extends Api
{
    static function handle($args=""){

        return self::handleSpacepediaComplete($args);
    }
    static function handleSpacepediaComplete($args){
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
        ));
        if (!$request['id'] && !$request['q']) {
            echo "参数错误！！";
            die;
//            return self::request('error',"","参数错误!");
        }
        if ($request['id']) {
            $rs = Data_Mysql_Table_Spacepedia::select('id, CONCAT( "[", id, "] ", space_name) as name', array("id" => $request['id']));
        } else {
            $rs = Data_Mysql_Table_Spacepedia::select('id, CONCAT( "[", id, "] ", space_name) as name', array("id like ? OR space_name like ?" => array($request['q'] . '%', $request['q'] . '%')), '', 5);
        }
        echo json_encode($rs);
        die;
//        die;
//        $ajax_arr = array(
//            "total_count" => 2,
//            "incomplete_results" => false,
//            "items" => array(
//                array(
//                    'id' => 1,
//                    'name' => '',
//                    'full_name' => ''
//                ),
//            )
//        );
//        foreach ($rs as $key => $val) {
//            $ajax_arr['items'][$key]['id'] = $val['id'];
//            $ajax_arr['items'][$key]['name'] = $val['name'];
//            $ajax_arr['items'][$key]['full_name'] = $val['name'];
//        }
//        return self::request('success',$ajax_arr,"返回匹配的场地百科");
    }

}