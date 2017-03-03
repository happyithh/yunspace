<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/22
 * Time: 18:10
 * 修改报价发短信状态。状态改为-1 意为改场地需要发短息给供应商（负责人）
 */
class Api_Demand_Offer_Match_Result_Delete extends  Api{

        static  function handle(){
            return self::deleteData($_REQUEST);
        }

        static  function deleteData($args){

              $request = Func_Input::filter(array(
                    'id' => 'int',
                  'demand_id' => 'int',
                ),$args);
            if(empty($request['id'])||empty($request['demand_id'])){
                return self::request('error',"","参数错误!");
            }
            $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("*",array('demand_id=?'=>$request['demand_id']),'',1);
            if(empty($demand_offer_info)){
                return Api::request('error', '', '当前需求已经是关闭状态。');
            }
             $month = date('Ym', $demand_offer_info[0]['create_time']);
            $rs = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->delete(array('id=?'=>$request['id']));
            $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));
            if(!empty($administratorAccount['account_id'])){
                $account_id =$administratorAccount['account_id'];
            }
            Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '删除报价匹配结果',  $_SESSION['administrator']['username'].'删除匹配结果：需求id'.$request['demand_id'], $request['demand_id']);
            if($rs){
                return self::request('success',$request,"删除成功");
            }else{
                return self::request('error',"","删除失败!");
            }

        }

}
