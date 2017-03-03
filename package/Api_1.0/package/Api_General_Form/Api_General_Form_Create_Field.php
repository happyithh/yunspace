<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/23
 * Time: 16:27
 *
 * 通用表单 添加、编辑提交
 */
class Api_General_Form_Create_Field extends Api
{
    static function createFieldForm($args)
    {
        if (!empty($args['submit'])) {
            $filter = Func_Input::filter(array(
                'id' => 'int',
                'form' => 'string',
                'field' => 'string',
                'email' => 'string',
                'backemail' => 'string',
                'start_time' => 'string',
                'end_time' => 'string',
            ), $args);

            if (empty($filter['form'])) {
                return self::request('error', '', '表单名称不能为空!!');
            }
            if (empty($filter['start_time']) && empty($filter['end_time'])) {
                return self::request('error', '', '请设置起止时间!!');
            }
            if (!empty($filter['start_time']) && !empty($filter['end_time'])) {
                if (strtotime($filter['start_time'] . "00:00:00") > strtotime($filter['end_time'] . "23:59:59")) {
                    return self::request('error', '', '请正确选择时间范围!!');
                }
            }
            $filter['start_time'] = empty($filter['start_time']) ? 0 : strtotime($filter['start_time'] . "00:00:00");
            $filter['end_time'] = empty($filter['end_time']) ? 0 : strtotime($filter['end_time'] . "23:59:59");
//            $filter['field_require'] = explode('、', $filter['field_require']);
            $data['form'] = $filter['form'];
            $data['email'] = $filter['email'];
            $data['backemail'] = $filter['backemail'];
            $data['field'] = $filter['field'];
            $data['start_time'] = $filter['start_time'];
            $data['end_time'] = $filter['end_time'];
            @session_start();
            if (!empty($filter['id'])) {
                $data['update_time'] = time();
                $res = Data_Mysql_Table_Form::update(array('id' => $filter['id']), $data);
                if (!empty($res)) {
                    //创建操作日志
                    $account_id = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));
                    Data_Mysql_Table_Account_Log::insertAccountLog($account_id['account_id'],$_SESSION['administrator']['id'],'表单修改--'.$data['form'],'表单管理',$filter['id']);
                    return self::request('success', '', '修改成功！');
                } else {
                    return self::request('error', '', '修改失败！');
                }
            } else {
                $data['create_time'] = time();
                $data['update_time'] = time();
                $res = Data_Mysql_Table_Form::insert($data);
                if (!empty($res)) {
                    //创建操作日志
                    $account_id = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));
                    Data_Mysql_Table_Account_Log::insertAccountLog($account_id['account_id'],$_SESSION['administrator']['id'],'表单创建--'.$data['form'],'表单管理',$res[0]);
                    return self::request('success', '', '添加成功！');
                } else {
                    return self::request('error', '', '添加失败！');
                }
            }

        }
    }
}