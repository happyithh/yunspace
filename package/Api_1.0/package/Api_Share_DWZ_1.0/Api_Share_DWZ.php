<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/7/6
 * Time: 16:44
 * @分享短网址
 */
class  Api_Share_DWZ extends Api
{
    /**
     * 接收参数
     * $args= array(
     *      account_id=[Api_Session::user_id]
     *      id   => 产品ID||套餐ID
     *      type  =>  类型   1：产品，2：套餐
     * )
     *
     *
     *
     *
     * *
     * 返回结果：
     * 返回状态status （0，返回未成功，1返回成功），
     * 状态消息 msg：返回成功 或返回失败原因
     * 返回结果data：url连接
     *
     */

    static function  handle($args = '')
    {
        $args['account_id'] = Api_Session::user_id();
        return self::handleShareLink($args);
    }

    static function handleShareLink($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'id' => 'int',
            'type' => 'int',
        ), $args);
        if (empty($request['id']) || empty($request['type']) || empty($request['account_id'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $url = Data_Mysql_Table_Dwz::getUrl($request['account_id'], $request['id'], $request['type']);
        if (!empty($url)) {
            return self::request('success', $url, '生成分享链接成功');
        }
        return Api::request('error', '', '生成分享链接失败');

    }


}