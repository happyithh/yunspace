<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2015/5/13
 * Time: 13:53
 */
class OA_Weixin_Ticket_Manage
{
    static function handle()
    {
        $_REQUEST['action'] = empty($_REQUEST['action']) ? "list" : $_REQUEST['action'];
        switch ($_REQUEST['action']) {
            case 'add':
                self::handleAdd();
                break;
//            case 'contacts':
//                self::handleEditSubmit($isMy || $is_urgent);
//                break;
            case 'submit_edit':
                self::handleBindAccountSubmit();
                break;
            case 'edit':
                self::handleEdit();
                break;
            case 'eventStatus':
                self::handleStatus();
                break;
            case 'eventRealDel':
                self::handleRealDel();
                break;
//            case 'ajax_user_json':
//                self::handleGetAccountToJson();
//                break;
//            case 'ajax_admin_json':
//                self::handleGetAdminToJson();
//                break;
//            case 'ajax_change_receiver':
//                self::handleChangeReceiverToJson();
//                break;
//            case 'add_contact_record':
//                self::handleRecord();
//                break;
//            case 'get_contact_demand':
//                self::handleDemand();
//                break;
            case 'list':
                self::handleWeixinEventList();
                break;
            default:
                Func_Header::notFound();
                break;
        }
    }


    //活动列表
    static function handleWeixinEventList()
    {
        $conditions = array();
//        $request = Func_Input::filter(array(
//                'status'=>'int'
//        ),$_REQUEST);
//        Q($request);
        $status = isset($_REQUEST['status']) ? $_REQUEST['status'] : 1;
        Tpl_Smarty::assign('status', $status);
        $conditions['status'] = $status;
        $list = Data_Mysql_Table_Weixin_Event_Info::page(0, 10, "*", $conditions, 'ORDER BY update_time DESC');
        Tpl_Smarty::assign('newTime',time());
        Tpl_Smarty::assign('_data', $list);
//        Tpl_Smarty::display('OA', 'weixin/event_list.tpl');
        Tpl_Smarty::display("OA_Static::wechat/event_list.tpl");
    }

    static function handleAdd()
    {
        // Tpl_Smarty::assign('data', $_REQUEST);
        // Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
//        Tpl_Smarty::display('OA', 'weixin/event_add.tpl');
        Tpl_Smarty::display("OA_Static::wechat/event_add.tpl");
    }

    static function handleEdit()
    {
        $request = Func_Input::filter(array(
            "id"=>'int'
        ),$_REQUEST);
        if(empty($request['id'])){
            Func_Header::back("参数错误，缺少id");
        }
        //活动信息
        $rs = Data_Mysql_Table_Weixin_Event_Info::select("id,title,content,status,checkticketphone,start_time,end_time,activity_time,activity_end_time,addr,ticket_type,is_mail,event_logo,is_showtime",$request['id']);
        if(empty($rs[0]['id'])){
            Func_Header::back("此活动不存在");
        }
         Tpl_Smarty::assign('info', $rs[0]);

        //门票信息
        $ticketlist = Data_Mysql_Table_Weixin_Ticket_Info::select("*",array('envent_id'=>$rs[0]['id'],'status'=>1),'',100);
        Tpl_Smarty::assign('ticketlist', $ticketlist);
        // Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
       self::handleAdd();
    }

