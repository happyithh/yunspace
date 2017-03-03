<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/6/18
 * Time: 10:43
 */
class OA_Demand_Recommend_List
{
    static function handle($type = 0)
    {
        $_REQUEST['type']=$type;
        $data =  Api_Demand_Admin_getRecommendList::getList($_REQUEST);
        if(!empty($data['data'])){
            Tpl_Smarty::assign('data', $data['data']);
        }
        if($type==1){
            Tpl_Smarty::display('OA_Static::elements/demand_recommend_set_list.tpl');
        }else{
            Tpl_Smarty::display('OA_Static::elements/demand_recommend_list.tpl');
        }
    }
}