<?php
/*
 * Created by PhpStorm
 * User: yl
 * Date: 2015/9/23
 * Time: 17:13
 * 网站前台活动案例加载更多接口
 */
class Api_Spacepedia_Web_Case extends Api
{
    static function handle($args=""){
        return self::handleSpacepediaWebCase($args);
    }
    static function handleSpacepediaWebCase($args){
        $action=$args['action'];
        switch($action){
            case "case":
                $data=self::handleGetMoreCase();
                break;
            default:
                $data=self::request('error','','操作错误！');
                break;
        }
        return $data;
    }

    //场地百科活动案例加载更多
    static function handleGetMoreCase(){
        $request=Func_Input::filter(array(
            'space_name'=>'string',
            'case_limit'=>'int',
            'last_id'=>'int',
        ));
        if(empty($request['space_name'])){
            return self::request('error','','参数缺失！！');
        }
        if(empty($request['case_limit'])){
            $request['case_limit']=6;
        }
        if(!empty($request['last_id'])){
           $condition['id < ?']=$request['last_id'];
        }

        $raider_list=array();
        $cols="id,title,des,logo,media";
//        $condition['title']=$request['space_name'];
        $condition['tags_info']=$request['space_name'];
        $condition['status']=1;
//        $condition['des']=$request['space_name'];
//        $condition['title = ? OR des = ?']=array($space_name,$space_name);
        $order="ORDER BY id DESC, counter_praise DESC,counter_view DESC";
        $raider_list=Data_Mysql_Table_Raiders_Info::select($cols,$condition,$order,$request['case_limit']);
        if(empty($raider_list)){
            return self::request('error',"","无活动案例数据");
        }else{
            return self::request('success',$raider_list,'返回活动案例数据');
        }
    }



}