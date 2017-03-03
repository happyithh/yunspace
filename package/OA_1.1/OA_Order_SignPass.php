<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/21
 * Time: 10:33
 *
 * 订单签约列表
 */

class OA_Order_SignPass
{
    static function handle(){
     $action = empty($_REQUEST['action'])? 'list' : $_REQUEST['action'];
        switch($action){
            case 'list':
                self::signList();
                break;
            default:
                self::signList();
                break;
        }
    }
    static function signList(){
        $conditions = array();
        if(!empty($_REQUEST['search'])){
            $search = Func_Input::filter(array(
                'vendor_name' => 'string',
                'order_no' =>'string',
                'username'=>'string',
                'admin_user'=>'string'
            ),$_REQUEST['search']);
            if(!empty($search['vendor_name'])) {
                $conditions = array(
                    'vendor_name like ?' => $search['vendor_name'].'%',
                );
            }
            if(!empty($search['username'])){
                $conditions = array(
                    '{prefix}account.username like ?' => $search['username'].'%',
                );
            }
            if(!empty($search['order_no'])){
                $conditions = array(
                    'order_no like ?' => $search['order_no'].'%',
                );
            }
            if(!empty($search['admin_user'])){
                $conditions = array(
                    '{prefix}administrator.username like ?' => $search['admin_user'].'%',
                );
            }
        }
        $cols = array(
            '{table}.id,{table}.vendor_id, {table}.order_no,{table}.vendor_account_id, {table}.product_id,{table}.product_set_id,{prefix}administrator.username as admin_username, {table}.vendor_name, {table}.order_title, {table}.remark, {table}.order_price, {table}.order_price_last, {table}.order_price_pay, {table}.order_payment_percent, {table}.order_status, {table}.start_time, {table}.end_time, {table}.create_time3,{table}.buyer_account_id,{prefix}account.username,{prefix}account.fullname'
        );
        $conditions['{table}.create_time3 !=?'] = 'NULL';
        $res = Data_Mysql_Table_Order_Info::page(0, 10, $cols, $conditions, 'ORDER BY id DESC', '{table} LEFT JOIN {prefix}account ON {table}.buyer_account_id = {prefix}account.id LEFT JOIN {prefix}administrator ON {table}.admin_id = {prefix}administrator.id ');
        Tpl_Smarty::assign('_data',$res);
        Tpl_Smarty::display('OA_Static::elements/order_sign_list.tpl');
    }

}