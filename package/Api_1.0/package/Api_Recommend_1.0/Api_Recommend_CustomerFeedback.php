<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/6
 * Time: 13:21
 * @客户对于需求推荐的 反馈
 */
class  Api_Recommend_CustomerFeedback extends Api
{
    /**
     *
     * @param  $args = array(){
     *              demand_id:
     *              recommend_id:
     *
     * }
     *
     * @return  array(
     *
     * )
     *
     */
    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        return self::feedback($args);
    }

    static function feedback($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'recommend_id' => 'int',
            'feedback' => 'int',     // 客户反馈    -1 :关闭       3有意向   5：想去看场地
        ), $args);
        if (empty($request['recommend_id']) || empty($request['feedback'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $status = Data_Mysql_Table_Demand_Recommend::update(array('id =?' => $request['recommend_id'], 'demand_id=?' => $request['demand_id']),
            array('customer_feedback =?' => $request['feedback']));
        if ($status[0] > 0) {
            return Api::request('success', '', '反馈成功');
        }
        return Api::request('error', '', '您的提交的操作失败，请稍后再试');

    }

}