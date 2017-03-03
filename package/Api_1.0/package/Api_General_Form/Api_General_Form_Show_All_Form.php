<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/23
 * Time: 17:11
 *
 * 通用表单 所有表单显示
 */
class Api_General_Form_Show_All_Form extends Api
{
    static function showAllForm($args){
        $request=Func_Input::filter(array(
//            'type'=>'string',
            'search'=>'array',

        ),$args);
        $condition=array();
//        $request['type'] =empty($request['type'])?'normal':$request['type'];
//        switch($request['type']){
//            case 'normal':
//                $condition['status = ?']=0;
//                break;
////            case 'close':
////                $condition['status = ?']=-1;
////                break;
//            default:
//                $condition['status = ?']=0;
//        }
        $condition['status = ?']=0;
        if(!empty($request['search']['title'])){
            $condition['form']=$request['search']['title'];
        }
        $res = Data_Mysql_Table_Form::page(0, 15, "*", $condition, 'ORDER BY create_time DESC');
        $data = Data_Mysql_Table_Form_Data::select("form_id,count(id) as sum ",'','GROUP BY form_id',99999);
        $form_detail = array();
        if(!empty($data)){
            foreach($data as $kk=>$vv){
                $form_detail[$vv['form_id']] = $vv['sum'];
            }
        }

        if(!empty($res['rows'])){
            foreach ($res['rows'] as $k => $v) {
                $res['rows'][$k]['field'] = json_decode($v['field'], 1);
                if(!empty($form_detail[$v['id']])){
                    $res['rows'][$k]['sum'] = $form_detail[$v['id']].' 条';
                }else{
                    $res['rows'][$k]['sum'] = '0 条';
                }
            }
        }
        return self::request('success',$res,'');
    }
}