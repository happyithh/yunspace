<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/23
 * Time: 16:52
 *
 * 通用表单编辑
 */
class Api_General_Form_Edit_Field extends Api
{
    static function editFieldForm($args)
    {
        $request = Func_Input::filter(array(
            'id'=>'int',
        ));
        if (!empty($request['id'])) {
            $res = Data_Mysql_Table_Form::select('*', array('id' => $args['id']));
            if (!empty($res)) {
                if (!empty($res[0]['field'])) {
                    $res[0]['field'] = json_decode($res[0]['field'], 1);
                }
                return self::request('success',$res[0],'');
            } else {
                return self::request('error','','请求异常！');
            }
        }else{
            return self::request('error','','请求异常！');
        }
    }
}