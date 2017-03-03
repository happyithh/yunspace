<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/11
 * Time: 17:21
 */
class Api_Demand_Admin_getTakeLook extends Api
{
    /*
  * @param $args = array(
  *          'type' =>'int',                 //(区分场地、套餐)：1 场地; 2 套餐
  *          'product_name' => 'string',     //场地(ID)/套餐名称(ID)
             'phone' =>'string',              //需求人电话
             'username' =>'string',          //销售人员
             'start_time' => 'string',       //需求创建时间
             'end_time' => 'string',         //需求创建时间
             'search_city' =>'string'        //城市
  *          )

  * */
    static function getTakeLook($args){
        $conditions = array();
        if(!empty($args['search'])){
            $search = Func_Input::filter(array(
                'type'=>'int',
                'set_name'=>'string',
                'product_name' => 'string',
                'phone'=>'string',
                'username' => 'string',
                'end_time' => 'string',
                'start_time' => 'string',
                'search_city'=>'string'
            ), $args['search']);
            //场地名称/ID 搜索处理
            if(!empty($search['type']) || !empty($search['product_name']) || !empty($search['set_name'])){
                if(($search['type']==1 && !empty($search['product_name'])) || ($search['type']!=2 &&!empty($search['product_name']))){
                    if(is_numeric($search['product_name'])){
                        $conditions['{prefix}product_info.id =?'] = $search['product_name'];
                    }else{
                        $conditions[] ="{prefix}product_info.product_name like '%" . $search['product_name'] . "%'";
                    }
                }
                //套餐名称/ID 搜索处理
                if(($search['type']==2 && !empty($search['product_name'])) || ($search['type']!=1 && !empty($search['set_name']))){
                    if(is_numeric($search['product_name'])){
                        $conditions['{prefix}product_set.id =?'] =$search['product_name'];
                    }else{
                        $conditions[] ="{prefix}product_set.set_name like '%" . $search['product_name'] . "%'" ;
                        $conditions['{table}.product_id =?']='null';
                    }
                }
            }
            //需求人名称搜索处理
            if(!empty($search['phone'])){
                 $conditions['{prefix}demand.phone =?'] =$search['phone'];
            }
            //操作人名称搜索处理
            if(!empty($search['username'])){
                $conditions[]="{prefix}account.username like '%".$search['username']."%'";
            }
            //操作时间搜索处理
            if(!empty($search['start_time']) && !empty($search['end_time'])){
                if(strtotime($search['start_time'].'00:00:00') >strtotime($search['end_time'].'23:59:59') ){
                    $result = self::request(0,'','请选择正确的时间范围！');
                    return $result;
                }else{
                    $conditions['{table}.create_time between ? and ?'] =array(strtotime($search['start_time'].'00:00:00'),strtotime($search['end_time'].'23:59:59'));
                }
            }
            if(!empty($search['start_time']) && empty($search['end_time'])){
                $conditions['{table}.create_time >?'] =strtotime($search['start_time'].'00:00:00');
            }
            if(empty($search['start_time']) && !empty($search['end_time'])){
                $conditions['{table}.create_time <?'] =strtotime($search['end_time'].'23:59:59');
            }
            //城市搜索处理
            if(!empty($search['search_city'])){
                $conditions['{prefix}demand.city =?'] =$search['search_city'];
            }
        }
        $conditions['look_time !=?']='null';
        $cols ='{prefix}product_info.product_name,{prefix}product_set.set_name,{table}.look_time,{table}.look_reason,{table}.create_time,{table}.demand_id,{prefix}demand.city,{prefix}demand.demand,{prefix}account.username,{prefix}demand.phone';
        $table ='{table} LEFT JOIN {prefix}product_info ON {table}.product_id={prefix}product_info.id LEFT JOIN {prefix}product_set ON {table}.set_id={prefix}product_set.id LEFT JOIN {prefix}demand ON {table}.demand_id={prefix}demand.id LEFT JOIN {prefix}account ON {table}.recommend_account_id={prefix}account.id';
        $order ='ORDER BY {table}.look_time DESC';
        $res = Data_Mysql_Table_Demand_Recommend::page(0,15,$cols,$conditions,$order,$table);
        if(!empty($res['rows'])){
            foreach($res['rows'] as $k=>$v){
                if(!empty($v['demand'])){
                    $res['rows'][$k]['demand'] = json_decode($v['demand'],1);
                }
            }
            $result = self::request('success',$res,'');
        }else{
            $result = self::request('error','','数据获取失败！');
        }
        return $result;
    }
}