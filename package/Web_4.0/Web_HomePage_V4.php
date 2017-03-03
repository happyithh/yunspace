<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/8
 * Time: 14:07
 */
class Web_HomePage_V4 extends Data_Config
{
    // 每日推荐
    static function everydayRecommend(){

        $cache_data = Web_HomePage_V4::get('cache_data');
        $recommend = Web_HomePage_V4::get('recommend');
        if(empty($cache_data) || $cache_data['update_time']!=$recommend['update_time']){
            OA_Home_Page_New::handleRecommend();
            $cache_data = Web_HomePage_V4::get('cache_data');
        }
        return $cache_data['data'][date('N',time())];
    }
    // 首页专题 add by yl
    static function topicRecommend(){
        return Api_Topic_List::getHomeTopicList();    
    }



    // 空间/文创/发现/咨讯
    static function getSpace($type)
    {
        $data = Web_HomePage_V4::get('data');
//        q($data[$type],$type);
        // 处理缓存字符串
        $title = explode('，',$data[$type]['标题']);
        if (!empty($data[$type]['标题'])) {
            $data[$type]['标题'] = implode('","', explode('，', '"' . $data[$type]['标题'] . '"'));
        }else{
            $data[$type]['标题']='';
        }
        if(empty($data[$type]['热门项目'])){
            $data[$type]['热门项目']='';
        }
        if (!empty($data[$type])) {
            switch ($type) {
                case 'space':    //空间
                    //百科内容
                    $spaceData['pic_space'] = self::getContent($data[$type]['标题'], 112, 9,$title);
                    // 最新内容
                    $spaceData['new_space'] = self::getRaider(112, 0, 20);
                    // 精彩推荐
                    $spaceData['recommend'] = self::getRaider(112, 1, 5);
                    break;
                case 'wenChuang':  //文创
                    //百科内容
                    $spaceData['pic_space'] = self::getContent($data[$type]['标题'], 200, 6,$title);
                    // 最新内容
                    $spaceData['new_space'] = self::getRaider(200, 0, 20);
                    // 精彩推荐
                    $spaceData['recommend'] = self::getRaider(200, 1, 5);
                    break;
                case 'find':     //发现
                    //百科内容
//                    $spaceData['pic_space'] = self::getContent($data[$type]['标题'], 300, 4,$title);
                    // 最新内容                                //特殊的值
//                    $spaceData['new_space'] = self::getRaider(3000, 0, 20);
                    // 精彩推荐
                    $spaceData['recommend'] = self::getRaider(300, 0, 60);
                    break;
                case 'consult': //零售
                    //百科内容
                    $spaceData['pic_space'] = self::getContent($data[$type]['标题'], 400, 6,$title);
                    $spaceData['new_space'] = self::getConsult();
                    $spaceData['recommend'] = self::getRaider(400, 1, 20);
                    break;
            }

            // 热门项目标签
            if ($type != 'find') {
                $hotTitle = explode('，', $data[$type]['热门项目']);
                // 热门项目处理
                if (!empty($hotTitle[0])) {
                    $spaceData['space_name'] = $hotTitle;
                } else {
                    foreach ($spaceData['pic_space'] as $k => $v) {
//                        q($v['space_name']);
                        $spaceData['space_name'][] = $v['space_name'];
                    }

                }

            }
            return $spaceData;
        }

    }


