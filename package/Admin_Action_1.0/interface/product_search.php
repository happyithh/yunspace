<?php
/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/4/14
 * @产品信息处理
 */

switch (Core::$urls['action']){
    case 'update_product_info_list':
        Admin_Search_Product_Search ::handle();
        break;
    default:
            Func_Header::notFound();
        break;
}