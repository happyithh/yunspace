<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-10-26
 * Time: 下午5:15
 */
$spacepedia = Web_Spacepedia_Info::getInstance();

//处理子空间
if(count($spacepedia->spaceItem)==1 && $spacepedia->spaceItem[0]['item_name']== $spacepedia->info['space_name']){
    Tpl_Smarty::assign('itemList',array());
}else{
    Tpl_Smarty::assign('itemList',$spacepedia->spaceItem);
}

$spaceMedia=$spacepedia->getMediaByNum(0,3);


$request=Func_Input::filter(array(
    'start_num'=>'int',
    'limit'=>'int',
));

//js获取图片
if(!empty($request['start_num']) && !empty($request['limit'])){
    $spaceMedia=$spacepedia->getMediaByNum($request['start_num'],$request['limit']);
    if(!empty($spaceMedia)){
        Func_Output::json('success',$spaceMedia,'返回图片数据');
    }else{
        Func_Output::json('error',$spaceMedia,'无图片数据返回');
    }

}

//js获取活动案例
$_REQUEST['case_limit']=3;

Tpl_Smarty::assign('spaceMedia',$spaceMedia);
Web_Spacepedia_Info::display( 'Web_Mobile_Static::baike/baike_info.tpl');