    // 获取中间图片区域的百科
    static function getContent($space_name, $category, $count,$title)
    {
        if($category==112){
            $category_ids= Data_Mysql_Table_Spacepedia::getChildren($category);
            array_unshift($category_ids,112);
        }
        $data=array();
        if (!empty($space_name)) {
            $conditions[] = "t1.space_name IN(" . $space_name . ")";
            if (!empty($category_ids)) {
                $conditions[] = "t1.category_id IN(" . implode(',', $category_ids) . ")";
            } else {
                $conditions['t1.category_id = ?'] = $category;
            }
            $conditions[] = 't1.level IN(4,3)';
            $conditions['t1.status = ?'] = 1;
            $conditions['t1.logo !=?']='';
            $table = '{table} as t1 LEFT JOIN {prefix}baike_statistical as t2 ON t1.id = t2.space_id';
            $data = Data_Mysql_Table_Spacepedia::select('t1.id,t1.space_name,t1.logo,t1.addr,t1.category_id,t1.attr,t1.mobile_logo,t2.click', $conditions, '', $count, $table);
        }
        // 处理数据
        $data_new =array();
        if(!empty($data)) {
            foreach ($data as $k => $v) {
                $data_new[array_search($v['space_name'], $title)] = $data[$k];
            }
            ksort($data_new);
        }
        if (count($data_new) < $count) {
            unset($conditions);
            if(!empty($space_name)){
                $conditions1[] = "t1.space_name NOT IN(" . $space_name . ")";
            }
            $conditions1['t1.status =?'] = 1;
            $conditions1[] = 't1.level IN(4,3)';
            $conditions1['logo !=?']='';
            if (!empty($category_ids)) {
                $conditions1[] = "t1.category_id IN(" . implode(',', $category_ids) . ")";
            } else {
                $conditions1['t1.category_id = ?'] = $category;
            }
            $table1 = '{table} as t1 LEFT JOIN {prefix}baike_statistical as t2 ON t1.id = t2.space_id';
            $data1 = Data_Mysql_Table_Spacepedia::select('t1.id,t1.space_name,t1.logo,t1.addr,t1.category_id,t1.attr,t1.mobile_logo,t2.click', $conditions1, 'ORDER BY t1.level DESC', ($count - count($data_new)), $table1);

            if(!empty($data_new)){
                $data_new = array_merge($data_new, $data1);
            }else{
                $data_new=$data1;
            }
        }
        // 获取我喜欢和现场足迹数据(移动端使用)
        if(Core::$urls['path']=='/m/' && !empty($data_new)){
            $baike_ids = array_column($data_new,'id');
             $sumData = self::getLikeAndGoData($baike_ids);
        }
        foreach ($data_new as $k => $v) {
            if(!empty($v['attr'])){
                $data_new[$k]['attr'] = json_decode($v['attr'],1);
            }
            if(isset($sumData) && !empty($sumData)){
                $data_new[$k]['sum'] = $sumData[$v['id']];
            }
        }
        return $data_new;
    }

    // 楼层最新动态/精彩推荐
    static function getRaider($pid, $type, $count)
    {
        // 获取$pid的所有子类
        if($pid!=3000){
            $ids = Data_Mysql_Table_Spacepedia::getChildren($pid);
            if (!empty($ids)) {
               $baike_cid =  implode(',', $ids) . "," . $pid;
                $conditions["baike_cid"] = $baike_cid;
            } else {
                $conditions['baike_cid'] = $pid;
            }
        }

        if ($type == 1) {
            $conditions['is_good'] = 1;
        }
        $condition['category_id !=?'] = 30;  //推广的分类
        $conditions['status'] = 1;
        $data = Data_Mysql_Table_Raiders_Info::select('id,title as space_name,cont,create_time,logo,counter_praise,counter_view', $conditions, 'ORDER BY create_time DESC', $count);

        // 百科名称截取
        if (!empty($data)) {
            foreach ($data as $k => $v) {
//                $data[$k]['space_title'] = mb_substr($v['space_name'], 0, 13, 'utf8');
                $data[$k]['id'] = Func_NumEncode::e($data[$k]['id']);
            }
        }
        return $data;
    }


    // 头部空间/文创获取数据
    static function titleSpace($pid)
    {
        // 获取$pid的所有子类
        $ids = Data_Mysql_Table_Spacepedia::getChildren($pid);
        if (!empty($ids)) {
            $conditions[] = "category_id IN(" . implode(',', $ids) . "," . $pid . ")";
        } else {
            $conditions['category_id = ?'] = $pid;
        }
        $conditions['status =?'] = 1;
        $conditions[] = 'level IN(4,3)';
        $conditions['logo !=?']='';
        $data = Data_Mysql_Table_Spacepedia::select('space_name,logo,addr,media,attr', $conditions, 'ORDER BY create_time DESC', 4);
        // 如果logo为空默认使用media的第一张图片
        foreach ($data as $k => $v) {
            if (empty($v['logo'])) {
                $media = json_decode($v['media'], 1);
                if (!empty($media[0])) {
                    $data[$k]['logo'] = $media[0]['path'];
                }
            }
            if(!empty($v['attr'])){
                $data[$k]['attr'] = json_decode($v['attr'],1);
            }
        }
        return $data;
    }

