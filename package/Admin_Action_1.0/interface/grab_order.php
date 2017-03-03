<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/29
 * Time: 10:35
 */
switch (Core::$urls['action']) {
    case 'list':
        Web_Mobile_Grab_Order::handleLeaderAllot();
        break;
}