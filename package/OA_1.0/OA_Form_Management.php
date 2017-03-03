<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/6/23
 * Time: 15:44
 */

/**
 * 表单管理
 * 每个事件下有个一form表单，不同的事件form的action唯一
 *
 */
@session_start();

Class OA_Form_Management
{
    //储存表单所需字段
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::formInfoList();
                break;
            case 'add':
                self::formAdd();
                break;
            case 'edit':
                self::formEdit();
                break;
            case 'edit_submit':
                self::formAdd();
                break;
            case 'detail':
                self::formTypeUser();
                break;
            case 'check':
                self::formUserCheck();
                break;
//            case 'close':
//                self::formClose();
//                break;
//            case 'restore':
//                self::formRestore();
//                break;
            default:
                self::formInfoList();

        }
    }

    //表单字段设置提交
    static function formAdd()
    {
        $data = Api_General_Form_Create_Field::createFieldForm($_REQUEST);
        if (!empty($data)) {
            if ($data['status'] == 1) {
                Func_Header::to(' ' . $data['msg'], '?');
            } else {
                Func_Header::back($data['msg']);
            }
        }


        Tpl_Smarty::display('OA_Static', 'form/form_add.tpl');
    }

    //表单 编辑
    static function formEdit()
    {
        $data = Api_General_Form_Edit_Field::editFieldForm($_REQUEST);
        if ($data['status'] == 1) {
            Tpl_Smarty::assign('data', $data['data']);
            Tpl_Smarty::display('OA_Static::form/form_add.tpl');
        } else {
            Func_Header::back($data['msg']);
        }

    }

    //获取某一表单下所有用户信息
    static function formTypeUser()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'type' => 'string',
        ), $_REQUEST);
        if (empty($request['id'])) {
            Func_Header::back('请求异常！');
        }
        Tpl_Smarty::assign('form_id', $request['id']);
        $data = Api_General_Form_Show_User_Info::showUserInfoList($_REQUEST);
        if ($data['status'] == 1) {
            Tpl_Smarty::assign('data', $data['data']);
        } else {
            Func_Header::back($data['msg']);
        }
        Tpl_Smarty::assign('type', empty($request['type']) ? 'waiting' : $request['type']);
        $title = Data_Mysql_Table_Form::select('form', array('id' => $request['id']));
        if (!empty($title)) {
            Tpl_Smarty::assign('title', $title[0]);
        }
        Tpl_Smarty::assign('status', self::$status);
        Tpl_Smarty::display('OA_Static::form/form_user_list.tpl');
    }

    // 存储用户提交的表单信息
    static function submitUserForm()
    {
        $request = Func_Input::filter(array(
            'urls' => 'string',  // 表单提交后需要跳转的指定地址
        ), $_REQUEST);
        $data = Api_General_Form_User_Submit_Form::userSubmitForm($_REQUEST);
        if (!empty($data)) {
            if ($data['status'] == 1) {
                $userFormId['user_form_id'] = $data['data'][0];
                Api_General_Form_SendMsg_To_Backemail::sendMsg($userFormId);
                if (!empty($request['urls'])) {
                    Func_Header::to($data['msg'], $request['urls']);
                } else {
                    Func_Header::to($data['msg'], Core::$urls['referer'] ? Core::$urls['referer'] : Core::$urls['root']);
                }
            } else {
                Func_Header::back($data['msg']);
            }
        }
    }

    // 存储用户提交的表单信息(ajax提交的数据)
    static function submitUserAjaxForm()
    {
        Core::output('');
        $data = Api_General_Form_User_Submit_Form::userSubmitForm($_REQUEST);
        if (!empty($data)) {
            if ($data['status'] == 1) {
                $userFormId['user_form_id'] = $data['data'][0];
                Api_General_Form_SendMsg_To_Backemail::sendMsg($userFormId);
                if ($_REQUEST['id'] == 18) {
                     $status=   self::sendMessageBaikeInfo(array('phone'=>$_REQUEST['phone'],'url'=>$_REQUEST['data'][1]));
                    if($status['status']==1) {
                        Func_Output::json('success', '', $status['msg']);
                    }
                    Func_Output::json('error', '', $status['msg']);
                } else {
                    Func_Output::json('success', '', '恭喜您数据提交成功了！');
                }
            } else {
                Func_Output::json('error', '', $data['msg']);
            }
        }
    }

    //ID 为18的表单 发生短信
    static function sendMessageBaikeInfo($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'url' => 'url',
        ), $args);
        if (empty($request['phone']) || empty($request['url'])) {
            return Api::request('error', '', '抱歉，缺少参数！');
        }
        if (!empty($request['url'])) {
            $baike_url = Func_Url::str_urldecode(Func_String::utf8($request['url']));
            $baike = explode('site/', $baike_url);
            $baike_name = explode("-", $baike[1]);
            if (!empty($baike_name[0]) && !empty($request['phone'])) {
                $conditions['space_name=?'] = $baike_name[0];
                $data = Api_Spacepedia_Get_Info::getBaikeInfo($conditions);
                //处理短网址
                $dwzUrl = Data_Mysql_Table_Baike_Dwz::getUrl($_REQUEST['data'][1]);
                if (!empty($data) && $dwzUrl) {
                    $msg = $data['space_name'] . '：' . $data['addr'] . '，容纳人数：' . $data['attr'][10] . '㎡' . '，参考价:' . $data['min_price'] . '/' . $data['price_unit'] . ';';

                    Func_Message::sendSMS($request['phone'], array($msg, $dwzUrl . '，'), 109534);
                    return Api::request('success', '', '发送成功');
                }
            }
        }
        return Api::request('error', '', '抱歉，无法为您发送短信了！');
    }

    //获取表单类型信息
    static function formInfoList()
    {
        $request = Func_Input::filter(array(
            'type' => 'string'
        ), $_REQUEST);
        $data = Api_General_Form_Show_All_Form::showAllForm($_REQUEST);
        if ($data['status'] == 1) {
            Tpl_Smarty::assign('data', $data['data']);
        }
        Tpl_Smarty::assign('type', empty($request['type']) ? 'normal' : $request['type']);
        Tpl_Smarty::display('OA_Static::form/form_list.tpl');
    }

    //审核用户信息
    static function formUserCheck()
    {
        $request = Func_Input::filter(array(
            'form_id' => 'form_id',
        ), $_REQUEST);
        $data = Api_General_Form_User_Check::userCheckList($_REQUEST);
        if ($data['status'] == 1) {
            Func_Header::to('  ' . $data['msg'], '?action=detail&id=' . $request['form_id']);
        } else {
            Func_Header::back($data['msg']);
        }
    }
