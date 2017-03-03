<?php

/**
 * Created by PhpStorm.
 * User: liushengchun
 * Date: 15/1/28
 * Time: 11:41
 */
class Data_Mysql_Table_StaticLog extends Data_Mysql_Table
{
    public $cols = array(
        'session_id' => '40',         //session_id
        'user_id' => 'int',
        'log' => '200',
        'ip' => '15',
        'layer'=>'int',
        'url' => '200',
        'referer' => '200',
        'create_time' => 'int',
    );
    public $index = array(
////        'static_id' => 'i',
//        'user_id' => 'i',
//        'create_time' => 'i',
    );
    public $title = array(
        '' => '浏览操作日志',
        'static_id' => '对象ID',
        'user_id' => '用户ID',
        'log' => '记录',
        'ip' => 'IP',
        'url' => '页面',
        'referer' => '来源',
        'create_time' => '添加时间',
    );
    public $titleHidden = array( //    list / form / both
    );
    public $filter = array();

    static function log($subTable, $staticId, $userId, $log = '')
    {
        return self::subTable('_' . $subTable . date('_Ym'))->insert(array(
            'static_id' => $staticId,
            'user_id' => $userId,
            'log' => $log,
            'ip' => Func_Input::ip(),
            'referer' => Core::$urls['referer'],
            'create_time' => time(),
        ));
    }
}