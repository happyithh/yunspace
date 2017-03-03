<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/16
 * Time: 10:48
 *  系统 公告
 */
class OA_System_Notice
{
    static function  handle()
    {
        switch (@$_REQUEST['action']) {
            case 'edit':
                self::handleEdit();
                break;
            case 'from':
                self::handleFrom();
                break;
            case 'info':
                self::handleInfo();
                break;
            case 'deletenotice':
                self::handleDeleteNotice();
                break;
            default:
                self::handleList();
        }
    }


    static function  handleList()
    {
        $request = Func_Input::filter(array(
            'type' => 'int',
        ));
        if (!empty($request['type'])) {

            $conditions['category_id =?'] = $request['type'];
            $conditions['status !=?'] = -1;
        } else {
            $conditions = array();
        }
        $page = Data_Mysql_Table_System_Notice::page(0, 0, 'id,title,create_time,category_id,status', $conditions, 'ORDER BY create_time DESC');
        Tpl_Smarty::assign('_data', $page);
        Tpl_Smarty::display('OA_Static::Grab_Order_Notice.v1.0/list.tpl');
    }

    /**
     *详情
     */
    static function  handleInfo()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));

        $data = Data_Mysql_Table_System_Notice::select('*', array('id =?' => $request['id']));
        $d = $data[0];
        Tpl_Smarty::assign('_data', $d);
        Tpl_Smarty::display('OA_Static::Grab_Order_Notice.v1.0/info.tpl');
    }

    /**
     * 编辑 添加 在这里处理
     *
     * 有ID 是编辑 ，没有ID  是添加
     */
    static function  handleFrom()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));

        if (!empty($request['id'])) {
            $data = Data_Mysql_Table_System_Notice::select('*', array('id =?' => $request['id']));
            Tpl_Smarty::assign('_data', $data[0]);
        }
        Tpl_Smarty::display('OA_Static::Grab_Order_Notice.v1.0/from.tpl');

    }

    static function  handleEdit()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'title' => 'string',
            'type' => 'string',
            'create_time' => 'string',
            'cont' => 'html',
        ));

        if (empty($request['title'])) {
            Func_Header::to('请输入标题！');
        }
        if ($request['type'] == '公告') {

            $data['category_id'] = 1;

        } else {
            $data['category_id'] = 5;
        }
        $data['title'] = $request['title'];
        $data['content'] = $request['cont'];
        if (!empty($request['id'])) {
            $data['id'] = $request['id'];
        }
        if (!empty($request['create_time'])) {

            $data['create_time'] = strtotime($request['create_time']);
        } else {
            $data['create_time'] = time();
        }

        $data['status'] = 0;

        Data_Mysql_Table_LiveChat_Message_Recent::update(array('from_account_id=?' => array('-1')), array('is_notice' => 0));

        $rs = Data_Mysql_Table_System_Notice::update($data);
        if ($rs[0] > 0) {
            Func_Header::to('  成功', "?");
        }
        Func_Header::to('失败', "?");

    }

    //删除
    static function handleDeleteNotice()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'status' => 'int',
            'id' => 'int',
        ));
        if (!$request['id']) {
            Func_Output::json('error', '', '参数缺失！');
        }

        $rs = Data_Mysql_Table_System_Notice::update(array('id =?' => $request['id']), array('status =?' => $request['status']));
        if (!empty($rs[0])) {
            Func_Output::json('success', '', '操作成功！');
        } else {
            Func_Output::json('error', '', '操作失败！');
        }
    }

} 