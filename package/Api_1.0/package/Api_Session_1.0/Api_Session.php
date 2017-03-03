<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/8/5
 * Time: 10:14
 */
class Api_Session extends Api{



    static function user_id()
    {
        if (isset($_SESSION['user']['id'])) {
            return $_SESSION['user']['id'];
        }
        $request = Func_Input::filter(array(
            'token' => 'string',
            'user_id' => 'int',
        ));

        if (!empty($request['token']) && !empty($request['user_id'])) {
            Api_Session::checkToken(1);
            return $_SESSION['user']['id'] = $request['user_id'];
        } else {
            @session_start();
            if (!empty($_SESSION['user']['id'])) {
                return $_SESSION['user']['id'];
            }
        }
        return $_SESSION['user']['id'] = 0;
    }


    static function checkToken($isReture = 0)
    {
        if (Func_Input::isLocal()) {
            return true;
        }
        $request = Func_Input::filter(array(
            'token' => 'string',
            'user_id' => 'int',
        ));
        if (!empty($request['token']) && !empty($request['user_id'])) {
            $data = Data_Mysql_Table_App_Login::select('token',
                array('user_id =?' => $request['user_id']));
            if (!empty($data[0])) {
                if ($request['token'] == $data[0]['token']) {
                    return true;
                }
            }
            $result = self::request('-1', '',
                '身份验证失败,您的账号可能在另一台设备上登录，请尝试重新登录！');
        } else {
            @session_start();
            if (!empty($_SESSION['user'])) {
                return true;
            }
            $result = self::request('-2', '',
                '您尚未登录,不能执行此操作！');
        }
        if (!$isReture) {
            return false;
        }
        /* 输出结果 */
        return Api::jsonOutput($result);
    }

    static function user_info()
    {
        @session_start();
        $user_id = Api_Session::user_id();
        $data = array();
        if ($user_id) {
            if (!empty($_SESSION['user']['phone'])) {
                return $_SESSION['user'];
            } else {
                $conditions['t1.id =?'] = $user_id;
                $table = "{table} as t1 LEFT JOIN {prefix}account_wechat as t2 ON t1.id = t2.account_id";
                $data = Data_Mysql_Table_Account::select('t1.*,t2.openid,t2.user_info',
                    $conditions, '', 1, $table);
                if (!empty($data[0])) {
                    $r = $data[0];
                    $_SESSION['user'] = array(
                        'id' => $r['id'],
                        'fullname' => $r['fullname'],
                        'email' => $r['email'],
                        'phone' => $r['phone'],
                        'username' => $r['username'],
                        'avatar' => $r['avatar'],
                        'identity_time' => $r['identity_time'],
                        'pnr_account' => $r['pnr_account'],
                        'password' => $r['password'],
                        'password2' => $r['password2'],
                        'attr' => $r['attr'] ? json_decode($r['attr'],
                            1) : '',
                        'register_time' => $r['register_time'],
                        'login_time' => time(),
                        'sub_account' => false,
                        'avatar' => $r['avatar'],
                        'openid' => $r['openid'],
                        'wechat' => json_decode($r['user_info'],
                            1)
                    );
                    return $r;
                }
            }
        }
        return false;
    }

    static function admin_id()
    {
        @session_start();
        if (!empty($_SESSION['administrator']['id'])) {
            return $_SESSION['administrator']['id'];
        }
        return false;
    }

}