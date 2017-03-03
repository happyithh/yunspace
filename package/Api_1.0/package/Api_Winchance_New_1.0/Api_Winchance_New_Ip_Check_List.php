<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/9
 * Time: 20:05
 * IP 审核列表
 */
class Api_Winchance_New_Ip_Check_List extends Api
{
    static function ipCheckList()
    {
        if(!empty($_REQUEST['search'])){
            $search = Func_Input::filter(array(
                'admin_id'=>'int',
                'category'=>'string',
                'manifestation'=>'string',
                'city'=>'string',
                'cooperating_mode'=>'string',
                'area'=>'string',
                'ip_name'=>'string',
            ),$_REQUEST['search']);
            if(!empty($search['admin_id'])){
                $conditions['admin_id = ?']=$search['admin_id'];
            }
            if(!empty($search['category'])){
                $conditions[]= 'category LIKE "%'.$search['category'].'%"';
            }
            if(!empty($search['manifestation'])){
                $conditions[]='manifestation ="'.$search['manifestation'].'"';
            }
            if(!empty($search['city'])){
                $conditions[]='city LIKE "%'.$search['city'].'%"';
            }
            if(!empty($search['cooperating_mode'])){
                $conditions[]='cooperating_mode LIKE "%'.$search['cooperating_mode'].'%"';
            }
            if (!empty($search['area'])) {
                if ($search['area'] == '100') {
                    $conditions['min_area <=?'] = 100;
                } elseif ($search['area'] == '3000') {
                    $conditions['max_area >=?'] = 3000;
                } else {
                    $area = explode('-', $search['area']);
                    $conditions['min_area <=?'] = $area[1];
                    $conditions['max_area >=?'] = $area[0];
                }
            }
            if(!empty($search['ip_name'])){
                if(is_numeric($search['ip_name'])){
                    $conditions['ip_id = ?']=$search['ip_name'];
                }else{
                    $conditions[]='(ip_name LIKE "%'.$search['ip_name'].'%")';
                }
            }
        }
        $conditions['status'] = 0;
//        Data_Mysql_Table_Winchance_Check::debug(1);

//        $table = '{table} as t1 LEFT JOIN {prefix}winchance_new as t2 ON t1.ip_id = t2.id';
        $data = Data_Mysql_Table_Winchance_Check::page(0, 15, '*', $conditions, 'ORDER BY update_time DESC');
        if(!empty($data['rows'])){
            foreach($data['rows'] as $k=>$v){
                $data['rows'][$k]['data'] = json_decode($data['rows'][$k]['data'],1);
              if($v['ip_step']==2){
                    $data['rows'][$k]['conform_crowd'] = $data['rows'][$k]['data']['conform_crowd'];
                }
//                if(!empty($v['cooperating_mode'])){
//                    $data['rows'][$k]['cooperating_mode'] = explode(',',$v['cooperating_mode']);
//                }
                if(!empty($v['city'])){
                    $data['rows'][$k]['city'] = explode(',',$v['city']);
                }
                if($v['ip_step']==1){
                    $data['rows'][$k]['ip_name'] = $data['rows'][$k]['data']['ip_name'];
                }
            }
        }
        return $data;
    }
}