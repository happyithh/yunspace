<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/4/2
 * Time: 19:54
 */
switch (Core::$urls['action']) {
    // 我的供应商（新）
    case 'my_vendor_new':
        OA_Vendor_List_New::handle(1);
        break;
    // 所有供应商(新)
    case 'all_vendor_new':
        OA_Vendor_List_New::handle(0);
        break;
    //所在城市供应商
    case "all_vendor_city":
        OA_Vendor_List_New::handle(2);
        break;
    // 所有供应商审核(新)
    case 'all_vendor_check':
        OA_Vendor_List_All_Check::handle();
        break;
    //处理采集过来的图片水印
    case 'delete_img':
        OA_Vendor_Delete_Img::handle();
        break;
    default:
        Func_Header::notFound();
}