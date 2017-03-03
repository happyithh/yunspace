<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/15
 * Time: 11:01
 */
class Api_Grab_Order_Update_Step_Record extends Api
{


    static function  handle($args = '')
    {
        Api_Session::checkToken(1);
        return self::handleStep($args);
    }

    /**
     * @param $args
     * @return array
     * 处理进度
     */
    static function  handleStep($args)
    {
        @session_start();
        $request = Func_Input::filter(array(
            'id' => 'int',
            'step' => 'int',
            'content' => 'string',
        ), $args);
        if (empty($request['id']) || empty($request['step'])) {
            return Api::request('error', '', '请刷新后重试~');
        }
        if (empty($request['content'])) {
            return Api::request('error', '', '请输入内容');
        }
        $order = Api_Grab_Order_Get_Info::getInfo(array('id' => $request['id'], 'phone' => $_SESSION['user']['phone']));
        if (empty($order['data'])) {
            return Api::request('error', '', '没有找到数据信息~');
        }
        if (($order['data']['step'] > $request['step']) && $request['step'] > 0) {
            return Api::request('error', '', '不能小于当前进度哦~');
        }
        $step = Data_Mysql_Table_Grab_Order::update(array('id=?' => $request['id']), array('step' => $request['step']));

        if (empty($step[0])) {
            return Api::request('error', '', '操作失败了');
        }


        $data = $order['data'];
        $admin = Api_Administrator_GetBaseAccountInfo::getBastAccountInfoByPhone(array('phone' => $_SESSION['user']['phone']));
//        $record = array(
//            'phone' => $data['customer_phone'],
//            'demand_id' => $data['id'],
//            'admin_id' => $admin['admin_id'],
//            'admin_name' => $admin['username'],
//            'content' => $request['content'],
//            'step' => $request['step'],
//            'time' => time(),
//        );

        $record = array(
            'demand_id' => $request['id'],
            'step' => $request['step'],
            'admin_id' => $admin['admin_id'],
            'reason' => $request['content']
        );
        //处理积分
        $step_integral = Data_Mysql_Table_Demand::$step_integral;
        if (isset($step_integral[$request['step']])) {
            if ($request['step'] == 100) {
                $integral = $order['data']['integral'] * 7;
            } else {
                $integral = $step_integral[$request['step']];

            }
            $log = Api_Administrator_Integral_Manage::integralManages(array(
                'phone' => $_SESSION['user']['phone'],
                'type' => 'add',
                'reason' => '更新订单进度.ID=' . $request['id'],
                'title' => '更新订单进度',
                'integral' => $integral,
            ));
        } elseif ($request['step'] < 0 && ($order['data']['integral'] > 0)) {
            //如没有联系 就扣分
            if (($order['data']['step'] == 0 && empty($request['content'])) ||
                $order['data']['demand_type'] == '销售创建'
            ) {
                //如果是关闭
                if ($order['data']['demand_type'] == '销售创建') {
                    $number = $order['data']['integral'];

                } else {
                    $number = ($order['data']['integral'] * 2);

                }

                $log = Api_Administrator_Integral_Manage::integralManages(array(
                    'phone' => $_SESSION['user']['phone'],
                    'type' => 'reduce',
                    'reason' => '更新订单进度.ID=' . $request['id'],
                    'title' => '关闭订单',
                    'integral' => $number,
                ));

            } else {
                //2016 3 2  关闭将扣减的积分还回去
                $log = Api_Administrator_Integral_Manage::integralManages(array(
                    'phone' => $_SESSION['user']['phone'],
                    'type' => 'add',
                    'reason' => '更新订单进度.ID=' . $request['id'],
                    'title' => '更新订单进度',
                    'integral' => $order['data']['integral'],
                ));

            }
        }

//        Data_Mysql_Table_Contact_Record::insert($record);
        $a = Data_Mysql_Table_Demand_Step_Record::insert($record);
        return Api::request('success', '', '成功');
    }
}