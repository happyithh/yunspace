<?php
/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/2/4
 * Time: 11:59
 */
switch (Core::$urls['action']) {
    case 'home_page_banner':
//        banner
        $banner = Web_HomePage::get('banner');

        if (empty($banner) || !is_array($banner)) {
            $banner = array();
        }
        unset($_REQUEST['data']['media']['$$']);
        if (!empty($_REQUEST['data']['media']) && !empty($_REQUEST['city'])) {
            $banner[$_REQUEST['city']] = $_REQUEST['data']['media'];
            Web_HomePage::set('banner', $banner);
        }
        if (empty($_REQUEST['city'])) {
            $_REQUEST['city'] = '上海';
        }
        if (!empty($banner[$_REQUEST['city']])) {
            Tpl_Smarty::assign('_data', array('media' => $banner[$_REQUEST['city']]));
        }

//        其他
        $hotContent = Web_HomePage::get('hotContent');
        if (empty($hotContent) || !is_array($hotContent)) {
            $hotContent = array();
        }
        if (!empty($_REQUEST['data']['hotContent']) && !empty($_REQUEST['city'])) {
            $hotContent[$_REQUEST['city']] = $_REQUEST['data']['hotContent'];
            Web_HomePage::set('hotContent', $hotContent);
        }
        if (!empty($hotContent[$_REQUEST['city']])) {

            Tpl_Smarty::assign('_data2', array('hotContent' => $hotContent[$_REQUEST['city']]));
        }

        Tpl_Smarty::display("B2B_Admin", "website_home_page_banner.tpl");
        break;
//    case 'home_page_hot_content':
//        Tpl_Smarty::display("B2B_Admin", "website_home_page_hot_content.tpl");
//        break;
    case 'home_page_v2':
        OA_Home_Page::handle();
        break;
    case 'home_page_banner_v2':
        OA_Home_Page::handleHomeBanner();
        break;
    case 'home_page_banner_v4':
        OA_Home_Page_New::handle();
        break;
    case "annual_meeting":
        OA_Annual_Meeting::handle();
        break;
    default:
        Func_Header::notFound();
        break;
}