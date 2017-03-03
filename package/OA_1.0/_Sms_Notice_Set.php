<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/6/18
 * Time: 11:09
 */
class OA_Sms_Notice_Set
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::noticeList();
                break;
            case 'add':
                self::noticeAdd();
                break;
            case 'addsubmit':
                self::noticeSubmitAdd();
                break;
            case 'edit':
                self::noticeEdit();
                break;
            case 'delete':
                self::noticeDel();
                break;
            default:
                self::noticeList();
                break;
        }
    }

    static function noticeList()
    {
        if (!empty($_REQUEST['search']['title'])) {
            $_REQUEST['search']['title'] = trim($_REQUEST['search']['title']);
        }
        if (!empty($_REQUEST['search']['title']) && isset($_REQUEST['search']['title'])) {
            $search = trim($_REQUEST['search']['title']);
            $conditions = array(
                "(name =? or city = ?)" => array(
                    $search, $search
                )
            );
        }
        $conditions['status'] = 1;

        $res = Data_Mysql_Table_Sms_Notice::page(0, 15, "*", $conditions);
        foreach ($res['rows'] as &$v) {
            $v['update_time'] = date('Y-m-d', $v['update_time']);
        }
        Tpl_Smarty::assign('data', $res);
        Tpl_Smarty::display('OA', 'notice/notice_list.tpl');
    }

    static function noticeAdd()
    {
        $notice_type = Data_Mysql_Table_Sms_Notice::$noticeType;
        Tpl_Smarty::assign('_data2', $notice_type);
        Tpl_Smarty::display('OA', 'notice/notice_add.tpl');
    }

    static function noticeSubmitAdd()
    {
        if (!empty($_REQUEST['submit'])) {
            $request = Func_Input::filter(
                array(
                    'title' => 'string',
                    'contact' => 'string',
                    'city' => 'string',
                )
            );
            if (empty($request['title'])) {
                Func_Header::back('标题不能为空！');
            }
            if (empty($request['contact'])) {
                Func_Header::back('联系方式不能为空！');
            }
            $data = array(
                'name' => $request['title'],
                'city' => trim($request['city']),
                'create_time' => time(),
                'update_time' => time(),
                'status' => '1',
                'contact' => $request['contact']
            );
            $re = Data_Mysql_Table_Sms_Notice::select("*", array('name =?' => $data['name'], 'city =?' => $data['city'], 'status =?' => 1));
            if (!empty($re)) {
                $res = Data_Mysql_Table_Sms_Notice::update(array('id' => $re[0]['id']), $data);
                if ($res > 0) {
                    Func_Header::to('【' . $data['city'] . '】的【' . $data['name'] . '】已经存在，系统将自动更新！', Core::$urls['path']);
                } else {
                    Func_Header::back('  该' . $data['city'] . '的' . $data['name'] . '已经存在!');
                }
            } else {
                $result = Data_Mysql_Table_Sms_Notice::insert($data);
                if ($result > 0) {
                    Func_Header::to('  添加成功！', Core::$urls['path']);
                } else {
                    Func_Header::back('添加失败！');
                }
            }
        }
    }

    static function noticeEdit()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！');
        }
        $notice_type = Data_Mysql_Table_Sms_Notice::$noticeType;
        Tpl_Smarty::assign('_data2', $notice_type);
        $res = Data_Mysql_Table_Sms_Notice::select("*", array('id' => $_REQUEST['id']));
        Tpl_Smarty::assign('data', $res[0]);
        Tpl_Smarty::display('OA', 'notice/notice_add.tpl');
        if (!empty($_REQUEST['submit'])) {
            $filter = Func_Input::filter(
                array(
                    'title' => 'string',
                    'contact' => 'string',
                    'city' => 'string',
                )
            );
            if (empty($filter['title'])) {
                Func_Header::back('标题不能为空！');
            }
            if (empty($filter['contact'])) {
                Func_Header::back('联系方式不能为空！');
            }
            $data = array(
                'name' => $filter['title'],
                'city' => $filter['city'],
                'update_time' => time(),
                'status' => '1',
                'contact' => $filter['contact']
            );
            $res = Data_Mysql_Table_Sms_Notice::update(array('id' => $_REQUEST['id']), $data);
            if ($res > 0) {
                Func_Header::to('  修改成功！', Core::$urls['path']);
            } else {
                Func_Header::back('修改失败！');
            }
        }
    }

    static function noticeDel()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::back('参数错误！');
        }
        $result = Data_Mysql_Table_Sms_Notice::update(array('id' => $_REQUEST['id']), array('status' => -1));
        if (!empty($result)) {
            Func_Header::back();
        }
    }
}