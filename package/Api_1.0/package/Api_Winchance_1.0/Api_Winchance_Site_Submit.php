<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/4/8
 * Time: 14:00
 * 文创场地创建
 */
@session_start();
class Api_Winchance_Site_Submit extends Api{
    static function siteSubmit($args)
    {
        $request = Func_Input::filter(array(
            'id'=>'int',
            'site_name'=>'string',
            'city'=>'string',
            'step'=>'string',
            'site_type'=>'string',
            'entry_type'=>'int',
            'create_time'=>'string',
            'operator'=>'string',
            'des'=>'string',
            'plan'=>'array',
            'note'=>'string',
            'history_des'=>'string',
            'history_note'=>'string',
            'history_plan_1'=>'string',
            'history_plan_2'=>'string',
        ),$args);
        if(empty($request['city'])){
            Func_Header::back('城市不能为空');
        }
        if(empty($request['step'])){
            Func_Header::back('工作状态不能为空');
        }
        if(empty($request['site_type'])){
            Func_Header::back('场地类型不能为空');
        }
        if(empty($request['operator'])){
            Func_Header::back('负责人不能为空！');
        }
        $data=array();
        $data['site_name'] = $request['site_name'];
        $data['city'] = $request['city'];
        $data['step'] = $request['step'];
        $data['site_type'] = $request['site_type'];
        $data['entry_type'] = $request['entry_type'];
        $data['create_time'] = empty($request['create_time'])?time():strtotime($request['create_time']);
        $data['operator'] =$request['operator'];
//        $operator_base = '【操作者:'.$_SESSION['administrator']['fullname'].'|时间：'.date('Y/m/d H:i:s').'】';
        if(!empty($request['history_des'])){
            $request['history_des'] = str_replace('&#34;','"',$request['history_des']);
            $data['des'] = json_decode($request['history_des'],1);
            if(!empty($request['des'])){
                array_push($data['des'], $request['des']);
            }
        }else{
//            q($request['des']);
            $data['des'][0] =  $request['des'];
        }
        if(!empty($request['history_plan_1'])){
            $request['history_plan_1'] = str_replace('&#34;','"',$request['history_plan_1']);
            $data['plan']['本周进展'] = json_decode($request['history_plan_1'],1);
            if(!empty($request['plan']['本周进展'])){
                array_push($data['plan']['本周进展'], $request['plan']['本周进展']);
            }
        }else{
            $data['plan']['本周进展'][] =  $request['plan']['本周进展'];
        }
        if(!empty($request['history_plan_2'])){
            $request['history_plan_2'] = str_replace('&#34;','"',$request['history_plan_2']);
            $data['plan']['下周计划'] = json_decode($request['history_plan_2'],1);
            if(!empty($request['plan']['下周计划'])){
                array_push($data['plan']['下周计划'], $request['plan']['下周计划']);
            }

        }else{
            $data['plan']['下周计划'][] =  $request['plan']['下周计划'];
        }
        if(!empty($request['history_note'])){
            $request['history_note'] = str_replace('&#34;','"',$request['history_note']);
            $data['note'] = json_decode($request['history_note'],1);
            if(!empty($request['note'])){
                array_push($data['note'], $request['note']);
            }

        }else{
            $data['note'][0] =  $request['note'];
        }
        $data['update_time'] = time();
        $data['status'] = 1;
        $data['admin_id'] = $_SESSION['administrator']['id'];
//        q($data);
        if(!empty($request['id'])){
            $res = Data_Mysql_Table_Winchance_Site::update(array('id'=>$request['id']),$data);
        }else{
            $res = Data_Mysql_Table_Winchance_Site::insert($data);
        }
       return $res;
    }
}