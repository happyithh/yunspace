<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/10/19
 * Time: 15:40
 */
class OA_Demand_Offer
{

    static function   handle()
    {
        $action = empty($_REQUEST['action']) ? 'search_tpl' : $_REQUEST['action'];
        switch ($action) {
            case 'search_tpl':
                self::handleSearch();
                break;
            case 'search_result':
                self::handleSearchResult();
                break;
            case 'list_show':
                self::handleListShow();
                break;
            //可能要改到修改子空间修改状态的接口上
            case 'change_item_status';
                self::changeItemStatus();
                break;
            case 'userrevisit';
                self::userRevisit();
                break;
            case 'remove';
                self::removeOffer();
                break;
        }
    }


    static function handleSearch()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'type' => 'int',  //默认是0  正常流程  1是代表销售进入。或者其他渠道进入报价系统。
        ));
//        $request['demand_id'] = 780;
        $request['type'] = isset($request['type']) ? $request['type'] : 0;
        if (empty($request['demand_id']) && $request['type'] == 0) {
            Func_Header::back('需求id不能为空');
        }
        //显示需求详情，并把人数和价格区间和城市加入默认 (模板还没写呢)
        $demand_info = Api_Demand_GetInfo::getInfo($request);
//        Q($demand_info['data']['demand']);
        $demand_people = explode('-', $demand_info['data']['demand']['活动人数']);
        $demand_people[1] = isset($demand_people[1]) ? $demand_people[1] : 0;
        $demand_info['data']['start_people'] = intval($demand_people[0]);
        $demand_info['data']['end_people'] = empty($demand_people[1]) ? 0 : intval($demand_people[1]);
        Tpl_Smarty::assign('_demand', $demand_info['data']);
//        Tpl_Smarty::assign('demand_id',$request['demand_id']);
        $_REQUEST['search_type'] = 1;
        $tag_Result = Api_Demand_Offer_Get_Demand_Tag_List::getTagList();
        $tag_list = array();
        foreach ($tag_Result['data'] as $k => $v) {
            $tag_list[] = $v['tag_value'];
        }
        Tpl_Smarty::assign('_tag_list', $tag_list);
        //已有标签
        Tpl_Smarty::display("OA_Static::demand_offer/demand_offer_search.tpl");
    }

    static function handleSearchResult()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'search' => 'array',
            'type' => 'string',   //精准匹配，泛匹配，泛匹配（未激活），不匹配的未激活
        ));
        //处理标签
        if (isset($request['search']['tags'])) {
            $tag_temp = array();
            foreach ($request['search']['tags'] as $k => $v) {
                if (empty($v['value'])) {
                    Func_Header::back('标签需要选择选项');
                }
                $tag_temp[$v['id']] = $v['value'];
            }
            $request['search']['tags'] = $tag_temp;
        } else {
            Func_Header::back('标签需要选择选项');
        }
        /**
         * //写入主表
         */
        $offer_info = Api_Demand_Offer_Insert::insertData($request);
        if ($offer_info['status'] == 1) {
            $offer_id = $offer_info['data'];
            Tpl_Smarty::assign('_offer_id', $offer_id);
            $offer_info_new = Data_Mysql_Table_Demand_Offer::select('*', array('id=?' => $offer_id), '', 1);
            $offer_info_new[0]['demand_filter'] = json_decode($offer_info_new[0]['demand_filter'], 1);
            Tpl_Smarty::assign('_offer_info', $offer_info_new[0]);
        } else {
            Func_Header::back($offer_info['msg']);
        }
        $request['offer_id'] = $offer_id;
        //搜索匹配 返回数据
        Api_Demand_Offer_GET_Match_Result_List::getList($request);
        $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $_SESSION['administrator']['id']));
        if (!empty($administratorAccount['account_id'])) {
            $account_id = $administratorAccount['account_id'];
        }
        Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '保存匹配信息', $_SESSION['administrator']['username'] . '保存报价匹配信息,保存数据，匹配条件：' . json_encode($request['search']) . '需求id' . $request['demand_id'], $request['demand_id']);
