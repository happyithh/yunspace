<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/4/15
 * Time: 10:36
 * 添加文创线上数据
 */
class Api_Winchance_Online_Site_Create extends Api
{
    static function WinchanceSiteCreate($demand_id)
    {
        $conditions['t1.id = ?'] = $demand_id;
        $conditions['t1.demand_status = ?'] = 1;
        $damand = Data_Mysql_Table_Demand::select('t1.city,t1.demand,t1.create_time,t3.username', $conditions, '', 1, '{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id=t2.id LEFT JOIN {prefix}administrator as t3 ON t2.sale_phone = t3.phone');
        if (!empty($damand[0])) {
            $data['city'] = $damand[0]['city'];
            if (!empty($damand[0]['demand'])) {
                $damand[0]['demand'] = json_decode($damand[0]['demand'], 1);
                if (isset($damand[0]['demand']['场地名称'])) {
                    $data['site_name'] = $damand[0]['demand']['场地名称'];
                }
                if (isset($damand[0]['demand']['需求类型'])) {
                    unset($damand[0]['demand']['需求类型']);
                }
                $data['des'][0] = '';
                if (isset($damand[0]['demand']['联系人'])) {
                    $data['des'][0] = '联系人：' . $damand[0]['demand']['联系人'] . '；';
                }
                if (isset($damand[0]['demand']['联系电话'])) {
                    $data['des'][0] = $data['des'][0] . '   联系电话：' . $damand[0]['demand']['联系电话'] . '；';
                }
                if (isset($damand[0]['demand']['活动类型'])) {
                    $data['des'][0] = $data['des'][0] . '   活动类型：' . $damand[0]['demand']['活动类型'] . '；';
                }
                if (isset($damand[0]['demand']['活动人数'])) {
                    $data['des'][0] = $data['des'][0] . '   活动人数：' . $damand[0]['demand']['活动人数'] . '；';
                }
                if (isset($damand[0]['demand']['具体要求'])) {
                    $data['des'][0] = $data['des'][0] . '   具体要求：' . $damand[0]['demand']['具体要求'];
                }
            }
            $data['entry_type'] = 1;
            $data['operator'] = $damand[0]['username'];
            $data['create_time'] = $damand[0]['create_time'];
            $data['update_time'] = time();
            $res = Data_Mysql_Table_Winchance_Site::update(array('demand_id' => $demand_id), $data);
            if (empty($res[0])) {
                $data['demand_id'] = $demand_id;
                Data_Mysql_Table_Winchance_Site::insert($data);
            }
        }
    }
}