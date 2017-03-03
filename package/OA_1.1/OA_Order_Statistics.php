<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/3/17
 * Time: 9:45
 *
 * 订单统计
 */
class OA_Order_Statistics {
    static function handle(){
        switch(Core::$urls['action']){
            case 'order_statistics':
                self::orderStatistics();
                break;
        }
    }
    static function orderStatistics(){
        $data = Api_Order_Statistics::orderStatistics($_REQUEST);
        Tpl_Smarty::assign('grab_order_step',Data_Mysql_Table_Demand::$grab_order_step);
        Tpl_Smarty::assign('data',$data);
        Tpl_Smarty::display('OA_Static::order/order_list.tpl');
    }
}