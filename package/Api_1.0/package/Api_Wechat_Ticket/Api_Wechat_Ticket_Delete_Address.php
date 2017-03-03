<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/9/14
 * Time: 16:54
 * 微信售票收获地址管理（前端操作接口）
 */
@session_start();

class Api_Wechat_Ticket_Delete_Address extends Api
{

    /***
     * 1.获取地址，获取地址详情（单一）
     * 2.获取地址列表
     * 3.添加地址
     * 4.修改地址
     * 5.设置默认
     */

    static function handle()
    {
        $result = self::updateAddress($_REQUEST);
        return $result;
    }

    //获取地址列表
    static function  updateAddress($args)
    {
        $request = Func_Input::filter(array(
            'address_id' => 'int',   //地址id
//            'name' => 'string',  //收件人姓名
//            'phone' => '15',  //收件人电话
//            'address_content' => 'string',  //收件人地址
//            'is_default' => 'int',
//            'status' => 'int'
        ), $args);
        //判断是否登录
        $user_id = Api_Session::user_id();
        if (empty($user_id)) {
            $result = self::request('error', '', "请先登录！");
            return $result;
        } else {
            $request['account_id'] = $user_id;
        }
        //判断地址是否存在
        $rs = Data_Mysql_Table_Weixin_Ticket_Address_Info::select("*", array("id=?" => $request['address_id'], "account_id=?" => $request['account_id']), '', 1);
        if (empty($rs)) {
            $result = self::request('error', '', "地址id错误，未查到该地址");
            return $result;
        }
        // 删除 地址操作
            $condition = array('id=?' => $request['address_id'], "account_id=?" => $request['account_id']);
            unset($request['address_id']);
            unset($request['account_id']);
            $request['status']=-2;
            $request['update_time'] = time();
            $rs = Data_Mysql_Table_Weixin_Ticket_Address_Info::update($condition, $request);
        if (!empty($rs[0])) {
            $result = self::request('success', $request, "地址删除成功");
            return $result;

        } else {
            $result = self::request('error', '', "地址删除失败");
            return $result;
        }


    }

}