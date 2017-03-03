<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/5/28
 * Time: 上午10:05
 */
class Data_Mysql_Table_Dwz extends Data_Mysql_Table
{
    public $cols = array(
        'uid' => 'int',  //分享着用户id
        'pid' => 'int',     //分享产品id
        'urlcode' => 10,       //短网址代码
        'type' => 'tinyint',      //类型 默认是产品     3 是短网址
    );
    public $index = array(
        'pid' => 'i',
        'urlcode' => 'i',
        'origin_url' => 'i',
        'uid,pid' => 'u',
    );

    static function  getUrl($uid, $pid, $type = 1)
    {

        if (empty($uid) || empty($pid)) {
            Func_Header::back("用户ID或产品ID不能为空！");
        }
        $data['uid'] = $uid;
        $data['pid'] = $pid;
        $data['urlcode'] = time();
        $data['type'] = $type;

        $rs = Data_Mysql_Table_Dwz::insert($data);

        if ($rs[0]) {
            $urlcode = base_convert(($rs[0] + 10000), 10, 16);
            Data_Mysql_Table_Dwz::update($rs[0], array("urlcode" => $urlcode));
            return 'http://' . Core::$urls['host'] . '/u' . $urlcode;
        } else {
            $res = Data_Mysql_Table_Dwz::select("urlcode", array("uid" => $uid, "pid" => $pid));
            if ($res[0]['urlcode']) {
                return 'http://' . Core::$urls['host'] . '/u' . $res[0]['urlcode'];
            } else {
                return '';
            }
        }
    }

}