<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-6-18
 * Time: 上午11:27
 * 带看场地相关数据调用
 */
class OA_Demand_Handle_Recommend{
    static function handle(){
        if(!empty($_REQUEST['action']) && $_REQUEST['action']=='demand_detail'){
            self::demandDetail();
        }else{
            self::demandRecommendList();
        }
    }
    /*
     *需求推荐列表
     */
    static function demandRecommendList(){
        $conditions=$data=array();
        //筛选条件
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
            ), $_REQUEST['search']);
            //名称或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $conditions['{prefix}product_info.id = ?'] = $search['title'];
                } else {
                    $conditions['{prefix}product_info.product_name = ?'] = $search['title'];
                }
            }
        }
        $data = Data_Mysql_Table_Demand_Recommend::page(0, 0, '{prefix}product_info.id as product_id,{prefix}product_info.product_name,{table}.demand_id,{table}.create_time,{table}.demo', $conditions, 'ORDER BY {table}.create_time DESC', '
        {table} LEFT JOIN {prefix}product_info on {table}.product_id={prefix}product_info.id');
        Tpl_Smarty::assign('_data',$data);
        Tpl_Smarty::display('OA','element/element_demand_recommend.tpl');
    }
    /*
     *查看需求
     */
    static function demandDetail(){
        if(empty($_REQUEST['id'])){
            Func_Header::back('参数错误！！');
        }
        OA_Demand_Operate::demandDetail();
    }

}