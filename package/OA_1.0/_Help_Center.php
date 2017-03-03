<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/27
 * Time: 16:19
 */
$_REQUEST['action'] = empty($_REQUEST['action']) ? 'list':$_REQUEST['action'];
class OA_Help_Center
{
    static function handle()
    {
        switch ($_REQUEST['action']) {
            case 'list':
                self::helpCenterList();
                break;
            case 'add':
                self::helpCenterAdd();
                break;
            case 'edit':
                self::helpCenterEdit();
                break;
            case 'publish':
                self::helpInfoPublish();
                break;
            case 'cancel':
                self::helpInfoCancel();
                break;
            case 'delete':
                self::deleteHelpInfo();
                break;
            default:
                self::helpCenterList();
        }
    }

    static function  helpCenterList()
    {
        $conditions[] = 'status >= 0';
        $order = 'ORDER BY create_time DESC';
        $data = Data_Mysql_Table_Help_Center::page(0,15,"*",$conditions,$order);
        foreach ($data['rows'] as &$v){
            $v['update_time'] = date('Y-m-d',$v['update_time']);
        }
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::display('OA', 'help-center.tpl');
    }

    static function helpCenterAdd()
    {
      if(!empty($_REQUEST['submit'])) {
            $filter = Func_Input::filter(
                array(
                    'title' => 'string',
                    'contents' => 'html',
                    'category' => 'string',
                ), $_REQUEST);
          if(empty($filter['title'])){
              Func_Header::back('标题不能为空！');
          }
          if(empty($filter['contents'])){
              Func_Header::back('内容不能为空！');
          }
          if($filter['category']=='请选择'){
              Func_Header::back('请选择帮助类型！');
          }
            if ($filter['title']) {
                $data = array(
                    'title' => $filter['title'],
                    'contents' => $filter['contents'],
                    'category' => $filter['category'],
                    'create_time' => time(),
                    'username' => 'yunspace',
                    'status' => '0',
                );
                $result = Data_Mysql_Table_Help_Center::insert($data);
                if ($result > 0) {
                    Func_Header::to('  添加成功！', Core::$urls['path']);
                } else {
                    Func_Header::back('添加失败！');
                }
            }
      }
          $category = Data_Mysql_Table_Help_Center::$category;
          Tpl_Smarty::assign('category',$category);
          Tpl_Smarty::display('OA', 'help-center-add.tpl');

    }

    static function helpCenterEdit()
    {
        if(empty($_REQUEST['id'])||!is_numeric($_REQUEST['id'])) {
            Func_Header::back('消息不存在！');
        }
        $conditions['id'] = $_REQUEST['id'];
        $data = Data_Mysql_Table_Help_Center::select("*", array('id'=>$_REQUEST['id']));
        $category = Data_Mysql_Table_Help_Center::$category;
        Tpl_Smarty::assign('category',$category);
        Tpl_Smarty::assign('data', $data);
        //q($_REQUEST);
        if(!empty($_REQUEST['submit'])) {
            $filter = Func_Input::filter(
                array(
                    'title' => 'string',
                    'contents' => 'html',
                    'category' => 'string',
                ), $_REQUEST);
            if(empty($filter['title'])){
                Func_Header::back('标题不能为空！');
            }
            if(empty($filter['contents'])){
                Func_Header::back('内容不能为空！');
            }
            if($filter['category']=='请选择'){
                Func_Header::back('请选择帮助类型！');
            }
            if (!empty($filter)) {
                $data1 = array(
                    'title' => $filter['title'],
                    'contents' => $filter['contents'],
                    'category' => $filter['category'],
                    'update_time' => time(),
                );
                $result = Data_Mysql_Table_Help_Center::update($conditions, $data1);
                if ($result > 0) {
                    Func_Header::to('  修改成功！', '?');
                } else {
                    Func_Header::back('修改失败！');
                }
            }
        }
            Tpl_Smarty::display('OA','help-center-add.tpl');
            die();
    }
    static function helpInfoPublish()
    {
        $result = Data_Mysql_Table_Help_Center::update(array('id'=>$_REQUEST['id']),array('status'=>1));
        if(!empty($result)){
            Func_Header::back('  发布成功！');
        }else{
            Func_Header::back('发布失败！');
        }
    }
    static function helpInfoCancel()
    {
        $result = Data_Mysql_Table_Help_Center::update(array('id'=>$_REQUEST['id']),array('status'=>0));
        if(!empty($result)){
            Func_Header::back('  撤消成功！');
        }else{
            Func_Header::back('撤消失败！');
        }
    }
    static function deleteHelpInfo(){
        $result = Data_Mysql_Table_Help_Center::update(array('id'=>$_REQUEST['id']),array('status'=>-1));
        if(!empty($result)){
            Func_Header::back();
        }
    }
}