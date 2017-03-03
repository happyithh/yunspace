<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/1/4
 * Time: 11:19
 */
class Api_Search_Get_Library_List extends Api{

    /**
     * 全局搜索的关键词库，根据关键词返回相应列表，默认返回8条吧
     * 不同的数据不同的关键字表只是存数关键词
     */
    static function handle($args = ''){
        $action = isset($_REQUEST['action'])&&!empty($_REQUEST['action'])?$_REQUEST['action']:'default';
        if($action=='default'){
            return self::getLibraryList($args);
        }else{
            return self::getLibraryListNew($args);
        }
    }

    static function getLibraryList($args){
        $request = Func_Input::filter(array(
            'keyword' => 'string',
        ),$args);
        $con=array();
        if($request['keyword']){
            $con[] = "s_key like '".$request['keyword']."%' ";
        }
        $list = Data_Mysql_Table_Search_Keyword_lib::select("id,s_key",$con,'ORDER BY frequency DESC',8);
        Tpl_Smarty::assign('list', $list);
        $DataTpl = Tpl_Smarty::fetch("Web_Static::inc/public_space_inc.tpl");

        if($list){
            return self::request('success',$DataTpl,"返回数据成功");
        }else{
            return self::request('error','',"关键词为空");
        }
    }
    static function getLibraryListNew($args){
        $request = Func_Input::filter(array(
            'keyword' => 'string',
        ),$args);
        $con=array();
        if($request['keyword']){
            $con[] = "s_key like '".$request['keyword']."%' ";
        }
        $list = Data_Mysql_Table_Search_Keyword_lib::select("id,s_key",$con,'ORDER BY frequency DESC',8);

        if($list){
            return self::request('success',$list,"返回数据成功");
        }else{
            return self::request('error','',"关键词为空");
        }
    }
}