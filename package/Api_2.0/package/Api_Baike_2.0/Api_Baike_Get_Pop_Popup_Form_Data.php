<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/8/16
 * Time: 19:08
 */
@session_start();

class  Api_Baike_Get_Pop_Popup_Form_Data extends Api
{

    static function  handle($args = '')
    {
        return self::handleRequestData($args);
    }

    static function  handleRequestData($args)
    {
        $request = Func_Input::filter(array(
            'data' => 'array',
            'condition' => 'array',
        ), $args);
        $data = array(
            'session_id' => session_id(),
            'data' => $request['data'],
        );
        Data_Mysql_Table_Baike_Popup_Form_Data::insert($data);

        $condition = $request['condition'];
        return self::handleResult(array('city' => $condition['city'], 'type' => $condition['type']));

    }

    static function  handleResult($args)
    {
        $request = Func_Input::filter(array(
            'city' => 'string',
            'type' => 'string',
        ), $args);
        $category = Data_Mysql_Table_Spacepedia::getChildrenByCid(112);
        $category[112] = '空间';
        $all_category = array_flip($category);
        $type = $all_category[trim($request['type'])];
        if (!empty($type)) {
            $conditions['category_id'] = $type;
        }
        $conditions['city'] = $request['city'];
        $data = Data_Mysql_Table_Spacepedia::select(' COUNT(id) as c ', $conditions);
        if (!empty($data[0])) {
            if ($data[0]['c'] > 2) {
                return Api::request('success', $data[0]['c']+20, 'ok');
            }
        }
        return Api::request('error', '', '没找到更多');
    }
}

class Data_Mysql_Table_Baike_Popup_Form_Data extends Data_Mysql_Table
{
    public $cols = array(
        'session_id' => '100',
        'phone' => '11',
        'data' => 'array',
        'create_time' => 'int',
    );
}