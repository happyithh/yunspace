<?php

/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 15-3-31
 * Time: 上午11:39
 * 运营部管理---需求管理
 * yl
 *
 * //zzc   12/16更新
 */
class OA_Demand_Operate
{
    static function handle()
    {
        $action = empty($_REQUEST['action']) ? 'list' : $_REQUEST['action'];
        switch ($action) {
            case 'list':
                self::demandList();
                break;
            case 'detail':
                self::demandDetail();
                break;
            case 'abandon':
                self::demandAbandon();
                break;
            case 'receive':
                self::handleDemandReceive();
                break;
            case 'receive_from_submit':
                self::handleDemandReceiveFromSubmit();
                break;
            case 'ajaxSelectRecentDemand':
                OA_Demand_getRecent::getRecentDemand();
                break;
            case 'offer':
                self::handleDemandOffer();
                break;
            case 'backout':
                self::handleDemandBackout();
                break;
            default :
                self::demandList();
                break;
        }
    }


    /*
     *需求管理
     */
    static function demandList()
    {
        $type = isset($_REQUEST['type']) ? $_REQUEST['type'] : "all";
        $order = 'order by create_time desc';
        $conditions = array();
        //获取所有需求总数
        $totalNum = array(
            '0' => 0,
            '1' => 0,
            '5' => 0,
            '-1' => 0,
            '-2' => 0,
            '-3' => 0,
            '2' => 0,
        );
        if (!empty($_REQUEST['search'])) {
            $search = Func_Input::filter(array(
                'city' => 'string',
                'demandType' => 'string',
                'start_time' => 'string',
                'end_time' => 'string',
                'username' => 'string',
                'phone' => 'string',
                'no' => 'int',
                'demand_level' => 'int',
            ), $_REQUEST['search']);
            if (!empty($search['city'])) {
                $conditions['city'] = $search['city'];
            }
            if (!empty($search['demandType'])) {
                $conditions['demand_type'] = $search['demandType'];
            }
            if (!empty($search['start_time']) && !empty($search['end_time'])) {
                if (strtotime($search['start_time']) > strtotime($search['end_time'])) {
                    Func_Header::back('请正确选择时间范围！！');
                } else {
                    $conditions['create_time between ? and ?'] = array(
                        strtotime($search['start_time']),
                        strtotime($search['end_time']) + 86340
                    );
                }
            } elseif (!empty($search['start_time']) && empty($search['end_time'])) {
                $conditions['create_time >= ?'] = strtotime($search['start_time']);
            } elseif (empty($search['start_time']) && !empty($search['end_time'])) {
                $conditions['create_time <= ?'] = strtotime($search['end_time']) + 86340;
            }
            if (!empty($search['username'])) {
                $conditions['demand_name like ?'] = '%' . $search['username'] . '%';
            }
            if (!empty($search['phone'])) {
                $conditions['phone=?'] = $search['phone'];
            }
            //需求级别
            if (isset($search['demand_level']) && $_REQUEST['search']['demand_level'] !='全部') {

                $conditions['demand_level'] = $search['demand_level'];
            }
            if (!empty($search['no'])) {
                $conditions['(id =? OR id =?)'] = array($search['no'], Func_NumEncode::d($search['no']));
            }
            $countCondition = $conditions;
        }
        //搜索tab进行处理
        if (!empty($_REQUEST['search'])) {
            $searchArray = 'search[city]=' . $search['city'] . '&search[demandType]=' . $search['demandType'] . '&search[start_time]=' . $search['start_time'] . '&search[end_time]=' . $search['end_time'] . '&search[username]=' . $search['username'] . '&search[phone]=' . $search['phone'] . '&search[demand_level]=' . $search['demand_level'];
            Tpl_Smarty::assign('urls', $searchArray);
        }
        $countCondition[] = '1 GROUP BY demand_status';
        $total = Data_Mysql_Table_Demand::select('count(*) as count, demand_status', $countCondition, '', 5);
        foreach ($total as $v) {
            $totalNum[$v['demand_status']] = $v['count'];
            $totalNum[2] += $v['count'];
        }
        //获取所有未处理需求
        switch ($type) {
            case 'all':
                /**
                 * 测试状态的需求不显示在全部里面
                 */
                $conditions['demand_status !=?'] = 5;
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', $conditions, $order);
                break;
            case 'waiting':
                $conditions['demand_status=?'] = 0;
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', $conditions, $order);
                break;
            case 'done':
                $conditions['demand_status=?'] = 1;
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', $conditions, $order);
                break;
            case 'abandon':
                $conditions['demand_status=?'] = '-1';
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', $conditions, $order);
                break;
            case 'abandon_repeat':
                $conditions['demand_status=?'] = '-2';
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', $conditions, $order);
                break;
            case 'abandon_system_repeat':
                $conditions['demand_status=?'] = '-3';
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', $conditions, $order);
                break;
            case 'offer':
                $conditions['demand_status=?'] = 5;
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', $conditions, $order);
                break;
            default :
                $data = Data_Mysql_Table_Demand::page(0, 0, '*', '', $order);
                break;
        }

        if (!empty($data['rows'])) {
            $data['rows'] = self::changeArr($data['rows']);
            Tpl_Smarty::assign('_data', $data);
        }
        Tpl_Smarty::assign('type', $type);
        Tpl_Smarty::assign('total', $totalNum);

        Tpl_Smarty::assign('_demandType', Data_Mysql_Table_Demand::$_demandType);
        Tpl_Smarty::display('OA_Static::Demand.v2.0/operate/operate_demand.tpl');
    }

