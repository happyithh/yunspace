<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/9/14
 * Time: 16:54
 * 微信售票收获地址管理（前端操作接口）
 */
@session_start();
class Api_Wechat_Ticket_Add_Address extends  Api
{

    /***
     * 1.获取地址，获取地址详情（单一）
     * 2.获取地址列表
     * 3.添加地址
     * 4.修改地址
     * 5.设置默认
     */

//    static function handle(){
//        $result = self::addAddress($_REQUEST);
//        return $result;
//    }

    //获取地址列表
    static  function  addAddress($args){
        $request = Func_Input::filter(array(
//            'account_id' => 'int',   //账户id
            'name'=>'string',  //收件人姓名
            'phone' => '15',  //收件人电话
            'address_content' => 'string',  //收件人地址
            'is_default'=>'int',
        ), $args);
        //判断是否登录
        $user_id = Api_Session::user_id();
        if(empty($user_id)){
            $result =self::request('error','',"请先登录！");
            return $result;
        }else{
            $request['account_id'] = $user_id;
        }
        //传递参数
        if(empty($request['name'])||empty($request['phone'])||empty($request['address_content'])){
            $result =self::request('error','',"收货人姓名，电话，地址不能为空");
            return $result;
        }
        //判断是否设置为默认地址。如果传递了。就把其他的地址设置为0.
        //如果没有传递，判断是否是第一个地址，如果是第一个。就设置成默认的
        if(empty($request['is_default'])){
            $rs = Data_Mysql_Table_Weixin_Ticket_Address_Info::select("*",array("account_id=?"=>$request['account_id']),'',1);
            if(empty($rs)){
                $request['is_default'] =1;
            }else{
                $request['is_default'] =0;
            }
        }else{
           Data_Mysql_Table_Weixin_Ticket_Address_Info::update(array("account_id=?"=>$request['account_id']),array("is_default=?"=>0));
        }
        $request['create_time'] = $request['update_time'] = time();
        $request['status'] = 1;
        $rs = Data_Mysql_Table_Weixin_Ticket_Address_Info::insert($request);
        if(!empty($rs)){
            $request['address_id'] =$rs[0];
            $result =self::request('success',$request,"添加地址成功");
            return $result;

        }else{
            $result =self::request('error','',"添加地址失败");
            return $result;
        }



    }

}