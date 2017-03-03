<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/14
 * Time: 10:58
 * 抢单
 */
class Api_Grab_Order_Create extends Api
{

    /**
     * @param $args
     * @return array
     * 创建，
     */
    static function  create($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',    //需求ID
        ), $args);
        if (empty($request['demand_id'])) {
            return Api::request('error', '', '缺少需求ID啊');
        }
        $data = Data_Mysql_Table_Demand::select('city,demand_type,demand,demand_name,id,phone,account_id',
            array('id =?' => $request['demand_id'], 'demand_status >=?' => 0));
        if (empty($data[0]['id'])) {
            return Api::request('error', '', '您提交的需求不符合条件，不能进入抢单系统~');
        }

        $insert = $data[0];
        $insert['demand'] = json_decode($data[0]['demand'], 1);
        $insert['demand']['活动名称'] = $insert['demand_name'];

        $conditions[] = "backup_demand IS NULL AND id = " . $request['demand_id'];
        $integral = Data_Mysql_Table_Integral_Record::handlePriceIntegral(intval(@$insert['demand']['price_up']),intval(@$insert['demand']['price_down']));

        $demand_status = Data_Mysql_Table_Demand::update($conditions, array(
            'backup_demand' => $insert['demand'],
            'demand_status' => 1,
            'resolve_time' => time(),
            'integral' => $integral,                     // 积分,
        ));
        if (empty($demand_status[0])) {
            return Api::request('error', '', '此需求单不符合抢单条件无法进入抢单系统！');
        }
        //文创不让进抢单
        if (!empty($insert['demand_type']) && $insert['demand_type'] == '文创项目合作') {

            $grab_order = array('id' => $insert['id'], 'customer_phone' => $insert['phone'], 'status' => 1);
            $is_win = true;
        } else {
            $grab_order = array('id' => $insert['id'], 'customer_phone' => $insert['phone']);
        }

        $id = self::handleInsert($grab_order);

        if ($id['status'] == 0) {

            return Api::request('error', '', '进入抢单系统失败');

        } else {
            if (isset($is_win)) {
                Api_Demand_Notice_V2::saleGroupWinChance(array('id' => $insert['id']));

                return Api::request('success', '文创项目合作', '  已经通知文创组！');
            }
            return Api::request('success', '', '  成功');
        }
    }

    /**
     * @param $args
     * @return array
     * 处理插入，不处理通知
     */
    static function  handleInsert($args)
    {
        $insert = Func_Input::filter(array(
            'id' => 'int',
            'customer_phone' => 'phone',
            'sale_phone' => 'phone',
            'status' => 'int',
        ), $args);
        if (empty($insert['id']) || empty($insert['customer_phone'])) {

            return Api::request('error', '', '参数不正确！');

        }
        $grab = array(
            'id' => $insert['id'],
            'customer_phone' => $insert['customer_phone'],
            'create_time' => time(),
        );
        if (!empty($insert['sale_phone'])) {
            $grab['sale_phone'] = $insert['sale_phone'];
        }

        if (!empty($insert['status'])) {
            $grab['status'] = $insert['status'];
        }
        $status = Data_Mysql_Table_Grab_Order::insert($grab);
        if ($status[0] > 0) {
            return Api::request('success', $status[0], '新建成功,记得去更新下进度哦。');
        }
        return Api::request('error', '', '没有创建成功！');
    }

    /**
     * @param $args
     * @return array
     * 回复数据到初始
     */
    static function recovery($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'phone' => 'phone',
        ), $args);

        $conditions[] = 't1.sale_phone=' . $request['phone'] . " AND t1.id=" . $request['id'];
        $isTRUE = Data_Mysql_Table_Grab_Order::select('t1.sale_phone,t2.*', $conditions, '', 1,
            "{table} as t1 LEFT JOIN {prefix}demand as t2 ON t1.id = t2.id");
        if (empty($isTRUE['0'])) {
            return Api::request('error', '', '信息不对称~没有找到这个订单');
        }
        //TODO::

    }


} 