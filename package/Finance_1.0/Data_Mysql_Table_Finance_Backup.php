<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/3/19
 * Time: 10:37
 */
class Data_Mysql_Table_Finance_Backup extends Data_Mysql_Table
{
    public $cols = array(
        'table_name' => '20',
        'object_id' => 'int',
        'sign' => '32',
        'data' => 'array',
        'create_time' => 'int',
    );
    public $index = array(
        'table_name,object_id' => 'i',                                                    //p:主键, u:唯一索引, i:索引
        'create_time' => 'i'
    );
    public $title = array(
        "" => "备份",                                                     //空键,表名
        'table_name' => '表名',
        'object_id' => '编号',
    );

    static function backup($tableName, $objectId, $data)
    {
        self::subTable(date('_Ym'))->insert(array(
            'table_name' => $tableName,
            'object_id' => $objectId,
            'sign' => md5(json_encode($data)),
            'data' => $data,
            'create_time' => time(),
        ));
    }
}