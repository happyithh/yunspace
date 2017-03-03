<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 16/8/18
 * Time: 上午10:05
 */
class Data_Mysql_Table_Baike_Dwz extends Data_Mysql_Table
{
    public $cols = array(
        'origin_url' => '250',
        'sign' => '100',
        'urlcode' => '10',       //短网址代码
    );
    public $index = array(
        'urlcode' => 'i',
        'sign' => 'i',
        'origin_url' => 'u',
    );

    static function  getUrl($url)
    {
        if (!$url) {
            return false;
        }
        $data['urlcode'] = time();
        $data['origin_url'] = $url;
        $sign = substr(md5($url), 0, 5);
        $data['sign'] = $sign;
        $rs = Data_Mysql_Table_Baike_Dwz::insert($data);
        $urlcode = base_convert(($rs[0] + 10000), 10, 18);
        if ($rs[0]) {
            Data_Mysql_Table_Baike_Dwz::update($rs[0], array("urlcode" => $urlcode));
            return 'http://' . Core::$urls['host'] . '/b' . $urlcode;
        } else {
            $status = Data_Mysql_Table_Baike_Dwz::select('*', array('sign' => $sign));
            if (!empty($status[0])) {
                return 'http://' . Core::$urls['host'] . '/b' . $urlcode;
            }
        }
        return false;
    }

}