<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/11/27
 * Time: 13:33
 */
//需求订单详情页
@session_start();
class Api_Demand_Product_Detail extends Api
{
    static function handle($args='')
    {
//        Api_Session::checkToken(1);
        return self::handlegetDetail($args);
    }


    static function handlegetDetail($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ),$args);
        $conditions = array();
        if ($request['id']) {
            $conditions['id = ?'] = $request['id'];
        }

        //检测该手机号下的所有子空间id，控制手机号子空间权限
        $rs_name = Api_Demand_Product_Name::handle(array('phone' => $_SESSION['user']['phone']));
        $item_ids = array();
        foreach($rs_name['data'] as $key=>$val) {
            $item_ids[]= $val['id'];
        }
        $conditions[] = 'item_id IN ('.implode(',',$item_ids).')';


        $rs = Data_Mysql_Table_Product_Demand::select('*', $conditions,'',1);

//        q($rs);
        if(!empty($rs[0])) {
        $rs[0]['detail'] = json_decode($rs[0]['detail'],1);
        $rs[0]['demand'] = json_decode($rs[0]['demand'],1);
        $rs[0]['demand_id'] = Func_NumEncode::e($rs[0]['demand_id']);
        $start_time_year = date('Y',$rs[0]['activity_start_time']);
        $end_time_year = date('Y',$rs[0]['activity_end_time']);
        if($start_time_year != $end_time_year) {
            $rs[0]['total_day'] = 1+365-date('z',$rs[0]['activity_start_time'])+date('z',$rs[0]['activity_end_time']);
        } else {
            $rs[0]['total_day'] = date('z',$rs[0]['activity_end_time'])-date('z',$rs[0]['activity_start_time'])+1;
        }
//        if($rs>0) {
            $result = self::request('success',$rs,'成功');
        }else{
            $result = self::request('error','','失败');
        }
        return $result;
    }
}