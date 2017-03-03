<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2015/7/27
 * Time: 17:16
 * 获取账户
 */
class  Api_Account_Auto_Complete extends Api
{
    static function  handle($args = '')
    {
        //接受参数
        //        'id' => 'int',
        //            'q' => 'string',

        //返回结果：
        //         返回状态status （0，返回未成功，1返回成功），
        //         状态消息 msg：返回成功 或返回失败原因
        //         返回结果data：管理员列表

        return self::handleAccountAutoComplete($args);
    }

    static function handleAccountAutoComplete($args="")
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'type' => 'int',
            'q' => 'string',
        ),$args);
        if (!$request['id'] && !$request['q']) {
            return self::request('error','',"参数错误!");
        }
        if ($request['id']) {
            $rs = Data_Mysql_Table_Account::select('id,username', array("id= ? " => array($request['id'])));
        } else {
            $rs = Data_Mysql_Table_Account::select('id, CONCAT( "[", id, "] ", username) as username', array("id like ? OR username like ?" => array($request['q'] . '%', $request['q'] . '%')), '', 5);
        }
        $ajax_arr = array(
            "total_count" => 2,
            "incomplete_results" => false,
            "items" => array(
                array(
                    'id' => '',
                    'full_name' => ''
                ),
            )
        );
        foreach ($rs as $key => $val) {
            $ajax_arr['items'][$key]['id'] = $val['id'];
            $ajax_arr['items'][$key]['full_name'] = $val['username'];
        }
        return self::request('error',$ajax_arr,"返回匹配的账户");

    }
}