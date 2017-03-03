<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-13
 * Time: 下午3:19
 * 投稿审核列表
 */
class OA_Raiders_Check_List{
    static function handle(){
        $action=empty($_REQUEST['action'])?"list":$_REQUEST['action'];
        switch($action){
            case "list":
                self::getCheckList();
                break;
            case "detail":
                self::getCheckDetail();
                break;
            case 'is_submit':
                self::submitRaidersInfo();
                break;
            case 'pass':
                self::passRaiders();
                break;
            case 'abandon':
                self::refuseRaiders();
                break;
            default:
                self::getCheckList();
                break;
        }
    }
    static function getCheckList(){
        //定义操作内容
        $cate = Data_Mysql_Table_Raiders_Info::$category_name;
        $categoryName = OA_Raiders_Info::getCatTree($cate);
        foreach($categoryName as $k=>$v){
            $category_name[$v['id']]=$v;
        }
        Tpl_Smarty::assign('category_name', $category_name);

        //筛选条件
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',                //文章标题
                'author' => 'string',                //作者
                'category_id' => 'int',                //栏目id
                'end_time' => 'string',               //开始时间
                'start_time' => 'string',             //结束时间
            ), $_REQUEST['search']);

            //文章标题或ID筛选
            if (!empty($search['title'])) {
                if (is_numeric($_REQUEST['search']['title'])) {
                    $condition['id'] = $search['title'];
                } else {
                    $condition['title'] = $search['title'];
                }
            }
            //作者筛选
            if (!empty($search['author'])) {
                $condition['author'] = $search['author'];
            }
            //栏目筛选
            if (!empty($search['category_id'])) {
                $condition['category_id'] = $search['category_id'];
            }


            //创建时间筛选
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $condition['create_time between ? and ?'] = array(strtotime($search['start_time']), strtotime($search['end_time']));
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $condition['create_time > ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $condition['create_time < ?'] = strtotime($search['end_time']);
            }
        }

        //获取所有待审核投稿信息
        $handle_type=empty($_REQUEST['handle_type'])?"all":$_REQUEST['handle_type'];
        $condition['status']=2;
        switch($handle_type){
            case "case_convert":
                $condition['from_where']=100;
                break;
            case "deliver":
                $condition['from_where']=3;
                break;
            case "abandon":
                $condition['status']=-1;
                break;
            default:
                break;
        }
        $data=Data_Mysql_Table_Raiders_Info::subTable('_update')->page(0,20,'*',$condition,"ORDER BY update_time DESC");
        Tpl_Smarty::assign("handle_type",$handle_type);
        Tpl_Smarty::assign("data",$data);
        Tpl_Smarty::display('OA_Static',"raiders_check/raiders_check_list.tpl");
    }
    static function getCheckDetail(){
        //定义操作内容
        $cate = Data_Mysql_Table_Raiders_Info::$category_name;
        $categoryName = OA_Raiders_Info::getCatTree($cate);
        foreach($categoryName as $k=>$v){
            $category_name[$v['id']]=$v;
        }
        Tpl_Smarty::assign('category_name', $category_name);

        //定义文章状态
        $status = Data_Mysql_Table_Raiders_Info::$status;
        Tpl_Smarty::assign('status', $status);

        //定义关键字
        $vendorAttr = Data_Config_Vendor_Attr::get('attr');
        Tpl_Smarty::assign('attr', $vendorAttr['服务行业']);


        //获取当前文章的内容
        if(empty($_REQUEST['id'])){
            Func_Header::back('参数缺失！');
        }
        $data=Data_Mysql_Table_Raiders_Info::subTable('_update')->select("*",array('id'=>$_REQUEST['id']));
        if(empty($data[0])){
            Func_Header::back('数据不存在！');
        }
        if(!empty($data[0]['tags_info'])){
            $data[0]['tags_info']=json_decode($data[0]['tags_info'],1);
        }
        if(!empty($data[0]['detail_des'])){
            $data[0]['detail_des']=json_decode($data[0]['detail_des'],1);
        }
        Tpl_Smarty::assign('_data',$data[0]);
        if(!empty($_REQUEST['handle_action']) && $_REQUEST['handle_action']=="edit"){
//            Tpl_Smarty::display('OA',"raiders_info_edit.tpl");
            Tpl_Smarty::display('OA_Static', 'article/raiders_info_edit.tpl');
        }else{
            Tpl_Smarty::display('OA_Static',"raiders_check/raiders_check_edit.tpl");
        }
    }

    //表单提交，等于审核通过
    static function submitRaidersInfo(){
        $data=OA_Raiders_Info::handleSubmitData();
        $data['counter_view'] = mt_rand(50,100);
        $data['counter_praise'] = mt_rand(50,100);
        $data['from_where'] =3;
        $data['create_time'] =strtotime("2015-03-16 13:20:56");
        $data['update_time'] =strtotime("2015-03-20 13:20:56");
        //更新update表中的数据
        $rs_update=Data_Mysql_Table_Raiders_Info::subTable('_update')->update($data);

        //向info表中添加数据
        if(!empty($rs_update[0])){
            unset($data['id']);
            $data['update_id']=$_REQUEST['id'];
            $rs=Data_Mysql_Table_Raiders_Info::insert($data);
            if(!empty($rs[0])){
                Func_Header::to(" 文章信息已更改且已通过审核！","?");
            }else{
                Func_Header::back("文章信息更新成功，审核失败！");
            }
        }else{
            Func_Header::back("文章信息更新失败！！");

        }
    }

    //审核通过
    static function passRaiders(){
        if(empty($_REQUEST['id'])){
            Func_Header::back('参数缺失！！');
        }
        //更新update表中的数据

        $rs_update=Data_Mysql_Table_Raiders_Info::subTable('_update')->update(array("id"=>$_REQUEST['id']),array('status'=>1));
        $data=Data_Mysql_Table_Raiders_Info::subTable('_update')->select("*",array('id'=>$_REQUEST['id']));
        $data[0]['update_id']=$_REQUEST['id'];
        //向info表中添加数据
        unset($data[0]['id']);
        $data[0]['create_time'] =strtotime("2015-03-16 13:20:56");
        $data[0]['update_time'] =strtotime("2015-03-20 13:20:56");
//        q($data[0]);
        $rs=Data_Mysql_Table_Raiders_Info::insert($data[0]);
        if(!empty($rs_update[0]) && !empty($rs[0])){
            Func_Header::to(" 文章已通过审核！","?");
        }else{
            Func_Header::back("审核失败！");
        }
    }

    //丢弃
    static function refuseRaiders(){
        if(empty($_REQUEST['id'])){
            Func_Header::back('参数缺失！！');
        }
        //更新update表中的数据
        $rs_update=Data_Mysql_Table_Raiders_Info::subTable('_update')->update(array("id"=>$_REQUEST['id']),array('status'=>-1));
        if(!empty($rs_update[0])){
            Func_Header::to(" 文章已丢弃！","?");
        }else{
            Func_Header::back("丢弃失败！");
        }
    }
}