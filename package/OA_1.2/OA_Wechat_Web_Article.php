<?php
/**
 * Created by PhpStorm.
 * User: sdd
 * Date: 2016/8/26
 * Time: 10:56
 */
class OA_Wechat_Web_Article {

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
                self::handleWechatWebArticleList();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }

    //活动列表
    static function handleWechatWebArticleList()
    {
        $conditions = array();
        //筛选条件
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'title' => 'string',
                'category' => 'int',
                'is_lnk' => 'int',
                'is_recommend' => 'int',
            ), $_REQUEST['search']);

//            q($search);
            //文章名称
            if (!empty($search['title'])){
                if (is_numeric($_REQUEST['search']['title'])){
                    $conditions['id=?'] = $search['title'];
                } else {
                    $conditions['title=?'] = $search['title'];
                }
            }
            //分类
            if (!empty($search['category'])){
                $conditions['category_id=?'] = $search['category'];
            }
            //是否有链接
            if(isset($search['is_lnk'])){
                if (!empty($search['is_lnk'])){
                    $conditions['is_lnk=?'] = $search['is_lnk'];
                }

            }
            if(isset($search['is_recommend'])){
                if (!empty($search['is_recommend'])){
                    $conditions['is_recommend=?'] = $search['is_recommend'];
                }

            }
//            q($conditions);
        }
//        q($conditions);
        $status = isset($_REQUEST['status']) ? $_REQUEST['status'] : 1;
        Tpl_Smarty::assign('status', $status);
        $conditions['status=?'] = $status;
//        q($conditions);
//        Data_Mysql_Table_Wechat_Web_Article::debug(1);
        $list = Data_Mysql_Table_Wechat_Web_Article::page(0, 10, "*", $conditions, 'ORDER BY update_time DESC');
        $category = Data_Mysql_Table_Wechat_Web_Category::select('id,category,status','','ORDER BY status DESC',20);
//        q($category);
        foreach($list['rows'] as $k=>$v){
            $num = mb_strlen($v['title']);
            if($num>=20){
                $list['rows'][$k]['title'] = mb_substr($v['title'],0,20,"utf-8")."...";
            }
            $list['rows'][$k]['url_id'] = Func_NumEncode::e($v['id'].'9528');
//            $num = mb_strlen($v['content']);
//            if($num>=23){
//                $list['rows'][$k]['content'] = mb_substr($v['content'],0,23,"utf-8")."...";
//            }
//            $num = mb_strlen($v['introduction']);
//            if($num>=15){
//                $list['rows'][$k]['introduction'] = mb_substr($v['introduction'],0,15,"utf-8")."...";
//            }
//            $num = mb_strlen($v['image']);
//            if($num>=15){
//                $list['rows'][$k]['image'] = mb_substr($v['image'],0,15,"utf-8")."...";
//            }
//            $num = mb_strlen($v['link']);
//            if($num>=15){
//                $list['rows'][$k]['link'] = mb_substr($v['link'],0,15,"utf-8")."...";
//            }
            foreach($category as $key=>$val){
                if($v['category_id'] == $val['id']){
                    $list['rows'][$k]['category_id'] = $val['category'];
                }
            }
        }
//        q($list);
        Tpl_Smarty::assign('category', $category);
        $is_lnk = Data_Mysql_Table_Wechat_Web_Article::$is_lnk;
        Tpl_Smarty::assign('is_lnk', $is_lnk);
        $is_recommend = Data_Mysql_Table_Wechat_Web_Article::$is_recommend;
        Tpl_Smarty::assign('is_recommend', $is_recommend);
        Tpl_Smarty::assign('_data', $list);
        Tpl_Smarty::display("OA_Static::wechat_web_article/article_list.tpl");
//        q($list);
    }

    static function handleAdd()
    {
        $request = Func_Input::filter(array(
            'id' => 'int'
        ));
        $category = Data_Mysql_Table_Wechat_Web_Category::select('id,category,status','','ORDER BY status DESC',20);
//        q($category);
        Tpl_Smarty::assign('category', $category);
        if (!empty($request['id'])) {
            $info = Data_Mysql_Table_Wechat_Web_Article::select('*', array('id =?' => $request['id']), '', 1);
            Tpl_Smarty::assign('info', $info[0]);
        }
//        q($info);
        Tpl_Smarty::display("OA_Static::wechat_web_article/article_add.tpl");
    }

    static  function handleBindAccountSubmit(){
        $request = Func_Input::filter(array(
            'aid' => 'int',
            'title' => 'string',
            'category_id' => 'string',                       //分类名称
            'image' => 'string',             //类别图片
            'is_lnk' => 'int',
            'link' => 'string',
            'introduction' => 'string',
            'content' => 'html',
            'status' => 'int',               //0下线   1上线
            'url_referer'=>'string',
            'is_recommend' => 'int',
        ),$_REQUEST);
//        if(!empty($request['image'])){
//            Func_Image::thumCenterImage(Core::$paths['root'].$request['image'], Core::$paths['root'].$request['image'],414, 276);
//        }
//        q($request);
        if(empty($request['title'])){
            Func_Header::back('文章名不能为空！');
        }
        $data['title'] = $request['title'];
        $data['category_id'] = $request['category_id'];
        $data['image'] = $request['image'];
        $data['status'] = $request['status'];
        $data['is_lnk'] = $request['is_lnk'];
        $data['is_recommend'] = $request['is_recommend'];
        $data['link'] = $request['link'];
        $data['introduction'] = $request['introduction'];
        $data['content'] = $request['content'];
        $data['update_time'] = time();
        if (!empty($request['aid'])) {
            $data['id'] = $request['aid'];
        } else {
            $data['create_time'] = time();
        }
//        q($_REQUEST);
        $rows = Data_Mysql_Table_Wechat_Web_Article::update($data);
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
        $rss = Data_Mysql_Table_Wechat_Web_Article::update($request['id'],array("status"=>$status));
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
        $rs = Data_Mysql_Table_Wechat_Web_Article::update(array('id' => $request['id']),array("status"=>-2));
        if($rs){
            Func_Header::back("彻底删除成功");
        }else{
            Func_Header::back("彻底删除失败");
        }
    }

}