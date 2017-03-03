<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-12-28
 * Time: 下午14:00
 * 一键租场地
 */
class Api_Demand_Rent_Space extends Api{
    static function handleRentSpace(){
        $request = Func_Input::filter(array(
            'demand_city' => 'string',
            'username' => 'string',
            'phone' => 'string',
            'people' => 'string',
            'demand_style' => 'string',
            'start_date' => 'string',
            'end_date' => 'string',
            'demand_budget' => 'string',
            'demand_other' => 'string',
            'demand_supply' => 'string',
            'space_name'=>'string',
            'item_id'=>'int',
            'space_item_name'=>'string',
            'is_mobile' => 'int',
        ), $_REQUEST);
        if (!empty($request['demand_supply']) && strlen($request['demand_supply']) > 500) {
            return self::request('error', '', '您的补充要求输入过多!');
        }
        if (empty($_SESSION['user']) && empty($request['phone'])) {
            return self::request('error', '', '未登录用户联系电话必须填写!');
        }
        if(empty($request['start_date']) || empty($request['end_date'])){
            return self::request('error', '', '请选择活动日期!');
        }

        if(!empty($request['start_date']) && !empty($request['end_date']) && strtotime($request['start_date']) > strtotime($request['end_date'])){
            return self::request('error', '', '请正确选择活动日期!');
        }
        $demand_data = array(
            '联系电话' => $request['phone'],
            '活动人数' => $request['people'],
            '联系人' => $request['username'],
            '活动城市' => $request['demand_city'],
            '活动类型' => $request['demand_style'],
            '开始时间' => $request['start_date'],
            '结束时间' => $request['end_date'],
        );
        if(!empty($request['demand_budget'])){
            $demand_data['活动预算']=$request['demand_budget'];
        }
        switch ($request["demand_budget"]) {
            case "2万以下":
                $data['price_down'] = 20000;
                break;
            case "2-5万":
                $data['price_up'] = 20000;
                $data['price_down'] = 50000;
                break;
            case "5-10万":
                $data['price_up'] = 50000;
                $data['price_down'] = 100000;
                break;
            case "10-30万":
                $data['price_up'] = 100000;
                $data['price_down'] = 300000;
                break;
            case "30-50万":
                $data['price_up'] = 300000;
                $data['price_down'] = 500000;
                break;
            case "50万以上":
                $data['price_up'] =500000;
                $data['price_down'] =500000;
                break;
        }

        $demand_data['具体要求']="";
        if (!empty($request['demand_other'])) {
            $demand_data['具体要求'].=  $request['demand_other'];
        }
        if (!empty($request['demand_supply'])) {
            $demand_data['具体要求'].=  " --- ".$request['demand_supply'];
        }
        if(!empty($request['space_name'])){
            $demand_data['意向场地']= $request['space_name'];
        }
        if(!empty($request['space_item_name'])){
            $demand_data['意向场地空间']= $request['space_item_name'];
        }
        if(!empty($request['item_id'])){
            $demand_data['item_id']= $request['item_id'];
        }
        $account = Api_Demand_Create::getAccountByPhone(array('phone' => $request['phone']));

        return Api_Demand_Create::create(array('demand' => $demand_data,
            'phone' => $request['phone'],
            'demand_type' => $request['is_mobile'] ? '一键租场地M' : '一键租场地',
//            'demand_name' => '一键租场地',
            'account_id' => $account['id'],
            'price_down'=>empty($data['price_down'])?0:$data['price_down'],
            'price_up'=>empty($data['price_up'])?0:$data['price_up'],
        ));
    }
}