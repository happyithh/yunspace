<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/12/14
 * Time: 14:54
 */

//Q(Core::$urls['action']);
@session_start();
//q(Core::$urls);
//$_SESSION['openid'] = 'okykjuCyTWO2iCB6OmuJTQvs7YKA';
//$_SESSION['url_back'] = 'http://'.Core::$urls['host'].Core::$urls['path'];
//q($_SESSION);
//if(empty($_SESSION['user']['id']) || empty($_SESSION['openid'])) {
//    Wechat_Oauth_Manager::handle();
//}
//if(empty($_SESSION['openid'])) {
//    Func_Header::back('请在微信客户端打开链接');
//}
switch (Core::$urls['action']) {

    //场地百科--基本信息
    case  "site_list":
        Web_Mobile_Site_Management::handle();
        break;
    case  "basic_info":
        Web_Mobile_Site_Management::basicInfo();
        break;
    case  "basic_info_edit":
        Web_Mobile_Site_Management::basicInfoEdit();
        break;
    case  "tags_edit":
        Web_Mobile_Site_Management::tagsEdit();
        break;
    case  "traffic_edit":
        Web_Mobile_Site_Management::trafficEdit();
        break;
    case  "business_edit":
        Web_Mobile_Site_Management::businessEdit();
        break;
    case  "test0":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m0.tpl');
        break;
    case  "test0-0":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m0-0.tpl');
        break;
    case  "test1-0":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m1-0.tpl');
        break;
    case  "test1-1":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m1-1.tpl');
        break;
    case  "test1-2":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m1-2.tpl');
        break;
    case  "test1-3":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m1-3.tpl');
        break;
    case  "test1-4":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m1-4.tpl');
        break;
    case  "test1-5":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m1-5.tpl');
        break;




    //场地--空间标准
    case  "space_std":
        Web_Mobile_Site_Management::spaceStd();
        break;
    case  "space_std_edit":
        Web_Mobile_Site_Management::spaceStdEdit();
        break;
    case  "test2-1":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m2-1.tpl');
        break;
    case  "test2-2":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m2-2.tpl');
        break;




    //场地--配套设施标准
    case  "mating_service":
        Web_Mobile_Site_Management::matingService();
        break;
    case  "mating_service_edit":
        Web_Mobile_Site_Management::matingServiceEdit();
        break;
    case  "test3-1":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m3-1.tpl');
        break;
    case  "test3-2":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m3-2.tpl');
        break;



    //场地--使用规格标准
//    case  "use_std":
//        Web_Mobile_Site_Management::useStd();
//        break;
//    case  "use_std_edit":
//        Web_Mobile_Site_Management::useStdEdit();
//        break;
    case  "test4-1":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m4-1.tpl');
        break;
    case  "test4-2":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m4-2.tpl');
        break;



    //场地--配套饮品标准
//    case  "mating_drink":
//        Web_Mobile_Site_Management::matingDrink();
//        break;
//    case  "mating_drink_edit":
//        Web_Mobile_Site_Management::matingDrinkEdit();
//        break;
    case  "test5-1":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m5-1.tpl');
        break;
    case  "test5-2":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m5-2.tpl');
        break;


    //场地--收费标准
//    case  "money_std":
//        Web_Mobile_Site_Management::moneyStd();
//        break;
//    case  "money_std_edit":
//        Web_Mobile_Site_Management::moneyStdEdit();
//        break;
    case  "test6-1":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m6-1.tpl');
        break;
    case  "test6-2":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m6-2.tpl');
        break;


    //场地--活动适用
    case  "act_apply":
        Web_Mobile_Site_Management::actApply();
        break;
    case  "trade_type_edit":
        Web_Mobile_Site_Management::tradeTypeEdit();
        break;
    case  "act_type_edit":
        Web_Mobile_Site_Management::actTypeEdit();
        break;
    case  "test7-1":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m7-1.tpl');
        break;
    case  "test7-2":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m7-2.tpl');
        break;
    case  "test7-3":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m7-3.tpl');
        break;


    //场地--图片管理
    case  "image_show":
        Web_Mobile_Site_Management::imageShow();
        break;
    case  "image_edit":
        Web_Mobile_Site_Management::imageEdit();
        break;
    case  "test8-1":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m8-1.tpl');
        break;
    case  "test8-2":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m8-2.tpl');
        break;




    //场地--子空间管理
    case  "space_item_list":
        Web_Mobile_Site_Management::spaceItemList();
        break;
    case  "space_item_show":
        Web_Mobile_Site_Management::spaceItemListShow();
        break;
    case  "space_item_list_edit":
        Web_Mobile_Site_Management::spaceItemListEdit();
        break;
    case  "space_item_tag_edit":
        Web_Mobile_Site_Management::spaceItemTagEdit();
        break;
    case  "test9-0":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m9-0.tpl');
        break;
    case  "test9-1":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m9-1.tpl');
        break;
    case  "test9-2":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m9-2.tpl');
        break;


    //全局图标------加载更多loading......
    case  "test0-1":
        Tpl_Smarty::display('Web_Mobile_Static::site_management/site_m0-1.tpl');
        break;


    //我的收藏
    case  "collect":
        Tpl_Smarty::display('Web_Mobile_Static::v1.0/my_collect.tpl');
        break;














}