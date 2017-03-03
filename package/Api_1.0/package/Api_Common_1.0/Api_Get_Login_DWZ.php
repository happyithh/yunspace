<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/7/6
 * Time: 16:44
 * @登录短网址
 */
class  Api_Get_Login_DWZ extends Api
{
    /**
     * 接收参数
     * $args= array(
     *      account_id=用户id
     *      access_url   => 访问链接
     *      overdue_time  =>  当前时间
     * )
     *
     *
     *
     *
     * *
     * 返回结果：
     * 返回状态status （0，返回未成功，1返回成功），
     * 状态消息 msg：返回成功 或返回失败原因
     * 返回结果data：url连接
     *
     */
//
//    static function  handle($args = '')
//    {
//        $result = self::getLoginLink($args);
//        return $result;
//    }

    static function getLoginLink($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'access_url' => 'string',
            'overdue_time' => 'int',
            'is_return_data' => 'int',
            'is_get_auth_code' => 'int',
        ), $args);
        if (empty($request['account_id']) || empty($request['access_url']) || empty($request['overdue_time'])) {
            return self::request('error', '', '缺少参数或者参数不正确，请检查参数合法性');
        }
        if(!isset($request['is_get_auth_code'])){
            $request['is_get_auth_code']=1;
        }
        $url = self::getUrl($request['account_id'], $request['access_url'], $request['overdue_time'], $request['is_return_data'],$request['is_get_auth_code']);
        if (!empty($url)) {
            $result = self::request('success', $url, '生成登录链接成功');
            return $result;
        }
        $result = self::request('error', '', "生成登录链接失败");
        return $result;

    }

    /**
     * @param $account_id
     * @param $access_url
     * @param int $overdue_time
     * @param int $is_return_data
     * @param int $is_get_auth_code 是否生成验证码
     * @return string
     */
    static function  getUrl($account_id, $access_url, $overdue_time = 30, $is_return_data = 0,$is_get_auth_code=1)
    {

        if (empty($account_id) || empty($access_url)) {
            return '';
        }
        $is_exist = Data_Mysql_Table_Login_Dwz::select('*', array('account_id =?' => $account_id, 'access_url' => $access_url));
        if (!empty($is_exist[0]['id']) && !empty($is_exist[0]['auth_code']) && !empty($is_get_auth_code)) {
            $data = $is_exist[0];
        } else {
            $data['account_id'] = $account_id;
            $data['access_url'] = $access_url;
            $data['url_code'] = Func_Input::str2num('login:' . $account_id . $access_url);
            $data['overdue_time'] = $overdue_time * 60 + time();
            if(!empty($is_get_auth_code)){
                $data['auth_code'] = rand(100000, 999999);
            }else{
                $data['auth_code'] = 0;
            }
            Data_Mysql_Table_Login_Dwz::insert($data, 1);
        }
        $url_host = Core::$urls['host'];
        if ($url_host == "pre0.yunspace.com.cn") {
            $url_host = "www.yunspace.com.cn";
        }
        if ($is_return_data == 1) {
            $data['url'] = 'http://' . $url_host . '/l' . $data['url_code'];
            return $data;
        } else {
            return 'http://' . $url_host . '/l' . $data['url_code'];
        }
    }


}