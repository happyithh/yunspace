<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/6/17
 * Time: 16:42
 */
Class Web_Activity_Raiders extends Page_Base
{

    //获取某个栏目列表的category_id
    function category_id()
    {
        if (is_numeric(Core::$urls['action'])) {
            $category_id = Core::$urls['action'];
        } else {
            $category_id = 0;
        }
        return $category_id;
    }


    //获取此category_id的父category_id和子category_id
    function topCategory_id()
    {
        return Data_Mysql_Table_Raiders_Info::categoryRelation($this->category_id);

    }


    //获取一个category_id的所有子category_id，不包含本身id
    function getChildren($id)
    {
        $Children_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($id);
        unset($Children_id[0]);
        return $Children_id;
    }

    //查出所有的category_id数组
    static function allCategory()
    {
        return Data_Mysql_Table_Raiders_Info::$category_name;
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
        //id小于5400
        $conditions['create_time <= ?'] = time();
        $conditions['status =?'] = 1;
        if ($this->category_id) {
            $category_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($this->category_id);
            $conditions[] = 'category_id IN (' . implode(',', $category_id) . ')';
        }
        if ($this->category_id == 0) {
            $wenku_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
            $conditions[] = 'category_id NOT IN (' . implode(',', $wenku_id) . ')';
//            $conditions['is_good'] = 1;
        }
        if (!empty($request['keyword'])) {
            $conditions['title'] = $request['keyword'];
            $conditions['author'] = $request['keyword'];
        }
        $action_arr = explode('/', Core::$urls['action']);
        if(!empty($action_arr[1])) {
            $action_arr[1] = urldecode($action_arr[1]);
        }
        if($action_arr[0] =='tags') {
            $conditions['tags_info'] = $action_arr[1];
        }
        //id大于5500的不显示
        $conditions['id <= ?']=5500;
        return $conditions;

    }

    //推荐的4篇文章
    function getIsgood()
    {
        $conditions['status = ?'] = 1;
        $conditions['is_good = ?'] = 1;
        $wenku_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
        $conditions[] = 'category_id NOT IN (' . implode(',', $wenku_id) . ')';
        //id大于5500的不显示
        $conditions['id <= ?']=5500;
        $rs_good = Data_Mysql_Table_Raiders_Info::select('id,title,create_time,author,logo,des,tags_info,counter_view,counter_praise',$conditions,'ORDER BY create_time DESC',4);
        foreach ($rs_good as $key => $val) {
            $rs_good[$key]['create_time'] = Date('Y-m-d H:i:s', $val['create_time']);
        }
        return $rs_good;
    }

    function getRaidersList()
    {
        $conditions = $this->conditions;
        $getIsgood_list = $this->getIsgood;
        if(!empty($getIsgood_list)) {
            foreach($getIsgood_list as $k=>$v) {
                $isgood_id[] = $v['id'];
            }
            $conditions[] = 'id NOT IN ('.implode(',',$isgood_id).')';
        }
        $conditions['id <= ?'] = 5400;
        $order = 'ORDER BY {table}.create_time desc';
        $rs = Data_Mysql_Table_Raiders_Info::page(0, 0, 'id,title,create_time,author,logo,des,tags_info,counter_view,counter_praise', $conditions, $order);
        foreach ($rs['rows'] as $key => $val) {
            $rs['rows'][$key]['create_time'] = Date('Y-m-d H:i:s', $val['create_time']);
        }
        return $rs;
    }

    function  guessYouLike()
    {
        //猜你喜欢数据
        $guessConditions = Web_Account::getFootPrintConditions();
        $guessConditions['attr_index'][46] = '+' . $_COOKIE['city'];
        $guessConditions['status'] = 1;
        $guessList = Data_Mysql_Table_Product_Search::select('id, product_name, logo, price', $guessConditions, '', 6);
        foreach ($guessList as $k => $v) {
            $guessList[$k]['price'] = $v['price'] > 10000 ? intval($v['price'] / 100) : 0;
        }
        return $guessList;
    }

    function getaccessory()
    {
        $conditions = $this->conditions;
        $order = 'ORDER BY {table}.create_time desc';
        $rs = Data_Mysql_Table_Raiders_Info::page(0, 20, 'id,title,create_time,logo,des,tags_info,download,counter_view,counter_praise,accessory,category_id', $conditions, $order);
        foreach ($rs['rows'] as $key => $val) {
            $rs['rows'][$key]['create_time'] = Date('Y-m-d', $val['create_time']);
            //  q($val['accessory']);

            $rs['rows'][$key]['accessory'] = json_decode($val['accessory'], 1);

        }
        return $rs;
    }

    //获取云发现轮播图的文章信息
    function getBannerList()
    {
        $conditions['is_hot'] = 1;
        $conditions['status'] = 1;
//        $conditions['category_id'] = !empty($this->category_id()) ? $this->category_id() :;
//        q($conditions);
        if(!empty($this->category_id)) {
            $p = Data_Mysql_Table_Raiders_Info::categoryRelation($this->category_id);
            $in_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($p['top_id']);
            $conditions[] = 'category_id IN (' . implode(',', $in_id) . ')';
        }
        //id大于5500的不显示
        $conditions['id <= ?']=5500;
        $order = 'ORDER BY {table}.create_time DESC';
        return $getBannerList = Data_Mysql_Table_Raiders_Info::select('id,title,des,logo',$conditions,$order,4);
    }

    //获取云发现推荐的文章信息
    function getHotList() {
//        q($this->category_id());
        $notin_id = array();
        $getBannerList = $this->getBannerList();
        if(!empty($getBannerList)) {
            foreach($this->getBannerList() as $k => $v) {
                $notin_id[] = $v['id'];
            }
        }
        if(!empty($this->category_id)) {
            $p = Data_Mysql_Table_Raiders_Info::categoryRelation($this->category_id);
            $in_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($p['top_id']);
            $conditions[] = 'category_id IN (' . implode(',', $in_id) . ')';
        }
        $conditions[] = 'id NOT IN (' . implode(',', $notin_id) . ')';
        $conditions['is_hot'] = 1;
        $conditions['status'] = 1;
        //id大于5500的不显示
        $conditions['id <= ?']=5500;
//        q($conditions);
        $order = 'ORDER BY {table}.create_time DESC';
        return $getHotList = Data_Mysql_Table_Raiders_Info::select('id,title',$conditions,$order,4);
    }

    function getHotCount() {
        return count($this->getBannerList());
    }


    //获取周浏览量排行（9条）
    function getWeekTopView() {
        $conditions['{table}.create_time > ?'] = time()-3600*24*7;
        if(!empty($this->category_id)) {
            $p = Data_Mysql_Table_Raiders_Info::categoryRelation($this->category_id);
            $in_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($p['top_id']);
            $conditions[] = 'category_id IN (' . implode(',', $in_id) . ')';
        }else{
            $not_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
            $conditions[] = 'category_id NOT IN (' . implode(',', $not_id) . ')';
        }
        $conditions['status'] = 1;
        //id大于5500的不显示
        $conditions['id <= ?']=5500;
        $order = 'ORDER BY {table}.counter_view DESC';
        $getWeekTopView = Data_Mysql_Table_Raiders_Info::select('id,title,counter_view', $conditions, $order, 9);
        if(count($getWeekTopView) < 9) {
            unset($conditions['{table}.create_time > ?']);
            $getWeekTopView = Data_Mysql_Table_Raiders_Info::select('id,title,counter_view', $conditions, $order, 9);
        }
        return $getWeekTopView;
    }

    //获取周点赞排行（9条）
    function getWeekTopPraise() {
        $conditions['status'] = 1;
        $conditions['{table}.create_time > ?'] = time()-3600*24*7;
        if(!empty($this->category_id)) {
            $p = Data_Mysql_Table_Raiders_Info::categoryRelation($this->category_id);
            $in_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($p['top_id']);
            $conditions[] = 'category_id IN (' . implode(',', $in_id) . ')';
        }else{
            $not_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
            $conditions[] = 'category_id NOT IN (' . implode(',', $not_id) . ')';
        }
        //id大于5500的不显示
        $conditions['id <= ?']=5500;
        $order = 'ORDER BY {table}.counter_praise DESC';
        $getWeekTopPraise = Data_Mysql_Table_Raiders_Info::select('id,title,counter_praise',$conditions,$order,9);
        if(count($getWeekTopPraise) < 9) {
            unset($conditions['{table}.create_time > ?']);
            $getWeekTopPraise = Data_Mysql_Table_Raiders_Info::select('id,title,counter_praise', $conditions, $order, 9);
        }
        return $getWeekTopPraise;
    }
//
    function getWenkuView() {
        $conditions['status'] = 1;
        $wenku_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
        $conditions[] = 'category_id IN (' . implode(',', $wenku_id) . ')';
//        $conditions['category_id'] = 12;
        //id大于5500的不显示
        $conditions['id <= ?']=5500;
        $order = 'ORDER BY {table}.counter_view DESC';
        return $getWenkuView = Data_Mysql_Table_Raiders_Info::select('id,title,counter_view',$conditions,$order,9);
    }

    function getWenkuLoad() {
        $conditions['status'] = 1;
        $wenku_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
        $conditions[] = 'category_id IN (' . implode(',', $wenku_id) . ')';
        //id大于5500的不显示
        $conditions['id <= ?']=5500;
//        $conditions['category_id'] = 12;
        $order = 'ORDER BY {table}.download DESC';
        return $getWenkuView = Data_Mysql_Table_Raiders_Info::select('id,title,download',$conditions,$order,9);
    }


}