<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/8
 * Time: 11:22
 */
class OA_Home_Page_New
{
    static function handle()
    {
        $type = empty($_REQUEST['action']) ? 'home_v4' : $_REQUEST['action'];

        switch ($type) {
            case 'home_v4':
                self::handleHome();
                break;
        }
    }

    static function handleHome()
    {
        //每日推荐-----------开始---------
        $recommend = Web_HomePage_V4::get('recommend');
        if (empty($recommend) || !is_array($recommend)) {
            $recommend = array();
        }
        if (!empty($_REQUEST['recommend'])) {
            // 逗号过滤
            $_REQUEST['recommend']['content'] = str_replace(',', '，', $_REQUEST['recommend']['content']);
            //查找符合条件百科ID
            if (!empty($_REQUEST['recommend']['content'])) {
                $baike_name = explode('，', $_REQUEST['recommend']['content']);
                $conditions['status =?'] = 1;
                $conditions[] = 'level IN (4,3)';
//                $conditions['category_id !=?'] =400;
                $conditions['logo !=?'] = '';
                $checkData = array();
                foreach ($baike_name as $k => $v) {
                    $conditions['space_name'] = $v;
                    $baike_id = Data_Mysql_Table_Spacepedia::select('id,space_name', $conditions);
                    if (empty($baike_id[0])) {
                        $checkData[] = $v;
                    } else {
                        $baike_ids[$k] = $baike_id[0];
                    }
                }
                if (!empty($checkData)) {
                    Func_Header::to(implode(',', $checkData).'数据不符合条件，请重新选择！', '?');
                    return false;
                }
                // 缓存每日推荐填写的百科ID、百科名称、缓存时间
                $recommend['baike_id'] = array_column($baike_ids, 'id');
                $recommend['update_time'] = time();
                $recommend['content'] = implode('，', array_column($baike_ids, 'space_name'));
                Web_HomePage_V4::set('recommend', $recommend);
            }

        }
        Tpl_Smarty::assign('recommend', $recommend);
        // 每日推荐----------结束---------


        // 楼层信息----------开始---------
        $data = Web_HomePage_V4::get('data');
        if (empty($data) || !is_array($data)) {
            $data = array();
        }
        if (!empty($_REQUEST['data'])) {
            // 逗号过滤
            // 空间过滤
            $space = explode('，',str_replace(',', '，', $_REQUEST['data']['space']['热门项目']));
            $spaceNew = '';
            if(!empty($space)){
                $conditions[] = 'space_name IN ("'.implode('","',$space).'")';
                $conditions[] = 'status = 1';
                $data_s = Data_Mysql_Table_Spacepedia::select('id,space_name',$conditions,'',count($space));
                if(!empty($data_s)){
                    $s = array_column($data_s,'space_name');
                    $spaceNew = implode('，',$s);
                }
            }

            // 文创过滤
            $wen = explode('，',str_replace(',', '，', $_REQUEST['data']['wenChuang']['热门项目']));
            $wenNew = '';
            if(!empty($wen)){
                $conditions_1[] = 'space_name IN ("'.implode('","',$wen).'")';
                $conditions_1[] = 'status = 1';
                $conditions_1[] = 'category_id = 200';
                $data_1 = Data_Mysql_Table_Spacepedia::select('id,space_name',$conditions_1,'',count($wen));
                if(!empty($data_1)){
                    $w = array_column($data_1,'space_name');
                    $wenNew = implode('，',$w);
                }
            }
            // 零售过滤
            $ls = explode('，',str_replace(',', '，', $_REQUEST['data']['consult']['热门项目']));
            $lsNew = '';
            if(!empty($ls)){
                $conditions_2[] = 'space_name IN ("'.implode('","',$ls).'")';
                $conditions_2[] = 'status = 1';
                $conditions_2[] = 'category_id = 400';
//                Data_Mysql_Table_Spacepedia::debug(1);
                $data_2 = Data_Mysql_Table_Spacepedia::select('id,space_name',$conditions_2,'',count($ls));
                if(!empty($data_2)){
                    $l = array_column($data_2,'space_name');
                    $lsNew = implode('，',$l);
                }
            }
            $_REQUEST['data']['space']['热门项目'] = $spaceNew;
            $_REQUEST['data']['space']['标题'] = str_replace(',', '，', $_REQUEST['data']['space']['标题']);
            $_REQUEST['data']['wenChuang']['热门项目'] = $wenNew;
            $_REQUEST['data']['wenChuang']['标题'] = str_replace(',', '，', $_REQUEST['data']['wenChuang']['标题']);
            $_REQUEST['data']['find']['标题'] = str_replace(',', '，', $_REQUEST['data']['find']['标题']);
            $_REQUEST['data']['consult']['标题'] = str_replace(',', '，', $_REQUEST['data']['consult']['标题']);
            $_REQUEST['data']['consult']['热门项目'] = $lsNew;
            $data = $_REQUEST['data'];
            Web_HomePage_V4::set('data', $data);
        }
        Tpl_Smarty::assign('data', $data);
        // 楼层信息----------结束----------

        Tpl_Smarty::display('OA_Static::website/home_page/home.tpl');
    }

