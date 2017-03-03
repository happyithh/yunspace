<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/27
 * Time: 16:15
 *
 * 需求修改
 * 1.修改需求表单
 * 2.修改群名称
 */
class Api_Demand_Edit extends Api
{
    /**
     * @传入参数  $args = array(
     *              account_id =>[Api_Session::user_id()],
     *              demand_id =>'',     需求ID
     *              demand =>array,     需求详情
     *
     * )
     *
     *
     *
     */
    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        $args['account_id'] = Api_Session::user_id();
        return self::handleMyDemandEdit($args);
    }

    static function  handleMyDemandEdit($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'demand_id' => 'int',
            'demand' => 'array',
        ), $args);

        if (empty($request['demand_id'])) {
            return Api::request('error', '', '缺少关联的需求');
        }
        $data = Func_Input::filter(array(
            '活动名称' => 'string',
            '活动人数' => 'string',
            '开始时间' => 'string',
            '活动类型' => 'string',
            '活动预算' => 'string',
            '具体要求' => 'string',
        ), $request['demand']);
        foreach ($data as $k => $val) {
            if (empty($data[$k])) {
                return Api::request('error', '', '为了更好的服务您，请正确填写' . $k);
            }
        }
        if (strlen($data['具体要求']) > 400) {
            return Api::request('error', '', '具体要求内容输入过长');
        }
        $oldDemand = Data_Mysql_Table_Demand::select('demand,group_id', array('id =?' => $request['demand_id']));
        if (!empty($oldDemand[0]['group_id'])) {
            Api_Livechat_Group_ReName::handleRename(array('account_id' => $request['account_id'],
                'group_id' => $oldDemand[0]['group_id'],
                'name' => $data['活动名称'],
            ));
        }
        if (!empty($oldDemand[0]['demand'])) {
            $newDemand = array_merge(json_decode($oldDemand[0]['demand'], 1), $data);
        } else {
            $newDemand = $data;
        }
        $newData = array(
            'demand_name' => $data['活动名称'],
            'demand' => $newDemand,
        );
        $status = Data_Mysql_Table_Demand::update(array('id =?' => $request['demand_id'], 'account_id=?' => $request['account_id']), $newData);
        if ($status[0] > 0) {
            return Api::request('success', '', '需求修改成功');
        }
        return Api::request('error', '', '需求修改失败');

    }

    /**
     * @传入参数  $args = array(
     *              account_id =>[Api_Session::user_id()],
     *              demand_status =>'',     需求状态
     *              demand_id =>'',     需求ID
     *              demand =>array,     需求详情
     *
     * )
     * 返回  bool
     */
    static function  demandEdit($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'demand_name' => 'string',
            'admin_id' => 'int',
            'city' => 'string',
            'notice_city' => 'string',
            'demand_status' => 'int',
            'demand_type' => 'string',
            'resolve_time' => 'int',
            'demand' => 'array',
            'price_up' => 'int',
            'price_down' => 'int',
            'is_phone' =>'int'
        ), $args);

        if (empty($request['demand']) || empty($request['demand_id'])) {
            return false;
        }
        $request['demand']['活动名称'] = $request['demand_name'];
        $newData = array(
            'demand' => $request['demand'],
            'demand_name' => $request['demand_name'],
        );
        if (!empty($request['city'])) {
            $newData['city'] = $request['city'];
        }
        if (!empty($request['notice_city'])) {
            $newData['notice_city'] = $request['notice_city'];
        }
        if (!empty($request['demand_type'])) {
            $newData['demand_type'] = $request['demand_type'];
        }
        if (!empty($request['demand_status'])) {
            $newData['demand_status'] = $request['demand_status'];
        }
        if (!empty($request['resolve_time'])) {
            $newData['resolve_time'] = $request['resolve_time'];
        }
        if (!empty($request['admin_id'])) {
            $newData['admin_id'] = $request['admin_id'];
        }
        if (!empty($request['price_up'])) {
            $newData['price_up'] = $request['price_up'];
        }
        if (!empty($request['price_down'])) {
            $newData['price_down'] = $request['price_down'];
        }
        if ($request['demand']['联系电话']) {
            $newData['phone'] = $request['demand']['联系电话'];
        }
        if(!empty($request['is_phone'])){
            $newData['is_phone'] = $request['is_phone'];
        }
        $status = Data_Mysql_Table_Demand::update(array('id =?' => $request['demand_id']), $newData);
        if ($status[0] > 0) {
            if($_REQUEST['data']['需求类型']=='文创项目合作'){
                Api_Winchance_Online_Site_Create::WinchanceSiteCreate($request['demand_id']);
            }
            return true;
        }
        return false;
    }

}
