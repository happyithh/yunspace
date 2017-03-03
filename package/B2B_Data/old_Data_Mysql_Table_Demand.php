<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class old_Data_Mysql_Table_Demand extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',
        'demand_type' => '20',  //  办活动 / 整体方案 / 供应商加盟 / 实地看场 / 客户人工服务 / 供应商人工客服 / 订单转发
        'demand_name' => '100',// 活动的名字       默认为空
        'phone' => '15',
        'ip' => '15',
        'city' => '20',
        'session_id' => '100',
        'demand' => 'array',
        'create_time' => 'int',
        'step' => 'int',            //客户进度情况     //分两种情况   1.AE客户项目进展    2.漏斗石销售客户跟进        //-n  为关闭
        'resolve_time' => 'int',    //  受理时间
        'demand_status' => 'tinyint',  //  0未处理  -1 已放弃   5转为测试 其他代表已处理
        'response_account_id' => 'int',   //响应人的id
        'admin_id' => 'int',
        'group_id' => 'int',        //群组ID
        'submit_person' => '15',   //提交人(手机号)
        'submit_person_account_id' => 'int', //提交人账户id
        'demand_reason' => 'array',//拒绝理由
        'update_time' => 'int',
        'price_up' => 'int',          //最低价
        'price_down' => 'int',            //最高价
        'win_id' => 'int',   //其他ID        文创ID
        'mark' => '100',  //标记
        'enter_url' => '100',  //入口页
        'referer' => '100',  //来源
        'refuse_time' => 'int',  //放弃时间

    );
    public $index = array(
        'account_id' => 'i',
        'win_id' => 'i',
        'group_id' => 'i',
        'phone' => 'i',
        'demand' => 'attr',
        'demand_type' => 'i',
        'demand_name' => 'i',
        'demand_status,mark' => 'i',
        'submit_person' => 'i',
        'city' => 'i',
        'step' => 'i',
        'admin_id' => 'i',
        'response_account_id' => 'i',
    );

    public static $_demandType = array(
        0 => '400订单',
        1 => '办活动',
        2 => '整体方案',
        3 => '实地看场',
        4 => '联系供应商',
        6 => '个人订单',
        7 => '预约咨询',
        8 => '订单转发',
        9 => '产品咨询档期',
        10 => '套餐咨询档期',
        11 => '活动爆料',
        12 => '办活动M',
        13 => '文创项目合作',
        14 => '年会咨询',
        15 => '查看参考价',
        16 => '查看参考价M',
    );


