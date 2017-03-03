<?php

$list = Web_HelpCenter::getInstance();
$action = explode(".", Core::$urls['action']);
$key = explode("/", $action[0]);
if (!empty(Core::$urls['action']) && $key[0] == 'info') {
    if(!empty($list->helpDetail[0])){
        Data_Config_Site::seo('help',$list->helpDetail[0]);
    }
    Web_HelpCenter::display('help-center-info.tpl');
} else if (!empty(Core::$urls['action']) && $key[0] == 'category') {
    if(!empty($list->helpCategory[0]['category'])){
        Data_Config_Site::seo('help',array('title'=>$list->helpCategory[0]['category']));
    }
    Web_HelpCenter::display('help-center-category.tpl');
} else if (!empty(Core::$urls['action']) && $key[0] == 'guide') {
    Data_Config_Site::seo('help',array('title'=>'新手指南'));
    if (!empty($key[1])) {
        $url = "help-center-guide-" . $key[1] . ".tpl";
        Web_HelpCenter::display($url);
    } else {
        Web_HelpCenter::display('help-center-guide-a.tpl');
    }
} else if (!empty(Core::$urls['action']) && $key[0] == 'hot') {
    Data_Config_Site::seo('help',array('title'=>'热门问题'));
    Web_HelpCenter::display('help-center-hot.tpl');
} else if (!empty($_REQUEST['is_search'])) {
    Data_Config_Site::seo('help',array('title'=>'帮助中心'));
    if (empty($_REQUEST['keyword'])) {
        Func_Header::to("搜索条件不能为空！");
    }
    Web_HelpCenter::display('help-center-search1.tpl');
} else {
    Data_Config_Site::seo('help',array('title'=>'最新问题'));
    Web_HelpCenter::display('help-center.tpl');
}