    /*
     * 查看需求详情
     */
    static function demandDetail()
    {
        if (empty($_REQUEST['id'])) {
            Func_Header::notFound();
        }
        $demandInfo = Data_Mysql_Table_Demand::select('tb1.*,tb2.id as offer_id', array('tb1.id=?' => $_REQUEST['id']),
            '', 1, '{table} as tb1 LEFT JOIN  {prefix}demand_offer as tb2 ON tb1.id=tb2.demand_id');
        $demand = self::changeArr($demandInfo);
        $events_arr = array("咨询价格和档期", "文创项目合作", "合作咨询");
        if (in_array($demand[0]['demand_type'], $events_arr)) {
            $events_data = Data_Mysql_Table_Demand_Events::select('*', array("demand_id" => $_REQUEST['id']),
                'ORDER BY create_time DESC', 20);
            if (!empty($events_data[0]['object_id'])) {
                Tpl_Smarty::assign('events_data', $events_data);
            }
        }
        Tpl_Smarty::assign('recent_demand',
            Api_Demand_Admin_Recent::getRecent(array('phone' => $demand[0]['phone'], 'demand_id' => $_REQUEST['id'])));

        Tpl_Smarty::assign('_demand', $demand[0]);
        Tpl_Smarty::display('OA_Static::Demand.v2.0/operate/operational_demand_detail.tpl');

    }

    /**
     * 接收需求
     */
    static function  handleDemandReceive()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
        ), $_REQUEST);
        $demandInfo = Data_Mysql_Table_Demand::select('*', array('id' => $request['demand_id']));
        $dataDemand = self::changeArr($demandInfo);

        Tpl_Smarty::assign('demand_receive', 1);
        Tpl_Smarty::assign('demand_options', Data_Demand_Option_Config::all());
        Tpl_Smarty::assign('_demand', @$dataDemand[0]);
        Tpl_Smarty::assign('_demandType', Data_Mysql_Table_Demand::$_demandType);
        Tpl_Smarty::assign('categoryList', Data_Mysql_Table_Product_Category::getTreeCache());
        $tags = Data_Config_Vendor_Attr::get('attr');
        if (!empty($tags['活动类型'])) {
            Tpl_Smarty::assign('tags', $tags['活动类型']);
        }
        $categoryTree = Data_Mysql_Table_Product_Category::getTreeCache();
        if (!empty($categoryTree)) {
            Tpl_Smarty::assign('categoryTree', $categoryTree);
        }


        Tpl_Smarty::display('OA_Static::Demand.v2.0/demand_edit.tpl');
    }

