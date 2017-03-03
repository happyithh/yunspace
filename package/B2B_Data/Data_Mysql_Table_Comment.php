<?php

class Data_Mysql_Table_Comment extends Data_Mysql_Table
{
    public $cols = array(
        'parent_id' => 'int',                   //隶属于谁的
        'user_id' => 'int',                 //评论人id
        'from_id' => 'int',                 //评论对象id
        'from_type' => 'int',              //文章类型
        'cont' => 'text',               //内容
        'marks' => 'text',                //拒绝原因
        'ip' => '100',               //ip
        'create_time' => 'int',
        'count_praise' => 'int',        //点赞数量
        'status' => 'tinyint',          //状态
    );
    public $index = array(
        'user_id' => 'i',
    );
    public static $from_type = array(
        '1' => '活动攻略',
    );

    /**
     * @param $from_id      评论主体 id
     * @param $from_type    主体类型
     * @return mixed
     */
    static function getCommentList($from_id, $from_type)
    {
        $table = "{table} LEFT JOIN {prefix}account ON {prefix}account.id = {table}.user_id";
        $cols = '{table}.*,{prefix}account.fullname,{prefix}account.avatar';
       
        $rs = self::page(0, 0, $cols, array(' {table}.status =? AND {table}.from_id =? AND {table}.from_type =?' => array(1, $from_id, $from_type)), ' ORDER BY {table}.create_time DESC', $table);
        if (empty($rs['rows'])) {
            return array();
        }
        foreach ($rs['rows'] as $key => $val) {
            if ($val['parent_id'] != 0) {

                $rs['rows'][$key]['cont'] = self::getCommentRelation($val['parent_id'], $val['cont']);
            }
        }
        return $rs;
    }

    function  getCommentRelation($id, $cont)
    {
        $table = "{table} LEFT JOIN {prefix}account ON {prefix}account.id ={table}.user_id";
        $cols = '{table}.*,{prefix}account.fullname,{prefix}account.avatar';
        $rs = self::select($cols, array('{table}.id=? AND {table}.status =?' => array($id, 1)), '', '1', $table);
        if (empty($rs[0]['fullname'])) {
            $username = '某某';
            $data = $cont . '//@' . $username . ':' . $rs[0]['cont'];
        } else {
            $data = $cont . '//@' . $rs[0]['fullname'] . ':' . $rs[0]['cont'];
        }

        return $data;
    }

}