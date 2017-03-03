<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/5/7
 * Time: 21:05
 * 字段编辑
 */
class Data_Mysql_Table_Winchance_Fields extends Data_Mysql_Table
{
    public $cols = array(
        'field' => '50',  // 文创表 字段名称
        'name' => '50',   // 模板显示名称
        'content' => 'array',  // 添加内容
    );

    static function getContent($name = '')
    {
        $data = Data_Mysql_Table_Winchance_Fields::select('content', array('name' => $name));
        if(!empty($data)){
            $data[0]['content'] = json_decode($data[0]['content'],1);
            return $data[0]['content'];
        }
    }
}