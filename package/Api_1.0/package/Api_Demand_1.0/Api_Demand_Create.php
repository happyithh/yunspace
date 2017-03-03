<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/23
 * Time: 16:15
 *
 */

/**
 * .
 * 1.需求创建(预约咨询,办活动，整体方案，查询档期，创建400)
 *
 */
@session_start();

class  Api_Demand_Create extends Api
{
    static function handle($args = '')
    {

        if ($_REQUEST['phone']) {
            $re = Func_Input::filter(array(
                'phone' => 'phone',
            ));
            if (empty($re['phone'])) {
                return self::request('error', '', '请输入您的联系电话哦');
            }
        }
        return self::handleDemandCreate($args);
    }

    static function handleDemandCreate($args)
    {
        $action = empty($_REQUEST['action']) ? '' : $_REQUEST['action'];
        switch ($action) {
            //预约咨询
            case 'consult':
                $data = self::handleCreateConsultDemand($args);
                break;
            //办活动
            case 'events':
                $data = self::handleCreateEventsDemand($args);
                break;
            //场地百科询价办活动
            case 'spacepedia_price':
                $data = Api_Demand_Spacepedia_Price::handleSpacepediaPrice($args);
                break;
            //场地百科/空间场地--查看参考价
            case 'look_price':
                $data = Api_Demand_Spacepedia_Look_Price::handleSpacepediaLookPrice($args);
                break;
            case 'events_update':
                $data = self::handleUpdateEventsDemand($args);
                break;
            case 'solution':
                //整体方案
                $data = self::handleCreateSolutionDemand($args);
                break;
            case 'broke':
                //我要爆料
                $args['account_id'] = Api_Session::user_id();
                if (empty($args['account_id'])) {
                    $password = rand(1111, 9999) . rand(1111, 9999);
                    $account = Api_Account_Register::quickRegister(array(
                        'phone' => $args['submit_person'],
                        'username' => $args['submit_person'],
                        'password' => $password));
                    if (!empty($account['data']['id'])) {
                        $args['account_id'] = $account['data']['id'];
                    }
//                    if($account['status']==1){
//                        Func_Message::sendSMS($args['submit_person'], array($args['submit_person'], $password), 23705);
//                    }
                }
                $data = self::handleCreateBrokeCreate($args);
                break;
            case 'grab_order_create':       //抢单创建 需求单
                $data = self::handleSaleNeedsOrderCreate($args);
                break;
            case 'new_events':      //查看档期和价格
//                $data = self::handleCreateNewEventsDemand($args);
//                q(Api_Demand_New_Events::test());
                $data = Api_Demand_New_Events::handleNewEventsDemand($args);
                break;
            case 'rent_space':
                //一键租场地
                $data = Api_Demand_Rent_Space::handleRentSpace($args);
                break;
            case 'rent_item':
                //一键租空间
                $data = Api_Demand_Rent_Space::handleRentSpace($args);
                break;
            case'baike_popup_form':
                // 百科弹框
                $data = Api_Demand_Create_Baike_Popup_Form::handleBaikePopupFormCreate($args);
                break;
            case 'annual_meeting':
                $data = self::handleCreateAnnualMeeting($args);
                break;
            case 'annual_meeting_package':
                $data = self::handleCreateAnnualMeetingPackage($args);
                break;
            case 'wanda':
                $data = self::handleCreateWanda($args);
                break;
            default:
                $data = self::request('error', '', '服务器开小差，请致电400-056-0599');
                break;
        }
        return $data;
    }
    static function handleCreateWanda($args){
        $request = Func_Input::filter(array(
            'username' => 'string',
            'phone' => 'phone',
            'people' => 'string',
            'start_date' => 'string',
            'end_date' => 'string',
            'company' => 'string',
            'event_type' => 'string',
            'annual_id' => 'string',
            'space_item' => 'string',
//            'auth_token' => 'string',
        ), $args);
        @session_start();
//        if(empty($request['auth_token'])||$request['auth_token']!=$_SESSION['auth_token']){
//            $result =self::request('error','',"非法请求！");
//            return $result;
//        }

        $demand_data = array(
            '联系电话' => $request['phone'],
            '活动人数' => $request['people'],
            '联系人' => $request['username'],
            '公司名称' => $request['company'],
            '活动类型' => $request['event_type'],
            '年会套餐' => '套餐id：'.$request['annual_id'].",套餐场地空间：".$request['space_item'],
            '活动起止日期' => $request['start_date']."--".$request['end_date'],
        );
        $account = self::getAccountByPhone(array('phone' => $request['phone']));

        return Api_Demand_Create::create(array('demand' => $demand_data,
            'phone' => $request['phone'],
            'demand_type' =>  '办活动',
            'demand_name' => 'New-万达专题',
            'account_id' => $account['id']
        ));


    }
    static function handleCreateAnnualMeetingPackage($args){
        $request = Func_Input::filter(array(
            'username' => 'string',
            'phone' => 'phone',
            'people' => 'string',
            'start_date' => 'string',
            'end_date' => 'string',
            'company' => 'string',
            'event_type' => 'string',
            'annual_id' => 'string',
            'space_item' => 'string',
//            'auth_token' => 'string',
        ), $args);
        @session_start();
//        if(empty($request['auth_token'])||$request['auth_token']!=$_SESSION['auth_token']){
//            $result =self::request('error','',"非法请求！");
//            return $result;
//        }

        $demand_data = array(
            '联系电话' => $request['phone'],
            '活动人数' => $request['people'],
            '联系人' => $request['username'],
            '公司名称' => $request['company'],
            '活动类型' => $request['event_type'],
            '年会套餐' => '套餐id：'.$request['annual_id'].",套餐场地空间：".$request['space_item'],
            '活动起止日期' => $request['start_date']."--".$request['end_date'],
        );
        $account = self::getAccountByPhone(array('phone' => $request['phone']));

        return Api_Demand_Create::create(array('demand' => $demand_data,
            'phone' => $request['phone'],
            'demand_type' =>  '办活动',
            'demand_name' => 'New-年会套餐',
            'account_id' => $account['id']
        ));


    }

