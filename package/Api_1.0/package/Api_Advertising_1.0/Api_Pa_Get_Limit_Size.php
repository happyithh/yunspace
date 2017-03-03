<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/22
 * Time: 16:22
 * 广告位
 * 获取 版本尺寸/文字大小
 *
 */
class Api_Pa_Get_Limit_Size extends Api
{
    static function limitSize($args)
    {
        $request = Func_Input::filter(array(
            'site_id' => 'int',
        ), $args);
        if (!empty($request['site_id'])) {
            $condition['id'] = $request['site_id'];
        }
        $res = Data_Mysql_Table_Pa_Site::select('id,size,adver_city', $condition, '', 1);
        $res[0]['size'] = json_decode($res[0]['size'], 1);
        $res[0]['size'] = $res[0]['size']['width'] . '*' . $res[0]['size']['height'] . '  (宽*高)';
        return $res[0];
    }
}