//    static function create($type, $demand)
//    {
//        @ session_start();
//        $data = array(
//            'ip' => Func_Input::ip(),
//            'demand' => $demand,
//            'demand_type' => $type,
//            'create_time' => time(),
//            'demand_status' => 0,
//        );
//        $request = Func_Input::filter(
//            array(
//                '联系电话' => 'phone',
//                '联系人' => 'string',
//                '具体要求' => 'string',
//                '活动城市' => 'string',
//                '提交人' => 'string',
//                '咨询内容' => 'string',
//            ), $demand);
//
//        if (empty($request['联系电话']) && !empty($demand['联系电话'])) {
//
//            preg_match_all('/^(0(10|21|22|23|[1-9][0-9]{2})(-|))?[0-9]{7,8}$/', $demand['联系电话'], $tel);
//            if (!empty($tel[0][0])) {
//                $request['联系电话'] = $tel[0][0];
//            } else {
//                return Api::request('error', '', '请输入正确的联系电话!');
//            }
//        }
//        $data['city'] = empty($request['活动城市']) ? $_COOKIE['city'] : $request['活动城市'];
//        $members = array(
//            'account_id' => '',
//            'username' => ''
//        );
//        if (!empty($_SESSION['user'])) {
//
//            $members['account_id'] = $_SESSION['user']['id'];
//            $members['username'] = $_SESSION['user']['username'];
//
//            $data['account_id'] = $_SESSION['user']['id'];
//            $data['phone'] = $_SESSION['user']['phone'];
//        } elseif ($request['联系电话']) {
//            $data['phone'] = $request['联系电话'];
//            $account = Data_Mysql_Table_Account::select('id,username', array('phone=?' => $request['联系电话']));
//            if (!empty($account[0]['id'])) {
//                $members['account_id'] = $account[0]['id'];
//                $members['username'] = $account[0]['username'];
//                $data['account_id'] = $account[0]['id'];
//            }
//
//        } else {
//            return Api::request('error', '', '请输入正确的联系电话!');
//        }
//        if (!empty($request['提交人'])) {
//            $data['submit_person'] = $request['提交人'];
//        }
//        //判断需求是否重复提交(手机号相同，一周之内，活动名称为空)
//        $conditions['phone'] = $data['phone'];
//        $conditions['create_time >= ?'] = time() - 7 * 24 * 3600;
//        $conditions['demand_name'] = '';
//        $conditions['demand_status >=?'] = 0;
//        $is_exist = self::select('id', $conditions);
//        if (!empty($is_exist[0]['id'])) {
//            if ($members['account_id']) {
//                $media = Api_Recommend_MessageMediaFormat::formatSpace($demand);
//                if ($media) {
//                    Api_Livechat_Message_Send::handleSendMessage(array(
//                        'to_account_id' => Data_Mysql_Table_LiveChat_Group::convertToAccountId($is_exist[0]['id']),
//                        'from_account_id' => $members['account_id'],
//                        'media' => $media
//                    ));
//                }
//                Api_Livechat_Message_Send::handleSendMessage(array(
//                    'to_account_id' => Data_Mysql_Table_LiveChat_Group::convertToAccountId($is_exist[0]['id']),
//                    'from_account_id' => $members['account_id'],
//                    'message' => $request['咨询内容']
//                ));
//            }
//            return Api::request('success', '', '您提交的需求已经更新，您可以在最新消息中收到咨询动态。');
//        } else {
//            $r = self::insert($data);
//        }
//
//        if (empty($r[0])) {
//            return Api::request('error', '', '需求创建失败!');
//        } else {
//            if ($type != '套餐档期查询' && $type != '产品档期查询' && $type != '预约咨询') {
//                $group = array(
//                    'demand_id' => $r[0],
//                    'members' => array($members),
//                );
//                Api_Livechat_Group_Create::handleCreate($group);
//            }
//
//            //通知运营部
//            Data_Config_Demand_Notice::sendNotice($r[0], '新需求');
//
//            return Api::request('success', $r[0], '您的需求已成功提交，稍候将有云·Space专业人员为您提供后续服务！');
//
//            //TODO::暂时注释
////            $noticePhone = Data_Config_Demand_Notice::get($type);
////            $testPhone = Data_Config_Demand_Notice::get('测试');
////            $testEmail = Data_Config_Demand_Notice::get('邮件地址');
////
////            if (empty($noticePhone)) {
////                $noticePhone = Data_Config_Demand_Notice::get('默认');
////            }
//////            Web_Message::demandNotice($testPhone, $r[0]);
//////            Web_Message::demandEmail($testEmail, $r[0]);
////            Web_Message::demandNotice($data['phone'], $r[0]);
////            Web_Message::demandNotice($noticePhone, $r[0]);
////            Data_Config_Demand_Notice::sendNotice($r[0], '新需求');
////            return $r[0];
//        }
//    }

    //AE客户项目进展
    static $step_AE = array(
        0 => '准备约谈的客户',
        10 => '沟通中的客户',
        20 => '正在提案中',
        30 => '项目执行中',
        40 => '市场执行中',
        100 => '已完成',
        -1 => '关闭',
    );
    //漏斗石销售客户跟进
    static $step_funnel = array(
        0 => '未沟通-0%',
        10 => '已电话的客户-20%',
        20 => '初步意向的客户-30%',
        30 => '上门拜访客户-50%',
        40 => '强意向客户-75%',
        50 => '商务洽谈客户-80%',
        100 => '成交-100%',
        -1 => '关闭',
//        -2 =>'转至报价系统自动处理'
    );
}