    static function handleCreateAnnualMeeting($args){
        $phone_check = Func_Input::filter(array(
            'phone'=>'11',
            'auth_code'=>'6',
        ),$args);
        @session_start();
        if(empty($phone_check['phone']) ){
            $result =self::request('error','',"手机号不能为空！");
            return $result;
        }
        if (empty($phone_check['auth_code'])) {
            $result = self::request('error', '', "验证码不能为空！");
            return $result;
        }
         if (empty($_SESSION['auth_code'][0]) || empty($phone_check['phone']) || $phone_check['phone'] != $_SESSION['auth_code'][0]) {
             $result =self::request('error','',"验证手机不一致！");
             return $result;
         }
        if(empty($_SESSION['auth_code'][0]) ||$phone_check['phone']!=$_SESSION['auth_code'][0]){
            return self::request('error','',"该手机号没有发送过验证码！");
        }
        if (empty($_SESSION['auth_code'][1]) || empty($phone_check['auth_code']) || $phone_check['auth_code'] != $_SESSION['auth_code'][1]) {
            $result =self::request('error','',"验证码错误!");
            return $result;
        }
        unset($_SESSION['auth_code']);
        $request = Func_Input::filter(array(
            'username' => 'string',
            'phone' => 'phone',
            'people' => 'string',
            'start_date' => 'string',
            'end_date' => 'string',
        ), $args);
        $demand_data = array(
            '联系电话' => $request['phone'],
            '活动人数' => $request['people'],
            '联系人' => $request['username'],
            '活动起止日期' => $request['start_date']."--".$request['end_date'],
        );
//        if (!empty($request['demand_other'])) {
//            $demand_data['具体要求'] = $demand_data['具体要求'] . "--还需要其他的配套服务";
//        }
        $account = self::getAccountByPhone(array('phone' => $request['phone']));

        return Api_Demand_Create::create(array('demand' => $demand_data,
            'phone' => $request['phone'],
            'demand_type' =>  '办活动',
            'demand_name' => 'New-年会活动',
            'account_id' => $account['id']
        ));


    }

