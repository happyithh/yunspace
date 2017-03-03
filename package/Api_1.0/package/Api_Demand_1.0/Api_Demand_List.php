<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/27
 * Time: 16:15
 *
 * 需求列表
 */
class Api_Demand_List extends Api
{
    /**
     * @传入参数  $args = array(
     *              account_id =>[Api_Session::user_id()],
     *              type =>'',          // 1进行中    2是已完成    -1删除的
     *              last_id=>''         //用于分页
     *
     * )
     *返回值 array()
     *
     *
     */
    static function  handle($args = '')
    {
        $args['account_id'] = Api_Session::user_id();
        return self::getList($args);


    }

    static function  getList($args)
    {
        $request = Func_Input::filter(array(
            'account_id' => 'int',
            'type' => 'int',
            'last_id' => 'int'
        ), $args);
        if (empty($request['account_id'])) {
            return Api::request('error', '', '缺少参数');
        }
        $conditions['(account_id =? OR response_account_id=?)'] = array($request['account_id'], $request['account_id']);
        switch ($request['type']) {
            case '-1':
                $conditions['step < ?'] = 0;
                break;
            case 2:
                $conditions['step =?'] = 100;
                break;
            default:
                $conditions['step  >=? AND step <=?'] = array(0, 100);
                break;
        }
        if (!empty($request['last_id'])) {
            $conditions['id <?'] = $request['last_id'];
        }
        $conditions['demand_name !=?'] = '';
        $data = Data_Mysql_Table_Demand::select('SQL_CALC_FOUND_ROWS id,demand_name,demand,demand_type,step,create_time,response_account_id=' .
            $request['account_id'] . ' as is_sale', $conditions, 'ORDER BY create_time DESC', 15);
        if (empty($data[0])) {
            return Api::request('error', '', '没有更多数据');
        }
//        foreach ($data as $k => $val) {
//            if (empty($val['demand_name'])) {
//                $data[$k]['demand_name'] = Date('Y-m-d') . '-新需求 -' . $val['demand_type'];
//            }
//        }
        return Api::request('success', self::monthGroup($data), '获取成功');

    }


    static function  monthGroup($data, $cole_time = 'create_time')
    {
        if (!is_array($data)) {
            return false;
        }
        $data_group = array();
        $month_array = array();

        foreach ($data as $key => $val) {
            $month = date('n', $val[$cole_time]);
            $month_array[] = $month;
        };

        $month = array_flip($month_array);

        foreach ($data as $k => $val) {
            $m = date('n', $val[$cole_time]);
            if (isset($month[$m])) {
                $data_group[$m][] = $val;
            } else {
                $data_group['#'][] = $val;
            }
        }

        return $data_group;
    }
}
