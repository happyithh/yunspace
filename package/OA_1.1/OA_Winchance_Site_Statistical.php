<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/4/8
 * Time: 17:43
 *
 * 文创场地进度统计
 */
class OA_Winchance_Site_Statistical {
    static function handle(){
        $action = empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action){
            case 'list':
                self::siteStatistical();
                break;
        }
    }
    static function siteStatistical(){
        $data = Api_Winchance_Site_Statistical::siteStatistical($_REQUEST);
        if(!empty($data['city'])){
            Tpl_Smarty::assign('city',$data['city']);
        }
        unset($data['city']);
        Tpl_Smarty::assign('data',$data);
        $citys = Data_Mysql_Table_Winchance::$citys;
        Tpl_Smarty::assign('citys',$citys);
        Tpl_Smarty::assign('step',Data_Mysql_Table_Winchance_Site::$step);
        Tpl_Smarty::display('OA_Static::winchance/site_statistical.tpl');
    }
}