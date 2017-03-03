<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/1/29
 * Time: 15:39
 *
 * 活动文库 -》详情页面-》你可能喜欢
 */
class Api_Raiders_Paper_Children_List extends Api
{
    static function getChildrenList($args)
    {
        $condition['id !=?']=$args['id'];
        $condition['category_id']=$args['type'];
        $res = Data_Mysql_Table_Raiders_Info::select('id,title,accessory', $condition, 'ORDER BY create_time DESC', 4);
//        q($res);
        foreach ($res as $k => $v) {
            if (!empty($v['accessory'])) {
                $v['accessory'] = json_decode($v['accessory'], 1);
                $res[$k]['paperType'] = self::paperType($v['accessory']['name']);
            }
        }
        return $res;
    }

    static function paperType($name)
    {
        if (!empty($name)) {
            if (strpos($name, '.doc') || strpos($name, '.docx')) {
                $type = 'doc';
            } elseif (strpos($name, '.xls') || strpos($name, '..xlsx')) {
                $type = 'xls';
            } elseif (strpos($name, '.pdf')) {
                $type = 'pdf';
            } elseif (strpos($name, '.pptx') || strpos($name, '.ppt')) {
                $type = 'ppt';
            } elseif (strpos($name, '.txt')) {
                $type = 'txt';
            }
            return $type;
        }
    }
}