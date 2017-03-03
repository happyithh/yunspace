<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/6
 * Time: 13:21
 * @带看场地
 *
 * 1.将客户的留下的备注加入到remark 中， 选择的时间加入到 look_time 中
 * 2. customer_feedback  改为 2
 * 3. 提交成功后发送一条消息到群组  说 【我想看场地】
 */
class  Api_Recommend_TakeLook extends Api
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
            'look_time' => 'string',
            'look_remark' => 'string',
        ), $args);
        if (empty($request['look_time']) || empty($request['recommend_id']) || empty($request['demand_id'])) {
            return Api::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        $data = Data_Mysql_Table_Demand_Recommend::select('id,remark', array('id=?' => $request['recommend_id'], 'demand_id=?' => $request['demand_id']));
        if (empty($data[0])) {
            return Api::request('error', '', '没有相关推荐信息，请尝试返回主界面重新打开');
        }
        $oldRemark = array();

        if ($data[0]['remark']) {
            $oldRemark = json_decode($data[0]['remark'], true);
        }

        if (empty($request['account_info']['id'])) {
            $reqRemark = array('[具体时间] ' => $request['look_time'],
                '[备注] ' => $request['look_remark']);
        } else {
            $reqRemark = array(
                '[' . $request['account_info']['username'] . ']' => '我想去看场地',
                '[具体时间] ' => $request['look_time'],
                '[备注] ' => $request['look_remark'],
            );
        }
        $newRemark = array_merge($reqRemark, $oldRemark);
       
        $status = Data_Mysql_Table_Demand_Recommend::update(array('id =?' => $data[0]['id']),
            array('remark' => $newRemark,
                'look_time' => strtotime($request['look_time'] . '00:00:00'),
                'customer_feedback' => 2,
            ));
        if ($status[0] > 0) {
            $to_account_id = Api_Demand_isGroup::isGroup(array('demand_id' => $request['demand_id']));
            Api_Livechat_Message_Send::handleSendMessage(array(
                'to_account_id' => Data_Mysql_Table_LiveChat_Group::convertToAccountId($to_account_id),
                'from_account_id' => $request['account_info']['id'],
                'message' => '我想看场地,具体时间：' . $request['look_time']));
            return Api::request('success', '', '  成功');
        }
        return Api::request('error', '', '您的提交的操作失败，请稍后再试');
    }

}