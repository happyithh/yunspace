<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/9/14
 * Time: 16:54
 * 微信售票收获地址管理（前端操作接口）
 */
@session_start();

class Api_Wechat_Ticket_Update_Address extends Api
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
            'name' => 'string',  //收件人姓名
            'phone' => '15',  //收件人电话
            'address_content' => 'string',  //收件人地址
            'is_default' => 'int',
            'status' => 'int'
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
            //传递参数
            if (empty($request['name']) || empty($request['phone']) || empty($request['address_content'])) {
                $result = self::request('error', '', "收货人姓名，电话，地址不能为空");
                return $result;
            }

            //判断是否设置为默认地址。如果传递了。就把其他的地址设置为0.
            //如果没有传递，判断是否是第一个地址，如果是第一个。就设置成默认的
//        q($request);
            if (!empty($request['is_default'])) {
                Data_Mysql_Table_Weixin_Ticket_Address_Info::update(array("account_id=?" => $request['account_id']), array("is_default=?" => 0));
            } else {
                $request['is_default'] = 0;
            }
            $request['update_time'] = time();
            $condition = array('id=?' => $request['address_id'], "account_id=?" => $request['account_id']);
            unset($request['address_id']);
            unset($request['account_id']);
            $rs = Data_Mysql_Table_Weixin_Ticket_Address_Info::update($condition, $request);
        if (!empty($rs[0])) {
            $result = self::request('success', $request, "地址修改成功");
            return $result;

        } else {
            $result = self::request('error', '', "地址修改失败");
            return $result;
        }


    }

}