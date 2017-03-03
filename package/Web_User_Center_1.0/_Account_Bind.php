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

class Web_User_Center_Account_Bind extends Base
{
    static function handle()
    {
        $request = Func_Input::filter(array(
            'action' => 'string',
        ));

        switch ($request['action']) {
            case "send_sms_code" :
                self::sendSMSCode();
                break;
            case "check_sms_code" :
                self::checkSMSCode();
                break;
            case "check_code_and_phone" :
                self::updatePhone();
                break;
            case "check_email" :
                self::checkEmailIsUsed();
                break;
            case "send_email" :
                self::sendEmail();
                break;
            case "send_email_success" :
                self::sendEmailSuccess();
                break;
            case "check_code" :
                self::handleEmailUpdate();
                break;
            case "updateHeadImg" :
                self::handleHeadImgUpdate();
                break;
            case "change_vendor_submit":
                self::handleChangeVendorSubmit();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }


    //发送验证码
    static function sendSMSCode()
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
        ));
        $phone = $request['phone'];
        $code = mt_rand(100000, 999999);
        $_SESSION['auth_code'] = array();
        $_SESSION['auth_code']['phone'] = $phone;
        $_SESSION['auth_code']['code'] = $code;
        $match = '/^((1[3|5|7|8]{1})+\d{9})$/';
        if (preg_match($match, $phone)) {
            Web_Message::globalAuthCode($phone, $code);
        } else {
            Func_Header::back('请输入正确的手机号码！！');
        }
        die();
    }

    //验证验证码
    static function checkSMSCode()
    {
        $request = Func_Input::filter(array(
            'code' => 'string',
        ));
        if ($request['code'] == $_SESSION['auth_code']['code']) {
            Func_Output::json('success', '', '验证码正确');
        }
        Func_Output::json('error', '', '验证码不正确');
    }

    //验证提交数据，并更新
    static function updatePhone()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'code' => 'string',
        ));
        if (empty($_SESSION['auth_code']['code']) || empty($request['code']) || $request['code'] != $_SESSION['auth_code']['code']) {
            Func_Output::json('error', 'code', '验证码错误');
        }
        if ($request['phone'] == $_SESSION['auth_code']['phone']) {
            Func_Output::json('error', 'phone', '两次绑定的手机号码一致');
        }

        $data = Data_Mysql_Table_Account::select('id', 'phone=' . $request['phone']);
        if (!empty($data[0])) {
            Func_Output::json('error', 'phone', '该手机号已被注册');
        }

        $update = Data_Mysql_Table_Account::update($_SESSION['user']['id'], array('phone' => $request['phone']));
        if (!empty($update[0])) {
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '绑定手机号', '更新--绑定手机号');
            $_SESSION['user']['phone'] = $request['phone'];
            Func_Output::json('success', '', '更换绑定手机号成功');
        }
        Func_Output::json('error', 'code', '操作失败');
    }

    //验证邮箱是否已绑定
    static function checkEmailIsUsed()
    {
        $request = Func_Input::filter(array(
            'email' => 'email',
        ));
        $data = Data_Mysql_Table_Account::select("id", 'email="' . $request['email'] . '"');
        $json = array();
        if ($data) {
            $json['code'] = "error";
        } else {
            $json['code'] = "success";
        }
        echo json_encode($json);
        die();
    }

    //发送邮件
    static function sendEmail()
    {
        $request = Func_Input::filter(array(
            'email' => 'email',
        ));
        if (empty($request['email'])) {
            Func_Header::back('邮箱格式不正确！！');
        }
        $code = mt_rand(100000, 999999);
        $enId = mt_rand(288, 9999);
        $checkCode = Func_String::encrypt(($_SESSION['user']['id'] + 106672) . ' ' . $request['email'] . ' ' . uniqid(), 'ieio2ok');
        $send = Web_Message::emailConform(
            $request['email'],
            $_SESSION['user']['username'],
            'http://' . Core::$urls['host'] . Core::$urls['path'] . '?action=check_code&code=' . $checkCode);
        $info = array();
        if ($send) {
            $info['code'] = 'success';
        } else {
            $info['code'] = 'error';
        }
        echo json_encode($info);
        die();
    }

    //发送成功，显示提示页面
    static function sendEmailSuccess()
    {
        $request = Func_Input::filter(array(
            'success' => 'int',
        ));
        switch ($request['success']) {
            case "0";
                Func_Header::back('验证邮件发送失败！！');
                break;
            case "1";
                Func_Header::back('验证邮件发送成功，请注意查收，如长时间未收到邮件，建议查看垃圾箱或点击重新发送！！');
                break;
        }
    }

    //处理邮件验证
    static function handleEmailUpdate()
    {
        if (empty($_REQUEST['code'])) {
            return false;
        }
        $checkCode = Func_String::decrypt(str_replace(' ', '%2B', $_REQUEST['code']), 'ieio2ok');
        $checkCode = explode(' ', $checkCode . '   ');
        $checkCode['id'] = $checkCode[0] - 106672;
        $checkCode['email'] = $checkCode[1];
        $checkCode = Func_Input::filter(array('id' => 'int', 'email' => 'email'), $checkCode);
        if ($checkCode['id'] != $_SESSION['user']['id']) {
            Func_Header::back('您当前登录的账号与验证邮箱不匹配！！');
        }
        $data = array(
            'email' => $checkCode['email']
        );
        $update = Data_Mysql_Table_Account::update(array(
            'id' => $_SESSION['user']['id']
        ), $data);
        if ($update) {
            $_SESSION['user']['email'] = $checkCode['email'];
            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '绑定邮箱', '更新--绑定邮箱');
            Func_Header::to('绑定邮件成功！！', Core::$urls['root'] . Core::$urls['package']);
        } else {
            Func_Header::to('绑定邮件失败！！', Core::$urls['root'] . Core::$urls['package']);
        }
    }

    //处理用户上传头像
    static function handleHeadImgUpdate()
    {
        $request = Func_Input::filter(array(
            'avatar' => 'array'
        ), $_FILES);
        if (empty($request['avatar'])) {
            Func_Header::back('请选择上传图片!');
        }
        $headImg = Func_Upload::image('avatar');
        $img_path = Func_Upload::getInstance()->___uploadPath . substr($headImg, strlen(Func_Upload::getInstance()->___uploadUrl));
        Func_Image::thumCenterImage($img_path, $img_path, 180, 180);
        if (!$headImg) {
            Func_Header::back('上传失败！,请稍候再试!');
        }
        //写入数据库
        $res = Data_Mysql_Table_Account::update($_SESSION['user']['id'], array(
            'avatar' => $headImg
        ));
        if (empty($res[0])) {
            Func_Header::back('操作异常,请稍候再试!');
        }
        Func_Header::to('更换头像成功！！');
        //var_dump($_FILES);die;

    }

    /*
     *账户更换绑定的供应商
     */
    static function handleChangeVendorSubmit()
    {

        $request = Func_Input::filter(array(
            'tab' => 'string',
            'vendor_id' => 'int',
            'data' => 'array',
        ));
        $requestData = Func_Input::filter(array(
            'vendor_name' => 'string',
            'des' => 'html',
            'attr' => 'array',
            'base_info' => 'array',
        ), $request['data']);
        $files = Func_Input::filter(array(
            '公司LOGO' => 'array',
        ), $_FILES);
        $requestData['account_id'] = $_SESSION['user']['id'];
        if (empty($requestData['vendor_name'])) {
            Func_Header::back('供应商名称不能为空！！');
        }
        $requestData['old_vendor_id'] = empty($request['vendor_id']) ? 0 : $request['vendor_id'];
        $requestData['attr'] = empty($requestData['attr']) ? array() : $requestData['attr'];
        $requestData['base_info'] = empty($requestData['base_info']) ? array() : $requestData['base_info'];
        $requestData['logo'] = empty($requestData['logo']) ? '' : $requestData['logo'];
        $requestData['des'] = empty($requestData['des']) ? '' : $requestData['des'];
        $requestData['demo'] = '';

        if (!empty($requestData['attr'])) {
            $requestData['attr']['城市'] = empty($requestData['attr']['城市']) ? '上海' : $requestData['attr']['城市'];
        }
        //获取供应商信息数据
        if (!empty($files['公司LOGO']['name'])) {
            $logo = Func_Upload::image('公司LOGO');
            if (!empty($logo)) {
                $requestData['logo'] = $logo;
            }
        }
        $requestData['create_time'] = time();
        $requestData['status'] = 0;
        //写入数据库
        $r = Data_Mysql_Table_Vendor_Account::update($requestData);
        if (empty($r[0])) {
            Func_Header::back('操作异常,请稍候再试!');
        }
        //创建操作日志
        Data_Mysql_Table_Account_Log::insertAccountLog($_SESSION['user']['id'], 0, '账户变更', '账户变更绑定的供应商');
        Func_Header::to('提交成功!', Core::$urls['root'] . Core::$urls['package'] . Core::$urls['route'] . 'account');
    }
}
