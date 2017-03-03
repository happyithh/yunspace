<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/10
 * Time: 15:01
 *
 * 字段内容的显示、修改
 */
@session_start();
class Api_Winchance_New_Field extends Api
{

    static function handle()
    {
        if (empty($_SESSION['administrator']['id'])) {
            return false;
        } else {
            return self::contentAdd();
        }
    }

    //列表数据显示
    static function fieldList()
    {
        $data = Data_Mysql_Table_Winchance_Fields::select('*', '', '', 5);
        if (!empty($data)) {
            foreach ($data as $k => $v) {
                $data[$k]['content'] = json_decode($v['content'], 1);
            }
        }
        return $data;
    }

    //字段内容增加
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