<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/3
 * Time: 11:18
 */
if (!empty($_SESSION['user']['sub_account'])) {
    Func_Header::notFound();
}

class Web_User_Center_Account extends Base
{
    static function handle()
    {
        //获取账户是否已提交过账户变更请求
        $change_info = array();
        $change = Data_Mysql_Table_Vendor_Account::select('*', array('account_id = ? AND (status = ? OR status = ?)' => array($_SESSION['user']['id'], 0, -1)));
        if (!empty($change[0])) {
            $change_info = $change[0];
            $change_info['attr'] = json_decode($change_info['attr'], 1);
            $change_info['base_info'] = json_decode($change_info['base_info'], 1);
        }
        Tpl_Smarty::assign('account_index', 1);
        Tpl_Smarty::assign('_vendor_attr', Data_Config_Vendor_Attr::get('attr'));
        Tpl_Smarty::assign('change', $change_info);
        Tpl_Smarty::display('Web_User_Center', 'account.tpl');
    }

    static function handleSecurity()
    {
        if (!empty($_REQUEST['security_submit'])) {
            /*
             * 判断手机号码跟邮件是否有值
             *判断request的字段是否有值，有值将数据写入到attr['phone'],
             * */

            $postRows = array();
//            if (!empty($_REQUEST['data']['绑定手机号码'])) {
//                $postRows['attr'] = $_SESSION['user']['attr'];
//                $postRows['attr']['phone'] = $_POST['data']['绑定手机号码'];
//                $postRows['phone'] = $postRows['attr']['phone'];
//            }
//            if (!empty($_REQUEST['data']['绑定邮箱'])) {
//                if (preg_match("/([\w\-]+\@[\w\-]+\.[\w\-]+)/", $_POST['data']['绑定邮箱'])) {
//                    empty($postRows['attr']) and $postRows['attr'] = $_SESSION['user']['attr'];
//                    $postRows['attr']['email'] = $_POST['data']['绑定邮箱'];
//                    $postRows['email'] = $postRows['attr']['email'];
//                } else {
//                    $errorMessage = "请输入正确的邮箱格式！！";
//                    Func_Header::back($errorMessage);
//                }
//            }

            /*
             * 修改密码
             * 验证新密码两次是否一致
             * 查询原始密码是否正确，
             *将新密码写入数据库
             * */
            if (!empty($_REQUEST['data']['新密码'])) {
                //判断新密码的输入是否一致
                if ($_REQUEST['data']['新密码'] != $_REQUEST['data']['确认新密码']) {
                    $errorMessage = "两次密码不一致！！";
                    Func_Header::back($errorMessage);
                }
                //判断旧密码是否正确
                if (Data_Mysql_Table_Account::checkPassword($_REQUEST['data']['旧密码'])) {
                    $postRows['password'] = Data_Mysql_Table_Account::makePassword($_REQUEST['data']['新密码']);
                } else {
                    Func_Header::back('旧密码不正确！！');
                }
            }

            /*
             * 查看当前的交易密码是否设置
             * 如果设置，可以修改设置密码（update）
             * 如果没设置，则设置新密码（insert）
             * */
            if (!empty($_REQUEST['data']['交易密码'])) {
                if ($_REQUEST['data']['交易密码'] != $_REQUEST['data']['确认交易密码']) {
                    $errorMessage = "两次交易密码不一致！！";
                    Func_Header::back($errorMessage);
                }
                if ($_SESSION['user']['password2']) {
                    //如果有交易密码
                    if (Data_Mysql_Table_Account::checkPassword2($_REQUEST['data']['旧交易密码'])) {
                        $postRows['password2'] = Data_Mysql_Table_Account::makePassword($_REQUEST['data']['交易密码']);
                    } else {
                        Func_Header::back('旧交易密码不正确！！');
                    }
                } else {
                    //没有交易密码
                    $postRows['password2'] = Data_Mysql_Table_Account::makePassword($_REQUEST['data']['交易密码']);
                }
            }
            if (empty($postRows)) {
                Func_Header::back('提交的是空表单!');
            }
            //更新信息
            Data_Mysql_Table_Account::update($_SESSION['user']['id'], $postRows);
            foreach ($postRows as $k => $v) {
                $_SESSION['user'][$k] = $v;
            }
            if (!empty($postRows['password2'])) {
                $_SESSION['user']['password2'] = $postRows['password2'];
            }
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '修改密码申请', '更新--修改密码申请');
            Func_Header::to('密码修改提交成功!', !empty($_REQUEST['url_back']) ? $_REQUEST['url_back'] : 'account');
        }
        //如果有值的话，就将手机跟邮箱显示进去
        Tpl_Smarty::assign('account_index', 2);
        Tpl_Smarty::display('Web_User_Center', 'account.tpl');
    }

    static function handleIdentity()
    {
        if (empty($_REQUEST['identity_type']) &&
            (!empty($_SESSION['user']['attr']['identity']['identity_type']) || !empty($_SESSION['user']['attr']['new_identity']['identity_type']))
        ) {
            $identity_type = empty($_SESSION['user']['attr']['identity']['identity_type']) ? $_SESSION['user']['attr']['new_identity']['identity_type'] : $_SESSION['user']['attr']['identity']['identity_type'];
            $_REQUEST['identity_type'] = $identity_type;
        }
        if (!empty($_SESSION['user']['attr']['identity'])) {
            Tpl_Smarty::assign('_identity', $_SESSION['user']['attr']['identity']);
        }
        if (!empty($_REQUEST['identity_submit']) && !empty($_REQUEST['identity_type'])) {
            $request = Func_Input::filter(array(
                'identity_type' => 'int',
                'data' => 'array',
                'files' => 'array',
            ));
            if ($request['identity_type'] == 2) {
                if (empty($request['data']['公司名称'])) {
                    Func_Header::back('公司名称不能为空！');
                }
                if (empty($request['data']['公司电话'])) {
                    Func_Header::back('公司电话不能为空！');
                }
                if (empty($request['data']['公司地址'])) {
                    Func_Header::back('公司地址不能为空！');
                }
                if (empty($request['data']['法人代表'])) {
                    Func_Header::back('法人代表不能为空！');
                }
            } else {
                if (empty($request['data']['真实姓名'])) {
                    Func_Header::back('姓名不能为空！');
                }
            }
            $attr = $_SESSION['user']['attr'];
//            if (!empty($attr['new_identity']['files'])) {
//                $request['files'] = $attr['new_identity']['files'];
//            }
            $attr['new_identity'] = $request;
//            $attr['identity'] = $request;
            $_SESSION['user']['attr'] = $attr;
            //文件上传处理
            if ($request['identity_type'] == 1) {
                $files = Func_Input::filter(array(
                    '手持身份证照' => 'array',
                    '其他有效证件' => 'array',
                ), $_FILES);
            } else {
//                $files = Func_Input::filter(array(
//                    '经营许可证' => 'array',
//                    '营业执照' => 'array',
//                    '组织机构代码' => 'array',
//                    '税务登记证' => 'array',
//                    '生产安全许可证' => 'array',
//                ), $_FILES);
                $files = Func_Input::filter(array(
                    '合作方信息询问表' => 'array',
                    '营业执照' => 'array',
                    '税务登记证' => 'array',
                    '银行开户许可证' => 'array',
                ), $_FILES);
            }
//            foreach ($files as $k => $v) {
//                if (empty($v['name'])) {
//                    if (empty($request['files'][$k])) {
////                        Func_Header::back($k . ' 不能为空!');
//                    } else {
//                        unset($files[$k]);
//                    }
//                }
//            }
            foreach ($files as $k => $v) {
                if($v['size']>1048576*2){
                    Func_Header::back($k."单个文件的大小不超过2M");
                }
                if (!empty($v['name'])) {
                    $attr['new_identity']['files'][$k] = Func_Upload::image($k);
                } else {
                    $attr['new_identity']['files'][$k] = $request['files'][$k];
                }

            }
            //写入数据库
            $r = Data_Mysql_Table_Account::update($_SESSION['user']['id'], array(
                'identity_time' => time() * -1,
                'attr' => $attr
            ));
            if (empty($r[0])) {
                Func_Header::back('操作异常,请稍候再试!');
            }
            $_SESSION['user']['attr'] = $attr;
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '提交身份认证信息', '更新---身份认证');
            Func_Header::to('身份认证信息提交成功!', !empty($_REQUEST['url_back']) ? $_REQUEST['url_back'] : 'account');
        }
        if (!empty($_SESSION['user']['attr']['new_identity']) || !empty($_SESSION['user']['attr']['identity'])) {
            Tpl_Smarty::assign('_identity', empty($_SESSION['user']['attr']['new_identity']) ? $_SESSION['user']['attr']['identity'] : $_SESSION['user']['attr']['new_identity']);
        }
        Tpl_Smarty::assign('account_index', 3);
        Tpl_Smarty::display('Web_User_Center', 'account.tpl');
    }

    static function handleSubAccount()
    {
        $rs = Data_Mysql_Table_Account::select('sub_account', array('id' => $_SESSION['user']['id']));
        $subAccount = empty($rs[0]['sub_account']) ? array() : json_decode($rs[0]['sub_account'], 1);
        if (!empty($_REQUEST['security_submit'])) {
            unset($_REQUEST['data']['$$']);
            $newSubAccount = array();
            foreach ($_REQUEST['data'] as $v) {
                if (!empty($subAccount[$v['用户名']])) {
                    $newSubAccount[$v['用户名']] = $subAccount[$v['用户名']];
                }
                if (!empty($v['密码'])) {
                    $newSubAccount[$v['用户名']][0] = Data_Mysql_Table_Account::makePassword($v['密码']);
                }
                if (!empty($v['权限'])) {
                    $newSubAccount[$v['用户名']][1] = array_fill_keys($v['权限'], 1);
                }
                $filter = Func_Input::filter(array('email' => 'email', 'phone' => 'phone'), $v);
                if (!empty($v['email'])) {
                    if (empty($filter['email'])) {
                        Func_Header::back('请输入正确的邮箱！');
                    }
                    $newSubAccount[$v['用户名']][2] = $filter['email'];
                }
                if (!empty($v['phone'])) {
                    if (empty($filter['phone'])) {
                        Func_Header::back('请输入正确的手机号！');
                    }
                    $newSubAccount[$v['用户名']][3] = $filter['phone'];
                }
                $subAccount = $newSubAccount;
                Data_Mysql_Table_Account::update($_SESSION['user']['id'], array(
                    'sub_account' => $subAccount,
                ));
                //创建操作日志
                Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '创建子账号', '更新--创建子账号');
            }
        }
        Tpl_Smarty::assign('sub_account', $subAccount);
        Tpl_Smarty::assign('account_index', 4);
        Tpl_Smarty::display('Web_User_Center', 'account.tpl');
    }

    static function handleBankAccount()
    {
        if (!empty($_REQUEST['is_submit'])) {
            self::handlePnrSign();
//            self::handlePnrLogin();
        }
        Tpl_Smarty::assign('account_index', 5);
        Tpl_Smarty::display('Web_User_Center', 'account.tpl');
    }

    static function handlePnrSign()
    {
        if (empty($_SESSION['user']['attr']['identity'])) {
            Func_Header::back('开通收款账户需要先进行实名认证!');
        }
//        $name = empty($_SESSION['user']['attr']['identity']['data']['公司名称']) ? $_SESSION['user']['attr']['identity']['data']['真实姓名'] : $_SESSION['user']['attr']['identity']['data']['公司名称'];
//        Payment_Pnr_Account::handleRegister($_SESSION['user']['phone'], 'ab123456', $name, $_SESSION['user']['username'], $_SESSION['user']['email'], $_SESSION['user']['phone']);
//        Payment_Pnr_Account::handleLogin($_SESSION['user']['phone']);
        Payment_Pnr_Account::handleSign(uniqid() . ($_SESSION['user']['id']), "http://" . Core::$urls['host'] . '/order_pay/sign_notify');
//        Payment_Pnr_Account::handleLogin('ac1_215');
    }

    static function handlePnrLogin()
    {
//        Payment_Pnr_Account::handleLogin($_REQUEST['data']['开户银行']);
//        Payment_Pnr_Account::handleLogin($_SESSION['user']['id']);
    }

    static function handlePhone()
    {
        Tpl_Smarty::display('account_phone.tpl');
    }

    static function handleEmail()
    {
        Tpl_Smarty::display('account_email.tpl');
    }

}