    // 排行榜  [空间/文创/活动]
    static function rankingList($category)
    {
        switch ($category) {
            case '空间':
                $pid = 112;
                break;
            case '文创':
                $pid = 200;
                break;
            case '资讯':      //零售
                $pid = 400;
                break;
        }
        $conditions = array();
//         获取$pid的所有子类
//        q($pid);
        if($category=='资讯'){
            $ids = Data_Mysql_Table_Raiders_Info::getCategoryChildren(1);
            $conditions[] ="category_id IN(" . implode(',', $ids).")";
            // 排行榜去重 (去除空间、文创)
            $no_ids = Data_Mysql_Table_Spacepedia::getChildren(112);
            $conditions[] ="(baike_cid NOT IN(" . implode(',', $no_ids).",200))";
        }else{
            $ids = Data_Mysql_Table_Spacepedia::getChildren($pid);
            if (!empty($ids)) {
                $conditions[] = "baike_cid IN(" . implode(',', $ids) . "," . $pid . ")";
            } else {
                $conditions['baike_cid'] = $pid;
            }
        }
        $conditions['status'] =1;
        $auto_add_where=$conditions;
        $default_where=$conditions;

        $default_where['create_time >=?'] =time()-86400*14;
        $data = Data_Mysql_Table_Raiders_Info::select('id,title,counter_view,baike_cid', $default_where, 'ORDER BY counter_view DESC', 10);
        if (!empty($data)) {
            foreach ($data as $k => $v) {
                $data[$k]['id'] = Func_NumEncode::e($data[$k]['id']);
            }
        }
          //是否符合 10条总数
        if(count($data) <10){
            if(!empty($data)){
                $auto_add_where[] ='id NOT IN('.implode(',',array_column($data,'id')).')';
            }
            $data = Data_Mysql_Table_Raiders_Info::select('id,title,counter_view,baike_cid', $auto_add_where, 'ORDER BY counter_view DESC', 10-count($data));
            if (!empty($data)) {
                foreach ($data as $k => $v) {
                    $data[$k]['id'] = Func_NumEncode::e($data[$k]['id']);
                }
            }

        }


        return $data;
    }

    /**
     * 获取媒体新闻
     */
    static  function getMediaNews(){

    }

    static function getConsult()
    {
//        $ids = Data_Mysql_Table_Raiders_Info::getCategoryChildren(1);
//        if (!empty($ids)) {
//            $conditions[] = "category_id IN(" . implode(',', $ids) . ")";
//        } else {
//            $conditions['category_id = ?'] = $ids;
//        }

        $conditions['baike_cid'] = 400;
        $conditions['status']=1;
        $data = Data_Mysql_Table_Raiders_Info::select('id,title,create_time', $conditions, 'ORDER BY create_time DESC', 20);
        if (!empty($data)) {
            foreach ($data as $k => $v) {
                $data[$k]['id'] = Func_NumEncode::e($data[$k]['id']);
            }
        }
        return $data;
    }

    // 获取我喜欢和现场足迹数据
    static function getLikeAndGoData($baike_ids){
        $key = array_fill(0,count($baike_ids),'');
        $sum = array_combine($baike_ids,$key);
        $conditions[] = "space_id IN (".implode(',',$baike_ids).")";
        $data=Data_Mysql_Table_Like_Go::select("count(*) as sum,space_id",$conditions,'GROUP BY space_id',10);
        foreach($data as $k=>$v){
            $sum[$v['space_id']] =$v['sum'] ;
        }
        return $sum;
    }


}
