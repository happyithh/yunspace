<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-4-22
 * Time: 下午4:24
 * 账户身份认证信息
 */
class OA_My_Customer_Handle_Identity{
    static $accountInfo;
    static function handle(){
        //获取账号信息
        $account=Data_Mysql_Table_Account::select('*',array('id'=>$_REQUEST['account_id']));
        if(empty($account[0])){
            Func_Header::back('账户信息不存在！');
        }
        self::$accountInfo=Api_Account_GetBaseInfo::convertDataToInfo($account[0]);
        Tpl_Smarty::assign('accountInfo',self::$accountInfo);
        if (!empty($_REQUEST['identity_type'])) {
            switch ($_REQUEST['identity_type']) {
                case 2:
                    if (!empty($_REQUEST['identity_submit'])) {
                        self::handleCompanyIdentity();
                    } else {
                        self::handleShowIdentity(self::$accountInfo);
                    }
                    break;
                case 1:
                    if (!empty($_REQUEST['identity_submit'])) {
                        self::handlePersonalIdentity();
                    } else {
                        self::handleShowIdentity(self::$accountInfo);
                    }
                    break;
                default:
                    self::handleShowIdentity(self::$accountInfo);
                    break;
            }
        }
    }
    /*
     *展示账户的身份认证信息
     */
    static function handleShowIdentity($accountInfo=array()){
        if(!empty($accountInfo['attr']['identity'])){
           Tpl_Smarty::assign('_identity',$accountInfo['attr']['identity']);
        }elseif(!empty($accountInfo['attr']['new_identity'])){
            Tpl_Smarty::assign('_identity',$accountInfo['attr']['new_identity']);
        }
    }
    static function handleCompanyIdentity(){
        $request = Func_Input::filter(array(
            'vendor_id'=>'int',
            'identity_type' => 'int',
            'data' => 'array',
            'files'=>'array',
        ));
        if(empty($request['data']['公司名称'])){
            Func_Header::back('公司名称不能为空！');
        }
        $attr['new_identity']['identity_type']=$request['identity_type'];
        $attr['new_identity']['data'] = $request['data'];
        $files = Func_Input::filter(array(
            '合作方信息询问表' => 'array',
            '营业执照' => 'array',
            '税务登记证' => 'array',
            '银行开户许可证' => 'array',
        ), $_FILES);
        foreach ($files as $k => $v) {
            if(!empty($v['name'])){
                $attr['new_identity']['files'][$k] = Func_Upload::image($k);
            }else{
                $attr['new_identity']['files'][$k] = $request['files'][$k];
            }
        }
        //写入数据库
        $r = Data_Mysql_Table_Account::update(self::$accountInfo['id'], array(
            'identity_time' => time() * -1,
            'attr' => $attr
        ));
        if (empty($r[0])) {
            Func_Header::back('操作异常,请稍候再试!');
        }
        //创建操作日志
        Data_Mysql_Table_Account_Log::insertAccountLog(self::$accountInfo['id'], $_SESSION['administrator']['id'], '提交身份认证信息', '更新---身份认证');
        Func_Header::to(' 身份认证信息提交成功!',Core::$urls['path'].'?action='.$_REQUEST['action'].'&tab='.$_REQUEST['tab'].'&vendor_id='.$request['vendor_id']);
    }
    static function handlePersonalIdentity(){
        $request = Func_Input::filter(array(
            'vendor_id'=>'int',
            'identity_type' => 'int',
            'data' => 'array',
            'files'=>'array',
        ));
        if(empty($request['data']['真实姓名'])){
            Func_Header::back('姓名不能为空！');
        }
        $attr['new_identity']['identity_type']=$request['identity_type'];
        $attr['new_identity']['data']=$request['data'];
        $files = Func_Input::filter(array(
            '手持身份证照' => 'array',
            '其他有效证件' => 'array',
        ), $_FILES);
        foreach ($files as $k => $v) {
            if (!empty($v['name'])) {
                $attr['new_identity']['files'][$k] = Func_Upload::image($k);
            }else{
                $attr['new_identity']['files'][$k] = $request['files'][$k];
            }
        }
        //写入数据库
        $r = Data_Mysql_Table_Account::update(self::$accountInfo['id'], array(
            'identity_time' => time() * -1,
            'attr' => $attr
        ));
        if (empty($r[0])) {
            Func_Header::back('操作异常,请稍候再试!');
        }
        //创建操作日志
        Data_Mysql_Table_Account_Log::insertAccountLog(self::$accountInfo['id'], $_SESSION['administrator']['id'], '提交身份认证信息', '更新---身份认证');
        Func_Header::to(' 身份认证信息提交成功!',Core::$urls['path'].'?action='.$_REQUEST['action'].'&tab='.$_REQUEST['tab'].'&vendor_id='.$request['vendor_id'].'&handle_type='.$_REQUEST['handle_type']);
    }
}