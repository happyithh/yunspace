<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/12/24
 * Time: 17:08
 */
switch (Core::$urls['action']) {
    case 'list':
        OA_System_Notice::handle();
        break;
}