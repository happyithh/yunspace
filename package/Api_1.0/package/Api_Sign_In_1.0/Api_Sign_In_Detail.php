<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/25
 * Time: 11:50
 *
 * 外出签到用户 签到详情
 *
 */
@session_start();
class Api_Sign_In_Detail extends Api{
    static function getDetail($args){
        if (!$_SESSION['user']) {
            $_SESSION['url_back'] = 'http://' . Core::$urls['host'] . Core::$urls['uri'] . '';
            Wechat_Oauth_Sale::handle();
        }
        $request = Func_Input::filter(array(
            'id'=>'int'
        ),$_REQUEST);

        if(!empty($request['id'])){
            $res = Data_Mysql_Table_Sign_In::select("*",array('id'=>Func_NumEncode::d($request['id'])));
            return $res[0];
        }
    }
}