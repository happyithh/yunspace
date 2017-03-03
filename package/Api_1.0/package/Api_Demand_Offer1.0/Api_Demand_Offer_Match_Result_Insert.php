<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/16
 * Time: 16:05
 * 匹配结果表插入数据
 */
class Api_Demand_Offer_Match_Result_Insert extends Api {

    static function insertResult($args){
        /**
         * 接受数据
         * 需求ID，产品id，报价搜索条件id，匹配情况(匹配等级) 1~10
         *
         * 添加匹配时间
         *
         */
            $request = Func_Input::filter(array(
                'demand_id'=>'int',
                'offer_id'=>'int',
                'item_id'=> 'int',
                'match_level'=>'int',
                'notice_time'=>'int',
            ),$args);
            $request['match_time']=time();
            $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("*",array('demand_id=?'=>$request['demand_id']),'',1);
            if(empty($demand_offer_info)){
                return Api::request('error', '', '当前需求不存在。');
            }
            $month = date('Ym', $demand_offer_info[0]['create_time']);
//            $month = date('Ym', time());
            $rs = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select("*",array('demand_id=?'=>$request['demand_id'],'item_id=?'=>$request['item_id']),'',1);
            if(empty($rs)){
                Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->insert($request);
            }else{
                $data = array(
                    'match_level'=>$request['match_level'],
                    'notice_time'=>$request['notice_time'],
                    'match_time'=>time(),
                );
                Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->update(array('demand_id=?'=>$request['demand_id'],'item_id=?'=>$request['item_id']),$data);
            }

    }
    //删除城市切换后多余的需求
    static function deleteResult($args){
        $request = Func_Input::filter(array(
            'demand_id'=>'int',
            'offer_id'=>'int',
            'create_time'=>'int',
        ),$args);
        $month = date('Ym', $request['create_time']);
         Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->delete(array('demand_id=?'=>$request['demand_id'],'offer_id=?'=>$request['offer_id'],'(notice_time=? OR notice_time=?)'=>array(0,-1)));
    }

}