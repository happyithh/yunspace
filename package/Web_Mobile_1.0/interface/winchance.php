<?php
switch (Core::$urls['action']) {
    case  "":
//        Tpl_Smarty::display('Web_Mobile_Static::winchance.v2.0/winchance.tpl');
//        break;
        Tpl_Smarty::assign('seo', array(
            '网页标题' => 'IP展_IP合作_IP活动_艺术展_动漫展_最聚购物中心客流【云SPACE-文创IP】',
            '网页关键词' => '超级IP,大IP,强品牌IP,原创IP,文创产品,ip授权,商场活动,动漫周边',
            '网页简介' => '云SPACE是国内首家"购物中心+IP"跨界合作平台,整合IP资源,帮助购物中心引导人流,将IP美陈与建筑结合、内容与所具备的情感结合，将IP变成一种情感纽带，从而更好的带动整体客流'
        ));
//        $winchance_seo['title'] = 'IP展_IP合作_IP活动_最聚商场客流-云SPACE';
//        Data_Config_Site::seo('winchance', $winchance_seo);
//        $category = Data_Mysql_Table_Winchance::$category;
//        Tpl_Smarty::assign('category', $category);
        Web_Winchance_Win_New::display('Web_Mobile_Static::wchuang/wchuang1.0.tpl');
        break;
    case  "list":
        Tpl_Smarty::assign('seo', array(
            '网页标题' => 'IP展_IP合作_IP活动_艺术展_动漫展_最聚购物中心客流【云SPACE-文创IP】',
            '网页关键词' => '超级IP,大IP,强品牌IP,原创IP,文创产品,ip授权,商场活动,动漫周边',
            '网页简介' => '云SPACE是国内首家"购物中心+IP"跨界合作平台,整合IP资源,帮助购物中心引导人流,将IP美陈与建筑结合、内容与所具备的情感结合，将IP变成一种情感纽带，从而更好的带动整体客流'
        ));
//        Tpl_Smarty::display('Web_Mobile_Static::winchance.v2.0/win_more.tpl');
//        break;
        $list = Api_Winchance_List::getData(array('num'=>5));
//        $category = Data_Mysql_Table_Winchance::$category;
//        Tpl_Smarty::assign('category', $category);
//        $winchance_seo['title'] = '文创活动';
//        Data_Config_Site::seo('winchance', $winchance_seo);
        Tpl_Smarty::assign('winchance_list',$list);
        Tpl_Smarty::display('Web_Mobile_Static::wchuang/wch_more_1.tpl');
        break;
    case 'demand':
        if(!empty($_REQUEST['space_id'])){
            $space_id = Func_NumEncode::d($_REQUEST['space_id']);
            $data = Data_Mysql_Table_Winchance_New::select('id,active_name,space_id', array('space_id=?'=>$space_id), '', 1);
            if($data){
                Tpl_Smarty::assign('ip_id',$data[0]['id']);
                Tpl_Smarty::assign('active_name',$data[0]['active_name']);
            }else{
                Func_Header::notFound();
            }
        }
        Tpl_Smarty::assign('seo', array(
            '网页标题' => 'IP展_IP合作_IP活动_艺术展_动漫展_最聚购物中心客流【云SPACE-文创IP】',
            '网页关键词' => '超级IP,大IP,强品牌IP,原创IP,文创产品,ip授权,商场活动,动漫周边',
            '网页简介' => '云SPACE是国内首家"购物中心+IP"跨界合作平台,整合IP资源,帮助购物中心引导人流,将IP美陈与建筑结合、内容与所具备的情感结合，将IP变成一种情感纽带，从而更好的带动整体客流'
        ));
        Tpl_Smarty::assign('category',Data_Mysql_Table_Spacepedia::getChildrenByCid(112));
        Tpl_Smarty::assign('cities',Web_Global::cities());
        Tpl_Smarty::display('Web_Mobile_Static::wchuang/enquiry.tpl');
        break;
    case 'join':
        Tpl_Smarty::assign('seo', array(
            '网页标题' => 'IP展_IP合作_IP活动_艺术展_动漫展_最聚购物中心客流【云SPACE-文创IP】',
            '网页关键词' => '超级IP,大IP,强品牌IP,原创IP,文创产品,ip授权,商场活动,动漫周边',
            '网页简介' => '云SPACE是国内首家"购物中心+IP"跨界合作平台,整合IP资源,帮助购物中心引导人流,将IP美陈与建筑结合、内容与所具备的情感结合，将IP变成一种情感纽带，从而更好的带动整体客流'
        ));
//        q( Web_Global::cities());
        Tpl_Smarty::assign('category',Data_Mysql_Table_Spacepedia::getChildrenByCid(112));
        Tpl_Smarty::display('Web_Mobile_Static::wchuang/wch_enquiry.tpl');
        break;
    default:
        Func_Header::notFound();

}