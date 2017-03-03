<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/9
 * Time: 10:16
 * IP人物形象显示、创建、修改等操作
 */
@session_start();

class Api_Winchance_New_Figure extends Api
{

    static function handle()
    {
        if (empty($_SESSION['administrator']['id'])) {
            return false;
        } else {
            return self::figureCreate();
        }
    }

    // 人物形象列表显示
    static function figureList()
    {
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'figure_name' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['figure_name'])) {
                $conditions['name =?'] = $search['figure_name'];
            }
        }
        $conditions['status !=?'] = -1;
        $data = Data_Mysql_Table_Winchance_Figure::page(0, 15, '*', $conditions, 'ORDER BY create_time DESC');
        return $data;
    }

    // 形象创建/编辑
    static function figureCreate()
    {
        $request = Func_Input::filter(array(
            'figure_id' => 'int',
            'name' => 'string',
            'note' => 'string',
            'company' => 'string',
        ), $_REQUEST);
        if (empty($request['name'])) {
            return self::request('error', '', 'IP人物形象不能为空！');
        }
        if (empty($request['company'])) {
            return self::request('error', '', '请选择IP品牌公司！');
        }
        $data['name'] = $request['name'];
        $data['note'] = $request['note'];
        $data['company'] = $request['company'];
        if (!empty($request['figure_id'])) {
            $data['update_time'] = time();
            $res = Data_Mysql_Table_Winchance_Figure::update(array('id' => $request['figure_id']), $data);
        } else {
            $condi['name = ?'] = $request['name'];
            $condi['status = ?'] = 1;
            $rs = Data_Mysql_Table_Winchance_Figure::select('name', $condi, '', 1);
            if (!empty($rs[0])) {
                return self::request('error', '', '人物形象已存在！');
            }
            $data['create_time'] = time();
            $res = Data_Mysql_Table_Winchance_Figure::insert($data);
        }
        if (!empty($res[0])) {
            return self::request('success', '', '操作成功！');
        } else {
            return self::request('error', '', '操作失败！');
        }
    }

}