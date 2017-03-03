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
class Api_Demand_Update extends Api
{
    /**
     * @传入参数  $args = array(
     *              demand_id =>'',     需求ID
     *              phone =>'',     手机号
     *              content =>'',     手机号
     *              level =>'',     手机号
     *
     * )
     */
    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        return self::handleDemandUpdate($args);
    }

    static function  handleDemandUpdate($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'phone' => 'string',
            'level' => 'int',
            'price' => 'string',
            'img' => 'string',
            'info' => 'string',
            'company' => 'string',
            'card' => 'string',
        ), $args);
        if (empty($request['demand_id']) || empty($request['phone'])) {
            return Api::request('error', '', '缺少关联的需求');
        }

        $request['demand_id']=Func_NumEncode::d($request['demand_id']);
        $oldDemand = Data_Mysql_Table_Demand::select('demand', array('id' => $request['demand_id'],"phone"=>$request['phone']));
        if (!empty($oldDemand[0]['demand'])) {
            $demand =json_decode($oldDemand[0]['demand'], 1);
        }
        if($request['level']==1){
            $demand['其他要求1']="场地价格：".$request['price']." -- 场地图片：".$request['img']." -- 基本信息：".$request['info'];
        }elseif($request['level']==2){
            $demand['免费vip-公司']=$request['company'];
            $demand['免费vip-名片']=$request['card'];
        }else{
            return Api::request('error', '', '操作错误');
        }
        $status = Data_Mysql_Table_Demand::update(array('id' => $request['demand_id'], 'phone' => $request['phone']), array("demand"=>$demand,"demand_level"=>$request['level']));
        if ($status[0] > 0) {
            $return['demand_id']=Func_NumEncode::e($request["demand_id"]);
            $return['phone']=Func_String::encrypt($request['phone'],"哈哈，猜不到吧");
            return Api::request('success',$return , '需求修改成功');
        }
        return Api::request('error', '', '操作错误');

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
            'demand_status' => 'int',
            'demand_type' => 'string',
            'resolve_time' => 'int',
            'demand' => 'array',
            'price_up' =>'int',
            'price_down'=>'int',
        ), $args);

        if (empty($request['demand']) || empty($request['demand_id'])) {
            return false;
        }
        $request['demand']['活动名称'] = $request['demand_name'];
        $newData = array(
            'demand' => $request['demand'],
            'city' => $request['city'],
            'demand_name' => $request['demand_name'],
        );
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
        if($request['demand']['联系电话'] ){
            $newData['phone'] = $request['demand']['联系电话'];
        }
        $status = Data_Mysql_Table_Demand::update(array('id =?' => $request['demand_id']), $newData);
        if ($status[0] > 0) {
            return true;
        }
        return false;
    }

}
