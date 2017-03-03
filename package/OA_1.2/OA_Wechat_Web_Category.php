<?php
/**
 * Created by PhpStorm.
 * User: sdd
 * Date: 2016/8/26
 * Time: 10:27
 */

class OA_Wechat_Web_Category {

    static function handle()
    {
        $_REQUEST['action'] = empty($_REQUEST['action']) ? "list" : $_REQUEST['action'];
        switch ($_REQUEST['action']) {
            case 'add':
                self::handleAdd();
                break;
            case 'submit_edit':
                self::handleBindAccountSubmit();
                break;
            case 'edit':
                self::handleAdd();
                break;
            case 'eventStatus':
                self::handleStatus();
                break;
            case 'eventRealDel':
                self::handleRealDel();
                break;
            case 'list':
                self::handleWechatWebCatergoryList();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }


    //活动列表
    static function handleWechatWebCatergoryList()
    {
        $conditions = array();
        $status = isset($_REQUEST['status']) ? $_REQUEST['status'] : 1;
        Tpl_Smarty::assign('status', $status);
        $conditions['status'] = $status;
        $list = Data_Mysql_Table_Wechat_Web_Category::page(0, 10, "*", $conditions, 'ORDER BY update_time DESC');
        if($list){
            foreach($list['rows'] as $k=>$v){
                $list['rows'][$k]['url_id'] = Func_NumEncode::e($v['id'].'9527');
            }
        }

        Tpl_Smarty::assign('_data', $list);
        Tpl_Smarty::display("OA_Static::wechat_web_category/category_list.tpl");
    }

    static function handleAdd()
    {
        $request = Func_Input::filter(array(
            'id' => 'int'
        ));
        if (!empty($request['id'])) {
            $info = Data_Mysql_Table_Wechat_Web_Category::select('*', array('id =?' => $request['id']), '', 1);
            Tpl_Smarty::assign('info', $info[0]);
        }
        Tpl_Smarty::display("OA_Static::wechat_web_category/category_add.tpl");
    }

    static  function handleBindAccountSubmit(){
        $request = Func_Input::filter(array(
            'cid' => 'int',
            'category' => 'string',                       //分类名称
            'big_picture' => 'string',             //类别图片
            'status' => 'int',               //0下线   1上线
            'is_show' => 'int',               //首页显示
            'url_referer'=>'string',
        ),$_REQUEST);
//        if(!empty($request['big_picture'])){
//            Func_Image::thumCenterImage(Core::$paths['root'].$request['big_picture'], Core::$paths['root'].$request['big_picture'], 450, 150);
//        }
        if(empty($request['category'])){
            Func_Header::back('分类名不能为空！');
        }
        $data['category'] = $request['category'];
        $data['big_picture'] = $request['big_picture'];
        $data['status'] = $request['status'];
        $data['is_show'] = $request['is_show'];
        $data['update_time'] = time();
        if (!empty($request['cid'])) {
            $data['id'] = $request['cid'];

        } else {
            $data['create_time'] = time();
        }
//        q($_REQUEST);
        $rows = Data_Mysql_Table_Wechat_Web_Category::update($data);
        if ($rows > 0) {
            Func_Header::to(' 操作成功！',empty($request['url_referer'])?Core::$urls['path']:$request['url_referer']);
        } else {
            Func_Header::to('操作失败！', Core::$urls['path']);
        }
    }

    static function handleStatus()
    {
        $request = Func_Input::filter(array(
            "id"=>'int',
            "handle"=>'string'
        ),$_REQUEST);
        if(empty($request['id']) && empty($request['handle'])){
            Func_Header::back("参数错误");
        }
        switch($request['handle']){
            case "up":
                $status=1;
                $msg = '上线';
                break;
            case "down":
                $status=0;
                $msg = '下线';
                break;
            case "del":
                $status=-1;
                $msg = '删除';
                break;
            case "recover":
                $status=0;
                $msg = '恢复';
                break;
            default:
                $msg = '操作错误';
        }
        $rss = Data_Mysql_Table_Wechat_Web_Category::update($request['id'],array("status"=>$status));
        if($rss){
            Func_Header::back(" ".$msg."成功");
        }else{
            Func_Header::back($msg."失败");
        }
    }
    static function handleRealDel()
    {
        $request = Func_Input::filter(array(
            "id"=>'int',
        ),$_REQUEST);
        if(empty($request['id'])){
            Func_Header::back("参数错误");
        }
        $rs = Data_Mysql_Table_Wechat_Web_Category::update(array('id' => $request['id']),array("status"=>-2));
        if($rs){
            Func_Header::back("彻底删除成功");
        }else{
            Func_Header::back("彻底删除失败");
        }
    }
} 