//        Tpl_Smarty::assign('_result_list',$list);
//        //保存当前搜索条件在session 供未激活的商品的点击匹配
//        //显示需求部分信息（联系人电话，具体需求等）
//        if(empty($request['demand_id'])){
//            Func_Header::to('需求id不能为空');
//        }
//        //显示需求详情，并把人数和价格区间和城市加入默认 (模板还没写呢)
//        $demand_info = Api_Demand_GetInfo::getInfo($request);
//        $demand_people = explode('-', $demand_info['data']['demand']['活动人数']);
//        $demand_people[1] =isset($demand_people[1]) ? $demand_people[1] : 0;
//        $demand_info['data']['start_people'] = intval($demand_people[0]);
//        $demand_info['data']['end_people'] = empty($demand_people[1]) ? 0 : intval($demand_people[1]);
//        Tpl_Smarty::assign('_demand',$demand_info['data']);
//        //显示匹配条件
//        $_REQUEST['search_type']=1;
//        $tag_Result = Api_Demand_Offer_Get_Demand_Tag_List::getTagList();
//        $tag_list = array();
//        foreach($tag_Result['data'] as $k=>$v){
//            $tag_list[]  = $v['tag_value'];
//            if(isset($request['search']['tags'])) {
//                foreach ($request['search']['tags'] as $kk => $vv) {
//                    if ($v['id'] == $kk) {
//                        $request['search']['new_tags'][$kk]['id'] = $v['id'];
//                        $request['search']['new_tags'][$kk]['tag_name'] = $v['tag_value'];
//                        $request['search']['new_tags'][$kk]['tag_check_value'] = $vv;
//                    }
//                }
//            }
//        }
//        Tpl_Smarty::assign('contactRecord',
//            OA_Demand_Detail::getRecord(array('phone' => $demand_info['data']['phone'])));
//        Tpl_Smarty::assign('_search',$request['search']);
//        Tpl_Smarty::assign('_tag_list',$tag_list);
//        //搜索结果总数
//        $count_num =Api_Demand_Offer_GET_Match_Result_List::getAllNum($request);
//        if($count_num){
//            Tpl_Smarty::assign('_total',$count_num);
//        }
        //显示搜索结果
        Func_Header::to('', Core::$urls['path'] . "?act=demand_offer&action=list_show&demand_id=" . $request['demand_id'] . "&offer_id=" . $offer_id . "&type=1");
//        Tpl_Smarty::display("OA_Static::demand_offer/demand_offer_search_result.tpl");
    }


    static function handleListShow()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'offer_id' => 'int',
            'type' => 'int',   //1精准匹配，2泛匹配，3泛匹配（未激活），4不匹配的未激活
        ));

        $offer_info = Data_Mysql_Table_Demand_Offer::select('*', array('id=?' => $request['offer_id']), '', 1);
//        if(!empty($offer_info[0]['admin_id'])){
//            $admin_name = Data_Mysql_Table_Administrator::select('username',array('id =?'=>$offer_info[0]['admin_id']),'',1);
//            Tpl_Smarty::assign('adminname',$admin_name);
//            Tpl_Smarty::assign('offer_info',$offer_info);
//          }

        $offer_info[0]['demand_filter'] = json_decode($offer_info[0]['demand_filter'], 1);
        Tpl_Smarty::assign('_offer_id', $offer_info[0]['id']);
        Tpl_Smarty::assign('_offer_info', $offer_info[0]);
//        //搜索匹配 返回数据
//        //保存当前搜索条件在session 供未激活的商品的点击匹配
//        //显示需求部分信息（联系人电话，具体需求等）
        if (empty($request['demand_id'])) {
            Func_Header::to('需求id不能为空');
        }
        //显示需求详情，并把人数和价格区间和城市加入默认 (模板还没写呢)
        $demand_info = Api_Demand_GetInfo::getInfo($request);
        $demand_people = explode('-', $demand_info['data']['demand']['活动人数']);
        $demand_people[1] = isset($demand_people[1]) ? $demand_people[1] : 0;
        $demand_info['data']['mark_tags'] = Data_Mysql_Table_Demand::handleConvertMarkTags(array('mark_tags' => $demand_info['data']['mark_tags']));
        $demand_info['data']['start_people'] = intval($demand_people[0]);
        $demand_info['data']['end_people'] = empty($demand_people[1]) ? 0 : intval($demand_people[1]);

        Tpl_Smarty::assign('_demand', $demand_info['data']);
        //显示联系记录
        $record = Api_Grab_Order_GetContactRecord::handleRecord(array('demand_id' => $request['demand_id']));
