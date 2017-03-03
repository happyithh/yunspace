<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/23
 * Time: 10:09
 *
 * 广告列表
 */
class  Api_Pa_Get_List extends Api{
    static function  paList($args)
    {
        $conditions=array();
        if(!empty($args['search'])){
        $search=Func_Input::filter(array(
            'site'=>'string',
            'advertising_title'=>'string',
            'status'=>'int',
            'city'=>'string'
        ),$args['search']);
//            q($search);

            if(!empty($search['site'])){
                $conditions['{prefix}pa_site.site =?']=$search['site'];
            }
            if(!empty($search['advertising_title'])){
                $conditions['{table}.advertising_title =?']=$search['advertising_title'];
            }
            if(!empty($search['status'])){
                $conditions['{table}.status =?']=$search['status'];
            }
            if(!empty($search['city']) && $search['city']!='全国'){
                $conditions['{table}.city =?']=$search['city'];
            }
            if(!empty($search['city']) && $search['city']=='全国'){
                $conditions['{table}.city=?']='全国';
            }
        }
//        q($conditions);
//        Data_Mysql_Table_Advertising::debug(1);
       $res = Data_Mysql_Table_Pa::page(0,30,"{table}.id,{table}.rank,{table}.site_id,{table}.advertising_title,{table}.start_time,{table}.end_time,{table}.status,{table}.company,{table}.default_adver,{table}.note,{table}.city,{table}.click_counter,{table}.display_counter,{prefix}pa_site.site,{prefix}pa_site.id as site_id_2",
           $conditions,'ORDER BY {table}.create_time DESC','{table} LEFT JOIN {prefix}pa_site ON {table}.site_id = {prefix}pa_site.id');
//Q($res);
        return $res;
    }
}