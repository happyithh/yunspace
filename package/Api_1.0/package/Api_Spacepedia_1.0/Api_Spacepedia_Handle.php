<?php
/*
 * Created by PhpStorm
 * User: yl
 * Date: 2015/9/23
 * Time: 17:13
 * 场地百科处理接口
 */
class Api_Spacepedia_Handle extends Api
{
    static function handle($args=""){

        return self::handleSpacepedia($args);
    }
    static function handleSpacepedia($args){
        $action=$args['action'];
        switch($action){
            case "change_status":
                $data=self::handleChangeStatus();
                break;
            case "change_category":
                $data=self::handleChangeCategory();
                break;
            case "change_level":
                $data=self::handleChangeLevel();
                break;
            case "add_subhead":
                $data=self::handleSubhead();
                break;
            default:
                $data=self::request('error','','操作错误！');
                break;
        }
        return $data;
    }

    //更改场地百科在线状态
    static function handleChangeStatus(){
        $request = Func_Input::filter(array(
            'status' => 'int',
            'space_id' => 'int',
        ));
        if (!$request['space_id']) {
            return self::request('error','','参数缺失！');
        }
        $r = Data_Mysql_Table_Spacepedia::query("UPDATE {table} SET status = ? WHERE id = ?", array($request['status'], $request['space_id']), 1);
        $os =Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->select('id', array('object_id' => $request['space_id']), 'order by create_time DESC');
        if($request['status'] ==2){
            $request['status'] =1;
        }
        $rs =Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->query("UPDATE {table} SET status = ? WHERE id = ?", array($request['status'], $os[0]['id']), 1);

        if (empty($r[0])) {
            return self::request('error','','操作失败！');
        }else{
            if( $request['status'] =1){
                Core::log('baike_handle', '场地百科：'.$request['space_id'].'，上线，操作员：' .$_SESSION['administrator']['id']);
            }else{
                Core::log('baike_handle', '场地百科：'.$request['space_id'].'，下线，操作员：' .$_SESSION['administrator']['id']);
            }
            return self::request('success','','操作成功！');
        }
    }

    //修改百科分类
    static function handleChangeCategory(){
        $request = Func_Input::filter(array(
            'category_id' => 'int',
            'space_id' => 'int',
        ));
        if (!$request['space_id']) {
            return self::request('error', '', '缺少参数！');
        }
        //更新百科的服务类型
        $r_update = Data_Mysql_Table_Spacepedia::query("UPDATE {table} SET category_id = ? WHERE id = ?", array(
            $request['category_id'],
            $request['space_id']
        ), 1);
        if (empty($r_update[0])) {
            return self::request('error', '', '修改失败！');
        } else {
            Core::log('baike_handle', '场地百科：'.$request['space_id'].'，类型修改为：'.$request['category_id'].'，操作员：' .$_SESSION['administrator']['id']);
            return self::request('success', '', ' 修改成功！');
        }
    }
    //修改百科级别
    static function handleChangeLevel(){
        $request = Func_Input::filter(array(
            'level' => 'int',
            'space_id' => 'int',
        ));
        if (!$request['space_id']) {
            return self::request('error', '', '缺少参数！');
        }
        //更新百科的级别
        $r_update = Data_Mysql_Table_Spacepedia::query("UPDATE {table} SET level = ? WHERE id = ?", array(
            $request['level'],
            $request['space_id']
        ), 1);
        if (empty($r_update[0])) {
            Core::log('baike_handle', '场地百科：'.$request['space_id'].'，级别修改为：'.$request['level'].'，操作员：' .$_SESSION['administrator']['id']);
            return self::request('error', '', '修改失败！');
        } else {
            return self::request('success', '', ' 修改成功！');
        }
    }

    //添加或修改副标题
    static function handleSubhead(){
        $request = Func_Input::filter(array(
            'subhead' => 'string',
            'space_id' => 'int',
            'raiders_id' => 'int',
        ));
        if (!$request['space_id'] || !$request['subhead'] || !$request['raiders_id']) {
            return self::request('error', '', '参数错误！！');
        }
        $spacepedia=Api_Spacepedia_List_And_Info::getSpacepediaInfoById($request['space_id']);
        $subhead=$spacepedia[0]['subhead'];
        $subhead[$request['raiders_id']]=$request['subhead'];
        //更新百科的副标题
        $r_update = Data_Mysql_Table_Spacepedia::query("UPDATE {table} SET subhead = ? WHERE id = ?", array(
            json_encode($subhead),
            $request['space_id']
        ), 1);
        if (empty($r_update[0])) {
            return self::request('error', '', '修改失败！');
        } else {
            Core::log('baike_handle', '场地百科：'.$request['space_id'].'，修改关联文章：'.$request['raiders_id'].'的副标题为：'.$request['subhead'].'，操作员：' .$_SESSION['administrator']['id']);
            return self::request('success', '', ' 修改成功！');
        }
    }

}