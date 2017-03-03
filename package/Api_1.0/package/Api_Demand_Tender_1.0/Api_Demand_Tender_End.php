<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/9/9
 * Time: 15:18
 * 结束
 */
class Api_Demand_Tender_End extends Api
{
    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        $args['account_id'] = Api_Session::user_id();
        return self::handleEnd($args);
    }

    static function  handleEnd($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'tender_id' => 'int',
        ), $args);
        Api_Log_Create::handle(array(
            'class' => get_called_class(),
            'func' => __FUNCTION__,
            'tender_id' => $request['tender_id'],
            'behavior' => '结束竞标'
        ));

        $is_exist = Data_Mysql_Table_Demand_Tender::select('{table}.id', array(
            '{prefix}demand.account_id =?' => $request['account_id'],
            '{table}.id =?' => $request['tender_id']), '', 1, "{table} LEFT JOIN {prefix}demand ON {table}.demand_id={prefix}demand.id");
        if (!empty($is_exist[0]['id'])) {

            $data['status'] = '-1';
            $rs = Data_Mysql_Table_Demand_Tender::update(array('id' => $request['tender_id']), $data);
            Data_Mysql_Table_Demand_Tender_Scheme::update(array('tender_id=?' => $request['tender_id'], 'status=?' => 0), $data);

            if ($rs[0] > 0) {
                return Api::request('success', '', '操作成功');
            }
            return Api::request('error', '', '操作失败');
        }
        return Api::request('error', '', '不可操作~');
    }
}