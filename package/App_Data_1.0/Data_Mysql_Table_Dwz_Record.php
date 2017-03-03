<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/5/28
 * Time: 上午10:05
 */
class Data_Mysql_Table_Dwz_Record extends Data_Mysql_Table
{
    public $cols = array(
        'unid' => 'string',     //临时id
        'uid' => 'int',         //用户id（被分享者，点击链接的用户）
        'shareid' => 'int',       //分享着id
        'pid' => 'int',           //产品id
        'sid' => 'int',           //套餐id
        'create_time' => 11,   //创建时间
    );
    public $index = array(
        'pid' => 'i',
        'sid' => 'i',
        'uid,pid,sid' => 'u',
    );

    /**
     * @param $urlcode
     * @param int $type 是单个产品还是套餐产品
     */
    static function  analysis($urlcode)
    {
        if (empty($urlcode)) {
            Func_Header::notFound();
        }
        $rs = Data_Mysql_Table_Dwz::select("*", array("urlcode" => $urlcode));
        if (empty($rs[0]['id'])) {
            Func_Header::notFound();
        }
        if (empty($_SESSION['user']['id'])) {
            self::unLoginLog($_COOKIE['unid'], $rs[0]['pid'], $rs[0]['uid'], $rs[0]['type']);
        } else {
            self::loginLog($_SESSION['user']['id'], $rs[0]['pid'], $rs[0]['uid'], $rs[0]['type']);
        }
        if ($rs[0]['type'] == 1) {
            Func_Header::location("http://" . Core::$urls['host'] . "/service_info/" . $rs[0]['pid'] . ".html");
        }
        if ($rs[0]['type'] == 2) {
            //套餐产品
            Func_Header::location("http://" . Core::$urls['host'] . "/set_info/" . $rs[0]['pid'] . ".html");
        }
    }
    /**
     *  处理短旧 网址
     */
    static function  analysisDwz($urlcode)
    {
         if(empty($urlcode)){
             Func_Header::notFound();
         }
        $conditions['urlcode']=$urlcode;
        $rs = Data_Mysql_Table_Baike_Dwz::select("*", $conditions);
        if (empty($rs[0]['id'])) {
            Func_Header::notFound();
        }
        Func_Header::location($rs[0]['origin_url']);

    }

    /**
     * 没有登录的时候。直接根据unidp 和id 查询记录表中是否有数据 如果有就就不管。如果没有。就插入一条新数据
     *
     * 判断过期的 三个月 如果过期的话就删除。重新插入数据
     * 2015.7.14 修改为。不判断过期时间。一直插入最新一条数据。旧的数据删除
     **/
    static function  unLoginLog($unid, $object_id, $shareid = "", $type = 1)
    {
        $data['unid'] = $unid;
        if ($type == 1) {
            $data['pid'] = $object_id;
        } elseif ($type == 2) {
            $data['sid'] = $object_id;
        }
        $data['uid'] = -mt_rand(1000000,9999999);
        $data['shareid'] = $shareid;
        $data['create_time'] = time();
        Data_Mysql_Table_Dwz_Record::insert($data,1);
    }


    /**
     * 如果登录的话， 直接根据用户id 和pid 查找记录表。如果有数据就就不管。如果没有就插入一条数据。并且 uid 和pid是唯一主键
     *
     * 判断过期 三个月  如果过期的话就删除。重新插入数据
     * 2015.7.14 修改为。不判断过期时间。一直插入最新一条数据。旧的数据删除
     * @param $uid
     * @param $pid
     * @param string $shareid
     */
    static function loginLog($uid, $object_id, $shareid = "", $type = 1)
    {

        $data['uid'] = $uid;
        if ($type == 1) {
            $data['pid'] = $object_id;
        } elseif ($type == 2) {
            $data['sid'] = $object_id;
        }
        $data['unid'] = $_COOKIE['unid'];
        $data['shareid'] = $shareid;
        $data['create_time'] = time();
        Data_Mysql_Table_Dwz_Record::insert($data,1);
    }


    /**
     * 设置cookie 中的uid
     */
    static function  setlogcookie()
    {
        if (empty($_COOKIE['unid'])) {
            $_COOKIE['unid'] = uniqid();
            setcookie("unid", $_COOKIE['unid'], time() + (3600 * 24 * 90));
        }
    }


    /**
     * 当用户登录之后。更新所有当前unid的数据
     */
    static function updataRecord()
    {
        if (!empty($_SESSION['user']['id'])) {
            Data_Mysql_Table_Dwz_Record::update(array("unid" => $_COOKIE['unid']), array("uid" => $_SESSION['user']['id']));
            $_COOKIE['unid'] = 0;
            setcookie("unid", '', time() + (3600 * 24 * 90));
        }
    }


}

Data_Mysql_Table_Dwz_Record::setlogcookie();