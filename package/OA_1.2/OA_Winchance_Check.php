<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/5/7
 * Time: 20:34
 */

class OA_Winchance_Check {
    static function handle()
    {
        $action = empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action)
        {
            case 'list':
                self::checkList();
                break;
            case 'check':
                self::checkDetail();
                break;
            case 'checkSubmit':
                self::checkSubmit();
                break;

        }
    }
    static function checkList(){
        /*
         * 获取模板必要数据------开始
         * */
        // 运营范围
        $city =Data_Mysql_Table_Winchance_Fields::getContent('运营范围');
        Tpl_Smarty::assign('city',$city);
        // 表现形式
        $manifestation =Data_Mysql_Table_Winchance_Fields::getContent('表现形式');
        Tpl_Smarty::assign('manifestation',$manifestation);
        // 分类
        $category =Data_Mysql_Table_Winchance_Fields::getContent('分类');
        Tpl_Smarty::assign('category',$category);
        //  来源国家
        $country =Data_Mysql_Table_Winchance_Fields::getContent('来源国家');
        Tpl_Smarty::assign('country',$country);
        //合作模式
        $cooperating_mode =Data_Mysql_Table_Winchance_Fields::getContent('合作模式');
        Tpl_Smarty::assign('cooperating_mode',$cooperating_mode);
        // 负责人
        $admin = Data_Mysql_Table_Winchance_Order::getTeamUserList();
        Tpl_Smarty::assign('admin',$admin);
        /*
         * 获取模板必要数据------结束
         * */
        $data = Api_Winchance_New_Ip_Check_List::ipCheckList();
        Tpl_Smarty::assign('_data',$data);
        Tpl_Smarty::display("OA_Static::winchance_new/winchance_check_list.tpl");
    }
    static function checkDetail(){
        /*
         * 获取模板必要数据------开始
         * */
        $step = empty($_REQUEST['step'])?'1':$_REQUEST['step'];
        Tpl_Smarty::assign('step',$step);
        // 运营范围
        $city =Data_Mysql_Table_Winchance_Fields::getContent('运营范围');
        Tpl_Smarty::assign('city',$city);
        // 表现形式
        $manifestation =Data_Mysql_Table_Winchance_Fields::getContent('表现形式');
        Tpl_Smarty::assign('manifestation',$manifestation);
        // 分类
        $category =Data_Mysql_Table_Winchance_Fields::getContent('分类');
        Tpl_Smarty::assign('category',$category);
        //合作模式
        $cooperating_mode =Data_Mysql_Table_Winchance_Fields::getContent('合作模式');
        Tpl_Smarty::assign('cooperating_mode',$cooperating_mode);
        //  来源国家
        $country =Data_Mysql_Table_Winchance_Fields::getContent('来源国家');
        Tpl_Smarty::assign('country',$country);
        /*
         * 获取模板必要数据------结束
         * */
        $data = Api_Winchance_New_Ip_Check_Detail::detail();
        Tpl_Smarty::assign('data',$data[0]);
        Tpl_Smarty::display("OA_Static::winchance_new/winchance_check_edit.tpl");
    }
    static function checkSubmit(){
       Api_Winchance_New_Ip_Check_Submit::checkSubmit();

    }
} 