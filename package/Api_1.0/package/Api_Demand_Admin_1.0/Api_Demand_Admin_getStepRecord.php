<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/11
 * Time: 13:25
 * 1.获取需求的进度记录
 */
class Api_Demand_Admin_getStepRecord extends Api
{
    /*
     * @param $args =>array(
     *              'demand_id'=>''           //需求ID
     *               'step' =>''    //int       // 进度
     *               'num' =>20     //int
     * )
     */
    static function  getRecord($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int',
            'step' => 'int',
            'num' => 'int',
        ), $args);
        if (empty($request['demand_id'])) {
            return false;
        }
        $num = 20;
        if (!empty($request['num'])) {
            $num = $request['num'];
        }
        $conditions['demand_id =?'] = $request['demand_id'];

        $data = Data_Mysql_Table_Demand_Step_Record::select('*', $conditions, '', $num);

        if (!empty($data[0])) {
            foreach($data as $k=>$v){
                $data[$k]['create_time'] = date('Y-m-d H:i:s',$v['create_time']);
            }
            return $data;
        }

        return false;

    }

}