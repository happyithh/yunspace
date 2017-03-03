<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/23
 * Time: 9:37
 * 需求单分配
 */
class Api_Grab_Order_Allot extends Api
{

    static function  handle($args = '')
    {
        $action = empty($_REQUEST['action']) ? '' : $_REQUEST['action'];

        switch ($action) {
            case 'allot_admin':
                return self::handleAllot($args);
                break;
            //重新分配
            case 'clear':
                return self::handleClear($args);
                break;
            default:
                Api_Session::checkToken(1);
                return self::handleAllot($args);
                break;


        }
    }

    /**
     * @param $args
     * @return array
     * 重新分配销售
     */
    static function  handleClear($args)
    {
        @session_start();
        $request = Func_Input::filter(array(
            'demand_id' => 'int',

        ), $args);

        if (empty($_SESSION['administrator'])) {
            return Api::request('error', '', ' 请先登录管理员');
        }
        if (empty($request['demand_id'])) {
            return Api::request('error', '', '缺少条件~！');
        }
        $table = "{table} as t1 RIGHT JOIN {prefix}demand as t2 ON t1.id =t2.id";
        $rs = Data_Mysql_Table_Grab_Order::select('t1.id,t1.sale_phone', array('t2.id=?' => array($request['demand_id'])), '', 1, $table);
        if (empty($rs[0])) {
            return Api::request('error', '', ' 不存在这个数据');
        }
        Data_Mysql_Table_Account_Log::insertAccountLog('', Api_Session::admin_id(), '重新分配', '点击了重新分配', $request['demand_id']);
        Data_Mysql_Table_Demand::query("UPDATE {table} SET response_account_id=? WHERE id=?", array(0, $request['demand_id']), 1);
        $data = Data_Mysql_Table_Grab_Order::update(array('id=?' => array($request['demand_id'])), array('sale_phone' => ''));
        if (empty($data[0])) {
            return Api::request('error', '', '失败');
        }
        Data_Mysql_Table_Account_Log::insertAccountLog('', $_SESSION['administrator']['id'], $_SESSION['administrator']['fullname'] . '重新分配需求单', '分配需求单', $request['demand_id']);

        //如果是报价系统
        if ($rs[0]['sale_phone'] == 9) {
            Api_Demand_Notice_V2::adminNoticeDemandOffer($request['demand_id'], 'clear');
        }
        return Api::request('success', '', '  成功');
    }

    static function  handleAllot($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'sale_phone' => 'phone',
        ), $args);

        if (empty($request['demand_id'])) {
            return Api::request('error', '', '参数缺少，请刷新后重试');
        }
        //如果是抢单 转走
        if ($_REQUEST['sale_phone'] == '-9') {
            return Api_Demand_Handle::handleInDemandOffer(array('id' => $request['demand_id']));
        }
        if (empty($request['sale_phone'])) {
            return Api::request('error', '', '手机号不正确！');
        }
        Data_Mysql_Table_Account_Log::insertAccountLog('', Api_Session::admin_id(), '分配需求单', '将id=' . $request['demand_id'] . '分给' . $request['sale_phone'], $request['demand_id']);

        $check = Data_Mysql_Table_Administrator::select('id,email', array('phone =?' => $request['sale_phone'], 'status=? ' => 1));

        if (!empty($check[0])) {
            $data = Data_Mysql_Table_Grab_Order::update(array(
                'id' => $request['demand_id'],
                'sale_phone' => $request['sale_phone'],
                'allot_time' => time(),
                'status' => 1,
            ));
            if (empty($data[0])) {
                return Api::request('error', '', '分配失败！请尝试刷新页面');
            }
            Data_Mysql_Table_Demand::query("UPDATE {table} SET admin_id=? WHERE id=?", array($check[0]['id'], $request['demand_id']), 1);

            //通知这个销售
            Api_Demand_Notice_V2::saleAllotNotice_A(array(
                'sale_phone' => $request['sale_phone'],
                'id' => $request['demand_id']
            ));
            if (!empty($check[0]['email'])) {

                //邮件通知
                Api_Demand_Notice_V2::saleAllotNotice_A_email(array(
                    'demand_id' => $request['demand_id'],
                    'email' => $check[0]['email']
                ));
            }
            //标记销售
            Data_Mysql_Table_Demand::handleAddMarkTags(array(
                'demand_id' => $request['demand_id'],
                'mark_id' => 21,

            ));
            // 文创项目合作同步至文创场地
            $res = Data_Mysql_Table_Demand::select('demand_type',array('id'=>$request['demand_id']));
            if(!empty($res[0]) && $res[0]['demand_type']=='文创项目合作'){
                Api_Winchance_Online_Site_Create::WinchanceSiteCreate($request['demand_id']);
            }

            return Api::request('success', '', ' 成功');
        }
        return Api::request('error', '', '不存在这个销售人员！');

    }

} 