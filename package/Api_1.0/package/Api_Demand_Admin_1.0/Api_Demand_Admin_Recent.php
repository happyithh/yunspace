<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/20
 * Time: 16:45
 * @获取最近一条需求记录
 */
class Api_Demand_Admin_Recent extends Api
{

    /**
     * @param $args =array(
     *      'phone'=>'',
     *      'demand_id'=>'',
     *
     * )
     * @return bool
     */
    static function getRecent($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'string',
            'demand_id' => 'int',
            'num' => 'int',
        ), $args);

        if (empty($request['phone']) && empty($request['demand_id'])) {
            return false;
        }
        if (!empty($request['phone'])) {
            $conditions['phone=?'] = $request['phone'];
        }
        if (!empty($request['demand_id'])) {
            $conditions['id !=?'] = $request['demand_id'];
        }
        if (empty($conditions)) {
            return false;
        }
        if (empty($request['num'])) {
            $num = 1;
        } else {
            $num = $request['num'];
        }
        //$conditions['admin_id !=?']=0;
        $conditions['demand_status >=?']=0;
        $recent = Data_Mysql_Table_Demand::select('*', $conditions, 'ORDER BY create_time DESC', $num);
        if (!empty($recent[0])) {

            foreach ($recent as $k => $val) {
                $recent[$k]['demand'] = json_decode($val['demand'], 1);
                $recent[$k]['person_liable'] = Api_Administrator_GetBaseInfo::getAdminInfo(array('admin_id' => $val['admin_id']));
            }
            return $recent;
        }
        return false;

    }
}