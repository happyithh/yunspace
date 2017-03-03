<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/6
 * Time: 13:21
 * @一条推荐记录的备注
 */
class  Api_Recommend_Remark extends Api
{
    /**
     *
     * @param  $args = array(){
     *              account_info ：[Api_Session::user_info()],
     *              demand_id:
     *              recommend_id:
     *              remark:         //客户的备注
     * }
     *
     * @return  array(
     *
     * )
     *
     * 1将原来的备注读取出来在
     */
    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        $args['account_info'] = Api_Session::user_info();
        return self::remark($args);
    }

    static function remark($args)
    {
        $request = Func_Input::filter(array(
            'account_info' => 'array',
            'demand_id' => 'int',
            'recommend_id' => 'int',
            'remark' => 'string',
        ), $args);
        if (empty($request['recommend_id']) || empty($request['remark'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $data = Data_Mysql_Table_Demand_Recommend::select('id,clientele_remark', array('id=?' => $request['recommend_id'], 'demand_id=?' => $request['demand_id']));
        if (empty($data[0])) {
            return Api::request('error', '', '没有相关推荐信息，请尝试返回主界面重新打开');
        }
        $oldRemark = json_decode($data[0]['clientele_remark'], true);
        $reqRemark = array(
            '[姓名]' => $request['account_info']['username'],
            '[备注]' => $request['remark'],
            '[时间]' => date('Y-m-d H:i:s'),
        );
        if (is_array($oldRemark)) {
            $newRemark = array_merge($oldRemark, $reqRemark);
        } else {
            $newRemark = $reqRemark;
        }
        $status = Data_Mysql_Table_Demand_Recommend::update(array('id =?' => $data[0]['id']),
            array('clientele_remark' => $newRemark));
        if ($status[0] > 0) {
            return Api::request('success', '', '成功');
        }
        return Api::request('error', '', '您的提交的操作失败，请稍后再试');
    }

}