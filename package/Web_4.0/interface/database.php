<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/12/15
 * Time: 10:28
 */
/***
 * 需要
 */
$_action = !empty($_REQUEST['action'])?$_REQUEST['action']:'';
$search_type =  !empty($_REQUEST['search_type'])?$_REQUEST['search_type']:'';
if(!empty($_REQUEST['keyword'])&&strstr($_REQUEST['keyword'],'-')!=false){
    $_REQUEST['keyword'] = str_replace('-',' ',$_REQUEST['keyword']);
}
$keyword = !empty($_REQUEST['keyword'])?$_REQUEST['keyword']:'';
if($_action=='is_submit' && $search_type!=''){
    switch($search_type){
        case "site_library":
            _make_url('spaces');
            Web_Space_Search_New::handle();
            Web_Search_Item_List::getInstance();
            Web_Search_Item_List::display("Web_Static::search/search_list_2.2.tpl");
//            Func_Header::to("",Core::$urls['root']."spaces-tags/".Func_Url::str_urlencode($keyword));
            break;
        case "project_library":
            _make_url('article');
            Web_Raiders_Search::handle('article');
//            Func_Header::to("",Core::$urls['root']."article-keyword/".Func_Url::str_urlencode($keyword));
            break;
        case "company_library":
            _make_url('company');
            Web_Raiders_Search::handle('company');
//            Func_Header::to("",Core::$urls['root']."company-keyword/".Func_Url::str_urlencode($keyword));
            break;
        case "paper_library":
            _make_url('doc');
            Web_Raiders_Search::handle('doc');
//            Func_Header::to("",Core::$urls['root']."doc-keyword/".Func_Url::str_urlencode($keyword));
            break;
        default:
          Func_Header::notFound();
            break;
    }
}
function _make_url($type){
    switch($type){
        case "spaces":
            $key_arr = array();
            $value_arr = array();
            $request = Func_Input::filter(array(
                'keyword' => 'string',
                'category_id' => 'int',
                'filter' => 'array',
                'size_range' => 'int',
                'city_key'=> "string",
            ), $_REQUEST);
//            foreach($request as $k=>$v){
//                if(!empty($v)&&!is_array($v)){
//                    $request[$k]= Func_String::RemoveXSS($v);
//                }
//                if(!empty($v)&&is_array($v)){
//                    $v_tmp = array_map(function ($val) {
//                        $val= Func_String::RemoveXSS($val);
//                        return $val;
//                    }, $v);
//                    $request[$k]= $v_tmp;
//                }
//            }
            $url_n = "/spaces-";
            if(!empty($request['city_key'])){
                $url_n .=$request['city_key']."-";
            }
            if (!empty($request['filter'])) {
                if(empty($request['city_key'])){
                    unset($request['filter'][4]);
                }
                foreach ($request['filter'] as $k => $v) {
                    $key_arr[] = $k;
                    $value_arr[] = $v;
                }
            }
            if(!empty($request['category_id'])){
                $key_arr[]='category';
                $value_arr[] = Data_Mysql_Table_Spacepedia::getCategoryNameById($request['category_id']);
            }
            if(!empty($request['size_range'])){
                $key_arr[]='size';
                $value_arr[] = $request['size_range'];
            }
            if(!empty($key_arr)){
                $key_str = implode("-",$key_arr);
                $url_n.=$key_str."-";
            }
            $url_n.="tags/";
            if(!empty($value_arr)){
                $value_str = implode("-",$value_arr);
                $url_n.= $value_str."-";
            }
            if(!empty($request['keyword'])){
                $url_n .= Func_Url::str_urlencode($request['keyword']);
            }
            Core::$urls['uri']=$url_n;
            Core::$urls['path']=$url_n;
            break;
        case 'article':
            $request = Func_Input::filter(array(
                'keyword' => 'string',
            ), $_REQUEST);
//            foreach($request as $k=>$v){
//                if(!empty($v)){
//                    $request[$k]= Func_String::RemoveXSS($v);
//                }
//            }
            $url_n = "/article-keyword/";
            if(!empty($request['keyword'])){
                $url_n .= Func_Url::str_urlencode($request['keyword']);
            }
            Core::$urls['uri']=$url_n;
            Core::$urls['path']=$url_n;
            break;
        case 'company':
            $request = Func_Input::filter(array(
                'keyword' => 'string',
            ), $_REQUEST);
//            foreach($request as $k=>$v){
//                if(!empty($v)){
//                    $request[$k]= Func_String::RemoveXSS($v);
//                }
//            }
            $url_n = "/company-keyword/";
            if(!empty($request['keyword'])){
                $url_n .= Func_Url::str_urlencode($request['keyword']);
            }
            Core::$urls['uri']=$url_n;
            Core::$urls['path']=$url_n;
            break;
        case 'doc':
            $request = Func_Input::filter(array(
                'keyword' => 'string',
            ), $_REQUEST);
//            foreach($request as $k=>$v){
//                if(!empty($v)){
//                    $request[$k]= Func_String::RemoveXSS($v);
//                }
//            }
            $url_n = "/doc-keyword/";
            if(!empty($request['keyword'])){
                $url_n .= Func_Url::str_urlencode($request['keyword']);
            }
            Core::$urls['uri']=$url_n;
            Core::$urls['path']=$url_n;
            break;
        default:
            break;
    }
//    q($_REQUEST,Core::$urls['path'],Core::$urls['uri']);
}
$type_array = array(
    "site"=>array(
        'search_type'=>'site_library',
        'search_page_label'=>'场地库',
        'search_page_input_value'=>'搜索场地，你可以输入场地名或者地标进行查找',
        'class'=>array(
            'search_page_site_active',
            'search_page_project',
            'search_page_company',
            'search_page_paper'
        ),

    ),
    "article"=>array(
        'search_type'=>'project_library',
        'search_page_label'=>'资讯库',
        'search_page_input_value'=>'搜索资讯，关注行业内最新最热的活动资讯',
        'class'=>array(
            'search_page_site',
            'search_page_project_active',
            'search_page_company',
            'search_page_paper'
        ),
    ),
    "company"=>array(
        'search_type'=>'company_library',
        'search_page_label'=>'公司库',
        'search_page_input_value'=>'搜索行业内公司',
        'class'=>array(
            'search_page_site',
            'search_page_project',
            'search_page_company_active',
            'search_page_paper'
        ),
    ),
    "paper"=>array(
        'search_type'=>'paper_library',
        'search_page_label'=>'文库',
        'search_page_input_value'=>'找PPT,策划方案、演讲稿、合同范例',
        'class'=>array(
            'search_page_site',
            'search_page_project',
            'search_page_company',
            'search_page_paper_active'
        ),
    ),
);
$u_action = Core::$urls['action'];
$title='';
if(!empty($u_action) &&isset($type_array[$u_action])){
    Tpl_Smarty::assign('_type_array',$type_array[$u_action]);
    Tpl_Smarty::assign("nav",$u_action);
    switch($u_action)
    {
        case 'site':
            $title = "活动场地库-【云SPACE】";
            break;
        case 'company':
            $title = "最新公司资料-【云SPACE】";
            break;
        case 'paper':
            $title="活动文库-【云SPACE】";
            break;
        case 'article':
            $title="场地活动资讯-【云SPACE】";
            break;
        default:
            $title = "活动场地库-全国活动场地库,最新场地资料_文创项目-【云SPACE】";
    }
}
if(empty($title)){
    $title = "活动场地库-全国活动场地库,最新场地资料_文创项目-【云SPACE】";
}
$seo = array(
    '网页标题'=>$title,
    '网页关键词'=>"云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定",
    '网页简介'=>"云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地",
);
Tpl_Smarty::assign('seo',$seo);
Web_Global::display('Web_Static::search/search.tpl');
