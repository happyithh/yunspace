<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/27
 * Time: 16:15
 *
 * 1.删除需求,如果是用户操作，需要把自己移除群内
 */
class Api_Demand_Delete extends APi
{
    /**
     *    传入参数
     *$args= array(
     *          account_id => [Api_Session::user_id()]
     *          demand_id =>   需求ID
     * )
     * 返回  array()
     */

    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        $args['account_id'] = Api_Session::user_id();
        return self::demandDelete($args);
    }

    static function  demandDelete($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'demand_id' => 'int',
            'reason'=>'string',
            'demo'=>'string'
        ), $args);
        if (empty($request['account_id']) || empty($request['demand_id'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $is_exist = Data_Mysql_Table_Demand::select('id,group_id', array('id=?' => $request['demand_id']));
        if (empty($is_exist[0]['id'])) {
            return Api::request('error', '', '不存在这个群组');
        }

        $status = Data_Mysql_Table_Demand::update(array('id=?' => $request['demand_id'], 'account_id =?' => $request['account_id']),
            array('step' => '-1', 'demand_status' => '-1','demand_reason'=>array($request['demo'],$request['reason'])));
        if ($status[0] > 0 || 1) {
            Api_Livechat_Group_RemoveMember::handleRemoveMember(array(
                'account_id' => $request['account_id'],
                'group_id' => $is_exist[0]['group_id'],
                'remove_account_id' => $request['account_id'],
            ));


            return Api::request('success', '', '删除成功');
        } else {
            return Api::request('error', '', '需求删除失败，请稍后再试。');
        }
    }
}
