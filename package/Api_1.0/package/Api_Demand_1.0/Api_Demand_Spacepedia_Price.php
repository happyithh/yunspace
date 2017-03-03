<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-10-23
 * Time: 上午11:35
 */
class Api_Demand_Spacepedia_Price extends Api{
    static function handleSpacepediaPrice(){
        $request = Func_Input::filter(array(
            'demand_city' => 'string',
            'username' => 'string',
            'phone' => 'string',
            'people' => 'string',
            'content' => 'string',
            'demand_style' => 'string',
            'demand_other' => 'int',
            'demand_date' =>'string',
            'is_mobile' => 'int',
            'price_list'=>'string', //询价清单
            'space_name'=>'string',
            'item_name'=>'string',
            'item_id'=>'int',
            'item_price'=>'string',
            'other_demand'=>'string',
        ), $_REQUEST);
//        if (empty($request['content'])) {
//            return self::request('error', '', '咨询内容必须填写!');
//        }
        if (!empty($request['content']) && strlen($request['content']) > 500) {
            return self::request('error', '', '您的咨询内容输入过多!');
        }
        if (empty($_SESSION['user']) && empty($request['phone'])) {
            return self::request('error', '', '未登录用户联系电话必须填写!');
        }
        $demand_data = array(
            '联系电话' => $request['phone'],
            '活动人数' => $request['people'],
            '联系人' => $request['username'],
            '具体要求' => $request['content'],
            '活动城市' => $request['demand_city'],
            '活动类型' => $request['demand_style'],
            '询价清单'=>$request['price_list'],
            '需求场地'=>$request['space_name'],
            '空间名称'=>$request['item_name'],
            '空间ID'=>$request['item_id'],
            '预定价格'=>$request['item_price'],
            '其他要求'=>$request['other_demand'],
        );
        if(!empty($request['demand_date'])){
            $demand_data['活动日期']=$request['demand_date'];
        }
        if (!empty($request['demand_other'])) {
            $demand_data['具体要求'] = $demand_data['具体要求'] . "--还需要其他的配套服务";
        }
        $account = Api_Demand_Create::getAccountByPhone(array('phone' => $request['phone']));

        return Api_Demand_Create::create(array('demand' => $demand_data,
            'phone' => $request['phone'],
            'demand_type' => $request['is_mobile'] ? '办活动M' : '办活动',
            'demand_name' => '我要办活动--询价',
            'account_id' => $account['id']));
    }
}