<?php
session_start();
$action = Core::$urls['action'];

//APP请求
if (!empty($_REQUEST['token']) && !empty($_REQUEST['user_id'])) {
    Api_Session::user_info();
}

//如果是商家;
if (!is_bool(strpos($action, 'splist'))) {
    if (empty($_SESSION['user']) && empty($_SESSION['user']['isWechatManage'])) {
        $_SESSION['url_back'] = 'http://' . Core::$urls['host'] . Core::$urls['uri'];
        Wechat_Oauth_Manager::handle();
    }
}else {
    Web_Account::handleIsLogin('');
}
Tpl_Smarty::assign('__user', Api_Session::user_info());

switch (Core::$urls['action']) {
    case  "splist":
       //场地类型
        $categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
            Tpl_Smarty::assign('categoryTree', $categoryTree);
        //城市
        $account_id =$_SESSION['user']['id'];
        $AllCity = Api_City_Auto_Complete::handle();
        Tpl_Smarty::assign('city', $AllCity['data']);
        Tpl_Smarty::assign('account_id',$account_id);
        Tpl_Smarty::display('Web_Mobile_Static::new_space.v1.0/new_space.tpl');
        break;
    case  "vdjoin":
        Tpl_Smarty::display('Web_Mobile_Static::vendor_join.v2.0/vendor_join.tpl');
        break;
}