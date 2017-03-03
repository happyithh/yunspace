<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/6/1
 * Time: 17:31
 * @ 套餐审核
 */
Class  OA_Check_Set
{
    static function  handle()
    {
        if (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'refuse') {
            self::handleSetRefuse();
        } elseif (!empty($_REQUEST['handle_type']) && $_REQUEST['handle_type'] == 'pass') {
            self::handleSetPass();
        } else {
            self::handleSetDetail();
        }
    }

    static function  handleSetRefuse()
    {
        $request = Func_Input::filter(array(
            'id' => 'id',
            'reason' => 'string',
        ));
        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        if (empty($request['reason'])) {
            Func_Header::back('请输入拒绝理由');
        }
        $condition['id'] = $request['id'];
        $data = array(
            'status' => 3,
//            'set_name = CONCAT(set_name,"|",?)' => $request['reason'],
            'refuse_reason' => $request['reason'],
        );
        $update_rs = Data_Mysql_Table_Product_Set::subTable('_update')->update($condition, $data);
        if ($update_rs[0] > 0) {
            $vendorInfo = Data_Mysql_Table_Vendor_Info::select('{table}.vendor_account_id,{prefix}product_info_update.id', array('{prefix}product_info_update.id = ?' => $request['id']), '', 1, '{table} LEFT JOIN {prefix}product_info_update ON {table}.id = {prefix}product_info_update.vendor_id');


            //审核拒绝则发送邮件
            $admin_name = empty($_REQUEST['admin_name']) ? '' : $_REQUEST['admin_name'];
            $id = empty($_REQUEST['id']) ? '' : $_REQUEST['id'];
            $vendor_id = empty($_REQUEST['vendor_id']) ? '' : $_REQUEST['vendor_id'];
            $href = 'http://www.yunspace.com.cn/vendor_center/vendor_admin/set_edit?set_id=' . $id;
            if ($_REQUEST['action'] = 'check_set') {
                $sort = '套餐';
            } else {
                $sort = '';
            }
            //根据供应商套餐id查询出相关数据
            if (!empty($id)) {
                $rs = Data_Mysql_Table_Product_Set::subTable('_update')->select("id,set_name", array('id = ?' => $id));
                $rs[0]['set_name'] = preg_replace('/\|.*/', '', $rs[0]['set_name']);
            }
            //根据供应商id查询出相关数据
            if (!empty($vendor_id)) {
                $r = Data_Mysql_Table_Vendor_Info::subTable('_update')->select("vendor_name", array('id = ?' => $vendor_id));
                $r[0]['vendor_name'] = preg_replace('/\|.*/', '', $r[0]['vendor_name']);
            }
            //有负责人则发送邮件给负责人
            if (!empty($admin_name)) {
                OA_Account_Check::refuseMailtoAdmin($admin_name, $request['reason'], $r[0]['vendor_name'], $sort, $rs[0]['id'], $rs[0]['set_name']);
            } else {
                //发送邮件给供应商账户
                OA_Account_Check::refuseMailtoAccount($vendorInfo[0]['vendor_account_id'], $request['reason'], $r[0]['vendor_name'], $sort, $rs[0]['id'], $rs[0]['set_name'], $href);
            }
            //创建操作日志
            if (!empty($vendorInfo[0])) {
                Data_Mysql_Table_Account_Log::insertAccountLog($vendorInfo[0]['vendor_account_id'], $_SESSION['administrator']['id'], '产品未通过审核', '审核产品', $request['id']);
            }
            Func_Header::to('该产品未通过审核！', Core::$urls['path'] . "?action=waiting&vendor_id=" . $_REQUEST['vendor_id'] . '&admin_name=' . $_REQUEST['admin_name']);
        }
        Func_Header::back('操作错误！');

    }

    static function handleSetPass()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'vendor_id' => 'int'
        ));
        if (empty($request['id'])) {
            Func_Header::notFound();
        }

        $condition['id'] = $request['id'];
        $update_data['status'] = 1;
        $update_data['refuse_reason'] = '';
        $update_rs = Data_Mysql_Table_Product_Set::subTable('_update')->update($condition, $update_data);
        if ($update_rs[0] > 0) {

            $update_data = Data_Mysql_Table_Product_Set::subTable('_update')->select('*', $condition);
            $rs = Data_Mysql_Table_Product_Set::subTable('_update')->rowFormat($update_data[0]);
            if (!empty($update_data[0]['id'])) {
                $rs['id'] = $update_data[0]['id'];
            }
            //如果之前被拒绝过则去掉名称“|”以及后面之前的拒绝理由
            if (!empty($update_data[0]['set_name'])) {
                $rs['set_name'] = preg_replace('/\|.*/', '', $update_data[0]['set_name']);
            }
            unset($rs['___search']);
//            unset($rs['refuse_reason']);
            //套餐通过并上线
            if (isset($_REQUEST['upstatus'])) {
                $rs['status'] = 1;
            } else {
                unset($rs['status']);
            }
            $set_rs = Data_Mysql_Table_Product_Set::update($rs);
            if ($set_rs[0] > 0) {
                //创建操作日志
                $vendorInfo = Data_Mysql_Table_Vendor_Info::select('id,vendor_account_id', array('id' => $request['vendor_id']));
                if (empty($vendorInfo[0])) {
                    Func_Header::to('该供应商没有绑定账户！');
                }
                Data_Mysql_Table_Account_Log::insertAccountLog($vendorInfo[0]['vendor_account_id'], $_SESSION['administrator']['id'], '套餐通过审核', '审核套餐', $request['id']);
                //创建历史记录
                $history_data = array('object_id' => $rs['id'], 'admin_id' => $_SESSION['administrator']['id'], 'operate_type' => 1, 'data_backup' => $rs);
                Data_Mysql_Table_History::subTable('_product_set' . date("_Ym"))->insert($history_data);
                Func_Header::to(' 套餐信息审核成功！', Core::$urls['path'] . "?action=waiting&vendor_id=" . $_REQUEST['vendor_id'] . '&admin_name=' . $_REQUEST['admin_name'] . '&time=' . time());

            }
        }
        Func_Header::to('拒绝理由字数不能超过100字！');
    }

    static function handleSetDetail()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'vendor_id' => 'int',
        ));
        $conditions['id'] = $request['id'];
        $conditions['vendor_id'] = $request['vendor_id'];
        $rs = Data_Mysql_Table_Product_Set::subTable('_update')->select('*', $conditions);
        $reason = array(
            '证件不全', '资历不够', '其他原因'
        );
        Tpl_Smarty::assign('rejectreason', $reason);
        Tpl_Smarty::assign('data', $rs[0]);
        Tpl_Smarty::display('OA', 'check/set_detail.tpl');
    }
}