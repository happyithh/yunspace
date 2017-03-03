<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-11-11
 * Time: 下午14:37
 * 场地百科--查看参考价
 */
class Api_Demand_Spacepedia_Look_Price extends Api{
    static function handleSpacepediaLookPrice(){
        $request = Func_Input::filter(array(
            'demand_city' => 'string',
            'phone' => 'string',
            'space_name'=>'string',
            'look_type'=>'string',
            'is_mobile' => 'int',
        ), $_REQUEST);
        if (empty($request['phone'])) {
            return self::request('error', '', '联系电话不能为空!');
        }
        $look_type="";
        if(empty($request['look_type'])){
            $demand_data['百科名称']=$request['space_name'];
            $look_type="场地百科";
        }elseif($request['look_type']=="product"){
            $demand_data['场地名称']=$request['space_name'];
            $look_type="空间场地";
        }
        $demand_data['查看类型']=$look_type;
        $demand_data['联系电话']=$request['phone'];
        $demand_data['活动城市']=$request['demand_city'];
        $account = Api_Demand_Create::getAccountByPhone(array('phone' => $request['phone']));

        return Api_Demand_Create::create(array('demand' => $demand_data,
            'phone' => $request['phone'],
            'demand_type' => $request['is_mobile'] ? '查看参考价M' : '查看参考价',
            'demand_name' => '客户资源--查看参考价',
            'account_id' => $account['id'])
        );
    }
}