<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/8/11
 * Time: 14:47
 * 场地推荐、套餐推荐
 * 
 *
 */
class Api_Demand_Admin_getRecommendList extends Api
{
    /*
     * @param $args = array(
     *          'type' =>'int',                 //(区分场地、套餐)：0 场地; 1 套餐
     *          'product_name' => 'string',     //场地名称
                'set' => 'string',              //套餐名称
                'phone' => 'string',            //需求人电话
                'username'=>'string',           //销售人员
                'start_time' => 'string',       //需求创建时间
                'end_time' => 'string',         //需求创建时间
                'search_city' =>'string'        //城市
     *          )

     * */
    static function getList($args){
        $conditions = array();
        // 搜索条件处理
        if(!empty($args['search'])){
            $search = Func_Input::filter(array(
                'product_name' => 'string',
                'set' => 'string',
                'phone' =>'string',
                'username'=>'string',
                'end_time' => 'string',
                'start_time' => 'string',
                'search_city' =>'string'
            ),$args['search']);
            //场地名称/ID 搜索处理
            if(!empty($search['product_name'])){
                if(is_numeric($search['product_name'])){
                    $conditions['{prefix}product_info.id =?'] = $search['product_name'];
                }else{
                    $conditions[] ="{prefix}product_info.product_name like '%" . $search['product_name'] . "%'";
                }
            }
            //套餐名称/ID 搜索处理
            if(!empty($search['set'])){
                if(is_numeric($search['set'])){
                    $conditions['{prefix}product_set.id =?'] =$search['set'];
                }else{
                    $conditions[] ="{prefix}product_set.set_name like '%" . $search['set'] . "%'" ;
                }
            }
            //需求人电话搜索处理
            if(!empty($search['phone'])){
                $conditions['{prefix}demand.phone =?'] = $search['phone'];
            }
            //销售人员搜索处理
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
        //  准备套餐/场地 查询数据
        $type =Func_Input::filter(array(
            'type'=>'int'
        ));
        if($type['type']==1){
            $conditions['{table}.set_id != ?']=0;
            $cols = '{table}.id as ids,{table}.demo,{table}.create_time,{prefix}demand.demand,{prefix}product_set.id,{prefix}product_set.set_name,{prefix}product_set.addr,{prefix}demand.city,{prefix}account.username,{prefix}demand.phone';
            $table = '{table} LEFT JOIN {prefix}product_set ON {table}.set_id={prefix}product_set.id LEFT JOIN {prefix}demand ON {table}.demand_id={prefix}demand.id LEFT JOIN {prefix}account ON {table}.recommend_account_id={prefix}account.id' ;
        }else{
            $conditions['{table}.product_id != ?']=0;
            $cols = '{table}.id as ids,{table}.demo,{table}.create_time,{prefix}demand.demand,{prefix}product_info.id,{prefix}product_info.product_name,{prefix}product_info.addr,{prefix}demand.city,{prefix}account.username,{prefix}demand.phone';
            $table = '{table} LEFT JOIN {prefix}product_info ON {table}.product_id={prefix}product_info.id LEFT JOIN {prefix}demand ON {table}.demand_id={prefix}demand.id LEFT JOIN {prefix}account ON {table}.recommend_account_id={prefix}account.id';
        }
        $order = 'ORDER BY {table}.create_time desc';
        $res = Data_Mysql_Table_Demand_Recommend::page(0, 10, $cols, $conditions, $order, $table);
        if(!empty($res['rows'])){
            foreach($res['rows'] as $k=>$v){
                if(!empty($v['demand'])){
                    $res['rows'][$k]['demand'] = json_decode($v['demand'],1);
                }
            }
            $result =self::request('success',$res,'');
        }else{
            $result =self::request('error','','数据获取失败！');
        }
        return $result;
    }
}