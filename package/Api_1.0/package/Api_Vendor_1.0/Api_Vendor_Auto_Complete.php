<?php

/**
 * Created by PhpStorm.
 * User: yaoli
 * Date: 2015/9/17
 * Time: 11:00
 *  供应商自动完成
 */
class  Api_Vendor_Auto_Complete extends Api
{
    static function handle($args=""){

        return self::handleVendorComplete($args);
    }
    static function handleVendorComplete($args){
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
        ));
        if (!$request['id'] && !$request['q']) {
            return self::request('error',"","参数错误!");
        }
        if ($request['id']) {
            $rs = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id, CONCAT( "[", id, "] ", vendor_name) as name', array("id" => $request['id']));
        } else {
            $rs = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('id, CONCAT( "[", id, "] ", vendor_name) as name', array("id like ? OR vendor_name like ?" => array($request['q'] . '%', $request['q'] . '%')), '', 5);
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
        return self::request('success',$ajax_arr,"返回匹配供应商");
    }

}