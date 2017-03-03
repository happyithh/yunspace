<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-4-14
 * Time: 下午6:33
 * yl
 * 全局标签
 */
switch (Core::$urls['action']) {
    case 'product':
        OA_Element_List::handle();
        break;
    case 'product_update':
        OA_Element_List_Product_Update::handle();
        break;
    case 'vendor':
        OA_Element_Vendor_List::handle();
        break;
    case 'order':
        OA_Order_List::handle();
        break;
    case 'product_set':
        OA_Product_Set_List::handle();
        break;
    case 'operate_log':
        OA_Operate_Log_List::handle();
        break;
    case 'order_log':
        OA_Order_Log_List::handle();
        break;
    case 'demand_recommend':
        OA_Demand_Recommend_List::handle();    //产品推荐列表
        break;
    case 'demand_take':
        OA_Demand_Handle_Take_Look::handle();
        break;
    case 'set_recommend':
        OA_Demand_Recommend_List::handle(1);  //套餐推荐列表
        break;
    case 'sign_list':
        OA_Order_SignPass::handle();
        break;
    default:
        Func_Header::notFound();
        break;
}
