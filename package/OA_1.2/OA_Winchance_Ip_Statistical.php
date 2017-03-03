<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2016/5/7
 * Time: 20:33
 */

class OA_Winchance_Ip_Statistical {

    static function handle()
    {
        $action = empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action)
        {
            case 'list':
                self::statisticalList();
                break;
        }
    }
    static function statisticalList(){
        // 城市
        $city = Data_Mysql_Table_Winchance_Fields::getContent('运营范围');
        Tpl_Smarty::assign('city',$city);
        // 负责人
        $admin = Data_Mysql_Table_Winchance_Order::getTeamUserList();
        Tpl_Smarty::assign('admin',$admin);
        // tab
        $tab = empty($_REQUEST['tab'])?'step':$_REQUEST['tab'];
        Tpl_Smarty::assign('tab',$tab);
        // step
        $step = Data_Mysql_Table_Winchance_New::$step;
        Tpl_Smarty::assign('step',$step);
//        q($data);
        if($tab=='step'){
            $data = Api_Winchance_New_Ip_Step_Statistical::stepList();
        }else{
            $data = Api_Winchance_New_Ip_Total_Statistical::totalList();
        }

        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::display("OA_Static::winchance_new/ip_statistical.tpl");
    }
}