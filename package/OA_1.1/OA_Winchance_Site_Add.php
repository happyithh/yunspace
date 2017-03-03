<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/4/8
 * Time: 14:03
 * 文创场地添加
 */
class OA_Winchance_Site_Add
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'add' : $_REQUEST['action'];

        switch ($action) {
            case 'add':
                self::add();
                break;
            case 'siteSubmit':
                self::siteSubmit();
                break;
            case 'edit':
                self::add();
                break;
            case 'siteDelete':
                self::siteDelete();
                break;
        }

    }

    static function add()
    {
        if (!empty($_REQUEST['id'])) {
            $data = Api_Winchance_Site_Detail::detail($_REQUEST);
            Tpl_Smarty::assign('data', $data);
        }
        $citys = Data_Mysql_Table_Winchance::$citys;
        Tpl_Smarty::assign('citys',$citys);
        $step = Data_Mysql_Table_Winchance_Site::$step;
        Tpl_Smarty::assign('step', $step);
        $site_type = Data_Mysql_Table_Winchance_Site::$site_type;
        Tpl_Smarty::assign('site_type', $site_type);
        Tpl_Smarty::display("OA_Static::winchance/site_add.tpl");
    }

    static function siteSubmit()
    {
        $res = Api_Winchance_Site_Submit::siteSubmit($_REQUEST);
        if (!empty($res[0])) {
            Func_Header::to('  操作成功！', 'http://' . Core::$urls['host'] . '/admin/action/winchance/site_list');
        } else {
            Func_Header::back('操作失败！');
        }
    }

    static function siteDelete()
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ), $_REQUEST);
        if (empty($request['id'])) {
            Func_Header::back('场地ID异常！');
        }
        $res = Data_Mysql_Table_Winchance_Site::update(array('id'=>$request['id']),array('status'=>-1));
        if(!empty($res[0])){
            Func_Header::to('  删除成功！');
        }else{
            Func_Header::back('  操作失败！');
        }
    }
}