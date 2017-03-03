<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/22
 * Time: 18:10
 * 修改报价发短信状态。状态改为-1 意为改场地需要发短息给供应商（负责人）
 */
class Api_Demand_Offer_Match_Result_Change_Status extends  Api{

        static  function handle(){
            return self::changeNoticeTime($_REQUEST);
        }

        static  function changeNoticeTime($args){

              $request = Func_Input::filter(array(
                    'id' => 'int',
                  'demand_id' => 'int',
                  'type'=>'int'
                ),$args);
            if(empty($request['demand_id'])){
                return self::request('error',"","参数错误!");
            }
            $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("*",array('demand_id=?'=>$request['demand_id']),'',1);
            if(empty($demand_offer_info)){
                return Api::request('error', '', '当前需求已经是关闭状态。');
            }
             $month = date('Ym', $demand_offer_info[0]['create_time']);
            $type = empty($request['type']) ? 0: $request['type'];
            switch($type){
                case 1:
                    $rs = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update(array('demand_id=?'=>$request['demand_id'],'match_level=?'=>5,'notice_time=?'=>0),array('notice_time=?'=>-1),'');
                    break;
                case 2:
                    $rs = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update(array('demand_id=?'=>$request['demand_id'],'match_level=?'=>3,'notice_time=?'=>0),array('notice_time=?'=>-1),'');
                    break;
                default:
                    if(empty($request['id'])){
                        return self::request('error',"","参数错误!");
                    }
                    $rs = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update(array('id=?'=>$request['id']),array('notice_time=?'=>-1),'');
                    break;
            }
            if($rs){
                //激活发送短信的计划任务
//               $result =  Data_Mysql_Table_Demand_Match_Result::select(array('id=?'=>$request['id']),'*','',1);
//                $data_sms = array(
//                    'demand_id'=>$result[0]['demand_id'],
//                    'offer_id'=>$result[0]['offer_id'],
//                );
                Api_Demand_Offer_Send_SMS_Vendor::Cron();
                return self::request('success',$request,"添加报价短信列表成功!");
            }else{
                return self::request('error',"","添加报价短信失败!");
            }

        }

}
