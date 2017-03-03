<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/14
 * Time: 14:53
 */
//获取百科的名称和操作
$baike = Web_Baike_Info::getInstance();
//调取我喜欢和现场足迹数据总量
$args['space_id']=$baike->info['id'];
$rs_like_go=Api_Baike_Like_Go::initLikeAndGoNum($args);
$count_num['is_love']=$rs_like_go['is_love'];
$count_num['is_go']=$rs_like_go['is_go'];
$rs_count=Api_Baike_Like_Go::initBaikeCountNum($args);
if(!empty($rs_count['status'])){
    $count_num['sum']=$rs_count['data'];
    if($count_num['sum']<100){
        $count_num['sum']=$count_num['sum']+100;
    }
}
Tpl_Smarty::assign('count_num',$count_num);


//调取现场足迹列表
$args=array(
    'space_id'=>$baike->info['id'],
    'limit'=>8,
);
$go =Api_Baike_Like_Go::getLikeAndGoList($args);
if(!empty($go['status'])){
    Tpl_Smarty::assign('like_list',$go['data']);
}


$baike_action = $baike->baikeAction;
$num_arr = explode('-', Core::$urls['action']);
//更新百科的浏览量
switch ($baike_action) {
    case "最新":
        //百科页--最新
//        $_REQUEST['space_name'] =$baike->info['space_name'];
        $_REQUEST['space_id'] =$baike->info['id'];
        $_REQUEST['type']='';
        $data = Api_Raiders_Get_List::getArticleList($_REQUEST);
        Tpl_Smarty::assign('article_list',$data);
        Web_Baike_Info::display('Web_Mobile_Static::site/site.tpl');
        break;
    case "精华":
        //百科页--精华
//        $_REQUEST['space_name'] =$baike->info['space_name'];
        $_REQUEST['space_id'] =$baike->info['id'];
        $_REQUEST['type']='fine';
        $data = Api_Raiders_Get_List::getArticleList($_REQUEST);
        Tpl_Smarty::assign('article_list',$data);
        Web_Baike_Info::display('Web_Mobile_Static::site/site.tpl');
        break;
    case "百科":
        $bai_ke_info =$baike->info();
        //处理百科子空间
        if (count($baike->spaceItem) == 1 && $baike->spaceItem[0]['item_name'] == $baike->info['space_name']) {
            Tpl_Smarty::assign('itemList', array());
        } else {
            Tpl_Smarty::assign('itemList', $baike->spaceItem);
        }
        $getPic = explode('-',urldecode( Core::$urls['action']));
        if(end($getPic)=='图片'){
            if($bai_ke_info['category_id']==200){
                Web_Baike_Wc_Info::display('Web_Mobile_Static::site/baike_pic.tpl');
            }else{
                Web_Baike_Info::display('Web_Mobile_Static::site/baike_pic.tpl');
            }
        }elseif($baike->item_id>0){
            Web_Baike_Info::display('Web_Mobile_Static::site/item_info.tpl');
        }else{
            if($bai_ke_info['category_id']==200){
                Web_Baike_Wc_Info::display('Web_Mobile_Static::wchuang/baike_wch_1.tpl');
                die();
            }else{
                Web_Baike_Info::display('Web_Mobile_Static::site/baike_info.tpl');
            }
        }
        break;
    case "讨论组":
        @session_start();
        // 判断用户是否登陆
        if(!isset($_SESSION['openid'])||(isset($_REQUEST['n_login'])&&$_REQUEST['n_login']=1&&!isset($_SESSION['user']['id']))){
            Tpl_Smarty::assign('isLogin', 0);
        }else{
            Tpl_Smarty::assign('isLogin', 1);
        }
        // 百科写入我喜欢
        if (in_array('PC', $baike->action)) {
            //判断是否登录。没有登录就跳转到登录哪里
            if (!isset($_SESSION['openid'])||empty($_SESSION['openid'])) {
                Core::$urls['uri'] = Func_String::isUtf8(Core::$urls['uri'])?Core::$urls['uri']:Func_String::utf8(Core::$urls['uri']);
                $_SESSION['url_back'] = 'http://' . Core::$urls['host'] .Core::$urls['uri'];
                Wechat_Oauth::handle('');
            } else {
                $baikeInfo['space_id'] = $baike->id;
                $baikeInfo['space_name'] = $baike->spaceName;
                if ($baike->action[3] == 'Go') {
                    $baikeInfo['like_go'] = $baike->action[3];
                }
                Api_Spacepedia_Like::createLike($baikeInfo);
            }
        }
        // 手机验证码登陆
        if(isset($baike->action[2]) && $baike->action[2]=='login'){
           Web_User_Center_Login::quickLogin();
        }
        if (isset($baike->action[2]) && $baike->action[2] == 'reply') {
            // 评论回复页面
            Web_Baike_Info::display('Web_Mobile_Static::site/comments_back.tpl');
        } else {
            // 讨论组页面
            Web_Baike_Info::display('Web_Mobile_Static::site/comments.tpl');
        }
        break;
    default:
        Func_Header::notFound();
}
$baike->updateCountViewPage;
die();