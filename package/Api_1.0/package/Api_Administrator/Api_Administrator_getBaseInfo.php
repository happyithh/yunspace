<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 15/8/20
 * Time: 15:09
 */
class Api_Administrator_getBaseInfo extends Api
{
    /**
     * @param $args =>array(
     *      'admin_id'=>''
     *
     * )
     * @return bool
     *
     *
     */
    static $template = array();

    static function getAdminInfo($args)
    {
        $request = Func_Input::filter(array(
            'admin_id' => 'int'
        ), $args);
        if (empty($request['admin_id'])) {
            return false;
        }
        if (!empty(self::$template[$request['admin_id']])) {
            return self::$template[$request['admin_id']];
        }
        $table = "{table} as t1 RIGHT join {prefix}department_member  as t2 on t1.id = t2.admin_id";
        $cols = "t1.fullname,t1.email,t1.username,t1.phone,t1.update_time,t1.status,t2.department_name,t2.team_name,t2.data,t2.position,t2.city";
        $conditions['t1.id =?'] = $request['admin_id'];
        $data = Data_Mysql_Table_Administrator::select($cols, $conditions, '', 1, $table);
        return self::$template[$request['admin_id']] = !empty($data[0])?$data[0]:'';

    }

    static function getAdminInfoByPhone($args)
    {
        $request = Func_Input::filter(array(
            'phone' => 'phone'
        ), $args);
        if (empty($request['phone'])) {
            return false;
        }
        $table = "{table} as t1 LEFT join {prefix}department_member  as t2 ON t1.id = t2.admin_id";
        $cols = "t1.fullname,t1.email,t1.username,t1.phone,t1.update_time,t1.status,t2.department_name,t2.team_name,t2.data,t2.position,t2.city";
        $conditions['t1.phone =?'] = $request['phone'];
        $data = Data_Mysql_Table_Administrator::select($cols, $conditions, '', 1, $table);

        if (!empty($data[0])) {
            return $data[0];
        }
        return false;
    }
}