    // 每日推荐处理
    static function handleRecommend()
    {
        //获取每日推荐百科数据
        $cache = Web_HomePage_V4::get('cache_data');
        $recommend = Web_HomePage_V4::get('recommend');
        if (!empty($cache)) {
            $data = self::getRecommendData($recommend, $type = 1);
            $a = 0;
            for ($i = date('N', time()); $i <= 7; $i++) {
                $j = $a * 4;
                $data_one[] = array_slice($data, $j, 4);
                $cache['data'][$i] = array_replace($cache['data'][$i], $data_one[$a]);
                $a++;
            }
            $newData = $cache['data'];
        } else {
            $data = self::getRecommendData($recommend);
            // 以周为单位 整理每日推荐
            for ($i = 1; $i <= 7; $i++) {
                $j = ($i - 1) * 4;
                if ($i == 1) {
                    $t = date('N', time());
                } elseif ((date('N', time()) + $i) <= 8) {
                    $t = date('N', time()) + $i - 1;
                } else {
                    $t = date('N', time()) + $i - 8;
                }
                $newData[$t] = array_slice($data, $j, 4);

            }
        }
        if ($cache['update_time'] != $recommend['update_time'] || (empty($cache['update_time']) && empty($recommend['update_time']))) {
            $cache_data['data'] = $newData;
            $cache_data['update_time'] = $recommend['update_time'];
            Web_HomePage_V4::set('cache_data', $cache_data);
        }

    }

    // 获取 每日推荐数据
    static function getRecommendData($recommend, $type = 0)
    {

//        q($baike_ids,$recommend['baike_id']);
        $res_one_new = array();
        $baike_ids = '';
        if (!empty($recommend['baike_id'])) {
            $baike_ids = implode(',', $recommend['baike_id']);
            $conditions[] = "t1.id IN (" . $baike_ids . ")";
            $table = '{table} as t1 LEFT JOIN {prefix}baike_statistical as t2 ON t1.id = t2.space_id';
            $res_one = Data_Mysql_Table_Spacepedia::select('t1.id,t1.space_name,t1.level,t1.logo,t1.addr,t1.attr,t1.mobile_logo,t2.click,t1.category_id',
                $conditions, '', 28, $table);
            if (!empty($res_one)) {
                /**
                 *目的为了匹配后台填写的每日推荐的顺序
                 */
                foreach ($res_one as $k => $v) {
                    $res_one_ids[$v['id']] = $v;
                }
                foreach ($recommend['baike_id'] as $k => $v) {
                    if (isset($res_one_ids[$v])) {
                        $res_one_new[$k] = $res_one_ids[$v];
                    }
                }
            }
        }

        /**
         * 如果数据不够28条，自动补齐（备足一周的数据）
         */
        if ($type == 1) {
            //如果有缓存数据存在，后台每日推荐只是更新数据------获取今天之后的数据
            $count = (8 - intval(date('N', time()))) * 4 - count($res_one_new);
        } else {
            // 没有任何缓存数据
            $count = intval(28 - count($res_one_new));
        }
        if (!empty($count)) {
            unset($conditions);
            if (!empty($baike_ids)) {
                $conditions[] = 't1.id NOT IN (' . $baike_ids . ')';
            }
            $conditions['t1.status = ?'] = 1;
            $conditions[] = 't1.level IN (4,3)';
//            $conditions['t1.category_id !=?'] =400;
            $conditions['t1.logo !=?'] = '';
            $table = '{table} as t1 LEFT JOIN {prefix}baike_statistical as t2 ON t1.id = t2.space_id';
            $res_two = Data_Mysql_Table_Spacepedia::select('t1.id,t1.space_name,t1.level,t1.logo,t1.addr,t1.attr,t1.mobile_logo,t2.click,t1.category_id',
                $conditions, 'ORDER BY t1.create_time DESC', $count, $table);
        }
        if (!empty($res_one_new) && !empty($res_two)) {
            foreach ($res_two as $k => $v) {
                $res_two_1[$k + count($res_one_new)] = $v;
            }
            $data = array_merge($res_one_new, $res_two_1);
        } else {
            $data = empty($res_two) ? $res_one_new : $res_two;
        }
        /**
         * 获取百科我喜欢和现场足迹数据
         */
        $baike_ids = array_column($data, 'id');
        $sumData = self::getLikeAndGoData($baike_ids);
        if (!empty($data)) {
            foreach ($data as $k => $v) {
                if (!empty($v['attr'])) {
                    $data[$k]['attr'] = json_decode($v['attr'], 1);
                }
                if (!empty($sumData)) {
                    $data[$k]['sum'] = $sumData[$v['id']];
                }
            }
        }
        return $data ? $data : array();
    }

    // 获取我喜欢和现场足迹数据
    static function getLikeAndGoData($baike_ids)
    {
        // 初始化我喜欢和现场足迹（移动首页使用）
        foreach ($baike_ids as $k => $v) {
            $id['space_id'] = $v;
            Api_Baike_Like_Go::initLikeAndGo($id);
        }
        $sum = array();
        $conditions[] = "space_id IN (" . implode(',', $baike_ids) . ")";
        $data = Data_Mysql_Table_Like_Go::select("count(*) as sum,space_id", $conditions, 'GROUP BY space_id', 28);
        foreach ($data as $k => $v) {
            $sum[$v['space_id']] = $v['sum'];
        }
        return $sum;
    }

}