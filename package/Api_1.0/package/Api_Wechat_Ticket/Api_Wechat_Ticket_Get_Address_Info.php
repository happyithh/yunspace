<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/9/14
 * Time: 16:54
 * 微信售票收获地址管理（前端操作接口）
 */

class Api_Wechat_Ticket_Get_Address_Info extends  Api
{

    /***
     * 1.获取地址，获取地址详情（单一）
     * 2.获取地址列表
     * 3.添加地址
     * 4.修改地址
     * 5.设置默认
     */

    //获取地址，获取地址详情（单一）
    static  function  getAddressInfo(){
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'address_id' => 'int',
        ), $_REQUEST);
        //判断是否登录
        $user_id = Api_Session::user_id();
        if(empty($user_id)){
            $result =self::request('error','',"请先登录！");
            return $result;
        }
        if($request['account_id'] != $user_id){
            $result =self::request('error','',"非法请求，请先登录");
            return $result;
        }
        if(empty($request['account_id'])||empty($request['address_id'])){
            $result =self::request('error','',"参数错误，用户id和地址id必须传递");
            return $result;
        }

        $rs = Data_Mysql_Table_Weixin_Ticket_Address_Info::select("*",array("id=?"=>$request['address_id'],"account_id=?"=>$request['account_id'],"status !=?"=>-2),'',1);
        if(!empty($rs)){
            $result =self::request('success',$rs[0],"地址详情返回成功");
            return $result;

        }else{
            $result =self::request('error','',"地址id错误，未查到该地址");
            return $result;
        }



    }

}