    /*
     *@预约咨询
     */
    /**
     * 1.查出产品信息，和供应商信息,
     * 2.如果有供应商信息则发消息给他
     * 3.创建一个需求单，
     * 4.创建一个需求推荐记录
     */
    static function handleCreateConsultDemand($args)
    {
        $request = Func_Input::filter(array(
            'ask_id' => 'int',
            'ask_name' => 'string',
            'ask_type' => 'int',
            'username' => 'string',
            'phone' => 'phone',
            'content' => 'string',
        ), $args);
        if (empty($request['username'])) {
            return self::request('error', '', '请输入您的姓名');
        }
        if (empty($request['phone'])) {
            return self::request('error', '', '请输入您的联系电话哦');
        }
        if (empty($request['content'])) {
            return self::request('error', '', '请输入您想的咨询内容');
        }
        if (empty($request['ask_type'])) {
            return self::request('error', '', '缺少参数，如有问题请致电400-056-0599,');
        }
        //如果是咨询供应商
        if (!empty($request['ask_type']) && $request['ask_type'] == 10) {
            return self::handleAskVendor($request);
        }
        $demand_create = array();
        $productInfo = array();
        if (!empty($request['ask_type'])) {
            if ($request['ask_type'] == 1) {
                //产品详情
                $productInfo = Api_Product_Search_SpaceVendor::getSpaceVendor(array('id' => $request['ask_id']));
                if (!$productInfo) {
                    return Api::request('error', '', '抱歉，未找到相关信息，如有问题请致电400-056-0599');
                }
                $demand_data = array(
                    '联系电话' => $request['phone'],
                    '联系人' => $request['username'],
                    'product_id' => $productInfo['id'],
                    '具体要求' => "产品咨询: {$productInfo['product_name']}\n咨询内容：" . $request['content'],
                    '来源类型' => '产品详情页',
                    '咨询内容' => $request['content'],
                );
                $demand_create = array('demand_type' => '预约咨询', 'phone' => $request['phone'], 'demand' => $demand_data);
                $recommend['product_id'] = $request['ask_id'];
            } elseif ($request['ask_type'] == 2) {
                //移动版  产品详情页  咨询档期
                $productInfo = Api_Product_Search_SpaceVendor::getSpaceVendor(array('id' => $request['ask_id']));
                if (!$productInfo) {
                    return self::request('error', '', '抱歉，未找到相关信息，如有问题请致电400-056-0599');
                }
                $demand_data = array(
                    '联系电话' => $request['phone'],
                    '联系人' => $request['username'],
                    'product_id' => $productInfo['id'],
                    '具体要求' => "产品档期查询: {$productInfo['product_name']}-日期：{$request['content']}",
                    '来源类型' => '移动版产品详情页',
                    '咨询内容' => "档期查询-" . $request['content'],
                );

                $demand_create = array('demand_type' => '产品档期查询', 'phone' => $request['phone'], 'demand' => $demand_data);
                $recommend['product_id'] = $request['ask_id'];
            } elseif ($request['ask_type'] == 5) {
                //套餐详情
                $productInfo = Api_Product_Search_SetVendor::getSetVendor(array('id' => $request['ask_id']));
                if (!$productInfo) {
                    return self::request('error', '', '抱歉，未找到相关信息，如有问题请致电400-056-0599');
                }

                $demand_data = array(
                    '联系电话' => $request['phone'],
                    '联系人' => $request['username'],
                    'set_id' => $productInfo['id'],
                    '具体要求' => "套餐咨询: {$productInfo['set_name']}\n咨询内容：" . $request['content'],
                    '来源类型' => '套餐详情页',
                    '咨询内容' => $request['content'],
                );
                $demand_create = array('demand_type' => '预约咨询', 'phone' => $request['phone'], 'demand' => $demand_data);
                $recommend['set_id'] = $request['ask_id'];
            } elseif ($request['ask_type'] == 6) {
                //移动版套餐详情页档期查询
                $productInfo = Api_Product_Search_SetVendor::getSetVendor(array('id' => $request['ask_id']));
                if (!$productInfo) {
                    return self::request('error', '', '抱歉，未找到相关信息，如有问题请致电400-056-0599');
                }
                $demand_data = array(
                    '联系电话' => $request['phone'],
                    '联系人' => $request['username'],
                    'set_id' => $productInfo['id'],
                    '具体要求' => "套餐档期查询: {$productInfo['set_name']}-日期{$request['content']}",
                    '来源类型' => '移动版套餐详情页',
                    '咨询内容' => "档期查询-" . $request['content'],
                );
                $demand_create = array('demand_type' => '套餐档期查询', 'phone' => $request['phone'], 'demand' => $demand_data);
                $recommend['set_id'] = $request['ask_id'];
            } elseif ($request['ask_type'] == 7) {
                //场地百科咨询
                $spacepedia = Api_Spacepedia_List_And_Info::getSpacepediaInfoByName($request['ask_name']);
                if (!$spacepedia) {
                    return Api::request('error', '', '抱歉，未找到相关信息，如有问题请致电400-056-0599');
                }
                $demand_data = array(
                    '联系电话' => $request['phone'],
                    '联系人' => $request['username'],
                    'space_name' => $spacepedia['space_name'],
                    '具体要求' => "百科咨询: {$spacepedia['space_name']}\n咨询内容：" . $request['content'],
                    '来源类型' => '百科详情页',
                    '咨询内容' => $request['content'],
                );
                $demand_create = array('demand_type' => '预约咨询', 'phone' => $request['phone'], 'demand' => $demand_data);
                //百科需求推荐    todo....
//                $recommend['space_name'] = $request['ask_name'];

            } else {
                Api::request('error', '', '抱歉，发生错误了，如有问题请致电400-056-0599');
            }


            $account = self::getAccountByPhone(array('phone' => $request['phone']));
            $demand_create['account_id'] = $account['id'];
            //创建需求
            $demand_status = Api_Demand_Create::create($demand_create);
            if (empty($demand_status['status'])) {
                return $demand_status;
            }
            //给供应商发消息,推荐
            if (!empty($productInfo['vendor_account_id'])) {
                $media = Api_Recommend_MessageMediaFormat::dataFormatSpace(array('data' => $productInfo,
                    'type' => empty($productInfo['set_name']) ? 'product' : 'set'));
                Api_Livechat_Message_Send::handleSendMessage(array('to_account_id' => $productInfo['vendor_account_id'],
                    'from_account_id' => $account['id'],
                    'media' => $media,
                ));
                Api_Livechat_Message_Send::handleSendMessage(array('to_account_id' => $productInfo['vendor_account_id'],
                    'from_account_id' => $account['id'],
                    'message' => $demand_data['具体要求'],
                ));
            }
            //加入到推荐记录
            $recommend['demand_id'] = $demand_status['data'];
            $recommend['recommend_account_id'] = $account['id'];
            $recommend['demo'] = $demand_data['咨询内容'];
            $recommend['only_add'] = 1;         //设置不发消息

            //没有供应商账户的情况下
            if (!empty($demand_status['data']) && empty($productInfo['vendor_account_id'])) {
                Api_Livechat_Group_Create::handleCreate(array('demand_id' => $demand_status['data'], 'members' => array(array(
                    'account_id' => $account['id'],
                    'username' => $account['username'],
                ))));
                $recommend['only_add'] = 0;
            }
            Api_Recommend_Add::addRecommend($recommend);

            return Api::request('success', $demand_status['data'], '您的咨询已成功提交，云·Space供应商和活动顾问将为您提供后续服务！');
        }

    }

