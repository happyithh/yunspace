<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2016/6/16
 * Time: 15:59
 * 子空间搜索头部名称搜索接口
 */
class Api_Search_Item_Title_Handle extends Api
{
    static function handle()
    {
        $action = Func_Url::str_urlencode($_REQUEST['action']);
        switch ($action) {
            case 'getSearchCount':
                return self::getSearchCount($_REQUEST);
                break;
            case 'getSearchTitle':
                return self::getSearchTitle($_REQUEST);
                break;
        }

    }

    // 移动端使用 获取符合搜索条件的数量
    static function getSearchCount($args)
    {
        $request = Func_Input::filter(array(
            'q' => 'string',
        ), $args);
        q(q);
        if (!empty($request['q'])) {
            // 获取搜索数量
            $conditions['baike_status'] = 1;
            $conditions['item_status'] = 1;
            $conditions[] = "baike_item_name like '%" . $request['q'] . "%'";
            $countName = Data_Mysql_Table_Search_Space_Item::select("count(*) as total", $conditions);
            // 获取百科地址下的数量
            unset($conditions);
            $conditions['baike_status'] = 1;
            $conditions[] = "addr like '%" . $request['q'] . "%'";
            $countAddr = Data_Mysql_Table_Search_Space_Item::select("count(*) as total", $conditions);
            // 输出数据
            $count = array(
                'name_count' => empty($countName) ? 0 : $countName[0]['total'],
                'addr_count' => empty($countAddr) ? 0 : $countAddr[0]['total']
            );
            return self::request('success', $count, '');
        } else {
            return self::request('error', '', '');
        }
    }

//    // 获取10条最接近搜索title的数据
//    static function getSearchTitle($args)
//    {
//        $request = Func_Input::filter(array(
//            'q' => 'string',
//        ), $args);
//        if (empty($request['q'])) {
//            return self::request('error', '', '请输入搜索内容！');
//        }
//        $conditions['baike_status'] = 1;
//        $conditions['item_status'] = 1;
//        $conditions[] = "baike_item_name like '" . $request['q'] . "%'";
//        $title = Data_Mysql_Table_Search_Space_Item::select('baike_item_name', $conditions, 'group by baike_id', 8);
//        if(!empty($title)){
//            foreach($title as $k=>$v){
//                if(strstr($v['baike_item_name'],'--')){
//                    $title_one = explode('--',$v['baike_item_name']);
//                    $title[$k]['baike_item_name']= $title_one[0];
//                }
//            }
//        }
//        return self::request('success',$title,'');
//    }
}