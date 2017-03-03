<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/6/23
 * Time: 12:34
 */
class OA_Comment_Info
{
    static function handle()
    {
        $_REQUEST['action'] = empty($_REQUEST['action']) ? "list" : $_REQUEST['action'];
        switch ($_REQUEST['action']) {
            case 'list':
                self::handleCommentList();
                break;
            case 'detail':
                self::handleCommentDetail();
                break;
            case 'pass':
                self::handleCommentPass();
                break;
            case 'reject':
                self::handleCommentReject();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }

    //评论列表
    static function handleCommentList()
    {

        $page_nav = empty($_REQUEST['page_nav']) ? 'notYet' : $_REQUEST['page_nav'];
        switch ($page_nav) {
            case 'yet':
                $status = 1;
                break;
            case 'rejected':
                $status = -1;
                break;
            default:
                $status = 0;
                break;

        }
        $conditions = array('{table}.status =?' => $status);

        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['title'])) {
                $conditions['id'] = $search['title'];
            }
        }

        $table = "{table} LEFT JOIN {prefix}account ON {prefix}account.id = {table}.user_id LEFT JOIN {prefix}raiders_info ON {table}.from_id = {prefix}raiders_info.id";
        $cols = '{table}.*,{prefix}account.fullname,{prefix}raiders_info.title';
        $order = 'ORDER BY {table}.create_time desc';

        $data = Data_Mysql_Table_Comment::page(0, 10, $cols, $conditions, $order, $table);

        Tpl_Smarty::assign('_data', $data);

        Tpl_Smarty::assign('page_nav', $page_nav);
        Tpl_Smarty::assign('type',Data_Mysql_Table_Comment::$from_type);
        Tpl_Smarty::display('OA::comment_list.tpl');
    }

    //审核
    static function handleCommentDetail()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));

        $conditions = array('{table}.status =?' => 0,'{table}.id =?' => $request['id']);
        $table = "{table} LEFT JOIN {prefix}account ON {prefix}account.id = {table}.user_id LEFT JOIN {prefix}raiders_info ON {table}.from_id = {prefix}raiders_info.id";
        $cols = '{table}.id,{prefix}account.fullname,{prefix}raiders_info.title,{table}.cont';

        $rs = Data_Mysql_Table_Comment::select($cols, $conditions, '', 1, $table);

        Tpl_Smarty::assign('data', $rs);
        Tpl_Smarty::display('OA::comment_detail.tpl');
    }
    //审核拒绝
    static function handleCommentReject()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'reason' => 'string',
        ));

        if (empty($request['id']) || empty($request['reason'])) {
            Func_Header::back('缺少参数或者参数不正确');
        }

            $rs = Data_Mysql_Table_Comment::select('id,status', array('id =?' => $request['id'], 'status=?' => 0));
            if (!empty($rs[0]['id'])) {

                $update = array(
                    'id' => $request['id'],
                    'status' => '-1',
                    'marks' => $request['reason'],
                );
                $r = Data_Mysql_Table_Comment::update($update);
                if ($r > 0) {
                    Func_Header::to(' 操作成功！', '?page_nav=notYet');
                } else {
                    Func_Header::to('操作失败');
                }

            } else {
                Func_Header::back('操作信息不存在，请重试！');
            }

    }
    //审核通过
    static function handleCommentPass()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));
        if (empty($request['id'])) {
            Func_Header::back('缺少参数或参数不正确！');
        }

            $rs = Data_Mysql_Table_Comment::select('id,status', array('id =?' => $request['id'], 'status=?' => 0));
            if (!empty($rs[0]['id'])) {
                $update = array(
                    'id' => $request['id'],
                    'status' => 1
                );
                $r = Data_Mysql_Table_Comment::update($update);

                if ($r > 0) {

                    Func_Header::to('  操作成功!', '?page_nav=notYet');
                } else {
                    Func_Header::to('操作失败！');
                }
            } else {
                Func_Header::back('操作信息不存在，请重试！');
            }

    }



}