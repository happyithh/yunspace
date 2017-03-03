<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/7/20
 * Time: 14:01
 */
class Web_Mobile_Chat
{

    static function  handleChatBody()
    {
        $request = Func_Input::filter(array(
            'to_account_id' => 'int',
            'rel_id' =>'int'
        ), $_REQUEST);
        if (empty($request['to_account_id'])) {
            Func_Header::notFound();
        }
        $data = Api_Livechat_Message_Read::handle(array('to_account_id' => $request['to_account_id']));
        if (isset($data['data'])) {
            $data['data'] = array_reverse($data['data']);
            Tpl_Smarty::assign('data', $data['data']);
        }
        if (Data_Mysql_Table_LiveChat_Group::isGroupId($request['to_account_id'])) {
            $to_account = Data_Mysql_Table_LiveChat_Group::select('name as to_account_name,members_total,demand_id', array('id=?' => Data_Mysql_Table_LiveChat_Group::convertFromAccountId($request['to_account_id'])));
        } else {
            $to_account = Data_Mysql_Table_Account::select('fullname as to_account_name', array('id=?' => $request['to_account_id']));
        }
        if ($request['to_account_id'] == '-1') {
            $to_account['to_account_name'] = '系统消息';
        } else {
            $to_account = empty($to_account[0]) ? '' : $to_account[0];
        }
        Tpl_Smarty::assign("to_account", $to_account);
        Tpl_Smarty::assign("rel_id", $request['rel_id']);
        Tpl_Smarty::display('Web_Mobile_Static::chat.v1.0/chat_body.php.tpl');
    }

    static function  handleChatContacts()
    {
        $request = Func_Input::filter(array(
            'type' => 'string',
        ), $_REQUEST);
        $type = empty($request['type']) ? "contacts" : $request['type'];
        switch ($type) {
            case 'contacts':
                $result = Api_Livechat_Contacts_List::handle();
                if (!empty($result['data'])) {
                    Tpl_Smarty::assign("contacts_list", $result['data']);
                }
                break;
            case 'group':
                $result = Api_Livechat_Group_List::handle();
                if (!empty($result['data'])) {
                    Tpl_Smarty::assign("group_list", $result['data']);
                }
                break;
            default:
                Func_Header::notFound();
                break;
        }
        Tpl_Smarty::assign("type", $type);
        Tpl_Smarty::display('Web_Mobile_Static::chat.v1.0/chat_contacts.php.tpl');
    }

    static function handleChatRecent()
    {
        Tpl_Smarty::assign('data', Api_Livechat_Message_Recent::handle());
        Tpl_Smarty::assign('today', strtotime('today'));
        Tpl_Smarty::display('Web_Mobile_Static::chat.v1.0/chat_recent.tpl');
    }

    static function  handleChatDemand()
    {
        if (empty($_REQUEST['type'])) {
            $_REQUEST['type'] = 1;
        }

        if (!empty($_REQUEST['load_more'])) {
            self::handleChatDemandLoadMore();
            die;
        }
        $status = Api_Demand_List::getList(array('type' => $_REQUEST['type'], 'account_id' => Api_Session::user_id()));
        $total = Data_Mysql_Table_Demand::query('SELECT FOUND_ROWS() as c', '', 1);

        Tpl_Smarty::assign('total', empty($total[0]['c']) ? 0 : $total[0]['c']);
        Tpl_Smarty::assign('data', empty($status['data']) ? '' : $status['data']);

        Tpl_Smarty::display('Web_Mobile_Static::chat.v1.0/chat_demand.php.tpl');
    }

    //需求列表加载更多
    static function handleChatDemandLoadMore()
    {
        $request = Func_Input::filter(array(
            'type' => 'int',
            'last_id' => 'int',
        ), $_REQUEST);
        $status = Api_Demand_List::getList(array('type' => $request['type'],
            'account_id' => Api_Session::user_id(),
            'last_id' => $request['last_id']));
        Tpl_Smarty::assign('data', empty($status['data']) ? '' : $status['data']);
        echo Tpl_Smarty::fetch('Web_Mobile_Static::chat.v1.0/inc/inc.chat_demand.php.tpl');
        die;
    }

