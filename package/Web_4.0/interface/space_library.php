<?php
//场地库
$rent_space=Web_Rent_Space_Item::getInstance();
$request=$rent_space->request;
// $request = Func_Input::filter(array(
//     'action' => 'string',
//     'people' => 'string',
//     'activity' => 'string',
//     'demand_id' => 'int',
//     'phone' => 'string',
//     'level' => 'int',
//     'space_id' => 'string',
// ));
if ($request['space_id'] && empty($request['action'])) {
    $request['action'] = 'form';
}
if (Core::$urls['action']) {
    $request['action'] = Core::$urls['action'];
}
$is_cache = true;
if (Core::$urls['route'] == 'city/') {
    $request['action'] = '';
    $is_cache = false;
}
switch ($request['action']) {
    case "form":
        Tpl_Smarty::assign('people', $rent_space->request['people']);
        Tpl_Smarty::assign('activity', $rent_space->request['activity']);
        // q($rent_space->item);
        Tpl_Smarty::assign('nav', "space_library");
        if($rent_space->item_id || $rent_space->price_id){
            if($rent_space->price_id){
                Tpl_Smarty::assign('item', $rent_space->item_price);
            }else{
                Tpl_Smarty::assign('item', $rent_space->item);
            }
            // q($rent_space->item_price);
            Web_Rent_Space_Item::display('Web_Static::space_library/rent_item_form.tpl');
        }else{
            Web_Rent_Space_Item::display('Web_Static::space_library/rent_space_form.tpl');
        }
        break;
    case "success":
        Tpl_Smarty::assign('phone', Func_String::decrypt($rent_space->request['phone'], "哈哈，猜不到吧"));
        Tpl_Smarty::assign('demand_id', $rent_space->request['demand_id']);
        Tpl_Smarty::assign('is_work_time', Web_Global::isWorkTime());
        // Tpl_Smarty::assign('demand_level', empty($request['level']) ? 1 : $request['level']);
        Tpl_Smarty::assign('nav', "space_library");
        Web_Rent_Space_Item::display('Web_Static::space_library/success.tpl');
        break;
    case '':
        if ($is_cache) {
            Web_Global::openCache(48);
        }
        Tpl_Smarty::assign('nav', "space_library");
        Web_Space_Library::display('Web_Static::space_library/space_library_2.0.tpl');
        break;
    case 'getShowSpace':
        Web_Space_Library::display('Web_Static::space_library/inc/getShowSpace.tpl');
        break;
    case 'getBarSpace':
        Web_Space_Library::display('Web_Static::space_library/inc/getBarSpace.tpl');
        break;
    case 'getBusinessSpace':
        Web_Space_Library::display('Web_Static::space_library/inc/getBusinessSpace.tpl');
        break;
    case 'getClubSpace':
        Web_Space_Library::display('Web_Static::space_library/inc/getClubSpace.tpl');
        break;
    case 'getMeetingSpace':
        Web_Space_Library::display('Web_Static::space_library/inc/getMeetingSpace.tpl');
        break;
    default:
        Func_Header::notFound();
        break;
}
