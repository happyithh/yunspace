<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/9/9
 * Time: 10:59
 */
class  Api_Log_Create extends Api
{

    static function  handle($args = '')
    {

        $args['accountInfo'] = Api_Session::user_info();
        $type = empty($args['type']) ? 'demandTender' : $args['type'];

        switch ($type) {
            case 'demandTender':
                $return = self::DemandTenderLog($args);
                break;
        }
    }

    static function  DemandTenderLog($args)
    {

//        //日志
//        Api_Log_Create::handle(array(
//            'class' => get_called_class(),
//            'func' => __FUNCTION__,
//            'tender_id' => $request['tender_id'],
//            'behavior' => '商家提交方案'
//        ));
//            'behavior' => 'string',
//            'tender_id' => 'int',
//            'scheme_id' => 'int'
        $request = Func_Input::filter(array(
            'class' => 'string',
            'func' => 'string',
            'behavior' => 'string',
            'accountInfo' => 'array',
            'tender_id' => 'int',
            'scheme_id' => 'int'
        ), $args);

        $logData = array(
            'php_class' => $request['class'],
            'php_func' => $request['func'],
            'behavior' => $request['behavior'],
            'loginInfo' => $request['accountInfo'],
            'account_id' => @$request['accountInfo']['id'],
            'tender_id' => $request['tender_id'],
            'scheme_id' => $request['scheme_id'],
            'create_time' => time()
        );
        $a = Data_Mysql_Table_Vendor_Demand_Tender_Log::subTable('_' . Date('m'))->update($logData);
    }

    /**
     * @param $args
     *
     *记录空间搜索的数据
     */
    static function  SpaceScreening($args)
    {

        $request = Func_Input::filter(array(
            'class' => 'string',
            'func' => 'string',
            'behavior' => 'string',
            'accountInfo' => 'array',
            'screening' => 'array',
        ), $args);

        $userInfo = Api_Session::user_info();
        $data = array(
            'php_class' => $request['class'],
            'php_func' => $request['func'],
            'behavior' => $request['behavior'],
            'loginInfo' => $userInfo,
            'account_id' => @$userInfo['id'],
            'screening' => $request['screening'],
            'city' => $_COOKIE['city']
        );
        Data_Mysql_Table_Space_Screening_Log::subTable('_' . Date('m'))->update($data);
    }

}