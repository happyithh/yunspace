<?php
/**
 * Created by PhpStorm.
 * User: adu
 * Date: 2015/12/18
 * Time: 15:07
 * 公司库
 */
class Web_Company_Search_New extends Web_Global{
    function seo(){
        if(!empty($this->request['keyword'])){
          $title = $this->request['keyword'].'相关公司,最新公司资料-【云SPACE】';
        }else{
            $title = '全国活动公司库_最新公司资料_活动场地-【云SPACE】';
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
        ));
        return $request;
    }

    function conditions()
    {
        $request = $this->request;
        $conditions['status =?'] = 1;
//        if ($this->category_id) {
//            $category_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($this->category_id);
//            $conditions[] = 'category_id IN (' . implode(',', $category_id) . ')';
//        }
//        if ($this->category_id == 0) {
//            $wenku_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
//            $conditions[] = 'category_id NOT IN (' . implode(',', $wenku_id) . ')';
////            $conditions['is_good'] = 1;
//        }
        if (!empty($request['keyword'])) {
            $conditions['vendor_name'] = $request['keyword'];
            Data_Mysql_Table_Search_Logm::searchLog($request['keyword'],'company');
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

    function getCompanyList()
    {
        $conditions = $this->conditions;
//        $getIsgood_list = $this->getIsgood;
//        if(!empty($getIsgood_list)) {
//            foreach($getIsgood_list as $k=>$v) {
//                $isgood_id[] = $v['id'];
//            }
//            $conditions[] = 'id NOT IN ('.implode(',',$isgood_id).')';
//        }
        $order = 'ORDER BY update_time DESC';
//        Data_Mysql_Table_Vendor_Info::debug(1);
        $list = Data_Mysql_Table_Vendor_Info::page(0, 8, "id, categories_id, des,vendor_name,attr_index,base_info, attr, logo,vendor_remarks, update_time", $conditions, $order);
        if (!empty($list['rows'])) {
            foreach ($list['rows'] as $k => $v) {
                $list['rows'][$k]['base_info'] = json_decode($v['base_info'], 1);
                $list['rows'][$k]['attr_index'] = json_decode($v['attr_index'], 1);
                $list['rows'][$k]['vendor_remarks'] = json_decode($v['vendor_remarks'], 1);
                $list['rows'][$k]['attr'] = json_decode($v['attr'], 1);
                $des =  preg_replace("/<(.*?)>/","",htmlspecialchars_decode($v['des']));
                $list['rows'][$k]['des'] = $des;
            }
        }
        return $list;
    }
    function getSearchList(){
        $request = $this->request;
        if (!empty($request['keyword'])) {
            $condition  =array(
                " search_title like '".$request['keyword']."%'"
            );
           $condition['search_type'] = 'company';
            $list = Data_Mysql_Table_Search_Logm::select("*",$condition,' group by search_title order by search_time desc,date_time desc',10);
            return $list;
        }else{
            $list =   Data_Mysql_Table_Search_Logm::hotSearchList('company');
            return $list;
        }
    }

}