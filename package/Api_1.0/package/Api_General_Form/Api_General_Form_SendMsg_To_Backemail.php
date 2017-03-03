<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/24
 * Time: 13:58
 *
 * 通用表单 通知反馈邮箱
 */
class Api_General_Form_SendMsg_To_Backemail extends Api
{
    static function sendMsg($args)
    {
        $request = Func_Input::filter(array(
            'user_form_id' => 'int',
        ), $args);
        if (!empty($request['user_form_id'])) {
            $res = Data_Mysql_Table_Form_Data::select('{table}.data,{table}.username,{prefix}form.form,{prefix}form.backemail', array('id' => $request['user_form_id']), '', 1, '{table} LEFT JOIN {prefix}form ON {prefix}form.id={table}.form_id');
            if (!empty($res[0])) {
                $res[0]['data'] = json_decode($res[0]['data'], 1);
                $str = '';
                foreach ($res[0]['data'] as $k => $v) {
                    $str .= $k . ': ' . $v . ' ;  <br/>';
                }
                $title = "【云.SPACE 表单反馈通知】{$res[0]['form']}活动，收集到新的用户信息 ";
                $msg = "{$title}<br><dl>";
                $msg .= "<hr><dt>用户{$res[0]['username']}提交【{$res[0]['form']}】活动的表单信息:</dt><dd >{$str}详情操作，请进<span style='font-weight: bold'>云.SPACE管理平台</span>！</dd>";
                $email = $res[0]['backemail'];
                Func_Mail::cronSend($email, $title, $msg . '</dl>');
            }
        }

    }
}