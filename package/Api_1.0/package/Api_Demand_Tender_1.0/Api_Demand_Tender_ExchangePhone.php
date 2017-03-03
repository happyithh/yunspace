<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/27
 * Time: 11:18
 * @交换手机号
 */
class  Api_Demand_Tender_ExchangePhone extends Api
{

    /**
     * @param string $args
     *
     */
    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        return self::ExchangePhone($args);
    }

    static function  ExchangePhone($args)
    {
        $request = Func_Input::filter(array(
            'scheme_id' => 'int',
            'tender_id' => 'int',
        ), $args);
        if (empty($request['tender_id'])) {
            return Api::request('error', '', '缺少参数~');
        }
        $is_exist = Data_Mysql_Table_Demand_Tender_Scheme::select('vendor_account_id', array(
            'tender_id=?' => $request['tender_id'],
            'id=?' => $request['scheme_id']));

        if (empty($is_exist[0]['vendor_account_id'])) {
            return Api::request('error', '', '操作失败~  如您遇到问题可以拨打400-056-0599~');
        }
        $data['tender_id'] = $request['tender_id'];
        $data['status'] = 1;
        $status = Data_Mysql_table_Demand_Tender_Scheme::update(array('id=?' => $request['scheme_id']), $data);
        //日志
        Api_Log_Create::handle(array(
            'class' => get_called_class(),
            'func' => __FUNCTION__,
            'tender_id' => $request['tender_id'],
            'scheme_id' => $request['scheme_id'],
            'behavior' => '交换电话'
        ));
        if ($status[0] > 0) {
            Data_Mysql_table_Demand_Tender::update(array(
                    'id=?' => $request['tender_id'],
                    'status=?' => 0
                ),
                array(
                    'status' => 1,
                    'scheme_id' => $request['scheme_id']
                )
            );
            //通知供应商
            Api_Demand_Tender_NoticeVendor::noticeVendorLookPhone(
                Api_Account_GetBaseInfo::getBaseInfoById(array('account_id' => $is_exist[0]['vendor_account_id'])),
                $request['tender_id']);

            return Api::request('success', '', '操作成功');
        }
        return Api::request('error', '', '操作失败');

    }
}