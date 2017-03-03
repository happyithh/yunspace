<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/12/18
 * Time: 15:07
 * 文库 资讯
 */
class Web_Raiders_Search_New extends Web_Global{
    function seo()
    {
        if(!empty($this->request['keyword'])){
            $ctype = '';
            if(empty($request['category_id'])){
                $ctype =   "相关资讯，最新活动资讯";
            }else{
                $ctype =   "相关文档，全国活动文库";
            }
            $title = $this->request['keyword'].$ctype."-【云SPACE】";
        }else{
            $title = "全国活动文库_最新活动资讯_活动策划_活动方案_活动主题-【云SPACE】";
        }
          return array(
              '网页标题'=>$title,
              '网页简介'=>"云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定",
              '网页关键词'=>"云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地",
          );
      }


    function request()
    {
        $request = Func_Input::filter(array(
            'keyword' => 'string',
            'category_id'=>'int'
        ));
        if(!empty($request['keyword'])){
            Tpl_Smarty::assign('_keyword',$request['keyword']);
        }
        return $request;
    }

    function conditions()
    {
        $request = $this->request;

        $conditions['status =?'] = 1;
        if (empty($request['category_id'])) {

            $category_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(0);
            $category_array=array(0);
            foreach($category_id as $k=>$v){
                $category_tmp=array();
                if($v!=12&&$v!=0){
                    $category_tmp =  Data_Mysql_Table_Raiders_Info::getCategoryChildren($v);
                }
                $category_array = array_merge($category_array,$category_tmp);
            }
            $conditions[] = 'category_id IN (' . implode(',', $category_array) . ')';
        }else{
            $category_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($request['category_id']);
            $conditions[] = 'category_id IN (' . implode(',', $category_id) . ')';
        }
//        if ($this->category_id == 0) {
//            $wenku_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
//            $conditions[] = 'category_id NOT IN (' . implode(',', $wenku_id) . ')';
////            $conditions['is_good'] = 1;
//        }
        if (!empty($request['keyword'])) {
            if(isset($_REQUEST['search_tag'])&&$_REQUEST['search_tag']==1){
                $conditions['tags_info'] =$request['keyword'];
            }else{
                $conditions['title'] = $request['keyword'];
            }
            Data_Mysql_Table_Search_Logm::searchLog($request['keyword'],'article');

//            $conditions['author'] = $request['keyword'];
        }
//        $action_arr = explode('/', Core::$urls['action']);
//        if(!empty($action_arr[1])) {
//            $action_arr[1] = urldecode($action_arr[1]);
//        }
//        if($action_arr[0] =='tags') {
//            $conditions['tags_info'] = $action_arr[1];
//        }
        return $conditions;

    }

//    //推荐的4篇文章
//    function getIsgood()
//    {
//        $conditions['status = ?'] = 1;
//        $conditions['is_good = ?'] = 1;
//        $wenku_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
//        $conditions[] = 'category_id NOT IN (' . implode(',', $wenku_id) . ')';
//        $rs_good = Data_Mysql_Table_Raiders_Info::select('id,title,create_time,author,logo,des,tags_info,counter_view,counter_praise',$conditions,'ORDER BY create_time DESC',4);
//        foreach ($rs_good as $key => $val) {
//            $rs_good[$key]['create_time'] = Date('Y-m-d H:i:s', $val['create_time']);
//        }
//        return $rs_good;
//    }

    function getRaidersList()
    {
        $conditions = $this->conditions;
//        $getIsgood_list = $this->getIsgood;
//        if(!empty($getIsgood_list)) {
//            foreach($getIsgood_list as $k=>$v) {
//                $isgood_id[] = $v['id'];
//            }
//            $conditions[] = 'id NOT IN ('.implode(',',$isgood_id).')';
//        }
        $order = 'ORDER BY {table}.create_time desc';
//        Data_Mysql_Table_Raiders_Info::debug(1);
        $rs = Data_Mysql_Table_Raiders_Info::page(0, 10, 'id,title,create_time,author,logo,des,tags_info,counter_view,counter_praise,accessory,download', $conditions, $order);
        foreach ($rs['rows'] as $key => $val) {
            $rs['rows'][$key]['create_time'] = Date('Y-m-d H:i:s', $val['create_time']);
            $rs['rows'][$key]['accessory'] = json_decode($val['accessory'],1);
            preg_match_all('/\.(.*)/', $rs['rows'][$key]['accessory']['name'], $match);
            $rs['rows'][$key]['match'] = $match;
        }
        return $rs;
    }

    function getSearchList(){
        $request = $this->request;
        if (!empty($request['keyword'])) {
            $condition  =array(
                " search_title like '".$request['keyword']."%'"
            );
                $condition['search_type'] = 'article';
            $list = Data_Mysql_Table_Search_Logm::select("*",$condition,' group by search_title order by search_time desc,date_time desc',10);
//            foreach($list as $k=>$v){
//                $list[$k]['search_title']=self::removeXss($v['search_title']);
//            }
            return $list;
        }else{
            $list =   Data_Mysql_Table_Search_Logm::hotSearchList('article');
//            foreach($list as $k=>$v){
//                $list[$k]['search_title']=self::removeXss($v['search_title']);
//            }
            return $list;
        }
    }

    static function removeXss($title){
        $pattern  = Data_Mysql_Table_Search_Logm::$partten;
        foreach($pattern as $kk=>$vv) {
            if (stripos($title, $vv) === FALSE) {
                continue;
            } else {
                $title= str_replace($vv, '', $title);
            }
        }
        return $title;
    }
}