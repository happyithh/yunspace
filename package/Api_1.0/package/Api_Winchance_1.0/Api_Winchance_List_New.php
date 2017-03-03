<?php

/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/10/12
 * Time: 15:27
 */

class Api_Winchance_List_New extends Api
{
    static function handle($args = '')
    {

        $result = self::handleGetList($args);
        return $result;
    }


    static function handleGetList($args)
    {
        $request = Func_Input::filter(array(
            'num' => 'int',
            'create_time' => 'int',
        ), $args);

        $conditions['status =?'] = 1;

        //调用的文创时间不能大于当前时间
        if (empty($request['create_time'])) {
            $conditions['{table}.create_time < ?'] = time();
        }
        //加载更多的列表传过来的时间
        if (!empty($request['create_time'])) {
            $conditions['{table}.create_time < ?'] = $request['create_time'];
        }
        if (empty($request['num'])) {
            $request['num'] = 5;
        }
        $rs = self::getData(array(
            'conditions' => $conditions,
            'num' => $request['num'],
        ));
        if (!empty($rs[0])) {
            Tpl_Smarty::assign('winchance_list', $rs);
            $tpl = Tpl_Smarty::fetch('Web_Mobile_Static::winchance.v2.0/inc_list.tpl');
            $result = self::request('success', $tpl, '成功');
        } else {
            $result = self::request('error', '', '失败');
        }
        return $result;

    }

    static function  getData($args)
    {
        $request = Func_Input::filter(array(
            'conditions' => "array",
            'num' => 'int',
        ), $args);
        $order = 'ORDER BY {table}.create_time desc';
        if (empty($request['conditions'])) {
            $request['conditions']['status =?'] = 1;
        }
        $rs = Data_Mysql_Table_Winchance::select('*', $request['conditions'], $order, $request['num']);

        if (empty($rs[0])) {
            return false;
        }
        foreach ($rs as $key => $val) {
            $rs[$key]['media'] = json_decode($val['media'], 1);
            $rs[$key]['tags_info'] = json_decode($val['tags_info'], 1);
            $rs[$key]['tags_info'][0] = explode(',',$rs[$key]['tags_info'][0]);
            $rs[$key]['accessory'] = json_decode($val['accessory'], 1);
            $rs[$key]['attr'] = json_decode($val['attr'], 1);
        }
        return $rs;
    }

}