<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/23
 * Time: 17:41
 *
 * 通用表单 显示用户信息
 */
class Api_General_Form_Show_User_Info extends Api
{
    static function showUserInfoList($args)
    {
        $request =Func_Input::filter(array(
            'id'=>'int',
            'type'=>'string',
        ),$args);
//        q($request);
        if (!empty($request['id'])) {
            $request['type']=empty($request['type'])?'waiting':$request['type'];
            switch($request['type']){
                case 'waiting':
                    $conditions['{table}.status =?']=0;
                    break;
                case 'done':
                    $conditions['{table}.status=?']=1;
                    break;
                case 'reject':
                    $conditions['{table}.status =?']=-1;
                    break;
                case 'del':
                    $conditions['{table}.status =?']=-2;
                    break;
                default:
                    $conditions['{table}.status =?']=0;
            }
            $conditions['form_id'] = $request['id'];
//            $conditions['{table}.status != ?'] = -1;
            $cols = "{table}.id,username,{table}.data,ip,{table}.status,{table}.create_time,form_id,{prefix}form.form";
            $res = Data_Mysql_Table_Form_Data::page(0, 15, $cols, $conditions, 'ORDER BY status ASC, create_time DESC', "{table} LEFT JOIN {prefix}form ON {table}.form_id = {prefix}form.id");
            $field = Data_Mysql_Table_Form::select("field,id", array('id' => $request['id']));
            if (!empty($field[0])) {
                $str = json_decode($field[0]['field'], 1);
                $field = explode('、', $str[0]);
            }else{
                return self::request('error','','没有该活动哦(⊙o⊙)…');
            }
            if (!empty($res['rows'])) {
                foreach ($res['rows'] as $k => &$v) {
                    $v['create_time'] = date('Y-m-d', $v['create_time']);
                    if (!empty($v['data'])) {
                        $v['data'] = json_decode($v['data'], 1);
                    }
                }
            }
            $res['fields']=$field;
            $res['form_id']=$request['id'];
            return self::request('success',$res,'');
        }else{
            return self::request('error','','请求异常！');
        }
    }
}