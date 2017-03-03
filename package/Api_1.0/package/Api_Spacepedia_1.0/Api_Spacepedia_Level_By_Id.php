<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/5/17
 * Time: 15:22
 */
@session_start();
class Api_Spacepedia_Level_By_Id extends Api {

    static function handle(){
        //判断权限
        if(empty($_SESSION['administrator']['id'])||!in_array('space/spacepedia',array_keys($_SESSION['administrator']['role_cache']))){
            return self::request('error','','你没有权限修改');
        }
        if(empty($_REQUEST['action'])){
            return self::request('error','','操作异常');
        }
        $action = $_REQUEST['action'];
        if($action=='set'){
            return self::setLevel();
        }elseif($action=='get'){
            return self::getLevel();
        }else{
            return self::request('error','','操作异常');
        }
    }

    static function getLevel(){
        $request = Func_Input::filter(array(
            'space_id' => 'int',
        ));
        if(empty($request['space_id'])){
            return self::request('error','','参数失败');
        }

        $condition = array(
            'id=?'=>$request['space_id']
        );
        $result = Data_Mysql_Table_Spacepedia_Search::select('id,order_index',$condition,'',1);
        if($result){
            return self::request('success',$result[0]['order_index'],'返回成功');
        }else{
            return self::request('error','','等级不存在');
        }
    }

    static function setLevel(){
        $request = Func_Input::filter(array(
            'space_id' => 'int',
            'index_num' => 'int',
        ));
        if(empty($request['space_id'])||empty($request['index_num'])){
            return self::request('error','','参数错误');
        }

        $condition = array(
            'id=?'=>$request['space_id']
        );
        $data = array(
            'order_index=?'=>$request['index_num']
        );
        $result = Data_Mysql_Table_Spacepedia_Search::update($condition,$data);
        if($result){
            return self::request('success','','修改成功');
        }else{
            return self::request('error','','修改失败,请更新地理位置之后再修改');
        }
    }

} 