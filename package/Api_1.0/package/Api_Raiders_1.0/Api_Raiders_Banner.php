<?php
/*
 * Created by PhpStorm
 * User: Yangchenglin
 * Date: 2015/9/29
 * Time: 14:53
 */
class Api_Raiders_Banner extends Api
{
    static function handle($args = '')
    {

//        q(1234);
        $result = self::handleBannerList($args);
        return $result;
    }


    static function handleBannerList($args)
    {
//        q(123);
        $request = Func_Input::filter(array(
            'category_id' => 'int',
        ), $args);
//
        if (empty($request['category_id'])) {
            $request['category_id'] = 0;
        }
//
        $conditions['status =?'] = 1;
        $conditions['is_hot=?'] = 1;
//
//        //调用的文章时间不能大于当前时间
        $conditions['{table}.create_time < ?'] = time();

        if ($request['category_id']) {
            $category_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($request['category_id']);
            $conditions[] = 'category_id IN (' . implode(',', $category_id) . ')';
        }
        if ($request['category_id'] == 0) {
            $wenku_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
            $conditions[] = 'category_id NOT IN (' . implode(',', $wenku_id) . ')';
        }

        $order = 'ORDER BY {table}.create_time asc';
        $rs = Data_Mysql_Table_Raiders_Info::select('*', $conditions, $order, 4);
//        q($rs);
        if ($rs > 0) {
            $result = self::request('success', $rs, '成功');
        } else {
            $result = self::request('error', '', '失败');
        }
        return $result;
    }
}