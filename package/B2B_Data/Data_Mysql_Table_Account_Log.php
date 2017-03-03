<?php

class Data_Mysql_Table_Account_Log extends Data_Mysql_Table
{
    public $cols = array(
        'account_id' => 'int',
        'admin_id' => 'int',
        'operate_type' => '50',
        'operate_message' => 'text',
        'object_id' => 'int',
        'create_time' => 'int',
    );
    public $index = array(
        'account_id' => 'i',
        'admin_id,operate_type' => 'i',
        'object_id' => 'i',
        'operate_message' => 'i',
    );
    public $title = array(
        'account_id' => '账户ID',
        'admin_id' => '操作者ID',
        'operate_type' => '操作类型',
        'operate_message' => '操作信息',
        'object_id' => '操作对象ID',
        'create_time' => '时间'
    );

    //创建该账户的操作日志
    static function insertAccountLog($account_id, $admin_id = '', $operate_message = '更新账户信息', $operate_type = '更新', $object_id = 0)
    {
        if (empty($account_id)) {
            $account_id = 0;
        }
        if (empty($admin_id)) {
            $admin_id = 0;
        }
        $log_data = array('account_id' => $account_id, 'admin_id' => $admin_id, 'operate_message' => $operate_message, 'operate_type' => $operate_type, 'object_id' => $object_id, 'create_time' => time());
        //获取当前月份
        $month = date('Ym', time());
        $rs = Data_Mysql_Table_Account_Log::subTable('_' . $month)->insert($log_data);

    }

    /**
     * @param $args
     * @return bool
     * 查询 所有
     */

    static function selectAll($args)
    {

        $request = Func_Input::filter(array(
            'dateYM' => 'array',
            'object_id' => 'int',
            'admin_id' => 'int',
            'account_id' => 'int',
            'start_time' => 'int',
            'end_time' => 'int',
            'operate_type' => 'string'
        ), $args);
        if (empty($request['dateYM'])) {
            return false;
        }
        $conditions = 1;
        if (!empty($request['object_id'])) {
            $conditions = $conditions . " AND object_id =" . $request['object_id'];
        }
        if (!empty($request['admin_id'])) {
            $conditions = $conditions . " AND admin_id =" . $request['admin_id'];
        }
        if (!empty($request['start_time'])) {
            $conditions = $conditions . " AND create_time >=" . $request['start_time'];
        }
        if (!empty($request['end_time'])) {
            $conditions = $conditions . " AND create_time <=" . $request['end_time'];
        }
        if (!empty($request['operate_type'])) {
            $conditions = $conditions . " AND operate_type = '" . $request['operate_type'] . "'";
        }

        $table = array();
        foreach ($request['dateYM'] as $val) {

            $table[] = 'yun_account_log_' . $val;
        }
        $union = "(SELECT * FROM " . $table[0] . ") ";
        for ($i = 1; $i < count($request['dateYM']); $i++) {

            $union = $union . " union ( SELECT * FROM " . $table[$i] . ") ";
        }
//        q("SELECT * FROM (" . $union . " ) t  WHERE " . $conditions);
        $data = self::query("SELECT * FROM (" . $union . " ) t  WHERE " . $conditions, '', 1);
        return $data;
    }

}