    /*
     *@办活动
     */
    static function handleCreateEventsDemand()
    {
        $request = Func_Input::filter(array(
            'demand_city' => 'string',
            'username' => 'string',
            'phone' => 'phone',
            'people' => 'string',
            'content' => 'string',
            'demand_style' => 'string',
            'demand_other' => 'int',
            'is_mobile' => 'int',
        ), $_REQUEST);
//        if (empty($request['content'])) {
//            return self::request('error', '', '咨询内容必须填写!');
//        }
        if (strlen($request['咨询内容']) > 500) {
            return self::request('error', '', '您的咨询内容输入过多!');
        }
        if (empty($_SESSION['user']) && empty($request['phone'])) {
            return self::request('error', '', '未登录用户联系电话必须填写!');
        }
        $demand_data = array(
            '联系电话' => $request['phone'],
            '活动人数' => $request['people'],
            '联系人' => $request['username'],
            '具体要求' => $request['content'],
            '活动城市' => $request['demand_city'],
            '活动类型' => $request['demand_style'],
        );
        if (!empty($request['demand_other'])) {
            $demand_data['具体要求'] = $demand_data['具体要求'] . "--还需要其他的配套服务";
        }
        $account = self::getAccountByPhone(array('phone' => $request['phone']));

        return Api_Demand_Create::create(array('demand' => $demand_data,
            'phone' => $request['phone'],
            'demand_type' => $request['is_mobile'] ? '办活动M' : '办活动',
            'demand_name' => 'New-我要办活动',
            'account_id' => $account['id']));


    }

    /***
     * @return array
     */

