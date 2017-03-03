<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/9
 * Time: 10:16
 * IP人物形象列表显示、添加
 */
@session_start();

class Api_Winchance_New_Company extends Api
{
    static function handle()
    {
        if (empty($_SESSION['administrator']['id'])) {
            return false;
        } else {
            return self::companyCreate();
        }
    }

    //品牌公司列表显示
    static function companyList()
    {
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'company_name' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['company_name'])) {
                $conditions['company=?'] = $search['company_name'];
            }
        }
        $conditions['status !=?'] = -1;
        $data = Data_Mysql_Table_Winchance_Company::page(0, 15, '*', $conditions, 'ORDER BY create_time DESC');
        return $data;
    }

    // 品牌公司增加/编辑
    static function companyCreate()
    {
        $request = Func_Input::filter(array(
            'company_id' => 'int',
            'company' => 'string',
            'note' => 'string',
        ), $_REQUEST);
        if (empty($request['company'])) {
            return self::request('error', '', 'IP形象公司不能为空！');
        }

        $data = array();
        $data['company'] = $request['company'];
        $data['note'] = $request['note'];
        if (!empty($request['company_id'])) {
            $data['update_time'] = time();
            $res = Data_Mysql_Table_Winchance_Company::update(array('id' => $request['company_id']), $data);
        } else {
            // 检查公司名称是否已存在
            $condi['company =?'] = $request['company'];
            $condi['status = ?'] = 1;
//        Data_Mysql_Table_Winchance_Company::debug(1);
            $re = Data_Mysql_Table_Winchance_Company::select('company', $condi, '', 1);
            if (!empty($re[0])) {
                return self::request('error', '', '公司名称已存在！');
            }
            $data['create_time'] = time();
            $res = Data_Mysql_Table_Winchance_Company::insert($data);
        }
        if (!empty($res[0])) {
            return self::request('success', '', '操作成功！');
        } else {
            return self::request('error', '', '操作失败！');
        }
    }
}