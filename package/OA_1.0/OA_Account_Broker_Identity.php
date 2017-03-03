<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/5/13
 * Time: 13:53
 */
class OA_Account_Broker_Identity
{
    static function handle()
    {
        $_REQUEST['action'] = empty($_REQUEST['action']) ? "list" : $_REQUEST['action'];
        switch ($_REQUEST['action']) {
            case 'list':
                self::handleBrokerIdentityList();
                break;
            case 'detail':
                self::handleBrokerIdentityDetail();
                break;
            case 'pass':
                self::handleBrokerIdentityPass();
                break;
            case 'reject':
                self::handleBrokerIdentityReject();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }

    static function handleBrokerIdentityList()
    {

        $page_nav = empty($_REQUEST['page_nav']) ? 'yet' : $_REQUEST['page_nav'];
        switch ($page_nav) {
            case 'notYet':
                $status = 0;
                break;
            case 'rejected':
                $status = -1;
                break;
            default:
                $status = 1;
                break;

        }
        $conditions = array('status =?' => $status);

        if (!empty($_REQUEST['search'])) {
           $search  = Func_Input::filter(array(
                'title' => 'string',
            ), $_REQUEST['search']);
            if(!empty($search['title'])) {
                $conditions['id'] = $search['title'];
            }
        }
        $data = Data_Mysql_Table_Account_Broker::page(0, 0, '*', $conditions);

        Tpl_Smarty::assign('_data', $data);

        Tpl_Smarty::assign('page_nav', $page_nav);
        Tpl_Smarty::display('OA', 'broker_account_identity_list.tpl');
    }


    static function handleBrokerIdentityDetail()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));
        $rs = Data_Mysql_Table_Account_Broker::select('*', array('id=?' => $request['id'], 'status =?' => 0));
        $data = array();
        if (!empty($rs[0])) {
            $data = Data_Mysql_Table_Account_Broker::rowFormat($rs[0]);
            $data['id'] = $rs[0]['id'];
        }
        $reason = array(
            '证件不全','资历不够','其他原因'
        );
        Tpl_Smarty::assign('rejectreason', $reason);
        Tpl_Smarty::assign('data', $data);
        Tpl_Smarty::display('OA', 'broker_account_identity_detail.tpl');
    }

    static function handleBrokerIdentityPass()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));
        if (empty($request['id'])) {
            Func_Header::back('缺少参数或参数不正确！');
        }
        if (!empty($_SESSION['administrator']['id'])) {
            $rs = Data_Mysql_Table_Account_Broker::select('id,account_id,status', array('id =?' => $request['id'], 'status=?' => 0));
            if (!empty($rs[0]['account_id'])) {
                $update = array(
                    'id' => $request['id'],
                    'status' => 1
                );
                $r = Data_Mysql_Table_Account_Broker::update($update);
                $rr = Data_Mysql_Table_Account::update(array('id =?' => $rs[0]['account_id']),array( 'is_broker=?' => 1));
                if ($r > 0 && $rr > 0) {
                    Data_Mysql_Table_Account_Log::insertAccountLog($rs[0]['account_id'], $_SESSION['administrator']['id'], '审核通过' . $request['id'], '经纪人审核', $request['id']);
                    Func_Header::to('  操作成功!', '?page_nav=notYet');
                } else {
                    Func_Header::to('操作失败！');
                }
            } else {
                Func_Header::back('操作信息不存在，请重试！');
            }
        } else {
            Func_Header::back('请先登录！');
        }

    }

    static function handleBrokerIdentityReject()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'reason' => 'string',
        ));
        if (empty($request['id']) || empty($request['reason'])) {
            Func_Header::back('缺少参数或者参数不正确');
        }
        if (!empty($_SESSION['administrator']['id'])) {
            $rs = Data_Mysql_Table_Account_Broker::select('id,status', array('id =?' => $request['id'], 'status=?' => 0));
            if (!empty($rs[0]['id'])) {

                $update = array(
                    'id' => $request['id'],
                    'status' => '-1',
                    'marks' => $request['reason'],
                );
                $r = Data_Mysql_Table_Account_Broker::update($update);
                if ($r > 0) {
                    //发送邮件给供应商账户
                    //OA_Account_Check::refuseMailtoAccount($rs[0]['account_id'],$request['reason']);
                    //创建操作日志
                    Data_Mysql_Table_Account_Log::insertAccountLog($rs[0]['account_id'], $_SESSION['administrator']['id'], '审核拒绝:' . $update['marks'], '经纪人审核', $request['id']);

                    Func_Header::to(' 操作成功！', '?page_nav=notYet');
                } else {
                    Func_Header::to('操作失败');
                }

            } else {
                Func_Header::back('操作信息不存在，请重试！');
            }
        }
    }


}