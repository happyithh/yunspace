<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/13
 * Time: 13:26
 * @供应商加盟
 */

/**
 * 1.供应商加盟列表 /未审核/通过/未通过
 * 2.
 *
 *
 *
 *
 *
 *
 */
class OA_Vendor_Join
{
    static function  handle()
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::handleVendorJoinList();
                break;
            case 'detail':
                self::handleVendorJoinDetail();
                break;
            case 'ajaxVendorJoinPass':
                self::ajaxVendorJoinToPass();
                break;

            case 'ajaxVendorJoinRefuse':
                self::ajaxVendorJoinToRefuse();
                break;
            default:
                Func_Header::back('亲，请通过正常方式进入页面');
                break;
        }
    }

    static function  handleVendorJoinList()
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
            'search' => 'array',
        ), $_REQUEST);
        $type = !empty($request['type']) ? $request['type'] : "all";

        $order = 'ORDER BY create_time DESC';
        $conditions = array();
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'city' => 'string',
                'start_time' => 'string',
                'end_time' => 'string',
                'vendor_name' => 'string',
            ), $_REQUEST['search']);
            if (!empty($search['city'])) {
                $conditions['city'] = $search['city'];
            }

            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['create_time < ?'] = strtotime($search['end_time']);
            }
            if (!empty($search['vendor_name'])) {
                $conditions['vendor_name like ?'] = '%' . $search['vendor_name'] . '%';
            }
            $conditions_total = $conditions;
        }
        //搜索tab进行处理
        if (!empty($_REQUEST['search'])) {
            $searchArray = 'search[city]=' . $search['city'] . '&search[start_time]=' . $search['start_time']
                . '&search[end_time]=' . $search['end_time'] . '&search[vendor_name]=' . $search['vendor_name'];
            Tpl_Smarty::assign('urls', $searchArray);
        }
        //获取所有需求总数
        $totalNum = array(
            '0' => 0,
            '1' => 0,
            '-1' => 0,
            '2' => 0,   //总数
        );
        $conditions_total[] = '1 GROUP BY status';

        $cities = Data_Mysql_Table_Vendor_Join::select('city', '', 'GROUP BY city', 10000);
        Tpl_Smarty::assign('city', $cities[0]);
        $total = Data_Mysql_Table_Vendor_Join::select('count(*) as count, status', $conditions_total, '', 3);
        foreach ($total as $v) {
            $totalNum[$v['status']] = $v['count'];
            $totalNum[2] += $v['count'];
        }

        switch ($type) {
            case 'all':
                $data = Data_Mysql_Table_Vendor_Join::page(0, 0, '*', $conditions, $order);
                break;
            case 'waiting':
                $conditions['status'] = 0;
                $data = Data_Mysql_Table_Vendor_Join::page(0, 0, '*', $conditions, $order);
                break;
            case 'pass':
                $conditions['status'] = 1;
                $data = Data_Mysql_Table_Vendor_Join::page(0, 0, '*', $conditions, $order);
                break;
            case 'abandon':
                $conditions['status'] = '-1';
                $data = Data_Mysql_Table_Vendor_Join::page(0, 0, '*', $conditions, $order);
                break;
            default :
                $data = Data_Mysql_Table_Vendor_Join::page(0, 0, '*', '', $order);
                break;
        }
        Tpl_Smarty::assign('category', Api_Site_Config_ProductMenu::getMenu());
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('total', $totalNum);
        Tpl_Smarty::assign('status', Data_Mysql_Table_Vendor_Join::$status);
        Tpl_Smarty::display('OA_Static::vendor_join/vendor_join_list.tpl');
    }

    /**
     *
     * 1.供应商信息
     * 2.供应商产品的信息
     */
    static function handleVendorJoinDetail()
    {
        $request = Func_Input::filter(array(
            'vendor_join_id' => 'int',
        ), $_REQUEST);
        if (empty($request['vendor_join_id'])) {
            Func_Header::back('请返回列表重试');
        }
        $data = Data_Mysql_Table_Vendor_Join::select('*', array('id=?' => $request['vendor_join_id']));

        Tpl_Smarty::assign('category', Api_Site_Config_ProductMenu::getMenu());
        Tpl_Smarty::assign('_data', Data_Mysql_Table_Vendor_Join::rowFormat($data[0]));
        Tpl_Smarty::display('OA_Static::vendor_join/vendor_join_detail.tpl');
    }

    /**
     *
     * 1.通过审核后-通知这个商家
     * 2.将产品信息 加入到正常流程          加入到 update 表        ID未变
     * 3.将供应商信息加入到正常审核流程     加入到 update 表         ID未变
     *
     */
    static function  ajaxVendorJoinToPass()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'vendor_join_id' => 'int',
            'remark' => 'string'
        ));
        if (empty($request['vendor_join_id'])) {
            Func_Output::json('error', '', '请刷新后重新提交！');
        }
        $table = "{table} as t1 LEFT JOIN yun_vendor_info_update as t2 ON t1.account_id = t2.vendor_account_id";

        $status = Data_Mysql_Table_Vendor_Join::select('t1.id,t2.id as vendor_id,t2.base_info',
            array('t1.id=?' => $request['vendor_join_id'], 't1.status=?' => 0), '', 1, $table);
        if (empty($status[0])) {
            Func_Output::json('error', '', '不可操作，请返回列表重试！');
        }
        $data = Data_Mysql_Table_Vendor_Join::update(array('id' => $request['vendor_join_id']),
            array(
                'status' => '1',
                'remark' => $request['remark']
            ));
        if ($data[0] > 0) {
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '审核-通过', '加盟供应商审核', $request['vendor_join_id']);
            //将产品信息 转正
            if (!empty($status[0]['vendor_id'])) {

                /**
                 * 将供应商信息加入到正常审核流程
                 */
                $conditions = array('id=?' => $status[0]['vendor_id']);

                $vendorUpdate = Data_Mysql_Table_Vendor_Info::subTable('_update')->select('status', $conditions);
                if (!empty($vendorUpdate) && $vendorUpdate[0]['status'] == '-10') {
                    $updateData = array('status' => 2);
                    Data_Mysql_Table_Vendor_Info::subTable('_update')->update($conditions, $updateData);
                }
                //产品审核
                Data_Mysql_Table_Product_Info::subTable('_update')->update(array(
                    'vendor_id =?' => $status[0]['vendor_id'],
                    'status=?' => 0
                ), array(
                    'status' => 2
                ));

                Data_Mysql_Table_Account_Log::insertAccountLog(0, $_SESSION['administrator']['id'],
                    '供应商信息加入到正式表/status=' . $updateData['status'], '加盟供应商审核', $status[0]['vendor_id']);
            }
            Func_Output::json('success', '', ' 操作成功');
        }
        Func_Output::json('error', '', '操作失败');

    }

    /**
     * 审核-拒绝
     */
    static function  ajaxVendorJoinToRefuse()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'vendor_join_id' => 'int',
            'refuse_reason' => 'string',
        ));

        if (empty($request['vendor_join_id'])) {
            Func_Output::json('error', '', '请刷新后重新提交！');
        }
        $status = Data_Mysql_Table_Vendor_Join::select('id', array('id =?' => $request['vendor_join_id'], 'status =?' => 1));
        if (!empty($status[0])) {
            Func_Output::json('error', '', '不可关闭,请返回列表重试！');
        }
        $data = Data_Mysql_Table_Vendor_Join::update(array('id' => $request['vendor_join_id']),
            array(
                'refuse_reason' => empty($request['refuse_reason']) ? '' : $request['refuse_reason'],
                'status' => -1
            ));
        $account = Data_Mysql_Table_Vendor_Join::select('account_id,phone', array('id =?' => $request['vendor_join_id']));
        if ($data[0] > 0) {

            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '审核 - 拒绝', '加盟供应商审核', $account[0]['account_id']);
            $conditions = array('vendor_account_id =?' => $account[0]['account_id']);
            $updateData = array('status' => -2);
            $vendor = Data_Mysql_Table_Vendor_Info::subTable('_update')->update($conditions, $updateData);
            /*  $title ='您的供应商加盟审核已被拒绝！';
              Func_Message::sendSMS($request['phone'], array( $account[0]['phone'], $title), 23705);*/

            if ($vendor[0] > 0) {
                Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '将供应商信息加入 - 2 / 回收站', '加盟供应商审核', $account[0]['account_id']);
            }

            Func_Output::json('success', '', ' 操作成功');
        }

        Func_Output::json('error', '', '操作失败');
    }
}