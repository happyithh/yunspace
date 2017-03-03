<?php
/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-12-21
 * Time: 下午19:03
 * 一键租场地
 */
$request=Func_Input::filter(array(
    'action'=>'string',
    'people'=>'string',
    'activity'=>'string',
    'demand_id'=>'int',
    'phone'=>'string',
    'level'=>'int',
    'space_id'=>'string',
));
if($request['space_id']&&empty($request['action'])){
    $request['action'] = 'form';
}
switch($request['action']){
    case "form":
       $seo =  array(
            '网页标题' => '【云SPACE－商业空间短租平台】一键租场地_活动场地预订',
            '网页简介'=>"云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定",
            '网页关键词'=>"云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地",
        );
        //获取意向场地
       if(!empty($request['space_id'])){
           $space_id=Func_NumEncode::d($request['space_id']);
//           $space=Api_Spacepedia_List_And_Info::getSpacepediaInfoById($space_id);
           $space=Data_Mysql_Table_Spacepedia_Search::select('id,space_name,city,attr,logo,addr',array("id"=>$space_id),'');
           if(!empty($space[0]['attr'])){
               $space[0]['attr']=json_decode($space[0]['attr'],1);
           }
           if(!empty($space[0]['attr']['特色标签'])){
               $space[0]['tags']=explode(",",$space[0]['attr']['特色标签']);
           }
           Tpl_Smarty::assign('space',empty($space[0])?array():$space[0]);
       }
        Tpl_Smarty::assign('seo',$seo);
        Tpl_Smarty::assign('people',$request['people']);
        Tpl_Smarty::assign('activity',$request['activity']);
        Web_Global::display('Web_Static::rent_space/rent_space_form.tpl');
        break;
    case "success":
        Tpl_Smarty::assign('phone',Func_String::decrypt($request['phone'],"哈哈，猜不到吧"));
        Tpl_Smarty::assign('demand_id',$request['demand_id']);
        Tpl_Smarty::assign('demand_level',empty($request['level'])?1:$request['level']);
        Tpl_Smarty::assign('is_work_time', Web_Global::isWorkTime());
        Web_Global::display('Web_Static::rent_space/success.tpl');
        break;
    case '':
        Web_Global::openCache(48);
        Web_Rent_Space::display( 'Web_Static::rent_space/rent_space.tpl');
        break;
    default:
        Func_Header::notFound();
        break;
}
