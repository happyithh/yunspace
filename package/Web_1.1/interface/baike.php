<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-22
 * Time: 上午9:41
 * 场地百科内页
 */
Data_Config_Site::cityShow();
$spacepedia = Web_Spacepedia_Info::getInstance();
//处理百科子空间
if(count($spacepedia->spaceItem)==1 && $spacepedia->spaceItem[0]['item_name']== $spacepedia->info['space_name']){
    Tpl_Smarty::assign('itemList',array());
}else{
    Tpl_Smarty::assign('itemList',$spacepedia->spaceItem);
}
$request=Func_Input::filter(array(
    'start_num'=>'int',
    'limit'=>'int',
));
$spaceMedia=$spacepedia->getMediaByNum(0,9);

//js获取图片
if(!empty($request['start_num']) && !empty($request['limit'])){
    $spaceMedia=$spacepedia->getMediaByNum($request['start_num'],$request['limit']);
    if(!empty($spaceMedia)){
        Func_Output::json('success',$spaceMedia,'返回图片数据');
    }else{
        Func_Output::json('error',$spaceMedia,'无图片数据返回');
    }

}
Tpl_Smarty::assign('spaceMedia',$spaceMedia);
Web_Spacepedia_Info::display( 'Web_Static::spacepedia/spacepedia_info.tpl');