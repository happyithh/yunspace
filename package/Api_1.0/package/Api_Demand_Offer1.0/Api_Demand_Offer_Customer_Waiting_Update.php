<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/10/16
 * Time: 15:20
 *
 * 客户更新等待时间
 *
 */

/**
 *
 * 1. 等待一个小时获取更多报价，更新报价主表的等待状态
 * 2. 选择不再接受报价,将报价关闭，更新报价主表的报价状态
 * 3.选择等待时间后注册一个计划任务，
 */
class Api_Demand_Offer_Customer_Waiting_Update extends Api
{

    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        $args['account_info'] = Api_Session::user_info();
        switch ($_REQUEST['type']) {
            case 'waiting':
                return self::waitingUpdate($args);
                break;
            default:
                return self::StatusUpdate($args);
                break;

        }

    }

    /**
     * @param $args
     * @return array
     * 状态修改
     */
    static function  StatusUpdate($args)
    {
        $request = Func_Input::filter(array(
            'offer_id' => 'int',
            'type' => 'string',
            'account_info' => 'array',
        ), $args);
        if (empty($request['offer_id'])) {
            return Api::request('error', '', '参数缺失，请返回重试');
        }
        $conditions['t1.id =?'] = $request['offer_id'];
        $conditions['t2.account_id =?'] = $request['account_info']['id'];
        //
        switch ($request['type']) {
            case 'close':
                $conditions['t1.status >=?'] = 0;
                $data = array(
                    'status' => '-1'
                );
                break;
            case 'noScheme':
                $conditions['t1.status >=?'] = 0;
                $data = array(
                    'status' => '-1'
                );
                break;
            case 'open':
                $conditions['t1.status <?'] = 0;
                $data = array(
                    'status' => 1
                );
                break;
            default:
                return Api::request('error', '', '错误的选项~');

        }
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.demand_id = t2.id";
        $is_exist = Data_Mysql_Table_Demand_Offer::select('t1.id,t1.status', $conditions, '', 1, $table);
        if (empty($is_exist[0])) {
            return Api::request('error', '', '当前状态不可修改~');
        }
        $rs = Data_Mysql_Table_Demand_Offer::update(array('id =?' => array($request['offer_id'])), $data);
        if (empty($rs)) {
            return Api::request('error', '', '修改失败');
        }
        return Api::request('success', '', '修改成功');

    }

    /**
     * @param $args
     * @return array
     */
    static function  waitingUpdate($args)
    {
        $request = Func_Input::filter(array(
            'offer_id' => 'int',
            'waiting_time' => 'int',
            'account_info' => 'array',

        ), $args);
        if (empty($request['offer_id'])) {
            return Api::request('error', '', '参数缺失，请返回重试');
        }
        $conditions['t1.id =?'] = $request['offer_id'];
        $conditions['t2.account_id =?'] = $request['account_info']['id'];
        $table = "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.demand_id = t2.id";

        $is_exist = Data_Mysql_Table_Demand_Offer::select('t1.id,t1.demand_id,t1.status', $conditions, '', 1, $table);

        if (empty($is_exist[0]['id'])) {
            return Api::request('error', '', '不存在需求~,有问题请致电400-056-0599');
        }


        //根据客户选择等待时间注册计划任务
        switch ($request['waiting_time']) {
            case -1:
                $data = array(
                    'status' => -1
                );
                break;
            default :
                $data = array(
                    'status' => 3,
                );
                break;

        }
        $rs = Data_Mysql_Table_Demand_Offer::update(array('id =?' => $request['offer_id'], 'status >=?' => 0), $data);
        if (empty($rs[0])) {
            return Api::request('error', '', '更新失败~');
        }

        return Api::request('success', '', '更新成功~');

    }

}