<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/8/12
 * Time: 17:23
 */
class Api_Broke_List extends Api
{
    // 爆料列表 详情
    static function listDetail($args=''){
        Api_Session::checkToken();
        $args['account_id'] =Api_Session::user_id();
        $request['submit_person_account_id']=$args['account_id'];
        if(empty($request['submit_person_account_id'])){
            $result =self::request('error','','请求参数错误！');
            return $result;
        }
        $res = Data_Mysql_Table_Demand::select('city,demand_type,demand_name,submit_person,phone,create_time,resolve_time,update_time,demand_status,demand',array('submit_person_account_id'=>$request['submit_person_account_id']),'ORDER BY create_time DESC',9999);
        if(!empty($res)){
            //组装数据
            $doneBroke=0;       //通过审核
            $waitingBroke=0;    //正在审核
            $abandonBroke=0;    //未过审核
                foreach($res as $k=>$v){
                    if($v['demand_status']==0){
                        $waitingBroke =$waitingBroke+1;
                    }elseif($v['demand_status']==-1){
                        $abandonBroke =$abandonBroke+1;
                    }else{
                        $doneBroke =$doneBroke+1;
                    }
                    $res[$k]['demand'] = json_decode($v['demand'],1);
                }
                $data = array(
                    'doneBroke'=>$doneBroke,
                    'waitingBroke'=>$waitingBroke,
                    'abandonBroke'=>$abandonBroke,
                    'sumBroke'=>count($res),    //爆料总数
                );
            $returnData =array(
                "list"=>$res,
                "dataCount"=>$data
            );
            $result =self::request('success',$returnData,'');
            return $result;
        }else{
            $result=self::request('error','','请求错误！');
            return $result;
        }
    }
}