    static function handleUpdateEventsDemand()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'price_range' => 'string',
            'start_time' => 'string',
            'end_time' => 'string',
        ), $_REQUEST);
        if (empty($request["demand_id"])) {
            return self::request('error', '', '需求请求错误');
        }
        if (empty($request["price_range"])) {
            return self::request('error', '', '请选择价格区间');
        }
        if (empty($request["start_time"]) || empty($request["end_time"])) {
            return self::request('error', '', '请选择日期');
        }
        $rs = Data_Mysql_Table_Demand::select("*", array("id=?" => $request["demand_id"]), '', 1);
        if (empty($rs[0])) {
            return self::request('error', '', '此需求不存在！');
        }
        $rs[0]['demand'] = json_decode($rs[0]['demand'], 1);
        $rs[0]['demand']['具体要求'] = $request['start_time'] . "--" . $rs[0]['demand']['具体要求'];
        $rs[0]['demand']['开始时间'] = $request["start_time"];
        $rs[0]['demand']['结束时间'] = $request["end_time"];
        $data = array(
//            "id=?"=>$request["demand_id"],
            "demand=?" => $rs[0]['demand'],
        );
        switch ($request["price_range"]) {
            case "2万以下":
                $data['price_down'] = 20000;
                break;
            case "2-5万":
                $data['price_up'] = 20000;
                $data['price_down'] = 50000;
                break;
            case "5-10万":
                $data['price_up'] = 50000;
                $data['price_down'] = 100000;
                break;
            case "10万以上":
                $data['price_up'] = 100000;
                break;
        }
        $result = Data_Mysql_Table_Demand::update(array("id=?" => $request["demand_id"]), $data);
        if ($result) {
            return Api::request('success', $request, '您的需求已成功提交，稍候将有云·Space专业人员为您提供后续服务！');
        } else {
            return Api::request('error', '', '需求创建失败');
        }
    }

    /*
    *@整体方案
    */
    static function handleCreateSolutionDemand()
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'username' => 'string',
            'submit_person' => 'string',
            'content' => 'string'
        ), $_REQUEST);
        if (empty($request['phone'])) {
            return self::request('error', '', '请正确的填写您的联系电话！');
        }
        if (empty($request['username'])) {
            return self::request('error', '', '联系人不能为空!');
        }
        if (empty($request['content'])) {
            return self::request('error', '', '具体要求必须填写!');
        }
        $demand_data = array(
            '联系电话' => $request['phone'],
            '联系人' => $request['username'],
            '具体要求' => $request['content'],
            '提交人' => $request['submit_person'],
        );

        $account = self::getAccountByPhone(array('phone' => $request['phone']));
        return Api_Demand_Create::create(
            array('demand' => $demand_data,
                'phone' => $request['phone'],
                'account_id' => $account['id'],
                'demand_type' => '整体方案'
            ));

    }

    /**
     *  咨询供应商
     */
    static function  handleAskVendor($args)
    {
        $request = Func_Input::filter(array(
            'ask_id' => 'int',
            'username' => 'string',
            'phone' => 'phone',
            'content' => 'string',
        ), $args);
        $demand_data = array(
            '联系电话' => $request['phone'],
            '联系人' => $request['username'],
            'vendor_id' => $request['ask_id'],
            '具体要求' => "咨询供应商{$request['content']}",
            '来源类型' => '供应商详情页',
        );
        $demand_create = array('demand_type' => '联系供应商', 'phone' => $request['phone'], 'demand' => $demand_data);
        $account = self::getAccountByPhone(array('phone' => $request['phone']));
        $demand_create['account_id'] = $account['id'];

        return self::create($demand_create);

    }
    //我要爆料 创建需求
    /**
     * param $args =  array(
     *               'city'=>'string',              // 需求城市
     *               'demand_type'=>'string',       //需求类型
     *               'contact_people'=>'string',       //需求人
     *               'submit_person'=>'int',        //提交人联系方式
     *               'phone'=>'int'                 // 活动方联系方式
     *          )
     * */
    static function handleCreateBrokeCreate($args)
    {

        $request = Func_Input::filter(
            array(
                'city' => 'string',
                'type' => 'string',
                'contact_people' => 'string',
                'submit_person' => 'string',
                'phone' => 'string',
                'account_id' => 'int',
                'otherData' => 'html'
            ), $args);
        $request['contact_people'] = trim($request['contact_people']);
        $request['phone'] = trim($request['phone']);
        if (empty($request['contact_people']) || empty($request['phone']) || empty($request['submit_person'])) {
            return self::request('error', '', '信息填写尚未完整，爆料不能提交成功哦！');
        }
        // 获取爆料人账户信息
        if (!empty($_SESSION['user']['id'])) {
            $accountInfo = Api_Session::user_info();
        } else {
            $accountInfo1 = Data_Mysql_Table_Account::select('id,username,phone', array('phone' => $request['submit_person']));
            $accountInfo = $accountInfo1[0];
        }
        $contact_account = self::getAccountByPhone(array('phone' => $request['phone'], 'username' => $request['contact_people'],
            'no_session' => 1));
        $demand['account_id'] = $contact_account['id'];
        $demand['submit_person_account_id'] = $accountInfo['id'];
        $demand['submit_person'] = $request['submit_person'];
        $demand['phone'] = $request['phone'];
        $demand['create_time'] = time();
        $demand['demand_name'] = 'New-' . $request['contact_people'] . '的新活动';
        $demand['demand_type'] = '活动爆料';
        $demand['ip'] = Func_Input::ip();
        $demand['demand'] = array(
            '联系人' => $request['contact_people'],
            '联系电话' => $request['phone'],
            '活动城市' => $request['city'],
            '具体要求' => '活动类型：' . $request['type'],
            '爆料人' => $accountInfo['username'],
            '爆料人手机' => $accountInfo['phone'],
            '爆料人ID' => $accountInfo['id'],
            '活动备注' => empty($request['otherData']) ? '' : $request['otherData']
        );
        $data = Api_Demand_Create::create($demand);
        if ($data['status'] == 1) {
            return self::request('success', $data['data'], '爆料成功！');
        }

        return self::request('error', '', '爆料失败,如有问题请致电400-056-0599');

    }

    /**
     * @param $args
     * @return array
     * 抢单 创建订单
     * 1.创建个人需求订单
     * 2.创建需求 至 需求库
     */
    static function   handleSaleNeedsOrderCreate($args)
    {
        $request = Func_Input::filter(array(
            'demand' => 'array',
            'phone' => 'phone',
            'create_type' => 'string',
        ), $args);
        if (empty($request['phone'])) {
            return Api::request('error', '', '请正确填写手机号！');
        }
        if (empty($request['create_type']) || empty($request['demand'])) {
            return Api::request('error', '', '参数缺少！');
        }
        $demand = Func_Input::filter(array(
            '活动城市' => 'string',
            '活动类型' => 'string',
            '联系人' => 'string',
            '具体要求' => 'string',
            '活动人数' => 'string',
            '开始时间' => 'string',
            '结束时间' => 'string',
            'price_up' => 'int',
            'price_down' => 'int',

        ), $request['demand']);
        $demandData = array(
            '活动类型' => $demand['活动类型'],
            '活动城市' => $demand['活动城市'],
            '联系人' => $demand['联系人'],
            '联系电话' => $request['phone'],
            '活动人数' => $demand['活动人数'],
            '开始时间' => $demand['开始时间'],
            '结束时间' => $demand['结束时间'],
            'price_up' => $demand['price_up'],
            'price_down' => $demand['price_down'],
            '具体要求' => $demand['具体要求'],
        );
        $account = self::getAccountByPhone(array('phone' => $request['phone'], 'no_session' => 1));
        $insertData = array(
            'demand' => $demandData,
            'backup_demand' => $demandData,
            'demand_status' => 0,
            'ip' => Func_Input::ip(),
            'city' => empty($_COOKIE['city']) ? '上海' : $_COOKIE['city'],
            'account_id' => $account['id'],
            'phone' => $request['phone'],
            'price_up' => $demandData['price_up'],
            'price_down' => $demandData['price_down'],
        );

//        $table = "{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id =t2.id";
//        $check_status = Data_Mysql_Table_Demand::select("t1.status,t2.step", array('t2.customer_phone=?' => array($request['phone'])), '', 1, $table);
//        if (!empty($check_status[0][''])) {
//
//        }
        $check = Data_Mysql_Table_Grab_Order::select('step,status', array(
            'customer_phone=? AND sale_phone=? ' => array(
                $request['phone'],
                $_SESSION['user']['phone']
            )), 'ORDER BY id DESC');

        if (!empty($check[0])) {
            if ($check[0]['step'] != 100 && $check[0]['step'] > -1) {
                $insertData['mark_tags'] = '20|';
//                return Api::request('error', '', '您已经有一个手机号相同的订单正在进行中了~，不能重复创建');
            }
        }
        //提交至抢单
        if ($request['create_type'] == 'grab_order') {

            //TODO::销售创建抢单 提交 需求库

        } elseif ($request['create_type'] == 'my_order') {
            //1.插入需求表
            //2.插入抢单表，领取手机号设为 自己

            $insertData['demand_type'] = '销售创建';
            $insertData['resolve_time'] = time();
            $insertData['demand_status'] = 1;
            $insertData['integral'] = 20;
            if (!empty($insertData['mark_tags'])) {
                $insertData['mark_tags'] = $insertData['mark_tags'] . '2';
            } else {
                $insertData['mark_tags'] = '2|';
            }
            //1
            $data = Data_Mysql_Table_Demand::insert($insertData);
            if (Func_Input::isLocal()) {
                $url_host = 'yun.bb';
            } else {
                $url_host = "master.yunspace.com.cn";
            }
            $url = "http://" . $url_host . "/static/api/message/remote/send.json?demand_id=" . $data[0] . "&token=" . md5(date('YmdH') . 'demand_msg');
            @Func_Http::get($url);
            //2
            $status = Api_Grab_Order_Create::handleInsert(array(
                'id' => $data[0],
                'customer_phone' => $request['phone'],
                'sale_phone' => @$_SESSION['user']['phone'],
                'status' => 1,
            ));

            if ($status['status'] == 1) {

                Api_Administrator_Integral_Manage::integralManages(array(
                    'phone' => $_SESSION['user']['phone'],
                    'integral' => 20,
                    'type' => 'add',
                    'title' => '新建订单',
                    'reason' => '新建订单',
                ));
                return Api::request('success', $status['data'], '创建成功，记得更新记录哦~！');
            }
            return $status;


        }
    }

    /**
     *  创建需求
     * param   $args =array(
     *              'demand'=>array(
     *              '联系电话'=>''
     *              '联系人'=>''
     *              '具体要求'=>''
     *              '咨询内容'=>''      。。。。还有
     *              ，
     *              'demand_type'=>''
     *              'phone'=>''
     *              'account_id'=>''
     * )
     *      )
     *
     */
    static function  create($args)
    {
        $request = Func_Input::filter(array(
            'demand' => 'array',
            'phone' => 'string',
            'account_id' => 'int',
            'demand_type' => 'string',
            'notice_city' => 'string',      //通知城市
            'demand_name' => 'string',
            'resolve_time' => 'int',
            'admin_id' => 'int',
            'demand_status' => 'int',
            'response_account_id' => 'int',
            'submit_person_account_id' => 'int',        //爆料人的ID
            'submit_person' => 'int',       //爆料人的手机号
            'price_up' => 'int',
            'price_down' => 'int',
            'win_id' => 'int',
            'object_id' => 'int',
            'object_name' => 'string',
            'object_type' => 'string',
            'is_phone' => 'int',
        ), $args);
        $city = empty($request['demand']['活动城市']) ? $_COOKIE['city'] : $request['demand']['活动城市'];
        if (!$request['demand_name']) {
            $demand_id = self::isRepeat(array('phone' => $request['phone'], 'city' => $city));
            if ($demand_id) {
                return Api::request('error', $demand_id, '您在一周内有未结束的活动需求，所以不能创建新的需求,如有问题请致电400-056-0599');
            }
        }
        $demand = array(
            'phone' => $request['phone'],
            'demand' => $request['demand'],
            'demand_type' => $request['demand_type'],
            'city' => $city,
            'notice_city' => $request['notice_city'],
            'create_time' => time(),
            'demand_status' => empty($request['demand_status']) ? 0 : $request['demand_status'],
            'ip' => Func_Input::ip(),
            'session_id' => session_id(),
            'account_id' => $request['account_id'],
            'admin_id' => $request['admin_id'],
            'demand_name' => $request['demand_name'],
            'resolve_time' => $request['resolve_time'],
            'response_account_id' => $request['response_account_id'],
            'submit_person_account_id' => $request['submit_person_account_id'],
            'submit_person' => $request['submit_person'],
            'price_up' => $request['price_up'],          //价格上限
            'price_down' => $request['price_down'],
            'win_id' => $request['win_id'],
            'referer' => @$_SESSION['referer'],
            'enter_url' => @$_SESSION['enter'],
            'is_phone' => $request['is_phone'],
        );

        $status = Data_Mysql_Table_Demand::insert($demand);
        if (Func_Input::isLocal()) {
            $url_host = 'yun.bb';
        } else {
            $url_host = "master.yunspace.com.cn";
        }
        $url = "http://" . $url_host . "/static/api/message/remote/send.json?demand_id=" . $status[0] . "&token=" . md5(date('YmdH') . 'demand_msg');
        @Func_Http::get($url);
        if (!empty($status[0])) {
            if ($demand['demand_type'] == '文创项目合作') {
                Api_Winchance_Online_Site_Create::WinchanceSiteCreate($status[0]);
            }
            if (empty($request['admin_id'])) {
//                Api_Demand_Notice::noticeCustomerService(array('demand_id' => $status[0]));
                Api_Demand_Notice_V2::servicesNotice_new_v1(array(
                    'demand_id' => $status[0],
                ));
            }

            //        非工作时间的  （办活动 办活动-M  一键租场地），且没有重复的 ， 直接进抢单 ，不舍时间限制
            if (!self::isWorkingDay() && ($request['demand_type'] == '一键租场地' || $request['demand_type'] == '办活动' || $request['demand_type'] == '办活动-M')) {
                if (is_numeric(strpos($city, '上海'))) {
                    $notice_city = '上海';
                } elseif (is_numeric(strpos($city, '北京'))) {
                    $notice_city = '北京';
                } elseif (is_numeric(strpos($city, '深圳'))) {
                    $notice_city = '深圳';
                } else {
                    $notice_city = '上海';
                }
                Api_Demand_Handle::getIntoGrabOrder(array(
                    'city' => $notice_city,
                    'phone' => $request['phone'],
                    'demand_id' => $status[0],
                    'demand' => $demand,
                    'is_holiday' => 1
                ));
            }


            //将查看参考价的手机号保存在cookie中
            if ($request['demand_type'] == "查看参考价" || $request['demand_type'] == "查看参考价M") {
                setcookie("look_price_phone", $request['phone'], time() + 86400 * 30, "/");
            }
            //一键租场地加密demand_id
            if ($request['demand_type'] == "一键租场地") {
                $return['demand_id'] = Func_NumEncode::e($status[0]);
                $return['phone'] = Func_String::encrypt($demand['phone'], "哈哈，猜不到吧");
                return Api::request('success', $return, '您的需求已成功提交，稍候将有云·Space专业人员为您提供后续服务！');
            }

            //不同类型添加一条数据
            $events_arr = array("咨询价格和档期", "文创项目合作", "合作咨询");
            if (in_array($request['demand_type'], $events_arr)) {
                $event_data['demand_id'] = $status[0];
                $event_data['object_id'] = $request['object_id'];
                $event_data['object_name'] = $request['object_name'];
                $event_data['object_type'] = $request['object_type'];
                Data_Mysql_Table_Demand_Events::update($event_data);
            }

            Api_Demand_Handle::cron();

            if(Api_Holiday::isWorkTime()){
                $new_msg = '您的需求已成功提交，稍候将有云·Space专业人员为您提供后续服务！';
            }else{
                $new_msg = '您的需求已成功提交，待工作时间将有云·Space专业人员为您提供后续服务！请保持通讯正常  我们工作时间是周一至周五 9：00-18：00';
            }
            return Api::request('success', $status[0], $new_msg);
        }
        return Api::request('error', '', '需求创建失败');

    }

    /**
     * @return bool
     * 判断是否是工作日
     */
    static function  isWorkingDay()
    {
        return true;
        $json = Api_Holiday::handleCheck(array('d' => date('Ymd')));
        $data = json_decode($json, 1);
        if (is_array($data)) {
            $isWorking = in_array(0, $data);
            //如果是工作时间 并且 是下班时间
            if ($isWorking) {

                if (date('H') > 17 || date('H') < 8) {
                    return false;
                }
            } else {
                return false;
            }
        }
        return true;

    }

