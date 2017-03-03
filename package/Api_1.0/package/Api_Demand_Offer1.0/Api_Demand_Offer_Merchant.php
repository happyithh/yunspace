<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/16
 * Time: 15:38
 * 新需求进入报价系统。搜索条件
 */
@session_start();

class Api_Demand_Offer_Merchant extends Api
{
    static function  handle()
    {
        $action =empty($_REQUEST['action']) ?'create_merchant':  $_REQUEST['action'] ;
        switch ($action) {
            case 'create_merchant':
                return self::insertMerchant();
                break;
            case 'create_clientele':
                return self::createClientele();
                break;

        }
//        return self::allot($args);
    }

    //添加商家回访
    static function insertMerchant()
    {
        /**
         * 参数。需求id，选择条件（人数范围，价格范围。标签数组）
         */

        //查出需求客户的手机号。插入数据库
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'space_id' =>'int',
            'item_id' =>'int',
            'reason' => 'string',

        ), $_REQUEST);
        if (empty($request['demand_id']) || empty($request['space_id'])) {
            return self::request('error', '', "参数错误");
        }
        /*if(empty($request['reason'])){
            return self::request('error', '', "备注不能为空");
        }*/

      /*  $data = array(
            't1.demand_id' => $request['demand_id'],
            't1.offer_id=?'=>$request['offer_id'],
        );
        $demand_offer_info = Data_Mysql_Table_Demand_Offer::select("*",array('demand_id=?'=>$request['demand_id'],'status >=?'=>0),'',1);
        if(empty($demand_offer_info)){
            return self::request('error', '', "找不到报价订单信息");;
        }
        $month = date('Ym', $demand_offer_info[0]['create_time']);
        $col="t1.demand_id,t1.offer_id,t2.*,t3.space_name";
        $table ='{table} as t1 LEFT JOIN {prefix}space_item as t2 ON t1.item_id =t2.id LEFT JOIN {prefix}spacepedia as t3 ON t2.space_id =t3.id';
        $demand_info = Data_Mysql_Table_Demand_Match_Result::subTable('_' . $month)->select($col,$data, '',1,$table);
        if (empty($demand_info)) {
            return self::request('error', '', "找不到商户信息");
        }*/
        $vs =array(
            'demand_id'=>$request['demand_id'],
            'item_id'=>$request['item_id'],
            'space_id'=>$request['space_id'],
            'reason'=>$request['reason'],
            'create_time'=>time(),
            'admin_id'=>$_SESSION['administrator']['id'],
        );
        $offer_info = Data_Mysql_Table_Demand_Offer_Merchant_Interview::insert($vs);
        if($offer_info>0){
            return self::request('success', '', " 添加成功！");
        }
        return self::request('error', '', "添加失败！");
    }
        static function createClientele(){
            $request = Func_Input::filter(array(
                'demand_id' => 'int',
                'step' =>'int',
                'addr' =>'string',
                'reason' => 'string',

            ), $_REQUEST);
            if (empty($request['demand_id'])) {
                return self::request('error', '', "参数错误");
            }
            $vs =array(
                'demand_id'=>$request['demand_id'],
                'step'=>$request['step'],
                'addr'=>$request['addr'],
                'reason'=>$request['reason'],
                'create_time'=>time(),
                'admin_id'=>$_SESSION['administrator']['id'],
            );
            $offer_info = Data_Mysql_Table_Demand_Offer_Merchant_Interview::insert($vs);
            if($offer_info>0){
                return self::request('success', '', " 添加成功！");
            }
            return self::request('error', '', "添加失败！");
        }


}