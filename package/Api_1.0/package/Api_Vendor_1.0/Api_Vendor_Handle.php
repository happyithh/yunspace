<?php

/**
 * Created by PhpStorm.
 * User: yaoli
 * Date: 2015/9/17
 * Time: 11:00
 *  供应商操作
 */
class  Api_Vendor_Handle extends Api
{
    static function handle($args=""){

        return self::handleVendor($args);
    }
    static function handleVendor($args){
        $action=$args['action'];
        switch($action){
            case "change_admin":
                $data=self::handleChangeAdmin();
                break;
            case "change_account":
                $data=self::handleChangeAccount();
                break;
            case "change_status":
                $data=self::handleChangeStatus();
                break;
            default:
                $data=self::request('error','','操作错误！');
                break;
        }
        return $data;
    }

    /*
    * 更改/分配供应商负责人
    * $param   $id     供应商id
    * $param   $admin_id     管理员id
    */
    static function handleChangeAdmin(){
        $request=Func_Input::filter(array(
            'admin_id'=>'int',
            'vendor_id'=>'int',
        ),$_REQUEST);
        if(empty($request['admin_id']) || empty($request['vendor_id'])){
            return self::request('error','','参数缺失！');
        }
        $r = Data_Mysql_Table_Vendor_Info::query("UPDATE {table} SET admin_id = ? WHERE id = ?", array($request['admin_id'], $request['vendor_id']), 1);
        $r_update = Data_Mysql_Table_Vendor_Info::query("UPDATE {table}_update SET admin_id = ? WHERE id = ?", array($request['admin_id'], $request['vendor_id']), 1);
        if (empty($r[0]) && empty($r_update[0])) {
            return self::request('error','','操作失败，请重试！！');
        } else {
            return self::request('success','','操作成功');
        }
    }

    /*
    * 更改供应商绑定账户
    * $param   $id     供应商id
    * $param   $admin_id     管理员id
    */
    static function handleChangeAccount(){
        $request=Func_Input::filter(array(
            'phone'=>'phone',
            'vendor_id'=>'int',
        ));
        if(empty($request['phone'])){
            return self::request('error',"",'请输入正确的手机号');
        }
        if(empty($request['vendor_id'])){
            return self::request('error',"",'参数缺失！');
        }
        //手机号快速注册账号
        $password = rand(10000, 99999) . rand(111, 999);
        $status = Api_Account_Register::quickRegister(array(
            'phone' => $request['phone'],
            'password' => $password,
            'username'=>empty($request['username'])?$request['phone']:$request['username'],
        ));

        $cols_update = array('id,vendor_name,city,admin_id,attr,attr_index,addr,base_info,categories_id,media,des,logo,vendor_remarks,create_time,update_time');
        $data_update = Data_Mysql_Table_Vendor_Info::subTable('_update')->select($cols_update, array('id' => $request['vendor_id']));

        if(!empty($status['data'])){
            $accountInfo=$status['data'];
            //判读该账号是否已绑定供应商
            $rs_vendor=Data_Mysql_Table_Vendor_Info::select('id,vendor_account_id',array('vendor_account_id'=>$accountInfo['id']));

            //已绑定供应商，解除原绑定
            if(!empty($rs_vendor[0])){
                Data_Mysql_Table_Vendor_Info::update(array('id'=>$rs_vendor[0]['id']),array('vendor_account_id'=>0));
                Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id'=>$rs_vendor[0]['id']),array('vendor_account_id'=>0));
            }
            $r_update=Data_Mysql_Table_Vendor_Info::subTable('_update')->update(array('id'=>$request['vendor_id']),array('vendor_account_id'=>$accountInfo['id']));
            $data_update[0]['vendor_account_id']=$accountInfo['id'];
            $r = Data_Mysql_Table_Vendor_Info::update($data_update[0]);
            if (empty($r[0]) || empty($r_update[0])) {
                return self::request('error','','操作失败，请重试！！');
            } else {
                return self::request('success','','已为该供应商添加联系人【'.$accountInfo['username']."】");
            }
        }else{
            return self::request('error','','操作错误！');
        }

    }


    /*
     * 更改供应商状态
     * @param   $table 更改哪个表的status  update 代表更改vendor_info_update表  info 代表更改vendor_info表，为空代表更改两个表
     * $param   $id     供应商id
     */
    static function handleChangeStatus(){
        $request=Func_Input::filter(array(
            'vendor_id'=>'int',
            'status'=>'int',
            'table'=>'string',
        ));
        $id=$request['vendor_id'];
        $status=$request['status'];
        $table=$request['table'];

        if(empty($table)){
            $r = Data_Mysql_Table_Vendor_Info::query("UPDATE {table} SET status = ? WHERE id = ?", array($status, $id), 1);
            $r_update = Data_Mysql_Table_Vendor_Info::query("UPDATE {table}_update SET status = ? WHERE id = ?", array($status, $id), 1);
            if (empty($r[0]) || empty($r_update[0])) {
                return self::request('error','','操作失败，请重试！！');
            } else {
                return self::request('success','','操作成功');
            }
        }elseif($table=="info"){
            $r = Data_Mysql_Table_Vendor_Info::query("UPDATE {table} SET status = ? WHERE id = ?", array($status, $id), 1);
            if (empty($r[0]) ) {
                return self::request('error','','操作失败，请重试！！');
            } else {
                return self::request('success','','操作成功');
            }
        }elseif($table=="update"){
            $r_update = Data_Mysql_Table_Vendor_Info::query("UPDATE {table}_update SET status = ? WHERE id = ?", array($status, $id), 1);
            if (empty($r_update[0])) {
                return self::request('error','','操作失败，请重试！！');
            } else {
                return self::request('success','','操作成功');
            }
        }

    }

}