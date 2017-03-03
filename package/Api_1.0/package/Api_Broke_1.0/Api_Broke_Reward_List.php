<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/8/19
 * Time: 15:00
 */
class Api_Broke_Reward_List extends Api
{
    /**
     *     后台爆料奖励
     *
     *    $args =array(
     *          'broke_time'=>'string'  // 月份
     * )
     */
    static function rewardList($args)
    {
        $conditions = array();
        if (!empty($args['search'])) {
            $request = Func_Input::filter(
                array(
                    'broke_time' => 'string',
                    'type'=>'string'
                ), $args['search']);
        }
        // 时间搜索
        if (empty($args['search']['broke_time'])) {
            $request['broke_time'] = date('Y-m', time());
        }
        // 获取 月份
        $dateTime = Api_Broke_ListPreview::getMonth($request['broke_time']);
        $conditions['{table}.create_time between ? and ? '] = array($dateTime['month_start_day'], $dateTime['month_end_day']);
        $conditions['{table}.demand_type =?'] = '活动爆料';
        $conditions['{table}.submit_person_account_id != ?'] =0;
        if(empty($request['type']) || $request['type']=='done'){
            $conditions['{table}.demand_status !=? and {table}.demand_status !=?'] = array(0, -1);
        }else{
            $conditions['({table}.demand_status =? or {table}.demand_status =?)'] = array(0, -1);
        }
        $cols = 'count({table}.submit_person_account_id) as sumBroke,{table}.submit_person_account_id,{table}.submit_person,{prefix}account_wechat.user_info';
        $group = 'GROUP BY submit_person_account_id';
        $res = Data_Mysql_Table_Demand::select($cols, $conditions, $group, '9999', '{table} LEFT JOIN {prefix}account_wechat ON {table}.submit_person_account_id = {prefix}account_wechat.account_id');
        if (!empty($res)) {
            if (!empty($res)) {
                foreach ($res as $k => $v) {
                    $res[$k]['user_info'] = json_decode($v['user_info'], 1);
                    $res[$k]['reward'] = self::getReward($res[$k]['sumBroke']);
                }
            }
            return self::request('success', $res, '');
        }
        return self::request('error', '', '暂无爆料奖励数据！');
    }

    // 奖励金额计算
    static function getReward($data)
    {
        $reward = 0;
        if ($data >= 0 && $data <= 10) {
            $reward = $data * 10;
        } elseif ($data > 10 && $data <= 30) {
            $reward = $data * 15;
        } elseif ($data > 30 && $data <= 60) {
            $reward = $data * 20;
        } elseif ($data > 60 && $data <= 100) {
            $reward = $data * 25;
        } elseif ($data > 100) {
            $reward = $data * 50;
        }
        return $reward;
    }

    //下载表格
    static function exportData($args)
    {
        $request = Func_Input::filter(
            array(
                'action' => 'string',
                'search' => 'array'
            ), $args);

        $data = self::rewardList($request);
        if (!empty($data['data'])) {
            $cols = array('爆料人', '联系方式', '爆料总数', '奖励金额', '时间');
            $list = array();
            foreach ($data['data'] as $k => $v) {
                $list[$k][] = $v['user_info']['nickname'];
                $list[$k][] = $v['submit_person'];
                if($request['search']['type']=='other'){
                    $list[$k][] =  '0 条';
                    $list[$k][] =  '0 元';
                }else{
                    $list[$k][] = $v['sumBroke'] . '条';
                    $list[$k][] = $v['reward'] . '元';
                }

                $list[$k][] = $request['search']['broke_time'];
            }
            $res = Func_Csv::writeRow($cols, $list, $request['search']['broke_time'] . '  爆料奖励名单');
            return self::request('success', $res, '');
        } else {
            return self::request('error', '', '没有数据');
        }

    }
}