//   // 表单关闭
//    static function formClose()
//    {
//        $request = Func_Input::filter(array(
//            'id' => 'int'
//        ), $_REQUEST);
//        if (empty($request['id'])) {
//            Func_Header::back('请求异常！');
//        }
//        $data = Data_Mysql_Table_Form::update(array('id' => $request['id']), array('status' => -1));
//        if (!empty($data)) {
//
//            //创建操作日志
//            $account_id = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));
//            Data_Mysql_Table_Account_Log::insertAccountLog($account_id['account_id'],$_SESSION['administrator']['id'],'表单修改--关闭','表单管理',$request['id']);
//
//            Func_Header::to('  关闭成功！');
//        }else{
//            Func_Header::back('关闭失败！');
//        }
//    }
    // 表单撤销关闭
//    static function formRestore()
//    {
//        $request = Func_Input::filter(array(
//            'id' => 'int'
//        ), $_REQUEST);
//        if (empty($request['id'])) {
//            Func_Header::back('请求异常！');
//        }
//        $data = Data_Mysql_Table_Form::update(array('id' => $request['id']), array('status' => 0));
//        if (!empty($data)) {
//            //创建操作日志
//            $account_id = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id'=>$_SESSION['administrator']['id']));
//            Data_Mysql_Table_Account_Log::insertAccountLog($account_id['account_id'],$_SESSION['administrator']['id'],'表单修改--恢复','表单管理',$request['id']);
//
//            Func_Header::to('  恢复成功！');
//        }else{
//            Func_Header::back('恢复失败!');
//        }
//    }
    static $status = array(
        '0' => '待审核',
        '1' => '通过',
        '-1' => '拒绝',
        '-2' => '删除',
    );
}