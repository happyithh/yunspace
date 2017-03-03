<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/25
 * Time: 10:01
 * 申请请假创建
 */
@session_start();

class Api_Sign_In_Apply_Create extends Api
{
    static function handle()
    {
        return self::applyCreate($_REQUEST);
    }

    static function applyCreate($args)
    {
        if (!$_SESSION['user']) {
            $_SESSION['url_back'] = 'http://' . Core::$urls['host'] . Core::$urls['uri'] . '';
            Wechat_Oauth_Sale::handle();
        }
        if (isset($_SESSION['user']['id']) && !empty($_SESSION['user']['id'])) {
            $request = Func_Input::filter(array(
                'id' => 'int',
                'outside_time' => 'string',
                'back_time' => 'string',
                'address' => 'string',
                'outside_reason' => 'string',
            ), $args);
            if (!empty($request['outside_time']) && !empty($request['back_time'])) {
                if (strtotime($request['outside_time']) > strtotime($request['back_time'])) {
                    return self::request('error', '', '请填写正常的时间！');
                } else {
                    $data['outside_time'] = strtotime($request['outside_time']);
                    $data['back_time'] = strtotime($request['back_time']);
                }
            } elseif (!empty($request['outside_time']) && empty($request['back_time'])) {
                $data['outside_time'] = strtotime($request['outside_time']);
            } elseif (empty($request['outside_time']) && !empty($request['back_time'])) {
                $data['back_time'] = strtotime($request['back_time']);
            } else {
                return self::request('error', '', '请填写离开时间！');
            }
            if (empty($request['address'])) {
                return self::request('error', '', '请填写外出地址！');
            } else {
                $data['address'] = $request['address'];
            }
            if (empty($request['outside_reason'])) {
                return self::request('error', '', '请填写外出事由！');
            } else {
                $data['outside_reason'] = $request['outside_reason'];
            }
            $data['create_time'] = time();
            $data['account_id'] = $_SESSION['user']['id'];
            $data['fullname'] = $_SESSION['user']['fullname'];
            $data['phone'] = $_SESSION['user']['phone'];
            if (!empty($request['id'])) {
                $res = Data_Mysql_Table_Sign_In::update(array('id' => $request['id']), $data);
            } else {
                $res = Data_Mysql_Table_Sign_In::insert($data);
            }
            if (!empty($res[0])) {
                return self::request('success', '', '提交成功！');
            } else {
                return self::request('error', '', '提交失败！');
            }
        }
    }
}