//
//        Tpl_Smarty::assign('contactRecord',
//            OA_Demand_Detail::getRecord(array('phone' => $demand_info['data']['phone'])));
        Tpl_Smarty::assign('contactRecord', $record['data']);
//        //显示匹配条件
        $_REQUEST['search_type'] = 1;
        $tag_Result = Api_Demand_Offer_Get_Demand_Tag_List::getTagList();
        $tag_list = array();
        foreach ($tag_Result['data'] as $k => $v) {
            $tag_list[] = $v['tag_value'];
            if (isset($offer_info[0]['demand_filter']['tags']) && is_array($offer_info[0]['demand_filter']['tags'])) {
                foreach ($offer_info[0]['demand_filter']['tags'] as $kk => $vv) {
                    if ($v['id'] == $kk) {
                        $offer_info[0]['demand_filter']['new_tags'][$kk]['id'] = $v['id'];
                        $offer_info[0]['demand_filter']['new_tags'][$kk]['tag_name'] = $v['tag_value'];
                        $offer_info[0]['demand_filter']['new_tags'][$kk]['tag_check_value'] = $vv;
                    }
                }
            }
        }
        Tpl_Smarty::assign('_search', $offer_info[0]['demand_filter']);
        Tpl_Smarty::assign('_tag_list', $tag_list);

//        //显示搜索结果
        $list = Api_Demand_Offer_GET_Match_Result_List::getListAll($request);
        //搜索数据
        $count_num = Api_Demand_Offer_GET_Match_Result_List::getAllNum($request);
        if ($count_num) {
            Tpl_Smarty::assign('_total', $count_num);
        }
//        switch($request['type']){
//            case 1:
//                $total['type_1'] = $list['page']['dt'];
//                break;
//            case 2:
//                $total['type_2'] = $list['page']['dt'];
//                break;
//            case 3:
//                $total['type_3'] = count($list);
//                break;
//            case 4:
//                $total['type_4'] = count($list);
//                break;
//        }
        //已发送短信数量
        $send_num = Api_Demand_Offer_GET_Match_Result_List::haveSendMessageNum($request);
        Tpl_Smarty::assign('_have_send_num', $send_num);
        //已报价的商家列表
        Tpl_Smarty::assign('_categories', Data_Mysql_Table_Product_Category::getTreeCache());
        $offer_list = Api_Demand_Offer_GET_Match_Result_List::getOfferList($request);
        Tpl_Smarty::assign('_offer_list', $offer_list);
