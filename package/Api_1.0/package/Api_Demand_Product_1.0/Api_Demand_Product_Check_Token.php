<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/11/27
 * Time: 13:31
 */
//APP验证本地保存的token是否正确
@session_start();
class Api_Demand_Product_Check_Token extends Api
{
    static function handle($args='')
    {
        $result = Api_Session::checkToken($args);
        return $result;
    }

    static function checkToken($args)
    {
        $request = Func_Input::filter(array(
            'token' => 'string',
            'user_id' => 'int',
        ), $_REQUEST);
        if (empty($request['token'])) {
            $result = self::request('error', '', "参数token不能为空！");
            return $result;
        }
        $rs = Data_Mysql_Table_App_Login::select('token',array('user_id'=>$request['user_id']));
        if($rs[0]['token'] == $request['token']) {
            $result = self::request('success', '', "传递的token正确！");
            return $result;
        } else {
            $result = self::request('error', '', "传递的token错误！");
            return $result;
        }
    }

}