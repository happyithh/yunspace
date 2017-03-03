<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/1/28
 * Time: 9:57
 */
class OA_Demand_Offer_Count
{

    static function  handle()
    {
        $action = empty($_REQUEST['action']) ? 'index' : $_REQUEST['action'];
        switch ($action) {
            case '':
                break;
            default:
                self::handleIndex();

        }
    }

    static function  handleIndex()
    {

        Tpl_Smarty::display('OA_Static::Demand_Offer.v1.0/count/index.tpl');
    }
} 