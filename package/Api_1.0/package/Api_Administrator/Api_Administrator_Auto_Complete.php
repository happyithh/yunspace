<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2015/7/27
 * Time: 17:16
 * 获取管理员
 */
class  Api_Administrator_Auto_Complete extends Api
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

        return self::handleAdminAutoComplete($args);
    }

    static function handleAdminAutoComplete()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'q' => 'string',
        ));
        if (!$request['id'] && !$request['q']) {
            return self::request('error','','参数错误！');
        }
        $condition['status']=1;
        if ($request['id']) {
            $condition['id']=$request['id'];
            $rs = Data_Mysql_Table_Administrator::select('id,username',$condition);
        } else {
            $condition['username like ?']=$request['q'] . '%';
            $rs = Data_Mysql_Table_Administrator::select('id,username',$condition, '', 5);
        }
        $ajax_arr = array(
            "total_count" => count($rs),
            "incomplete_results" => false,
            "items" => array(
                array(
                    'id' => '',
                    'full_name' => ''
                ),
            )
        );
        if (!empty($rs)) {
            foreach ($rs as $key => $val) {
                $ajax_arr['items'][$key]['id'] = $val['id'];
                $ajax_arr['items'][$key]['full_name'] = $val['username'];
            }
            return self::request('success',$ajax_arr,'返回匹配的管理员');
        }

    }
}