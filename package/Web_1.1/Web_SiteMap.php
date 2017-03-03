<?php

/**
 * Created by PhpStorm.
 * User: adu
 * Date: 15/9/24
 * Time: 18:41
 */
class Web_SiteMap extends Data_Config
{
    public $all = array(
        'space' => array(),
        'setList' => array(),
        'raiders' => array(),
        'vendor' => array(),
        'navigate'=>array(),
    );

    static function navigate()
    {
        $navigate = self::get('navigate');
        if (!empty($navigate['is_post'])) {
            return $navigate;
        }
        return array();
    }
    //space
    static function space()
    {
        $space = self::get('space');
        if (!empty($space['last_id'])) {
            return $space;
        }
        return array();
    }
    static function setList()
    {
        $set = self::get('setList');
        if (!empty($set['last_id'])) {
            return $set;
        }
        return array();
    }
    static function raiders()
    {
        $raiders = self::get('raiders');
        if (!empty($raiders['last_id'])) {
            return $raiders;
        }
        return array();
    }
    static function vendor()
    {
        $vendor = self::get('vendor');
        if (!empty($vendor['last_id'])) {
            return $vendor;
        }
        return array();
    }


}