//判断需求是否重复提交(手机号相同，一周之内，活动名称为空)
    static function isRepeat($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'string',
            'city' => 'string'
        ), $args);
        if (empty($request['phone'])) {
            return false;
        }
        if (empty($request['city'])) {
            return false;
        }
        $conditions['phone'] = $request['phone'];
        $conditions['city'] = $request['city'];
        $conditions['create_time >= ?'] = time() - 7 * 24 * 3600;
        $conditions['demand_name'] = '';
        $conditions['demand_status >=?'] = 0;
        $is_exist = Data_Mysql_Table_Demand::select('id', $conditions);
        if (!empty($is_exist[0]['id'])) {
            return $is_exist[0]['id'];
        }
        return false;
    }


    //处理用户信息
    static function  getAccountByPhone($args)
    {
        @session_start();
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'username' => 'string',
            'no_session' => 'int',
        ), $args);
        $account['id'] = '';
        $account['username'] = '';
        $sess_account = array();
        if (empty($request['no_session'])) {
            if (!empty($_SESSION['user']['id'])) {
                $sess_account['id'] = $_SESSION['user']['id'];
                $sess_account['username'] = $_SESSION['user']['username'];
            }
        }
        if (!empty($sess_account['id'])) {
            $account['id'] = $sess_account['id'];
            $account['username'] = $sess_account['username'];
        } else {
            $check_account = Api_Account_GetBaseInfo::getBaseInfoByPhone(array('phone' => $request['phone']));
            if (!empty($check_account['id'])) {
                $account['id'] = $check_account['id'];
                $account['username'] = $check_account['username'];
            }
        }

        if (empty($account['id'])) {
            //todo::办活动 提交的手机未经过验证
            $data = self::quickAccount(array('phone' => $request['phone'], 'username' => $request['username']));
            if ($data) {
                return $data;
            }
        }
        return $account;
    }

    /**
     *
     * 快速注册
     * 1.注册一个账户，密码自动生成
     * 2.注册成功后，将密码发送给用户
     *
     */
    static function  quickAccount($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
            'username' => 'string',
        ), $args);

        $password = rand(10000, 99999) . rand(111, 999);
        $status = Api_Account_Register::quickRegister(array(
            'username' => $request['username'],
            'phone' => $request['phone'],
            'password' => $password));
        if (!empty($status['data'])) {

//            Func_Message::sendSMS($request['phone'], array($request['phone'], $password), 23705);
            return $status['data'];
        }
        return false;

    }


}