<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2016/5/19
 * Time: 15:39
 * 获取文章内页 的下一篇文章
 */
class Api_Raiders_GetNextArticle extends Api
{

    static function  handle($args = '')
    {
        return self::handleNextArticle($args);
    }

    static function  handleNextArticle($args)
    {
        $request = Func_Input::filter(array(
            'id' => 'int',
            'category_id' => 'int',
        ), $args);
        if (empty($request['id'])) {
            return Api::request('error', '', '请刷新页面重试~');
        }
        $condition['status=?'] = 1;
        if(!empty($request['category_id'])){
            $c_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($request['category_id']);
            $condition[] = "category_id IN (" . implode(',', $c_id) . ")";
        }
        $condition['id <?'] = Func_NumEncode::d($request['id']);
//        Data_Mysql_Table_Raiders_Info::debug(1);
        $data = Data_Mysql_Table_Raiders_Info::select('id,create_time', $condition,"ORDER BY id DESC");
        if (!empty($data[0])) {

            $rs['id'] = Func_NumEncode::e($data[0]['id']);
            return Api::request('success', $rs, 'ok');
        }
        return Api::request('error', '', '失败');
    }



//    static function  handleNextArticle($args)
//    {
//        $request = Func_Input::filter(array(
//            'num' => 'int',
//            'page' => 'int',
//            'create_time' => 'string',
//            'category_id' => 'int',
//        ), $args);
//        if (empty($request['num']) || empty($request['page']) ||  empty($request['create_time'])) {
//            return Api::request('error', '', '请刷新页面重试~');
//        }
//        if (empty($request['page'])) {
//            $page = 1;
//        } else {
//            $page = $request['page'];
//        }
//        if (empty($request['num'])) {
//            $num = 1;
//        } else {
//            $num = $request['num'];
//        }
//        $condition['status=?'] = 1;
//
//        //c_id  小于 100  是文章的分类
//        if ($request['category_id'] < 99) {
//            $condition['category_id =?'] = $request['category_id'];
//        } elseif ($request['category_id'] == 200 || $request['category_id'] == 300 || $request['category_id'] == 400) {
//            $condition['baike_cid'] = $request['category_id'];
//        } else {
//            $space_c_id[112] = '空间';
//            $space_c_id = Data_Mysql_Table_Spacepedia::getChildrenByCid(112);
//            $condition['baike_cid'] = implode(',', array_keys($space_c_id));
//        }
//        $condition['create_time <=?'] = $request['create_time'];
//        $order = "ORDER BY create_time DESC";
////        Data_Mysql_Table_Raiders_Info::debug(1);
//        $data = Data_Mysql_Table_Raiders_Info::page($page, $num, 'id,create_time', $condition, $order);
//
//        if (!empty($data['rows'])) {
//
//            $rs['id'] = Func_NumEncode::e($data['rows'][0]['id']);
//            $rs['create_time'] = $data['rows'][0]['create_time'];
//            return Api::request('success', $rs, 'ok');
//        }
//        return Api::request('error', '', '失败');
//    }

} 