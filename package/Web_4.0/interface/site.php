<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-22
 * Time: 上午9:41
 * 场地百科内页
 */
//表存在的时候就删除此行
//Data_Mysql_Table_Baike_Statistical::select();

//获取百科的名称和操作
$baike = Web_Baike_Info::getInstance();
//add by yl 2016/06/24
if($baike->spaceName=="云SPACE"){
    Header("HTTP/1.1 301 Moved Permanently");
    Header("Location: http://www.yunspace.com.cn/yunspace/news"); 
    exit;
}
if($baike->info['category_id']==500){
    $baike->cityBaike();
    die();
}

//更新百科的浏览量
$baike->updateCountViewPage;

Web_Global::openCache(2);


$tags = empty($baike->action[2])?'':$baike->action[2];

$baike_action=$baike->baikeAction;
if($baike->is_inner){
    if($baike->itemInfo){
        Web_Baike_Info::display( 'Web_Static::site/inc/item_info.tpl');
        die();
    }else{
        Func_Header::notFound();
    }
}
switch($baike_action){
    case "最新":
        //百科页--最新
        Web_Baike_New::handle($baike->info,'new',$tags);
        break;
    case "精华":
        //百科页--精华
        Web_Baike_New::handle($baike->info,"fine",$tags);
        break;
    case "百科":
        //处理百科子空间
//        if(count($baike->spaceItem)==1 && $baike->spaceItem[0]['item_name']== $baike->info['space_name']){
//            Tpl_Smarty::assign('itemList',array());
//        }else{
            $itemList=array();
            foreach($baike->spaceItem as $k=>$v){
                $v['price_unit']=str_replace("元/",'',$v['price_unit']);
                $itemList[]=$v;
            }
            Tpl_Smarty::assign('itemList',$itemList);
        //        }
        if($baike->info['category_id']==200){
            Web_Baike_New::handle($baike->info,'wenchuang',$tags);
        }
        Tpl_Smarty::assign('json_media',json_encode($baike->spaceMedia));
        Tpl_Smarty::assign('is_more',count($baike->spaceMedia)>12);
        break;
    case "讨论组":
        //获取百科评论列表
//        q($num_arr);
        $baikeId['id'] = $baike->id;
        $comments = Api_Comments_GetCommentsList::commentsList($baikeId);
        Tpl_Smarty::assign('comments',$comments);
        break;
    default:
        Func_Header::notFound();
}
//Web_Baike_Info::display( 'Web_Static::baike.v1.0/winchuang.tpl');
Web_Baike_Info::display( 'Web_Static::site/site.tpl');