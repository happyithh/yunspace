<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/9/23
 * Time: 18:17
 *
 * 通用表单 用户提交信息
 */
@session_start();
class Api_General_Form_User_Submit_Form extends Api
{
    static function userSubmitForm($args)
    {
        $request = Func_Input::filter(array(
            "id" => 'int',
            "data" => 'array',
            "key" => 'array',
        ), $args);
        if (!empty($request['key'])) {
            $request['data'] = array_combine($request['key'], $request['data']);
        }
        if (!empty($request['id'])) {
            $res = Data_Mysql_Table_Form::select("*", array('id' => $request['id'],'status'=>0));
            if (empty($res)) {
                return self::request('error','','该活动不存在哦( ⊙ o ⊙ )！！');
            }
            if (!empty($res[0]['start_time']) && $res[0]['start_time'] > time()) {
                return self::request('error','','活动尚未开始，敬请期待！');
            }
            if (!empty($res[0]['end_time']) && $res[0]['end_time'] < time()) {
                return self::request('error','','活动已结束！');
            }
            $re = json_decode($res[0]['field'], 1);
            $re = explode('、', $re[0]);
            foreach ($request['data'] as $kk => $vv) {
                    $vv= trim($vv);
                if (in_array($kk, $re) && empty($vv)) {
                    return self::request('error','',$kk . '不能为空！');
                }
                if (in_array($kk, $re) && !empty($vv)) {
                    $request['field'][$kk] = $vv;
                }
            }
            if (!empty($res[0]['email'])) {
                $email = explode('、', $res[0]['email']);
                foreach ($email as $k => $v) {
                    foreach ($request['data'] as $kk => $vv) {
                        if ($v == $kk) {
                            $email1 = Func_Input::filter(array(
                                $kk => 'email',
                            ), $request['data']);
                            if (empty($email1[$kk])) {
                                return self::request('error','','请填写正确的邮箱格式！');
                            }
                        }

                    }

                }
            }

            if (!empty($request['field'])) {
                $must_info = md5(json_encode($request['field']));
                $res122 = Data_Mysql_Table_Form_Data::select("id", array("must_info" => $must_info), "", 10);
                if (!empty($res122[0])) {
                    if($request['id']==18){  //场地信息带着走表单
                        if(count($res122) >10 ){
                            return self::request('error','','您的发送次数达到上限！');
                        }
                    }else{
                        return self::request('error','','信息已经存在！');
                    }
                }
            }
            $form = array();
            $form['form_id'] = $request['id'];
            $form['data'] = $request['data'];
            if (isset($must_info)) {
                $form['must_info'] = $must_info;
            }
            $form['ip'] = Func_Input::ip();
            $form['create_time'] = time();
            if (!empty($_SESSION['user']['id'])) {
                $form['username'] = $_SESSION['user']['username'];
            }
            $info = Data_Mysql_Table_Form_Data::insert($form);
            if ($info[0] > 0) {
                    return self::request('success',$info,'提交成功，页面跳转中....');
            } else {
                return self::request('error','','信息提交失败！');
            }
        }
    }
}