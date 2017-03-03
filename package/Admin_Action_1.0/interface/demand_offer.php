<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/1/13
 * Time: 16:20
 */
switch (Core::$urls['action']) {

    case 'space_archives':
        OA_Demand_Offer_Space_Archives::handle();
        break;
}