<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15/12/23
 * Time: 15:09
 * @获取城市 的销售
 */
class Api_Administrator_SalePeopleByCity extends Api
{


    static function getSaleAllByCity($args)
    {
        $request = Func_Input::filter(array(
            'city' => 'string',
        ), $args);
        if (empty($request['city'])) {
            return false;
        }
        $conditions[] = 't1.city  = "' . $request['city'] . '"';
        $conditions[] = "t1.department_name = '销售部' AND t2.status = 1 AND t4.openid !=''";
        $table = '{table} as t1 LEFT JOIN {prefix}administrator as t2 ON t1.admin_id = t2.id LEFT JOIN {prefix}account as t3 ON t2.phone = t3.phone LEFT JOIN {prefix}account_wechat_sale as t4 ON t4.account_id = t3.id ';
//        Data_Mysql_Table_Department_Member::debug(1);
        $rs = Data_Mysql_Table_Department_Member::select('t2.phone,t2.email, t2.fullname,t4. account_id,t4.openid', $conditions, 'GROUP BY t2.id', 200, $table);

        if (empty($rs[0])) {
            return false;
        }
        shuffle($rs);
        return $rs;

    }

    static function getSaleLeaderByCity($args)
    {
        $request = Func_Input::filter(array(
            'city' => 'string',
        ), $args);
        if (empty($request['city'])) {
            return false;
        }
        $conditions[] = 't1.city  = "' . $request['city'] . '" AND t1.level > 0';
        $conditions[] = "t1.department_name = '销售部' AND t2.status = 1 AND t4.openid !=''";
        $table = '{table} as t1 LEFT JOIN {prefix}administrator as t2 ON t1.admin_id = t2.id LEFT JOIN {prefix}account as t3 ON t2.phone = t3.phone LEFT JOIN {prefix}account_wechat_sale as t4 ON t4.account_id = t3.id ';
        $rs = Data_Mysql_Table_Department_Member::select('t2.phone,t2.email, t2.fullname,t4. account_id,t4.openid', $conditions, 'GROUP BY t2.id', 999, $table);
        if (empty($rs[0])) {
            return false;
        }
        return $rs;

    }

}

