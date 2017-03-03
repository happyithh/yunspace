<?php

/**
 * Created by PhpStorm.
 * User: zzc
 * Date: 2015/6/17
 * Time: 16:42
 */
Class Web_Activity_Raiders_Detail extends Page_Base
{

    //本文章的id
    function id()
    {
        $action_arr = explode('/', Core::$urls['action']);
        if (count($action_arr) == 2) {
            $id= (int)substr($action_arr[1], 0, -5);
        } else {
            $id= (int)substr($action_arr[0], 0, -5);
        }
        //id大于5500的不显示
        if($id>5500){
            Func_Header::notFound();
        }
        return   $id;
    }


//    function Category()
//    {
//        $conditions['id =?'] = $this->id;
//        $guessList = Data_Mysql_Table_Raiders_Info::select('category_id',$conditions,'',1);
//        $Category=$guessList[0]['category_id'];
//        return $Category;
//    }


    //本文章的category_id
    function category_id() {
        $category_rs = Data_Mysql_Table_Raiders_Info::select('category_id',array('id'=>$this->id),'',1);
        return (int)$category_rs[0]['category_id'];
    }


    //从数据库中得到所有的category_id列表
    function allCategory()
    {
        return Data_Mysql_Table_Raiders_Info::$category_name;
    }


    //文章id的父category_id和子category_id
    function topCategory()
    {
//        return Data_Mysql_Table_Raiders_Info::categoryRelation($this->Category);
        return Data_Mysql_Table_Raiders_Info::categoryRelation($this->category_id);

    }


    //获取文章中包含的套餐
    function getCommentLink()
    {
        $conditions = $this->conditions;
        $rs = Data_Mysql_Table_Raiders_Info::select('raider_set', $conditions);
        if(!empty($rs[0]['raider_set'])) {
            $set_id = $rs[0]['raider_set'];
            $raiderset_data = Data_Mysql_Table_Product_Set::select('set_name,detail,logo,id',array('id'=>$set_id));

            $raiderset_data[0]['detail'] = json_decode($raiderset_data[0]['detail'],1);
            return $raiderset_data;
        }
    }
    function  guessaccessory()
    {
        //相关文档
        foreach($this->allCategory as $k => $v) {
            if ($v['id'] == 12 || $v['parent'] == 12) {
                $vs[] = $v['id'];
            }
        }
        $all =Data_Mysql_Table_Raiders_Info::select('*',array('category_id IN (' . implode(',', $vs).')','id !=?' => $this->id),'',5);
        foreach ($all as $key => $val) {
            $val['accessory'] = json_decode($val['accessory'],1);
            preg_match_all('/\.(.*)/', $val['accessory']['name'], $match);
            $all[$key]['match'] = $match;
        }
        return $all;

    }

    function conditions()
    {

        $conditions['status =?'] = 1;
        $conditions['id =?'] = $this->id;

        return $conditions;

    }

    function getRaidersDetail()
    {
        $conditions = $this->conditions;
        $data = array();
        $rs = Data_Mysql_Table_Raiders_Info::select('*', $conditions);
        //如果没有相关数据，则显示404页面
        if (empty($rs[0]['id'])) {
            Func_Header::notFound();
        }
        if (!empty($rs[0]['tags_info'])) {
            $rs[0]['tags_info'] = json_decode($rs[0]['tags_info'], 1);
//            q($rs[0]['tags_info']);
//            $rs[0]['tags_info'] = explode(',', $rs[0]['tags_info'][0]);
        }
//        q($rs[0]['tags_info']);
//        if (!empty($rs[0]['tags_info'])) {
//            $rs[0]['keywords'] = implode(',', json_decode($rs[0]['tags_info'], true));
//        }
        if (!empty($rs[0])) {
            $rs[0]['detail_des'] = json_decode($rs[0]['detail_des'],1);
            $data = $rs[0];
        }
        //处理文章内容,关联场地百科
        $content=Api_Raiders_Handle_Content::compareRaidersContentWithSpacepedia($data);
        $data['cont']=$content;
        return $data;
    }

    function getRelationRead()
    {
        $conditions = $this->conditions;
        $result = Data_Mysql_Table_Raiders_Info::select('tags_info,category_id', $conditions);

        //先根据文章的关键词标签来查找相关文章
        if(!empty($result[0]['tags_info'])) {
            $tags_info = json_decode($result[0]['tags_info'], 1);
            $tags_info = explode(',', $tags_info[0]);
            $tag = rtrim(json_encode($tags_info[0], 1), '"');
            $tag = mb_substr($tag, -5, 5, 'UTF-8');
            $conditions_a[] = '{table}.tags_info like "%' . $tag . '%"';
            $conditions_a['status'] = 1;
            $conditions_a['id != ?'] = $this->id;
            $rs_a = Data_Mysql_Table_Raiders_Info::select('id,title', $conditions_a, '', 6);

            if(count($rs_a) == 6) {
                $rs = $rs_a;
            }

            if(count($rs_a)<6) {

                $rs_a_id = array();
                $rs_a_id[] = $this->id;
                foreach($rs_a as $k => $v) {
                    $rs_a_id[] = $v['id'];
                }
//                q($rs_a_id); //id为3,2,9
                $category_id = $result[0]['category_id'];
                $conditions_b['status'] = 1;
                $conditions_b['category_id'] = $category_id;
//                $conditions_b['id != ?'] = $this->id;
                $conditions_b[] = 'id NOT IN ('.implode(',',$rs_a_id).')';
                $rs_b = Data_Mysql_Table_Raiders_Info::select('id,title', $conditions_b, '', 6-count($rs_a));


                if((count($rs_a)+count($rs_b))==6) {
                    $rs = array_merge($rs_a,$rs_b);
                }
                if((count($rs_a)+count($rs_b))<6) {

                    $rs_b_id = $rs_c_id = array();
                    foreach($rs_b as $k => $v) {
                        $rs_b_id[] = $v['id'];
                    }
//                    q($rs_b_id); //id为7
                    $rs_c_id[] = array_merge($rs_a_id,$rs_b_id);
                    $conditions_c['status'] = 1;
//                    $conditions_c['id != ?'] = $this->id;
                    $conditions_c[] = 'id NOT IN ('.implode(',',$rs_c_id[0]).')';
                    $rs_c = Data_Mysql_Table_Raiders_Info::select('id,title', $conditions_c, 'ORDER BY {table}.counter_view DESC', 6-(count($rs_a)+count($rs_b)));

                    $rs = array_merge($rs_a,$rs_b,$rs_c);
                }
            }
            //如果关键字为空，则根据文章的category_id来查相关文章
        } else {
            $conditions_d['status'] = 1;
            $conditions_d['id != ?'] = $this->id;
            $category_id = $result[0]['category_id'];
            $conditions_d['category_id'] = $category_id;
            $rs_d = Data_Mysql_Table_Raiders_Info::select('id,title', $conditions_d, '', 6);
            if(count($rs_d)==6) {
                $rs = $rs_d;
            }
            if(count($rs_d)<6) {
                $rs_d_id = array();
                $rs_d_id[] = $this->id;
                foreach($rs_d as $k=>$v) {
                    $rs_d_id[] = $v['id'];
                }
                $conditions_e['status'] = 1;
//                $conditions_e['id != ?'] = $this->id;
                $conditions_e[] = 'id NOT IN ('.implode(',',$rs_d_id).')';
                $rs_e = Data_Mysql_Table_Raiders_Info::select('id,title', $conditions_e, 'ORDER BY {table}.counter_view DESC', 6-count($rs_d));
                $rs = array_merge($rs_d,$rs_e);
            }
        }
        return $rs;
    }

    function  getCommentList()
    {

        $data = Data_Mysql_Table_Comment::getCommentList($this->id, 1);

        return $data;
    }



    //获取对应文章对应用户名的点赞数
//    function getPraise()
//    {
//        $user_id = $_SESSION['user']['id'];
//        $title_id = $this->id;
//        $rs = Data_Mysql_Table_Praise::select('praise', array('user_id =?' => $user_id, 'title_id =?' => $title_id));
//        return $rs[0];
//    }


    //获取已登录用户头像
    function getPhoto()
    {
        $username = $_SESSION['user']['username'];
        $rs = Data_Mysql_Table_Account::select('avatar', array('username =?' => $username));
        return $rs[0];
    }


    //获取对应评论对应用户名的点赞数
    function getCommentpraise()
    {
        $user_id = $_SESSION['user']['id'];
        $comment_id = $this->getcommentListid;
        $conditions[] = 'comment_id IN (' . implode(',', $comment_id) . ')';
        $conditions['user_id'] = $user_id;
        $rs = Data_Mysql_Table_Comment_Praise::page(0,0,'*',$conditions);
        if(!empty($rs['rows'])) {
            $arr = array();
            foreach($rs['rows'] as $v) {
                $arr[] = $v['comment_id'];
            }
            return $arr;
        }
    }

    //获取该文章下的所有评论列表的id
    function getcommentlistid()
    {
        $title_id = $this->id;
        $rs = Data_Mysql_Table_Comment::page(0,0,'id',array('from_id =?' => $title_id));
        $a = array();
        foreach($rs['rows'] as $k => $v) {
            $a[] = $v['id'];
        }
        return $a;
    }
    //获取 相关场地或套餐
    function getCommentLinks(){
//        q(Data_Mysql_Table_Product_Set::$category_name);
        $conditions = $this->conditions;
        $res = array();
        $res1 = array();
        $data = array();
        $rs = Data_Mysql_Table_Raiders_Info::select('id,cont', $conditions);
        if(!empty($rs[0])){
//            preg_match_all("/http:\/\/yun.cc\/[a-z]*[_]?[a-z]*\/[0-9]*.html/",$rs[0]['cont'],$matches);
//            preg_match_all("/http:\/\/".Core::$urls['host']."\/[a-z]*[_]?[a-z]*\/[0-9]*.html/",$rs[0]['cont'],$matches);
            preg_match_all("/http:\/\/(pre0.yunspace.com.cn|www.yunspace.com.cn|".Core::$urls['host'].")\/[a-z]*[_]?[a-z]*\/[0-9]*.html/",$rs[0]['cont'],$matches);
//            q($matches);
            $matches[0] = array_unique($matches[0]);
//            q($matches[0]);
            if(!empty($matches[0])){
                foreach($matches[0] as $k=>$v) {
                    $mark[$k] = explode('/',$v) ;
                    $id[$k] = explode('.',$mark[$k][4]);
//                    q($mark[$k][3]);
                    if($mark[$k][3]=='set_info' && is_numeric($id[$k][0])) {
                        $res[$k] = Data_Mysql_Table_Product_Set::select('{table}.id,{table}.category_id,{table}.set_price,{table}.set_name,{table}.logo,{table}.attr_index,{prefix}product_search.attr_index as info_attr',array('id'=>$id[$k][0],'status'=>1),'',1,'{table} LEFT JOIN {prefix}product_search ON {table}.schedule_product_id={prefix}product_search.id');
                        if(!empty($res[$k])){
                            foreach(Data_Mysql_Table_Product_Set::$category_name as $cate_k=>$cate_v) {
                                if($res[$k][0]['category_id']==$cate_k) {
                                    $res[$k][0]['category_name'] = $cate_v;
                                }
                            }
                            $getUrl = explode('<',$v);
                            $res[$k][0]['url']= $getUrl[0];
                        }else{
                            unset($res[$k]);
                        }
                    }
                    if($mark[$k][3]=='service_info' && is_numeric($id[$k][0])){
                        $res[$k] = Data_Mysql_Table_Product_Search::select("id,product_name,logo,attr_index",array('id'=>$id[$k][0],'status'=>1));
                        if(!empty($res[$k])){
                            $getUrl1 = explode('<',$v);
                            $res[$k][0]['url']= $getUrl1[0];
                        }else{
                            unset($res[$k]);
                        }

                    }
//                    if($mark[$k][3]=='service_info' && is_numeric($id[$k][0])){
//                        $res1[$k] = Data_Mysql_Table_Product_Search::select("id,product_name,logo,attr_index",array('id'=>$id[$k][0],'status'=>1));
//                        if(!empty($res1[$k])){
//                            $getUrl1 = explode('<',$v);
//                            $res1[$k][0]['url']= $getUrl1[0];
//                        }else{
//                            unset($res1[$k]);
//                        }
//
//                    }
                }
//                $data = array_merge($res,$res1);
                $data = $res;
            }
        }
        if(!empty($data[0])){
            return $data;
        }
    }


    //云发现详情页相关场地推荐
    function getRelationProduct() {
        $attr_new = $this->getCommentLinks();
//        q($attr_new);
        $attr = $product_id = array();
        if(!empty($attr_new)) {
            foreach ($attr_new as $k => $v) {
                if (!empty($v[0]['product_name'])) {
                    $attr[] = $v[0]['attr_index'];
                    $product_id[] = $v[0]['id'];
                }
            }
        } else {
            $attr = array();
        }
//        q($attr);
        if(!empty($attr)) {
            foreach($attr as $k=>$v) {
                $attr[$k] = json_decode($v,1);
            }
            if(!empty($attr[0][49])) {
                $conditions['attr_index'][49] ='+'.$attr[0][49];
            }
            if(!empty($attr[0][9])) {
                $conditions['attr_index'][9] = '+'.$attr[0][9];
            }
            if(!empty($attr[0][46])) {
                $conditions['attr_index'][46] = '+'.$attr[0][46];
            }
            $space_id = Data_Mysql_Table_Product_Category::getChildren(112);
            $conditions['status'] = 1;
            $conditions[] = 'id NOT IN (' . implode(',', $product_id) . ')';
            $conditions[] = 'category_id IN (' . implode(',', $space_id) . ')';
            $order = 'ORDER BY update_time DESC';
            $rs = Data_Mysql_Table_Product_Search::select('id, product_name,logo,vendor_name,price,attr_index,addr',$conditions,$order,3);
            foreach($rs as $k=>$v) {
                $rs[$k]['attr_index'] = json_decode($v['attr_index'],1);
            }
        } else {
            $space_id = Data_Mysql_Table_Product_Category::getChildren(112);
            $conditions[] = 'category_id IN (' . implode(',', $space_id) . ')';
            $conditions['status'] = 1;
            $order = 'ORDER BY order_index DESC';
            $rs_rand = Data_Mysql_Table_Product_Search::select('id,vendor_id, product_name,logo,vendor_name,addr,price,attr_index',$conditions,$order,12);
            $rs_key = array_rand($rs_rand,3);
            foreach($rs_key as $val) {
                $rs[] = $rs_rand[$val];
            }
            foreach($rs as $k=>$v) {
                $rs[$k]['attr_index'] = json_decode($v['attr_index'],1);
            }
        }
        return $rs;
    }
//        elseif (empty($attr_new)) {
//            $space_id = Data_Mysql_Table_Product_Category::getChildren(112);
//            $conditions[] = 'category_id IN (' . implode(',', $space_id) . ')';
//            $conditions['status'] = 1;
//            $order = 'ORDER BY order_index DESC';
//            $rs = Data_Mysql_Table_Product_Search::select('id,vendor_id, product_name,logo,vendor_name,addr,price,attr_index',$conditions,$order,3);
//            foreach($rs as $k=>$v) {
//                $rs[$k]['attr_index'] = json_decode($v['attr_index'],1);
//            }
//            return $rs;
//        }
//    }


    //获取云发现轮播图的文章信息
    function getBannerList()
    {
        $conditions['is_hot'] = 1;
        $conditions['status'] = 1;
        if($this->category_id) {
            $p = Data_Mysql_Table_Raiders_Info::categoryRelation($this->category_id);
            $in_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($p['top_id']);
            $conditions[] = 'category_id IN (' . implode(',', $in_id) . ')';
        }
        $conditions['id !=?'] =$this->id ;
//        q($conditions);
        $order = 'ORDER BY {table}.create_time DESC';
        return $getBannerList = Data_Mysql_Table_Raiders_Info::select('id,title,category_id,des,logo',$conditions,$order,4);
    }

    //获取云发现推荐的文章信息
    function getHotList() {
//        q($this->category_id());
        $notin_id = array();
        $getBannerList = $this->getBannerList();
        if(!empty($getBannerList)) {
            foreach($this->getBannerList() as $k => $v) {
                $notin_id[] = $v['id'];
                $conditions[] = 'id NOT IN (' . implode(',', $notin_id) . ')';
            }
        }
        if(!empty($this->category_id)) {
            $p = Data_Mysql_Table_Raiders_Info::categoryRelation($this->category_id);
            $in_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($p['top_id']);
            $conditions[] = 'category_id IN (' . implode(',', $in_id) . ')';
        }
        $conditions['id !=?'] =$this->id ;
        $conditions['is_hot'] = 1;
        $conditions['status'] = 1;
        $order = 'ORDER BY {table}.create_time DESC';
        return $getHotList = Data_Mysql_Table_Raiders_Info::select('id,title',$conditions,$order,4);
    }

    function getHotCount() {
        return count($this->getBannerList());
    }

    //获取周浏览量排行（9条）
    function getWeekTopView() {
        $conditions['status'] = 1;
        $conditions['{table}.create_time > ?'] = time()-3600*24*7;
//        $wenku_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
//        $conditions[] = 'category_id NOT IN (' . implode(',', $wenku_id) . ')';
        $p = Data_Mysql_Table_Raiders_Info::categoryRelation($this->category_id);
        $in_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($p['top_id']);
        $conditions[] = 'category_id IN (' . implode(',', $in_id) . ')';
        $order = 'ORDER BY {table}.counter_view DESC';
        $getWeekTopView = Data_Mysql_Table_Raiders_Info::select('id,title,counter_view',$conditions,$order,9);
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
        $p = Data_Mysql_Table_Raiders_Info::categoryRelation($this->category_id);
        $in_id = Data_Mysql_Table_Raiders_Info::getCategoryChildren($p['top_id']);
        $conditions[] = 'category_id IN (' . implode(',', $in_id) . ')';
        $order = 'ORDER BY {table}.counter_praise DESC';
        $getWeekTopPraise = Data_Mysql_Table_Raiders_Info::select('id,title,counter_praise',$conditions,$order,9);
        if(count($getWeekTopPraise) < 9) {
            unset($conditions['{table}.create_time > ?']);
            $getWeekTopPraise = Data_Mysql_Table_Raiders_Info::select('id,title,counter_praise', $conditions, $order, 9);
        }
        return $getWeekTopPraise;
    }


}