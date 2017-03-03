<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-10-23
 * Time: 上午11:40
 * 询价
 */
@session_start();
Tpl_Smarty::assign('__seo', array(
    '网页标题'=>'云SPACE|我要办活动',
));
$spaceInfo=array();
if(!empty($_REQUEST['space_id'])){
    if(strstr($_REQUEST['space_id'],',')){
        $space_ids = explode(',',$_REQUEST['space_id']);
        foreach($space_ids as $k=>$v){
            $space_id_n[] = Func_NumEncode::d($v);
        }
        $space_id_n = array_unique($space_id_n);
        $space_id = implode(',',$space_id_n);
    }else{
        $space_id=Func_NumEncode::d($_REQUEST['space_id']);
    }
    //获取场地信息
    $space=Api_Spacepedia_List_And_Info::getSpacepediaInfoById($space_id);
    if(!empty($space[0])){
        $spaceInfo=$space[0];
    }
}
if(!empty($spaceInfo)){
    //咨询场地档期和价格
    Tpl_Smarty::assign("spaceInfo",$spaceInfo);
    if(strstr($_REQUEST['space_id'],',')){
        Tpl_Smarty::display( 'Web_Mobile_Static::search_about/schedule_prices.tpl');
    }else{
        Tpl_Smarty::display( 'Web_Mobile_Static::baike/enquiry1.tpl');
    }

}else{
    Tpl_Smarty::display( 'Web_Mobile_Static::baike/enquiry.tpl');
}