//接收需求表单
    static function  handleDemandReceiveFromSubmit()
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'demand_name' => 'string',
            'notice_city' => 'string',
            'data' => 'array',
            'price_up' => 'int',
            'price_down' => 'int',
            'is_phone' => 'int',

        ), $_REQUEST);
        $demand = Func_Input::filter(array(
            '联系电话' => 'phone',
            '联系人' => 'string',
            '公司名称' => 'string',
            '场地类型' => 'string',
            '活动类型' => 'string',
            '活动城市' => 'string',
            '活动人数' => 'string',
            '开始时间' => 'string',
            '结束时间' => 'string',
            '需求场地' => 'string',
            '具体要求' => 'string',
        ), $request['data']);

        $demand['price_up'] = $request['price_up'];
        $demand['price_down'] = $request['price_down'];

        $oldDemand = Data_Mysql_Table_Demand::select('demand_type,city,account_id,phone,demand,create_time,delay_time',
            array('id =?' => $request['demand_id']));
        if (empty($oldDemand[0]['demand'])) {
            Func_Header::back('该需求不存在，请返回列表页重试');
        }

        foreach ($demand as $k => $v) {
            if ($v == '') {
                unset($demand[$k]);
            }
        }
        $oldDemand['demand'] = json_decode($oldDemand[0]['demand'], true);
        $newDemand = array_merge($oldDemand['demand'], $demand);
        $demand['account_id'] = $oldDemand[0]['account_id'];
        $newData = array(
            'demand_id' => $request['demand_id'],
            'demand_name' => $request['demand_name'],
            'demand_status' => 1,
            'city' => $demand['活动城市'],
            'resolve_time' => time(),
            'price_up' => $request['price_up'],          //价格上限
            'price_down' => $request['price_down'],
            'demand' => $newDemand,
            'notice_city' => $request['notice_city'],
            'is_phone' => $request['is_phone'],
        );

        $status = Api_Demand_Edit::demandEdit($newData);
        if ($status) {

            //创建操作日志
            Data_Mysql_Table_Account_Log::insertAccountLog($oldDemand[0]['account_id'],
                $_SESSION['administrator']['id'], '接受需求', '审核需求', $request['demand_id']);
            /***
             *   //如果是提交到报价系统
             */
//            if (!empty($request['is_offer']) && $request['is_offer'] == 1) {
//                //直接跳转
//                Func_Header::to('', 'http://' . Core::$urls['host'] . Core::$urls['root'] . Core::$urls['package'] . 'operation/demand_tender?act=demand_offer&demand_id=' . $request['demand_id']);
//            }
            //类型是文创项目合作  不进入抢单
            if ($oldDemand[0]['demand_type'] == '文创项目合作') {
                //通知文创组
                Api_Demand_Notice_V2::saleGroupWinChance(array('id' => $request['demand_id']));
                Func_Header::to('  操作成功', Core::$urls['base_path'] . '?action=list');
            }

                //进入抢单系统
                $create = Api_Demand_Handle::getIntoGrabOrder(array(
                    'city' => $request['notice_city'],
                    'phone' => $demand['联系电话'],
                    'demand_id' => $request['demand_id'],
                    'demand' => $demand
                ));
                if ($create['status'] == 0) {
                    Func_Header::to($create['msg']);

                }

            Func_Header::to('  操作成功', Core::$urls['base_path'] . '?action=list');

        }
        Func_Header::back('操作失败，请返回列表页重试', Core::$urls['base_path'] . '?action=list');
    }

    /*
     * 放弃需求
     */
    static function demandAbandon()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
            'demo' => 'string',
            'reason' => 'string',
        ));

        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        if (empty($request['reason'])) {
            Func_Output::json('error', '', '理由不能为空');
        }
        $condition = array('id' => $_REQUEST['id']);
        $data = array(
            'demand_status' => -2,
            'demand_reason' => array($request['reason'], $request['demo']),
            'refuse_time' => time(),
        );
        $rs = Data_Mysql_Table_Demand::update($condition, $data);
        if ($rs[0] > 0) {
            $account = Data_Mysql_Table_Demand::select('account_id', array('id =?' => $request['id']));
            Data_Mysql_Table_Account_Log::insertAccountLog($account[0]['account_id'], $_SESSION['administrator']['id'],
                '放弃需求', '审核需求', $request['id']);

            Func_Output::json('success', '', '  需求放弃成功');
        }
        Func_Output::json('error', '', '需求放弃失败');

    }


    /*
     * 需求数组的格式转换
     */
    static function changeArr($arr)
    {
        if (!is_array($arr)) {
            return false;
        }
        foreach ($arr as $k => $v) {
            $arr[$k]['demand'] = json_decode($v['demand'], 1);
            if(isset($arr[$k]['demand']['多个场地名称']) && !empty($arr[$k]['demand']['多个场地名称'])){
                $arr[$k]['demand']['多个场地名称'] = explode(',',$arr[$k]['demand']['多个场地名称']);
            }
            /**
             *
             * 创建时间加 20 分钟  是客户用来处理这单的时间
             *
             */
            $delay_time = 0;
            if (!empty($v['delay_time'])) {
                $delay_time = $v['delay_time'] - time();
                $delay_time = $delay_time > 0 ? $delay_time : 0;
            }
            $arr[$k]['end_time'] = ($v['create_time'] + 1200 + $delay_time) - time();

            $arr[$k]['response'] = empty($v['resolve_time']) ? Func_Time::timeDistance($v['create_time'],
                $v['refuse_time']) : Func_Time::timeDistance($v['create_time'], $v['resolve_time']);
            if (!empty($v['resolve_time'])) {
                $when_long = $v['resolve_time'] - $v['create_time'];
                if ($when_long > 0) {

                    $arr[$k]['response_when'] = $when_long / 60;
//                    q($arr[$k]['response_when']);
                }

            }
            $account_ids[] = $v['account_id'];
            if (!empty($v['demand_reason'])) {
                $arr[$k]['demand_reason'] = json_decode($v['demand_reason'], 1);
            }
            if (!empty($v['mark_tags'])) {
                $arr[$k]['mark_tags'] = Data_Mysql_Table_Demand::handleConvertMarkTags(array('mark_tags' => $v['mark_tags']));
            }
            $arr[$k]['source'] = Data_Mysql_Table_Demand::handleSource(array('referer_url' => $v['referer']));

        }
        //获取账户信息
        if (!empty($account_ids)) {
            $conditions = array("id IN (" . implode(',', $account_ids) . ") ");
            $userInfo = Data_Mysql_Table_Account::select('username,id', $conditions, '', 200);
            if ($userInfo) {
                foreach ($userInfo as $key => $value) {
                    foreach ($arr as $k => $v) {
                        if ($value['id'] == $v['account_id']) {
                            $arr[$k]['username'] = $value['username'];
                        }
                    }
                }
            }
        }
        return $arr;
    }

    //转为测试
    static function handleDemandOffer()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));

        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        $condition = array('id' => $request['id']);
        $data = array(
            'demand_status' => 5,
        );
        $rs = Data_Mysql_Table_Demand::update($condition, $data);
        if ($rs[0] > 0) {
            $account = Data_Mysql_Table_Demand::select('account_id', array('id =?' => $request['id']));
            Data_Mysql_Table_Account_Log::insertAccountLog($account[0]['account_id'], $_SESSION['administrator']['id'],
                '转为测试', '转为测试', $request['id']);

            Func_Output::json('success', '', '  转为测试成功');
        }
        Func_Output::json('error', '', '转为测试失败');

    }

    static function handleDemandBackout()
    {
        Core::output('');
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));

        if (empty($request['id'])) {
            Func_Header::notFound();
        }
        $condition = array('id' => $request['id']);
        $data = array(
            'demand_status' => 0,
        );

        $rs = Data_Mysql_Table_Demand::update($condition, $data);
        if ($rs[0] > 0) {
            $account = Data_Mysql_Table_Demand::select('account_id', array('id =?' => $request['id']));
            Data_Mysql_Table_Account_Log::insertAccountLog($account[0]['account_id'], $_SESSION['administrator']['id'],
                '撤销测试', '撤销测试', $request['id']);
            Func_Output::json('success', '', '  撤销成功');
        }
        Func_Output::json('error', '', '撤销失败！');

    }
}