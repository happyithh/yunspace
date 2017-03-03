<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/11/12
 * Time: 15:26
 */
class Api_Demand_Offer_Match_Result_Send_Message extends Api{

    static function handle(){
        return self::sendMessage($_REQUEST);
    }

    static function sendMessage($args){
        $request = Func_Input::filter(array(
            'item_id' => 'int',
            'demand_id'=>'int',
            'offer_id'=>'int',
        ),$args);
        if(empty($request['item_id'])||empty($request['demand_id'])||empty($request['offer_id'])){
            return self::request('error','',"参数错误!");
        }
        //加入匹配结果
        $data =  array(
            'demand_id'=>$request['demand_id'],
            'offer_id'=>$request['offer_id'],
            'item_id'=> $request['item_id'],
            'match_level'=>5,
            'notice_time'=>-1,
        );
        Api_Demand_Offer_Match_Result_Insert::insertResult($data);
        $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));
        if(!empty($administratorAccount['account_id'])){
            $account_id =$administratorAccount['account_id'];
        }
        Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '报价-添加到待发送列表',  $_SESSION['administrator']['username'].'报价系统添加到待发送短信列表：需求id'.$request['demand_id'], $request['demand_id']);

        Api_Demand_Offer_Send_SMS_Vendor::Cron();
        return self::request('success',$request,"数据更新成功!");
    }

}