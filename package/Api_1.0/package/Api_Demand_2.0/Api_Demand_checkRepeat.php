<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/12/30
 * Time: 14:38
 *
 * 在客服接受之后触发
 *
 * 重复判断
 * 1.需求创建判断  1小时内的需求单 标记为 重复
 * 2.需求创建时间大于1 天，将此单分配给 正在受理 此单的销售
 * 3.需求订单状态为关闭  的  此需求需要重新分配
 */
class Api_Demand_checkRepeat extends Api
{
    /**
     * @param $args
     * @return array
     * 只能检查最近一条记录 ，针对同一城市
     *  没有重复的  返回true   处理成功之后返回false
     */
    static function checkRepeat($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone',
        ), $args);
        if (empty($request['phone'])) {
            return Api::request('error', '', '手机号不正确');
        }
        $where["t1.phone=? AND t1.demand_status =?"] = array($request['phone'], 0);
        $table = "{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id = t2.id";
        $data = Data_Mysql_Table_Demand::select('t1.id,t1.demand_status,t1.city,t1.create_time,t2.id as g_id,t2.status,t2.step', $where, ' ORDER BY t1.create_time DESC', 2, $table);
        $newId = @$data[0]['id'];    //最后一次提交的需求ID
        //如果存在相近的需求单
        if (!empty($data[1]['id'])) {
            //如果是不同城市
            if ($data[0]['city'] != $data[1]['city']) {
                return Api::request('success', '', '不是同一城市，可以进入抢单！');
            }

            $result = $data[0]['create_time'] - $data[1]['create_time'];
            //如果是一小时内, 标记成重复，关闭订单

            if ($result <= 3600) {

                Data_Mysql_Table_Demand::handleAddMarkTags(array(
                    'demand_id' => $newId,
                    'mark_id' => 20,
                ));

                $ss = Data_Mysql_Table_Demand::update(array('id=?' => array($newId)), array(
                    'demand_status' => -3,
                    'demand_reason' => '系统认为此单是重读单！'
                ));
                q($ss);

                Api_Demand_Notice_V2::servicesNotice_systemHandle(array('demand_id' => $newId, 'type' => 'tags'));

                return Api::request('error', '', '  重复单，已标记！');

            }
            //通知领导 TODO：：
            //如果这单已经有销售在处理了，就直接分配给销售
            if (!empty($data[1]['g_id']) && !empty($data[1]['sale_phone']) && ($data[1]['step'] != 100 && $data[1]['step'] > -1) && ($data[1]['sale_phone'] > 10)) {

                Data_Mysql_Table_Account_Log::insertAccountLog('-10', '', '【系统】处理重复单', '将id=' . $newId . '分给' . $data[1]['sale_phone'], $newId);

                Api_Grab_Order_Allot::handleAllot(array(
                    'demand_id' => $newId,
                    'sale_phone' => $data[1]['sale_phone'],
                ));
                return Api::request('error', '', '  已分配给，最近联系客户的销售');

            }

        }
        return Api::request('success', '', '可以进入抢单');


    }

} 