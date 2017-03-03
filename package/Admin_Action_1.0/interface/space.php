<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-16
 * Time: 上午10:01
 */
switch (Core::$urls['action']) {
    case "old_product":
        OA_Old_Product_Convert_Spacepedia::handle();
        break;
    case "convert_once":
        OA_Old_Product_Convert_Once::handle();
        break;
    case "spacepedia":
        OA_Spacepedia_Management::handle();
        break;
    case "spacepedia_check":
        OA_Spacepedia_Check::handle();
        break;
    case "space_item_check":
        OA_Space_Item_Check::handle();
        break;
    case "spacepedia_repeat":
        OA_Spacepedia_Repeat::handle();
        break;
    case "demand_tag":
        OA_Denand_Tag::handle();
        break;
    case "pedia_space_assign":
        OA_Pedia_Space_Assign::handle();
        break;
    case 'new_space':
        OA_New_Space::handle();
        break;
    case "pedia_space_update":
        OA_Pedia_Space_Update::handle();
        break;
    case "space_item_list":
        OA_Space_Item_List::handle();
        break;
    default:
        Func_Header::notFound();
        break;
}