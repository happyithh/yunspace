<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-12-29
 * Time: 下午6:59
 */
if(empty($_REQUEST['action'])){
    Func_Header::to('',"http://".Core::$urls['host']);
}
switch($_REQUEST['action']){
    case 'product_space':
        //脚本，如果product_info中场地名字存在于百科表中，则给product_info表做一个标识，have_space值为1
        if(empty($_REQUEST['id'])){
            $_REQUEST['id']=1;
        }
        $lastId=Api_Import_New::updateProductHaveSpace($_REQUEST['id']);
        Func_Header::to('','?action=product_space&id='.$lastId);
        break;
    default:
        Func_Header::to('',"http://".Core::$urls['host']);
}

//一键转换旧场地
//if(empty($_REQUEST['id'])){
//    $_REQUEST['id']=1;
//}
//$lastId = OA_Import_New::convertOldProduct($_REQUEST['id']);
//Func_Header::to('','?id='.$lastId);




//更新baike_category_id，单一更新
//if(empty($_REQUEST['id'])){
//    $_REQUEST['id']=1;
//}
//$lastId = OA_Import_New::updateRaidersCategoryId($_REQUEST['id']);
//Func_Header::to('','?id='.$lastId);




//更新baike_category_id，多量更新   2016/05/12
// if(empty($_REQUEST['id'])){
//     $_REQUEST['id']=0;
// }
// $lastId = OA_Import_New::updateAllRaidersCategoryId($_REQUEST['id']);
// Func_Header::to('','?id='.$lastId);