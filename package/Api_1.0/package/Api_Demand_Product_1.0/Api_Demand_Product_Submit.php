<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/11/27
 * Time: 13:33
 */
//需求订单编辑和添加
@session_start();
class Api_Demand_Product_Submit extends Api
{
    static function handle($args='')
    {
//        Api_Session::checkToken(1);
        return self::handleSubmit($args);
    }


    static function handleSubmit($args)
    {
        $args['activity_start_time'] = strtotime($args['activity_start_time']);
        $args['activity_end_time'] = strtotime($args['activity_end_time']);
        $request = Func_Input::filter(array(
            'id' => 'int',                     //此订单的id
            'demand_time' => 'int',           //订单时间
            'status' => 'tinyint',            //订单状态
            'activity_start_time' => 'int',   //活动开始日期
            'activity_end_time' => 'int',     //活动结束日期
            'item_id' => 'int',              //场地名称ID
            'from_where' => 'int',              //订单来源
            'detail' => 'array',
            'demand' => 'array',
        ),$args);

        if(empty($request['status'])) {
            return $result = self::request('error','','请选择订单状态');
        }
        if(empty($request['activity_start_time'])) {
            return $result = self::request('error','','请选择活动开始日期');
        }
        if(empty($request['activity_end_time'])) {
            return $result = self::request('error','','请选择活动结束日期');
        }
        if(empty($request['detail']['活动名称'])) {
            return $result = self::request('error','','请填写活动名称');
        }
        if(empty($request['demand']['people'])) {
            return $result = self::request('error','','请填写订单联系人');
        }
        if(empty($request['demand']['phone'])) {
            return $result = self::request('error','','请输入手机号码');
        }

        $data = array();
        @!empty($_SESSION['user']['phone']) and $data['account_phone'] = $_SESSION['user']['phone'];
        $data['demand_time'] = !empty($request['demand_time']) ? $request['demand_time'] : time();
        $data['status'] = $request['status'];
        $data['activity_start_time'] = $request['activity_start_time'];
        $data['activity_end_time'] = $request['activity_end_time'];
        $data['item_id'] = $request['item_id'];
//        $rs_product = Data_Mysql_Table_Product_info::select('product_name',array('id'=>$request['item_id']),'',1);
        $rs_product = Data_Mysql_Table_Space_Item::select('item_name',array('id'=>$request['item_id']),'',1);
//        $data['item_name'] = $rs_product[0]['product_name'];
        $data['item_name'] = empty($rs_product[0]['item_name']) ? '' : $rs_product[0]['item_name'];
        $data['from_where'] = empty($request['from_where']) ? '' : $request['from_where'];

//        !empty($request['detail']['price']) and $data['detail']['price'] = $request['detail']['price'];
        $data['detail']['price'] = empty($request['detail']['price']) ? '' : $request['detail']['price'];
        $data['detail']['per_price'] = empty($request['detail']['per_price']) ? '' : $request['detail']['per_price'];
        $data['detail']['other_price'] = empty($request['detail']['other_price']) ? '' : $request['detail']['other_price'];
        $data['detail']['per_other_price'] = empty($request['detail']['per_other_price']) ? '' : $request['detail']['per_other_price'];
        $data['detail']['活动名称'] = empty($request['detail']['活动名称']) ? '' : $request['detail']['活动名称'];
        $data['detail']['活动类型'] = empty($request['detail']['活动类型']) ? '' : $request['detail']['活动类型'];
        $data['detail']['活动人数'] = empty($request['detail']['活动人数']) ? '' : $request['detail']['活动人数'];
        $data['detail']['活动备注'] = empty($request['detail']['活动备注']) ? '' : $request['detail']['活动备注'];

        $data['demand']['people'] = empty($request['demand']['people']) ? '' : $request['demand']['people'];
        $data['demand']['phone'] = empty($request['demand']['phone']) ? '' : $request['demand']['phone'];
        $data['demand']['email'] = empty($request['demand']['email']) ? '' : $request['demand']['email'];
        $data['demand']['company'] = empty($request['demand']['company']) ? '' : $request['demand']['company'];
        $data['demand']['company_type'] = empty($request['demand']['company_type']) ? '' : $request['demand']['company_type'];
//        q($data);
        if (!empty($request['id'])) {
            $rs = Data_Mysql_Table_Product_Demand::update(array('id'=>$request['id']),$data);
        } else {
            $rs = Data_Mysql_Table_Product_Demand::insert($data);
        }
        if($rs>0) {
            $result = self::request('success',$data,'成功');
        }else{
            $result = self::request('error','','失败');
        }
        return $result;
    }
}