    static  function handleBindAccountSubmit(){
//        q($_REQUEST);
        $request = Func_Input::filter(array(
            "eid"=>"int",
            "title"=>"string",
            "content"=>"html",
            "ticket_type"=>'int',
            "is_mail"=>'int',
            "event_logo"=>'string',
            "checkticketphone"=>"string",
            "event_id"=>"array",
            "event_name"=>"array",
            "event_price"=>"array",
            "event_stock"=>"array",
            "event_time"=>"array",
            "addr"=>'string',
            "activity_time"=>'string',
            "activity_end_time"=>'string',
            "start_time" => "string",
            "end_time" => "string",
            'is_showtime'=>'int',
            'price_type' => 'int',
        ),$_REQUEST);
//        q($request);
        if(!empty($request['checkticketphone'])){
//            Data_Mysql_Table_Account::debug(1);
            $ids = array();
            $res = Data_Mysql_Table_Account::select("id",array("phone in (".trim($request['checkticketphone']).")"),"",100);
            if($res){
                $idsarr =array();
                foreach($res as $k=>$v){
                    $ids[] = $v['id'];
                }
            }
            $data['checkticketids'] =$ids;
            $data['checkticketphone'] =$request['checkticketphone'];
        }
        if(!empty($request['event_logo'])){
            Func_Image::thumCenterImage(Core::$paths['root'].$request['event_logo'], Core::$paths['root'].$request['event_logo'], 120, 150);
        }
        if(empty($request['title'])){
            Func_Header::back('活动名称不能为空！');
        }
        if(empty($request['start_time']) || empty($request['end_time'])){
            Func_Header::back('请设置售票的起止时间！');
        }
        if (!empty($request['start_time']) && !empty($request['end_time'])) {
            if (strtotime($request['start_time'] . "00:00:00") > strtotime($request['end_time'] . "23:59:59")) {
                Func_Header::back('请正确选择售票时间的范围！！');
            } else {
                $request['start_time'] = strtotime($request['start_time'] . "00:00:00");
                $request['end_time'] = strtotime($request['end_time'] . "23:59:59");
            }
        }
        //对活动开始时间进行处理
        if(!empty($request['activity_time']) && !empty($request['activity_end_time'])){
            if (strtotime($request['activity_time'] . "00:00:00") > strtotime($request['activity_end_time'] . "23:59:59")) {
                Func_Header::back('请正确选择活动起止时间的范围！！');
            } else {
            $request['activity_time'] = strtotime($request['activity_time'] . "00:00:00");
            $request['activity_end_time'] = strtotime($request['activity_end_time'] . "23:59:59");
//            if($request['activity_time']<$request['start_time'] || $request['activity_time']>$request['end_time']){
//                Func_Header::back('请设置有效的活动开始时间');
            }
        }else{
            Func_Header::back('请设置有效的活动起止时间');
//            $request['activity_time'] = 0;
        }
        if(!empty($request['eid'])){
            $msg = "修改";
            //修改活动
            $data['title'] = $request['title'];
            $data['content'] = $request['content'];
            $data['ticket_type'] =$request['ticket_type'];
            $data['is_mail'] =$request['is_mail'];
            $data['event_logo'] =$request['event_logo'];
            $data['update_time'] = time();
            $data['start_time'] = $request['start_time'];
            $data['end_time'] = $request['end_time'];
            $data['activity_time'] = $request['activity_time'];
            $data['activity_end_time'] = $request['activity_end_time'];
            $data['addr'] =$request['addr'];
            $data['is_showtime'] = $request['is_showtime'];
            Data_Mysql_Table_Weixin_Event_Info::update(array('id'=>$request['eid']),$data);
        }else{
            $msg = "添加";
            //增加活动
            $data['title'] = $request['title'];
            $data['content'] = $request['content'];
            $data['ticket_type'] =$request['ticket_type'];
            $data['is_mail'] =$request['is_mail'];
            $data['event_logo'] =$request['event_logo'];
            $data['create_time'] =  $data['update_time'] = time();
            $data['admin_id'] = $_SESSION['administrator']['id'];
            $data['start_time'] = $request['start_time'];
            $data['end_time'] = $request['end_time'];
            $data['activity_time'] = $request['activity_time'];
            $data['activity_end_time'] = $request['activity_end_time'];
            $data['addr'] =$request['addr'];
            $data['status'] = 1;
            $data['is_showtime'] = $request['is_showtime'];
           $rs =  Data_Mysql_Table_Weixin_Event_Info::insert($data);
        }
       // Q($request,$request['title']);
        //修改门票信息
       $eid = !empty($request['eid']) ? $request['eid'] : $rs[0];
        $tickIds = array();
        foreach($request['event_name'] as $k=>$v){
            if(isset($request['event_id']) && !empty($request['event_id'][$k])){
                $ticketData['name'] = $v;
                if($request['price_type']==1) {
                    $ticketData['price'] = $request['event_price'][$k];
                    $ticketData['price_is_score'] = 0;
                } else {
                    $ticketData['price'] = $request['event_price'][$k];
                    $ticketData['price_is_score'] = 1;
                }
//                $ticketData['price'] = $request['event_price'][$k];
                $ticketData['stock'] = $request['event_stock'][$k];
                $ticketData['event_time'] = $request['event_time'][$k];
                $ticketData['envent_id'] = $eid;
                $ticketData['envent_title'] = $request['title'];
                $ticketData['update_time']  = time();
               // Data_Mysql_Table_Weixin_Ticket_Info::debug(1);
                Data_Mysql_Table_Weixin_Ticket_Info::update($request['event_id'][$k],$ticketData);
                //q($ticketData);
                $tickIds[] = $request['event_id'][$k];
                //修改
            }else{
                //添加
                if($request['price_type']==1) {
                    $ticketData['price'] = $request['event_price'][$k];
                    $ticketData['price_is_score'] = 0;
                } else {
                    $ticketData['price'] = $request['event_price'][$k];
                    $ticketData['price_is_score'] = 1;
                }
                $ticketData['name'] = $v;
//                $ticketData['price'] = $request['event_price'][$k];
                $ticketData['stock'] = $request['event_stock'][$k];
                $ticketData['event_time'] = $request['event_time'][$k];
                $ticketData['envent_id'] = $eid;
                $ticketData['envent_title'] = $request['title'];
                $ticketData['create_time'] = $ticketData['update_time']  = time();
                $ticketData['status']  = 1;
                $rs =   Data_Mysql_Table_Weixin_Ticket_Info::insert($ticketData);
                $tickIds[] = $rs[0];
            }
        }
//        Q($tickIds, implode($tickIds,','));
      //  Q(json_encode($tickIds,","));
        if(!empty($tickIds)){
            Data_Mysql_Table_Weixin_Ticket_Info::delete(array("envent_id"=>$eid,"id not in (".implode($tickIds,',').")"));
        }else{
            Data_Mysql_Table_Weixin_Ticket_Info::delete(array("envent_id"=>$eid));
        }
        //更新改活动下所有票的状态
//        Data_Mysql_Table_Weixin_Ticket_Info::debug(1);
      //  $rsss = Data_Mysql_Table_Weixin_Ticket_Info::delete(array("envent_id"=>$eid,"id not in (".implode($tickIds,',').")"));
        Func_Header::to(" ".$msg.'成功',"?");
//        Q($rsss);
    }

