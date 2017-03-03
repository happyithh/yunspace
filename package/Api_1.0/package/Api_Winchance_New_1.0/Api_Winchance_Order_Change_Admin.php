<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/5/12
 * Time: 11:02
 * 更换负责人
 */
class Api_Winchance_Order_Change_Admin extends Api
{
    static function handle()
    {
        if(!OA_Winchance_Order::is_manager()){
            return self::request('error', '', '没有权限修改订单所属！');
        }else{
            return self::changeAdmin();
        }
    }

    static function changeAdmin()
    {
        $request = Func_Input::filter(array(
            'order_id' => 'int',
            'admin_id' => 'int',
            'admin_name' => 'string',
        ), $_REQUEST);
        if (empty($request['order_id'])|| empty($request['admin_id']) || empty($request['admin_name'])) {
            return self::request('error', '', '参数异常！');
        }
        $data=array(
            'admin_id=?'=>$request['admin_id'],
            'admin_name=?'=>$request['admin_name'],
        );
        $rs = Data_Mysql_Table_Winchance_Order::update(array('id=?'=>$request['order_id']),$data);
        if ($rs) {
            $admin_info = Api_Administrator_List::getAdminInfo($request['admin_id']);
            if($admin_info&&!empty($admin_info['email'])){
                $subject="有新的文创订单分配给你！！！请到后台->IP订单管理->IP订单列表查看";
                $content = "有新的文创订单分配给你！！！请到后台->IP订单管理->IP订单列表查看,订单id是：".$request['order_id'];
                Func_Mail::send($admin_info['email'],$subject,$content);
            }
            return self::request('success', '', ' 操作成功！ ');
        } else {
            return self::request('error', '', '操作失败！');
        }

    }
}