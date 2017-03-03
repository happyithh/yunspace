<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/4/7
 * Time: 17:55
 * 文创场地列表
 */
class Api_Winchance_Site_list extends Api
{
    static function siteList($args)
    {
        $conditions =array();
        if(!empty($args['search'])){
            $request = Func_Input::filter(array(
                'site_name'=>'string',
                'step'=>'string',
                'site_type'=>'string',
                'operator'=>'string',
                'entry_type'=>'string',
                'city'=>'string',
            ),$args['search']);
            if(!empty($request['site_name'])){
                $conditions['site_name ']=$request['site_name'];
            }
            if(!empty($request['step'])){
                $conditions['step ']=$request['step'];
            }
            if(!empty($request['site_type'])){
                $conditions['site_type ']=$request['site_type'];
            }
            if(!empty($request['entry_type'])){
                $conditions['entry_type ']=$request['entry_type'];
            }
            if(!empty($request['city'])){
                $conditions['city ']=$request['city'];
            }
            if(!empty($request['operator'])){
                $conditions['operator ']=$request['operator'];
            }

        }
        $conditions['status != ?']=-1;
        if(!empty($_REQUEST['type']) && $_REQUEST['type']=="export"){
            $data = Data_Mysql_Table_Winchance_Site::select( '*', $conditions, 'ORDER BY create_time DESC',20000);
        }else{
            $data = Data_Mysql_Table_Winchance_Site::page(0, 10, '*', $conditions, 'ORDER BY create_time DESC');
        }
        if (!empty($data)) {
            if(!empty($_REQUEST['type']) && $_REQUEST['type']=="export"){
                foreach ($data as $k => $v) {
                    if (!empty($v['plan'])) {
                        $data[$k]['plan'] = json_decode($v['plan'],1);
                    }
                    if(!empty($data[$k]['des'])){
                        $data[$k]['des'] = json_decode($v['des'],1);
                    }
                    if(!empty($data[$k]['note'])){
                        $data[$k]['note'] = json_decode($v['note'],1);
                    }

                }
            }else{
                foreach ($data['rows'] as $k => $v) {
                    if (!empty($v['plan'])) {
                        $data['rows'][$k]['plan'] = json_decode($v['plan'],1);
                    }
                    if(!empty($data['rows'][$k]['des'])){
                        $data['rows'][$k]['des'] = json_decode($v['des'],1);
                    }
                    if(!empty($data['rows'][$k]['note'])){
                        $data['rows'][$k]['note'] = json_decode($v['note'],1);
                    }

                }
            }

        }
        return $data;
    }
}