    static function handleStatus()
    {
        $request = Func_Input::filter(array(
            "id"=>'int',
            "handle"=>'string'
        ),$_REQUEST);
        if(empty($request['id']) && empty($request['handle'])){
            Func_Header::back("参数错误");
        }
        //活动信息
        $rs = Data_Mysql_Table_Weixin_Event_Info::select("id,title,content,status",$request['id']);
        if(empty($rs[0]['id'])){
            Func_Header::back("此活动不存在");
        }
        switch($request['handle']){
            case "up":
                $status=1;
                $msg = '上线';
                break;
            case "down":
                $status=0;
                $msg = '下线';
                break;
            case "del":
                $status=-1;
                $msg = '删除';
                break;
            case "recover":
                $status=0;
                $msg = '恢复';
                break;
            default:
                $msg = '操作错误';
        }
        $rss = Data_Mysql_Table_Weixin_Event_Info::update($rs[0]['id'],array("status"=>$status));
        if($rss){
            Func_Header::back(" ".$msg."成功");
        }else{
            Func_Header::back($msg."失败");
        }
    }
    static function handleRealDel()
    {
        $request = Func_Input::filter(array(
            "id"=>'int',
        ),$_REQUEST);
        if(empty($request['id']) && empty($request['handle'])){
            Func_Header::back("参数错误");
        }
        //活动信息
        $rs = Data_Mysql_Table_Weixin_Event_Info::select("id,title,content,status",$request['id']);
        if(empty($rs[0]['id'])){
            Func_Header::back("此活动不存在");
        }
        $rss = Data_Mysql_Table_Weixin_Event_Info::update($rs[0]['id'],array("status"=>-2));
         Data_Mysql_Table_Weixin_Ticket_Info::update(array('envent_id'=>$rs[0]['id']),array("status"=>-2));
        if($rss){
            Func_Header::back("彻底删除成功");
        }else{
            Func_Header::back("彻底删除失败");
        }
    }



}