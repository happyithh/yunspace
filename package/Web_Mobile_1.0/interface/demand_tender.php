<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/9/1
 * Time: 10:41
 */
//1.客户查看竞标
//2.供应商报价

$action = Core::$urls['action'];
if (Core::$urls['host'] == 'pre0.yunspace.com.cn') {
    header('location:' . 'http://www.yunspace.com.cn' . Core::$urls['uri']);
}
switch ($action) {
    case 'customer':
        Web_Mobile_Demand_Tender::customer();
        break;

    case 'vendor':
        Web_Mobile_Demand_Tender::vendor();
        break;


}
