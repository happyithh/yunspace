<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/6/24
 * Time: 10:08
 */
if (!empty($_REQUEST['token']) && !empty($_REQUEST['user_id'])) {
    Api_Session::user_info();
}
if (Core::$urls['action']) {
    Web_Account::handleIsLogin('');
    Tpl_Smarty::assign('__user', $_SESSION['user']);
}
switch (Core::$urls['action']) {
    case "chat_contacts":
        Web_Mobile_Chat::handleChatContacts();
//        Tpl_Smarty::display('Web_Mobile_Static::chat.v1.0/chat_list.tpl');
        break;
    case "chat_contacts_detail":
        Tpl_Smarty::display('Web_Mobile_Static::chat.v1.0/chat_contacts_detail.tpl');
        break;
    case "chat_body":
        Web_Mobile_Chat::handleChatBody();
        break;
    case "chat_recent":
        Web_Mobile_Chat::handleChatRecent();
        break;
    case "chat_demand":
        Web_Mobile_Chat::handleChatDemand();
        break;
    case "chat_demand_info":
        Tpl_Smarty::assign('title', '需求详情');
        Web_Mobile_Chat::handleChatDemandInfo();
        break;
    case "chat_demand_edit":
        Tpl_Smarty::assign('title', '编辑需求');
        Web_Mobile_Chat::handleChatDemandFromEdit();
        break;
    case "chat_demand_recommend":
        Tpl_Smarty::assign('title', '需求推荐记录');
        Web_Mobile_Chat::handleChatDemandRecommend();
        break;
    case "chat_demand_remark_edit":
        Tpl_Smarty::assign('title', '添加备注');
        Web_Mobile_Chat::handleChatDemandRecommendRemarkEdit();
        break;
    case "chat_demand_remark":
        Tpl_Smarty::assign('title', '查看备注');
        Web_Mobile_Chat::handleChatDemandRecommendRemark();
        break;
    case "chat_collect":
        Web_Mobile_Collection::handle();
        break;
    case 'chat_demand_group':
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
        ));
        if (empty($request['demand_id'])) {
            Func_Output::json('error', '', '缺少参数');
        }
        $to_account_id = Api_Demand_isGroup::isGroup(array('demand_id' => $request['demand_id']));

        if (!empty($to_account_id)) {
            $url = Core::$urls['root'] . 'm/chat/chat_body?to_account_id=' . $to_account_id;
            Func_Output::json('success', $url, '成功');
        } else {
            Func_Output::json('error', '', '操作失败');
        }
        break;
    default:
        Tpl_Smarty::display('Web_Mobile_Static::chat.v1.0/index.tpl');
        break;
}
