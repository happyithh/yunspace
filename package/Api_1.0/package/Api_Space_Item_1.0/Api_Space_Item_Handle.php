<?php
/*
 * Created by PhpStorm
 * User: yl
 * Date: 2015/9/23
 * Time: 17:13
 * 场地百科处理接口
 */
class Api_Space_Item_Handle extends Api
{
    static function handle($args=""){

        return self::handleSpaceItem($args);
    }
    static function handleSpaceItem($args){
        $action=$args['action'];
        switch($action){
            case "change_status":
                $data=self::handleChangeStatus();
                break;
            default:
                $data=self::request('error','','操作错误！');
                break;
        }
        return $data;
    }

    //更改子空间在线状态
    static function handleChangeStatus(){
        $request = Func_Input::filter(array(
            'status' => 'int',
            'item_id' => 'int',
        ));
        if (!$request['item_id']) {
            return self::request('error','','参数缺失！');
        }
        $r = Data_Mysql_Table_Space_Item::query("UPDATE {table} SET status = ? WHERE id = ?", array($request['status'], $request['item_id']), 1);

        if (empty($r[0])) {
            return self::request('error','','操作失败！');
        }else{
            return self::request('success','','操作成功！');
        }
    }

}