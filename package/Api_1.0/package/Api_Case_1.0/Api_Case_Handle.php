<?php
/*
 * Created by PhpStorm
 * User: yl
 * Date: 2015/9/23
 * Time: 17:13
 * 案例处理接口
 */
class Api_Case_Handle extends Api
{
    static function handle($args=""){

        return self::handleProduct($args);
    }
    static function handleProduct($args){
        $action=$args['action'];
        switch($action){
            case "change_status":
                $data=self::handleChangeStatus();
                break;
            case "auto_complete":
                $data=self::handleAutoComplete();
                break;
            default:
                $data=self::request('error','','操作错误！');
                break;
        }
        return $data;
    }

    //更改案例状态
    static function handleChangeStatus(){
        $request = Func_Input::filter(array(
            'status' => 'int',
            'case_id' => 'int',
        ));
        if (!$request['case_id']) {
            return self::request('error','','参数缺失！');
        }
        //更新状态
        $rs = Data_Mysql_Table_Event_Case::query("UPDATE {table} SET status =? WHERE id=?", array(
            $request['status'],
            $request['case_id']
        ), 1);
        $r_update = Data_Mysql_Table_Event_Case::query("UPDATE {table}_update SET status = ? WHERE id = ?", array(
            $request['status'],
            $request['case_id']
        ), 1);
        if (empty($rs[0])) {
            return self::request('error','','操作失败！');
        }else{
            return self::request('success','','操作成功！');
        }
    }

    //活动名称自动补齐
    static function handleAutoComplete(){
        $request = Func_Input::filter(array(
            'query' => 'string'
        ));
        if ($request['query']) {
            $rs = Data_Mysql_Table_Event_Info::select('CONCAT( "[", id, "] ", event_name) as name', array("id like ? OR event_name like ?" => array($request['query'] . '%', $request['query'] . '%')), '', 5);
            echo json_encode($rs);
            die;
        }
    }


}