    static function  handleChatDemandInfo()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int'
        ), $_REQUEST);
        if (empty($request['demand_id'])) {
            Func_Header::back('缺少参数！');
        }
        $status = Api_Demand_GetInfo::handle(array('demand_id' => $request['demand_id']));
        if (empty($status['data'])) {
            Func_Header::back('抱歉没有找到相关需求，如有问题请致电400-056-0599');
        }
        Tpl_Smarty::assign('data', $status['data']);
        Tpl_Smarty::display('Web_Mobile_Static::chat.v1.0/chat_demand_info.php.tpl');
    }

    static function  handleChatDemandFromEdit()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',

        ), $_REQUEST);
        if (empty($request['demand_id'])) {
            Func_Header::back('缺少参数！');
        }
        $status = Api_Demand_GetInfo::handle(array('demand_id' => $request['demand_id']));
        if ($status['status'] == 1) {
            Tpl_Smarty::assign('data', $status['data']);
        }
        $option = Data_Demand_Option_Config::all();
        Tpl_Smarty::assign('option', $option);

        Tpl_Smarty::display('Web_Mobile_Static::chat.v1.0/chat_demand_info_from_edit.php.tpl');
    }

    static function  handleChatDemandRecommend()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'load_more' => 'int',
        ), $_REQUEST);
        if (!empty($request['load_more'])) {
            self::handleChatDemandRecommendLoadMore();
            die;
        }
        if (empty($request['demand_id'])) {
            Func_Header::back('缺少参数！');
        }
        $data = Api_Recommend_GetList::getDemandRecommend(
            array(
                'demand_id' => $request['demand_id']
            ));
        Tpl_Smarty::assign('customer_feedback', Data_Mysql_Table_Demand_Recommend::$customer_feedback);
        Tpl_Smarty::assign('data', Api_Demand_List::monthGroup($data));
        $total = Data_Mysql_Table_Demand_Recommend::query('SELECT FOUND_ROWS() as c', '', 1);
        Tpl_Smarty::assign('total', empty($total[0]['c']) ? 0 : $total[0]['c']);
        Tpl_Smarty::display('Web_Mobile_Static::chat.v1.0/chat_demand_info_recommend.php.tpl');
    }

    //需求推荐记录加载更多
    static function  handleChatDemandRecommendLoadMore()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'last_id' => 'int',
        ), $_REQUEST);
        $dd = array(
            'demand_id' => $request['demand_id'],
            'last_id' => $request['last_id'],
            'num' => 10,
        );
        $data = Api_Recommend_GetList::getDemandRecommend($dd);
        Tpl_Smarty::assign('data', Api_Demand_List::monthGroup($data));
        Tpl_Smarty::assign('customer_feedback', Data_Mysql_Table_Demand_Recommend::$customer_feedback);
        echo Tpl_Smarty::fetch('Web_Mobile_Static::chat.v1.0/inc/inc.chat_demand_recommend.php.tpl');
        die;
    }

    static function  handleChatDemandRecommendRemarkEdit()
    {

        Tpl_Smarty::display("Web_Mobile_Static::chat.v1.0/chat_demand_recommend_remark.php.tpl");
    }

    static function  handleChatDemandRecommendRemark()
    {
        $request = Func_Input::filter(array(
            'recommend_id' => 'int',
            'demand_id' => 'int',
        ));
        if (empty($request['recommend_id']) || empty($request['demand_id'])) {
            Func_Header::back('当前服务器开小差，请客户稍后重试');
        }
        $status = Data_Mysql_Table_Demand_Recommend::select('id,clientele_remark', array('demand_id=? AND id=?' => array($request['demand_id'], $request['recommend_id'])));
        if ($status[0] > 0) {
            $status[0]['clientele_remark'] = json_decode($status[0]['clientele_remark'], true);
            Tpl_Smarty::assign('data', $status[0]);
        }
        Tpl_Smarty::display("Web_Mobile_Static::chat.v1.0/chat_demand_recommend_remark.php.tpl");

    }
}