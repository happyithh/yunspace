<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/8/19
 * Time: 11:11
 * @ 城市自动完成
 */
class Api_City_Auto_Complete extends Api
{
    /**
     *
     * @$args = '';
     *
     * 1.默认返回省份
     * 2.根据省份取得市
     * 3.根据市取得区县
     */
    static function  handle($args = '')
    {
        return self::getCity($args);
    }

    static function  getCity($args)
    {
        $request = Func_Input::filter(array(
            'province_code' => 'string',
            'city_code' => 'string',
        ), $args);
        $json = file_get_contents(dirname(__FILE__) . '/all_city.json');
        $all = json_decode($json, 1);
        if (empty($request['province_code']) && empty($request['city_code'])) {
            return Api::request('success', $all['province'], '获取省份');
        }
        $city = array();
        $area = array();
        if (!empty($request['province_code'])) {
            foreach ($all['city'] as $key => $val) {
                if ($val['province_code'] == $request['province_code']) {
                    $city[] = $val;
                }
            }
            return Api::request('success', $city, '获取城市');
        }
        if (!empty($request['city_code'])) {
            foreach ($all['area'] as $key => $val) {
                if ($val['city_code'] == $request['city_code']) {
                    $area[] = $val;
                }
            }
            return Api::request('success', $area, '获取区域');
        }

        return Api::request('error', '', '获取失败！');

    }

    static function  allCity($args)
    {
        $request = Func_Input::filter(array(
            'num' => 'int,'
        ), $args);
        $json = file_get_contents(dirname(__FILE__) . '/all_city.json');
        $all = json_decode($json, 1);
        $allcity = array();
        if (!empty($request['num'])) {
            foreach ($all['province'] as $key => $val) {

                foreach ($all['city'] as $k => $v) {
                    if ($v['province_code'] == $val['code']) {
                        $allcity[] = $v;
                    }

                }

            }
            return Api::request('success', $allcity, '获取全部城市');
        }
    }

}