<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/7/23
 * Time: 16:15
 *
 */

/**
 * .
 * 1.接收需求
 *
 */
class  Api_Demand_Accept extends Api
{

    static function accept($args)
    {
        $request = Func_Input::filter(array(
            'demand_id' => 'int'
        ), $args);
        if (empty($request['demand_id'])) {
            return false;
        }
        $sql = "UPDATE {table}  SET demand_status =? WHERE id =?";
        $status = Data_Mysql_Table_Demand::query($sql, array(1, $request['demand_id']),
            1);
        if ($status[0] > 0) {
            return true;
        }
        return false;
    }


}