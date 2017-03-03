<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_Account extends Data_Mysql_Table
{
    public $cols = array(
        'username' => '50',
        'phone' => '15',
        'email' => 'email',
        'fullname' => '50',
        'avatar' => '300',
        'password' => '32',
        'password2' => '32',
        'account_type' => 'tinyint',         //联系人类型    1，客户  21，供应商
        'identity_time' => 'int',            // 负值为新增未审核的认证资料,  正值为已审核认证资料
        'attr' => 'array',
        'attr_index' => 'array',
        'sub_account' => 'array',   //子账户
        'pnr_account' => '40',   //银行账户 & 汇付天下分账号
        'register_time' => 'int',
        'login_times' => 'int',
        'is_broker' => 'tinyint',       //是否 经纪人
        'is_vendor' => 'tinyint',       //是否 供应商
        'status' => 'tinyint',
        'admin_id'=>'int',              //来源：账户的创建者
        'update_time'=>'int',
        'sign_num'=>'int' ,          //计数器
        'sign_time' =>'int',            //签到时间
        'integral' =>'int', //  积分
    );
    public $index = array(
        'username' => 'u',                                                    //p:主键, u:唯一索引, i:索引
        'phone' => 'i',
        'email' => 'i',
        'fullname' => 'title',
        'attr_index' => 'attr',
        'account_type' => 'i',
        'status' => 'i',
        'is_broker' => 'i',
        'is_vendor' => 'i',
    );
    public $title = array(
        "" => "账号信息",                                                     //空键,表名
        'username' => '用户名',
        'fullname' => '姓名',
        'avatar' => '头像地址',
        'phone' => '手机',
        'email' => 'E-mail',
        'account_type' => '账号类型',                   // 1:企业用户    21:供应商
        'password' => '密码',
        'password2' => '交易密码',
        'register_time' => '注册时间',
        'login_times' => '登录次数'
    );
    public $titleHidden = array( //    list / form / both
        'account_type' => 'list',
        'password' => 'list',
        'password2' => 'list',
        'register_time' => 'form',
        'login_times' => 'form'
    );

    static $tpl_account_type = array(1 => '客户', 21 => '供应商');

    static function makePassword($password)
    {
        return md5(get_called_class() . "_(8pq0modwd" . $password);
    }

    static function insert($data, $replace = false, $table = "{table}")
    {
        $data['register_time'] = time();
        return self::getInstance()->___handler->insert($data, $replace, $table);
    }

    static function checkPassword($password, $md5Password = '')
    {
        return $password && (!empty($_SESSION['user']['password']) ? self::makePassword($password) == $_SESSION['user']['password'] : ($md5Password == self::makePassword($password)));
    }

    static function checkPassword2($password, $md5Password = '')
    {
        return $password && (!empty($_SESSION['user']['password2']) ? self::makePassword($password) == $_SESSION['user']['password2'] : ($md5Password == self::makePassword($password)));
    }

    static function handleRegister()
    {
        if (empty($_REQUEST['account_type']) || $_REQUEST['account_type'] != 21) {
            $_REQUEST['account_type'] = 1;
        }
        if (empty($_REQUEST['phone'])) {
            Func_Header::back('手机号码不能为空！');
        }
        if (empty($_REQUEST['username'])) {
            Func_Header::back('用户名不能为空！');
        }
        $_REQUEST['username'] = trim($_REQUEST['username']);
        $_REQUEST['phone'] = trim($_REQUEST['phone']);
        $request = Func_Input::filter(array(
            'username' => 'string',
            'phone' => 'phone',
        ));
        if (empty($request['phone'])) {
            Func_Header::back('手机号码格式错误！');
        }
        if (strpos($_REQUEST['username'], '@')) {
            Func_Header::back('用户名不能包含@字符！');
        }
        if (strpos($_REQUEST['username'], ' ')) {
            Func_Header::back('用户名不能包含空格！');
        }
        if (strlen($_REQUEST['username']) > 50) {
            Func_Header::back('用户名不能太长！');
        }
        if (strlen($_REQUEST['username']) < 3) {
            Func_Header::back('用户名不能太短！');
        }
        if ($_REQUEST['username'] != $request['username']) {
            Func_Header::back('用户名不能包含html特殊字符！');
        }
        if (empty($_REQUEST['password']) || empty($_REQUEST['rpassword']) || $_REQUEST['password'] != $_REQUEST['rpassword']) {
            Func_Header::back('密码必须填写，且两次输入必须一致！');
        }
        if (strlen($_REQUEST['password']) < 8) {
            Func_Header::back('密码不能小于8个字符！');
        }
        $data = array(
            'fullname' => $_REQUEST['username'],
            'phone' => $_REQUEST['phone'],
            'username' => $_REQUEST['username'],
            'attr' => array(
                'register_ip' => Func_Input::ip(),
                'email' => '',
                'phone' => $_REQUEST['phone'],
                '服务领域' => empty($_REQUEST['category_id']) ? 0 : $_REQUEST['category_id']
            ),
            'account_type' => $_REQUEST['account_type'],
            'password' => Data_Mysql_Table_Account::makePassword($_REQUEST['password']),
            'register_time' => time(),
        );
        $rs = self::select('id, phone, password', array('phone = ?' => array($request['phone'])));
        if (!empty($rs[0]['id'])) {
            if (Data_Mysql_Table_Account::makePassword($request['phone']) == $rs[0]['password']) {
                $data['id'] = $rs[0]['id'];
                $rs = Data_Mysql_Table_Account::update($data);
            } else {
                Func_Header::back('手机号码已被注册！');
            }
        } else {
            if(!empty($_SESSION['administrator']['id'])){
                $data['admin_id']=$_SESSION['administrator']['id'];
            }else{
                $data['admin_id']=0;
            }
            $rs = Data_Mysql_Table_Account::insert($data);
        }
        if (empty($rs[0])) {
            Func_Header::back('该用户名已注册！！');
        }
        $data['id'] = $rs[0];
        return $data;
    }
}