//        Tpl_Smarty::assign('_total',$total);
        /* 商户回访记录*/
        $condition['demand_id'] = $request['demand_id'];
        $rs = Data_Mysql_Table_Demand_Offer_Merchant_Interview::select('*', $condition, 'order by create_time DESC', 999);
        Tpl_Smarty::assign('_rs', $rs);
        $as = Data_Mysql_Table_Demand_Offer_Merchant_Interview::select('step', array('demand_id =?' => $request['demand_id'], 'step !=0'), 'order by create_time DESC', 999);
        Tpl_Smarty::assign('_as', $as);
        Tpl_Smarty::assign('_data', $list);
        $quantity = Data_Mysql_Table_Demand_Offer_Quantity::select('*', array('demand_id =?' => $request['demand_id']));
        Tpl_Smarty::assign('quantity', $quantity);
        Tpl_Smarty::display("OA_Static::demand_offer/demand_offer_search_result.tpl");
    }

    //商户回访数据调用
    static function userRevisit()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'space_id' => 'int',
            'demand_id' => 'int',
        ));

        $condition['space_id'] = $request['space_id'];
        $condition['demand_id'] = $request['demand_id'];
        $rs = Data_Mysql_Table_Demand_Offer_Merchant_Interview::select('*', $condition, 'order by create_time DESC', 999);

        if (!empty($rs)) {
            foreach ($rs as $k => $v) {
                $rs[$k]['create_time'] = date('Y-m-d H:i:s', $v['create_time']);
            }
            Func_Output::json('1', $rs, '成功');
        } else {
            Func_Output::json('0', $rs, '失败');
        }

    }

    static function changeItemStatus()
    {
        $request = Func_Input::filter(array(
            'item_id' => 'int',
            'demand_id' => 'int',
            'offer_id' => 'int',
            'space_id' => 'int',
            'submit_type' => 'int',
            'phone' => 'phone',
            'email' => 'email',
            'contacts' => 'string',
            'min_price' => '100',
            'max_price' => '100',
            'min_people' => 'int',
            'max_people' => 'int',
            'size' => 'int',
            'expand_refuse_reason' => 'string',
            'space_id' => 'int',
            'repeat_ids' => 'array',
            'repeat_items' => 'array',
            'space_name' => 'string',
            'old_space_name' => 'string',
        ));
        Api_Spacepedia_Handle_Repeat::handleRepeatSpacepedia($request);
        if (empty($request['item_id']) || empty($request['space_id']) || empty($request['submit_type'])) {
            Func_Header::back("参数错误！");
        }
        if ($request['submit_type'] != -3) {
            if (empty($request['phone'])) {
                Func_Header::back("手机号不能为空或手机号格式不正确！");
            }
            //邮箱暂时未不必填项
//            if(empty($request['email'])){
//                Func_Header::back("邮箱不能为空！");
//            }
            if (empty($request['contacts'])) {
                $request['contacts'] = $request['phone'];
            }
            if ($request['submit_type'] == 1) {
                //加入匹配结果
                $data = array(
                    'demand_id' => $request['demand_id'],
                    'offer_id' => $request['offer_id'],
                    'item_id' => $request['item_id'],
                    'match_level' => 5,
                    'notice_time' => -1,
                );
                Api_Demand_Offer_Match_Result_Insert::insertResult($data);

                //发短信
                $data_sms = array(
                    'demand_id' => $request['demand_id'],
                    'offer_id' => $request['offer_id'],
                );
//                Api_Demand_Offer_Send_SMS_Vendor::Cron();
            }
        }
        $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $_SESSION['administrator']['id']));
        if (!empty($administratorAccount['account_id'])) {
            $account_id = $administratorAccount['account_id'];
        }
        //
        Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], $_SESSION['administrator']['username'] . '拓展数据,id' . $request['item_id'], '拓展场地数据', $request['demand_id']);
        $request['status'] = 1;
        $rs = Api_Space_Item_Change_Contacts_Info::changeContactsInfo($request);
        if ($rs['status'] == 1) {
            Api_Demand_Offer_Send_SMS_Vendor::Cron();
            Func_Header::to("  修改成功！");
        } else {
            Func_Header::back($rs['msg']);
        }
    }

    //移除报价列表。删除offerid 和匹配结果表
    static function removeOffer()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'offer_id' => 'int',
        ));
        if (empty($request['demand_id']) || empty($request['offer_id'])) {
            Func_Header::back('参数错误！');
        }
        $rs = Data_Mysql_Table_Demand_Offer::delete(array('id=?' => $request['offer_id']));
        Data_Mysql_Table_Demand_Match_Result::delete(array('demand_id=?' => $request['demand_id'], 'offer_id=?' => $request['offer_id']));
        $administratorAccount = Api_Administrator_GetBaseAccountInfo::getBastAccountInfo(array('admin_id' => $_SESSION['administrator']['id']));
        if (!empty($administratorAccount['account_id'])) {
            $account_id = $administratorAccount['account_id'];
        }
        Data_Mysql_Table_Account_Log::insertAccountLog($account_id, $_SESSION['administrator']['id'], '移除报价', $_SESSION['administrator']['username'] . '移除报价,需求id' . $request['demand_id'], $request['demand_id']);
        if ($rs) {
            Func_Header::to('移除成功！', Core::$urls['path']);
        } else {
            Func_Header::back('移除失败');
        }
    }
}