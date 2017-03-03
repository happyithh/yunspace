<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/4/7
 * Time: 17:29
 * 文创需求管理
 */
class OA_Winchance_Demand_list {
    static function handle(){
        $action = empty($_REQUEST['action'])?'list':$_REQUEST['action'];
        switch($action)
        {
            case 'list':
                self::demandList();
                break;
            case 'add':
                self::demandAdd();
                break;
            case 'submit':
                self::demandSubmit();
                break;
        }
    }
    // 文创需求列表
    static function demandList(){
        $data = Api_Winchance_Demand_list::demandList($_REQUEST);
        Tpl_Smarty::display('OA_Static::wenchuang/demand_list.tpl');
    }
}

