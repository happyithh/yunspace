<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/10/23
 * Time: 17:42
 * 广告 编辑
 */
class Api_Pa_Detail extends Api
{
    static function paDetail($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
        ));

        $conditions['{table}.id =?'] = $request['id'];
        $res = Data_Mysql_Table_Pa::select("{table}.*,{prefix}pa_site.site,{prefix}pa_site.size,{prefix}pa_site.adver_city", $conditions, '', 1, '{table} LEFT JOIN {prefix}pa_site ON {table}.site_id = {prefix}pa_site.id');
        $res[0]['size'] = json_decode($res[0]['size'], 1);
//        $res[0]['path'] = json_decode($res[0]['path'],1);
        $res[0]['price'] = explode('/',$res[0]['price']);
        return $res;
    }
}