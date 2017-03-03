<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/5/26
 * Time: 14:55
 */
class OA_My_Customer_Handle_Product_Schedule
{

    static function  handle()
    {

        $point = empty($_REQUEST['point']) ? 'product_schedule' : $_REQUEST['point'];
        switch ($point) {
            case 'product_schedule':
                self::handelProductSchedule();
                break;
            case 'submit':
                self::handelProductScheduleSubmit();
                break;
            case 'del':
                self::handelProductScheduleDel();
                break;
        }

    }

    static function  handelProductSchedule()
    {
        $request = Func_Input::filter(array(
            'vendor_id' => 'int',
            'product_id' => 'int',
        ));
        if (empty($request['vendor_id']) || empty($request['product_id'])) {
            Func_Header::back('缺少参数！');
        }
        $data = Data_Mysql_Table_Product_Schedule::select('*', array('status >?'=> 0,'product_id =?' => $request['product_id']), '', 999);
        $cols = "{table}.vendor_name,{table}.vendor_account_id,{prefix}product_info.id,{prefix}product_info.vendor_id,{prefix}product_info.product_name";
        $table = "{table} LEFT JOIN {prefix}product_info ON {table}.id = {prefix}product_info.vendor_id";

        $Info = Data_Mysql_Table_Vendor_Info::subTable("_update")->select($cols, array(
            '{table}.id =?' => $request['vendor_id'],
            '{prefix}product_info.id =? ' => $request['product_id']
        ), '', 1, $table);
        if (empty($Info[0]['id'])) {
            Func_Header::back('产品信息不存在！');
        }
        Tpl_Smarty::assign('Info', $Info[0]);
        Tpl_Smarty::assign('_data', $data);
        Tpl_Smarty::assign('status', Data_Mysql_Table_Product_Schedule::$status);
        Tpl_Smarty::display('OA_Static::customer_account_new/product_schedule.tpl');
        die;
    }

    static function handelProductScheduleSubmit()
    {

        $request = Func_Input::filter(array(
            'start_time' => 'string',
            'end_time' => 'string',
            'product_id' => 'int',
            'vendor_id' => 'int',
            'id'=>'int',
            'des' => 'string',
            'status' => 'int'
        ));
        if (empty($request['product_id']) || empty($request['start_time']) || empty($request['end_time'])) {
            Func_Header::back('缺少参数！');
        }
        $data = array(
            'start_time' => strtotime($request['start_time']),
            'end_time' => strtotime($request['end_time']),
            'des' => $request['des'],
            'product_id' => $request['product_id'],
            'vendor_account_id' => $request['id'],
            'status' =>$request['status'],
        );
        if ($data['end_time'] < $data['start_time']) {
            Func_Header::back('请正确的选择起止时间！');
        }
        $data['end_time']=$data['end_time']+86000;
        $rs = Data_Mysql_Table_Product_Schedule::insert($data);
        if (!empty($rs[0])) {
            Func_Header::to('  添加档期成功！','?action=detail&tab=schedule&vendor_id='.$request['vendor_id'].'&product_id='.$request['product_id']);
        }
        Func_Header::back('添加失败！请稍后再试！');
    }

    static function handelProductScheduleDel(){

        $request = Func_Input::filter(array(
            's_id'=>'int',
            'product_id'=>'int',
            'vendor_id'=>'int',
        ));
        if(empty($request['s_id'])||empty($request['product_id'])){
            Func_Header::back('参数不正确！');
        }
        if(empty($_SESSION['administrator']['id'])){
            Func_Header::back('请重新登录！');
        }
        $rs = Data_Mysql_Table_Product_Schedule::query("UPDATE {table} SET status = ? WHERE id =? AND product_id =?",array(-1,$request['s_id'],$request['product_id']),1);
        if (!empty($rs[0])){
            Func_Header::to('  删除档期成功！', '?action=detail&tab=schedule&vendor_id='.$request['vendor_id'].'&product_id='.$request['product_id']);
        }
        Func_Header::back('删除失败！请稍后再试！');
    }

}