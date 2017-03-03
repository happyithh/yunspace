<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/14
 * Time: 14:26

 */
class Api_Grab_Order_OperationIntegral extends Api
{

    /**
     * @param $args
     * @return array
     * 根据手机号查询积分
     */
    static function  getIntegralByPhone($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone'
        ), $args);

        if (empty($request['phone'])) {
            return Api::request('error', '', '手机号格式不对~');
        }
        $data = Data_Mysql_Table_Administrator::select('integral', array(
            'phone=? AND status>?' => array($request['phone'], 0)
        ));

        return Api::request('success', intval($data[0]['integral']), 'ok');
    }


    static function  saleIntegral($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'sale' => 'int',
        ), $args);

        $phoneIntegral = self::getIntegralByPhone(array('phone' => $request['phone']));
        if ($phoneIntegral['status'] == 1) {

            $data = Data_Mysql_Table_Administrator::update(array('phone=?' => $request['phone']), array('integral=', $phoneIntegral['data'] - ($request['sale'])));
            if (empty($data[0])) {
                return Api::request('error', '', '失败');
            }
            return Api::request('success', '', '成功');

        }
        return $phoneIntegral;

    }


} 