<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/10
 * Time: 15:43
 * 文创字段内容添加
 */
@session_start();

class Api_Winchance_New_Field_Content extends Api
{
    static function handle()
    {
        if (empty($_SESSION['administrator']['id'])) {
            return false;
        }else{
            return self::contentAdd();
        }
    }

    static function contentAdd()
    {
        $request = Func_Input::filter(array(
            'content' => 'string',
            'name' => 'string'
        ), $_REQUEST);
        if (empty($request['content'])) {
            return self::request('error', '', '请填写字段');
        }
        $content = array_filter(explode(',', $request['content']));

        $res = Data_Mysql_Table_Winchance_Fields::update(array('name' => $request['name']), array('content' => $content));
        if (!empty($res)) {
            return self::request('success', '', '操作成功！');
        } else {
            return self::request('error', '', '操作失败！');
        }

    }
}