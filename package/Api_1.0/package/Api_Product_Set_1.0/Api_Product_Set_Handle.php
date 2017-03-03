<?php
/*
 * Created by PhpStorm
 * User: yl
 * Date: 2015/9/23
 * Time: 17:13
 * 套餐处理接口
 */
class Api_Product_Set_Handle extends Api
{
    static function handle($args=""){

        return self::handleSet($args);
    }
    static function handleSet($args){
        $action=$args['action'];
        switch($action){
            case "change_status":
                $data=self::handleChangeStatus();
                break;
            case "get_commission":
                $data=self::handleGetSetCommission();
                break;
            case "change_commission":
                $data=self::handleChangeSetCommission();
                break;
            default:
                $data=self::request('error','','操作错误！');
                break;
        }
        return $data;
    }

    //更改套餐状态
    static function handleChangeStatus(){
        $request = Func_Input::filter(array(
            'status' => 'int',
            'set_id' => 'int',
        ));
        if (!$request['set_id']) {
            return self::request('error','','参数缺失！');
        }
        //更新在线状态
        $r = Data_Mysql_Table_Product_Set::query("UPDATE {table} SET status = ? WHERE id = ?", array(
            $request['status'],
            $request['set_id']
        ), 1);
        $r_update = Data_Mysql_Table_Product_Set::query("UPDATE {table}_update SET status = ? WHERE id = ?", array(
            $request['status'],
            $request['set_id']
        ), 1);
        if (empty($r[0])) {
            Func_Output::json('error', '', '修改失败！');
        } else {
            Func_Output::json('success', '', ' 修改成功');
        }
    }

    //获取套餐的成交佣金
    static function handleGetSetCommission(){
        $request=Func_Input::filter(array(
            'set_id'=>'int',
        ));
        if(empty($request['set_id'])){
            return self::request('error',"","参数缺失！");
        }
        $rs = Data_Mysql_Table_Product_Marketing::subTable('_set')->select('id,recommend_charges', array('id =?' => $request['set_id']));
        if (!empty($rs[0]['recommend_charges'])) {
            return self::request('success', $rs[0]['recommend_charges'] / 100, '获取成功');
        }else{
            return self::request('error',"","未设置佣金");
        }

    }

    //更新产品的成交佣金
    static function handleChangeSetCommission(){
        $request = Func_Input::filter(array(
            'set_id' => 'int',
            'recommend_charges' => 'int',
        ));
        if(empty($request['set_id'])){
            return self::request('error',"","参数缺失！");
        }
        if(!is_numeric($request['recommend_charges'])){
            return self::request('error',"","请输入正确的佣金！");
        }
        $r = Data_Mysql_Table_Product_Marketing::subTable('_set')->update(array(
            'id' => $request['set_id'],
            'recommend_charges' => $request['recommend_charges'] * 100,
        ));
        if ($r > 0) {
            return self::request('success', '', '  设置成功');
        } else {
            return self::request('error', '', '设置失败');
        }
    }
}