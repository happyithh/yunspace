<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/4/15
 * Time: 11:19
 */
// 获取线上数据
//Data_Mysql_Table_Winchance_Site::rebuildIndex();
$conditions ['t1.demand_type =?'] = '文创项目合作';
$conditions ['t1.demand_status =?'] = 1;
$table ='{table} as t1 LEFT JOIN {prefix}grab_order as t2 ON t1.id=t2.id LEFT JOIN {prefix}administrator as t3 ON t2.sale_phone = t3.phone';
$onlineWin = Data_Mysql_Table_Demand::select('t1.id,t1.city,t1.demand,t1.create_time,t3.username', $conditions,'ORDER BY t1.create_time DESC',99999,$table);
if (!empty($onlineWin)) {
    foreach ($onlineWin as $k => $v) {
        $data['city'] = $v['city'];
        if (!empty($v['demand'])) {
            $demand = json_decode($v['demand'], 1);
            if (isset($demand['场地名称'])) {
                $data['site_name'] = $demand['场地名称'];
            }
            if (isset($demand['需求类型'])) {
                unset($demand['需求类型']);
            }
            $data['des'][0] = '';
            if (isset($demand['联系人'])) {
                $data['des'][0] = '联系人：' . $demand['联系人'] . '；';
            }
            if (isset($demand['联系电话'])) {
                $data['des'][0] = $data['des'][0] . '   联系电话：' . $demand['联系电话'] . '；';
            }
            if (isset($demand['活动类型'])) {
                $data['des'][0] = $data['des'][0] . '   活动类型：' . $demand['活动类型'] . '；';
            }
            if (isset($demand['活动人数'])) {
                $data['des'][0] = $data['des'][0] . '   活动人数：' . $demand['活动人数'] . '；';
            }
            if (isset($demand['具体要求'])) {
                $data['des'][0] = $data['des'][0] . '   具体要求：' . $demand['具体要求'];
            }
        }
        $data['entry_type'] = 1;
        $data['operator'] = $v['username'];
        $data['create_time'] = $v['create_time'];
        $data['update_time'] = time();
        $res = Data_Mysql_Table_Winchance_Site::update(array('demand_id'=>$v['id']),$data);
//        q($res,empty($res[0]));
        if(empty($res[0])){
//            q($res,23673);
            $data['demand_id'] = $v['id'];
            Data_Mysql_Table_Winchance_Site::insert($data);
        }

    }
}