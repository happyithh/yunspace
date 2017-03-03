<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2015/10/22
 * Time: 09:30
 * @场地百科
 */
class  Web_Article_Info extends Web_Global
{
    function seo()
    {
        return array(
//            '网页标题'=>'云space-'.$this->getBaikeName.$this->info['baike_word'][0].'-'.$this->info['title'].'_场地百科|云SPACE',
            '网页标题' => $this->info['title'] . '-【云SPACE】',
            '网页关键词' => $this->getBaikeName . ',' . $this->info['title'] . ',' . $this->getTags,
            '网页简介' => mb_substr(trim(strip_tags($this->info['des'])), 0, 300, 'utf-8')
        );
    }

    // 获取文章 关键词 用于seo
    function getTags()
    {
        $tags = implode(',', $this->info['tags_info']);
        return $tags;
    }

    // 获取百科名称
    function getBaikeName()
    {
        $baikeName = '';
        if (!empty($this->getSpaceId)) {
            $space = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($this->getSpaceId);
            if (!empty($space[0])) {
                $baikeName = $space[0]['space_name'];
            }
        }
        return $baikeName;
    }

    // 获取百科ID
    function getSpaceId()
    {
        $space_id = 0;
        if (!empty($this->info['space_ids'])) {
            $space_ids = explode(",", $this->info['space_ids']);
            $space_id = $space_ids[0];
        }
        return $space_id;
    }


    /*
     * 文章id
     */
    function id()
    {
        $action_arr = explode('/', Core::$urls['action']);

        if (count($action_arr) == 2) {
            if (strpos($action_arr[1], '_')) {
                $action_arr = explode('_', $action_arr[1]);
                return Func_NumEncode::d($action_arr[0]);
            } else {
                return (int)Func_NumEncode::d(substr($action_arr[1], 0, -5));
            }

        } else {
            if (strpos($action_arr[0], '_')) {
                $action_arr = explode('_', $action_arr[0]);
                return Func_NumEncode::d($action_arr[0]);
            } else {
                return (int)Func_NumEncode::d(substr($action_arr[0], 0, -5));
            }

        }
    }


    //从数据库中得到所有的category_id列表
    function allCategory()
    {
        return Data_Mysql_Table_Raiders_Info::$category_name;
    }


    //文章id的父category_id和子category_id
    function topCategory()
    {
        return Data_Mysql_Table_Raiders_Info::categoryRelation($this->info['category_id']);

    }


    function conditions()
    {

        $conditions['status =?'] = 1;
        $conditions['id =?'] = $this->id;
        $conditions['create_time <=?'] = time();

        return $conditions;

    }

    function info()
    {
        $conditions = $this->conditions;
        $data = array();
        $rs = Data_Mysql_Table_Raiders_Info::select('*', $conditions);
        //如果没有相关数据，则显示404页面
        if (empty($rs[0]['id'])) {
            Func_Header::notFound();
        }
        if(!empty($rs[0]['is_jump'])){
            Func_Header::to('',$rs[0]['is_jump']);
        }
        if (!empty($rs[0]['tags_info'])) {
            $rs[0]['tags_info'] = json_decode($rs[0]['tags_info'], 1);
        }
        if (!empty($rs[0])) {
            $rs[0]['detail_des'] = json_decode($rs[0]['detail_des'], 1);
            $data = $rs[0];
        }
        if (!empty($data['accessory']) && !empty($data['accessory']['path'])) {
            $data['accessory'] = json_decode($data['accessory'], 1);
            $data['paperType'] = self::paperType($data['accessory']['name']);
        }
        //处理文章内容,关联场地百科
        $content = Api_Raiders_Handle_Content::compareRaidersContentWithSpacepedia($data, "site");
        $data['cont'] = $content;
        if (!empty($data['baike_word'])) {
            $data['baike_word'] = json_decode($data['baike_word'], 1);
        }
        return $data;
    }

    // 判断上传的文库类型
    function paperType($name)
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

    // 文库子类

    function paperChildren()
    {
        if (strpos(Core::$urls['action'], '_')) {
            $action_arr = explode('/', Core::$urls['action']);
            $paperChildren = explode('_', $action_arr[0]);
            return substr($paperChildren[1], 0, -5);
        } else {
            return 13;
        }
    }

    // 你可能喜欢[获取文库分类下的文章]
    // 活动方案
    function paperActivity()
    {
        $args['type'] = 13;
        $args['id'] = $this->id;
        return Api_Raiders_Paper_Children_List::getChildrenList($args);
    }
    // 策划技巧
    function paperPlanning()
    {
        $args['type'] = 14;
        $args['id'] = $this->id;
        return Api_Raiders_Paper_Children_List::getChildrenList($args);
    }
    // 演讲稿
    function paperSpeech()
    {
        $args['type'] = 22;
        $args['id'] = $this->id;
        return Api_Raiders_Paper_Children_List::getChildrenList($args);
    }
    // 营销传播
    function paperMarketing()
    {
        $args['type'] = 15;
        $args['id'] = $this->id;
        return Api_Raiders_Paper_Children_List::getChildrenList($args);
    }

    /*
     *获取相关文章
     */
    function relateArticle()
    {
        $rs = $rs_b = $rs_c = array();
        //先根据文章的关键词标签来查找相关文章
        $order='ORDER BY create_time DESC';
        if (!empty($this->info['tags_info'])) {
            $conditions_a['tags_info = ?'] = $this->info['tags_info'];
            $conditions_a['status'] = 1;
            $conditions_a['id != ?'] = $this->id;
            $rs = Data_Mysql_Table_Raiders_Info::select('id,title,logo,des', $conditions_a, $order, 5);

            if (count($rs) < 5) {
                foreach ($rs as $k => $v) {
                    $rs_ids[] = $v['id'];
                }
                $rs_ids[] = $this->id;
                $conditions_b['status'] = 1;
                $conditions_b['category_id'] = $this->info['category_id'];
                $conditions_b[] = 'id NOT IN (' . implode(',', $rs_ids) . ')';
                $rs_b = Data_Mysql_Table_Raiders_Info::select('id,title,logo,des', $conditions_b, $order, 5 - count($rs));
                //如果关键字为空，则根据文章的category_id来查相关文章
            } else {
                $conditions_b['status'] = 1;
                $conditions_b['category_id'] = $this->info['category_id'];
                $rs_b = Data_Mysql_Table_Raiders_Info::select('id,title,logo,des', $conditions_b, $order, 5);
            }

        }
        $data_c = array_merge($rs, $rs_b);
        if (count($data_c) < 5) {
            foreach ($data_c as $k => $v) {
                $rs_ids_c[] = $v['id'];
            }
            $rs_ids_c[] = $this->id;
            if (!empty($rs_ids_c)) {
                $conditions_c[] = 'id NOT IN (' . implode(',', $rs_ids_c) . ')';
            }
            $conditions_c['status'] = 1;
            $rs_c = Data_Mysql_Table_Raiders_Info::select('id,title,logo,des', $conditions_c, $order, 5 - count($data_c));
        }
        $return = array_merge($data_c, $rs_c);
        return $return;
    }

    /*
     * 获取精品推荐文章
     */
    function  isGoodArticle()
    {
        $rs = $rs1 = array();
        $condition['status'] = 1;
        $condition['id != ?'] = $this->id;
        $condition['is_good'] = 1;
        $order='ORDER BY create_time DESC';
        $rs = Data_Mysql_Table_Raiders_Info::select('id,title,logo,des,create_time,counter_praise,counter_view', $condition, $order, 3);
        if (count($rs) < 3) {
            foreach ($rs as $k => $v) {
                $rs_ids[] = $v['id'];
            }
            $rs_ids[] = $this->id;

            if (!empty($rs_ids)) {
                $conditions_c[] = 'id NOT IN (' . implode(',', $rs_ids) . ')';
            }
            $conditions_c['status'] = 1;
            $rs1 = Data_Mysql_Table_Raiders_Info::select('id,title,logo,des,create_time', $conditions_c, $order, 3 - count($rs));
        }
        $return = array_merge($rs, $rs1);
        return $return;
    }

    /*
     * 获取最新文章
     */
    function  isNewArticle()
    {
        $rs = array();
        $condition['status'] = 1;
        $condition['id != ?'] = $this->id;
        $rs = Data_Mysql_Table_Raiders_Info::select('id,title,logo,create_time', $condition, 'ORDER BY create_time DESC', 5);
        return $rs;
    }

    /*
     * 更新文章浏览量
     */
    function updateRaidersCountView()
    {
        Data_Mysql_Table_Raiders_Info::query('UPDATE {table} SET counter_view=counter_view+1 WHERE id=' . $this->id);
    }


    /*
     *处理文章与相关百科的浏览量
     */
//    function updateCountViewReletaBaike(){
//        $space_id=Api_Raiders_Handle::getRelateSpaceByRaidersId($this->id);
//        if(!empty($space_id)){
//            foreach($space_id as $k=>$v){
//                Data_Mysql_Table_Baike_Statistical::query('INSERT INTO {table} (space_id ,click) VALUES ("'.$v.'", 1)  ON DUPLICATE KEY UPDATE click = click +1');
//            }
//        }
//    }

    // 获取百科的tags
    function baikeTags()
    {
//        $tags = Data_Mysql_Table_Spacepedia::select('cache_tags',array('space_name'=>$this->info['baike_word'][0]));
        $tags = Data_Mysql_Table_Spacepedia::select('cache_tags', array('id' => $this->getSpaceId));
        if (!empty($tags[0]['cache_tags'])) {
            $tags = array_slice(json_decode($tags[0]['cache_tags'], 1), 0, 10, true);
        } else {
            $tags['tags'] = '';
        }
        return $tags['tags'];
    }

    // 获取百科信息
    function baikeInfo()
    {
        if ($this->getSpaceId) {
            //初始化百科的浏览量
            $article_view = Data_Mysql_Table_Raiders_Info::select("sum(counter_view) as total", array("space_ids" => $this->getSpaceId));
            $num = empty($article_view[0]['total']) ? 0 : $article_view[0]['total'];
            Data_Mysql_Table_Baike_Statistical::query('INSERT INTO {table} (space_id ,click) VALUES ("' . $this->getSpaceId . '", ' . $num . ')  ON DUPLICATE KEY UPDATE click = click +1');
            //获取百科信息
            $conditions['t1.id = ?'] = $this->getSpaceId;
            $logo = Data_Mysql_Table_Spacepedia::select('t1.id,t1.logo,t1.level,t1.space_name,t1.addr,t2.click,t2.is_love,t2.is_good,t2.is_go', $conditions, '', 1, '{table} as t1 LEFT JOIN {prefix}baike_statistical as t2 ON t1.id=t2.space_id');
            //获取百科浏览量和我喜欢，现场足迹信息
            $count_num['space_id'] = $this->getSpaceId;
            $click = Api_Baike_Like_Go::initBaikeCountNum($count_num);
            $people = Api_Baike_Like_Go::initLikeAndGoNum($count_num);
            $logo[0]['click'] = $click['data'];
            $logo[0]['sum'] = $people['is_love'] + $people['is_go'];
            return $logo[0];
        } else {
            return array();
        }
    }

    /**
     *
     * 零售详情页面使用数据   ------------开始----------------
    */
    // 判断是否是零售
    function isRetail(){
        if(count($this->info())>0 && strstr($this->info['space_ids'],'10644')){
            return true;
        }else{
            return false;
        }
    }
    // 最新资讯
    function newInformation(){
        $args['id'] = $this->id;
        $data = Api_Retail_New_Information::newInformation($args);
        return $data;
    }
    // 精心推荐
    function recommend(){
        $data = Api_Retail_Information_List::InformationList();
        $recommend = array();
        foreach($data as $k=>$v){
            if($v['id']==$this->id){
                unset($data[$k]);
            }else{
                if(count($recommend)<5){
                    $recommend[]=$data[$k];
                }
            }

        }
        return $recommend;
    }

    //优质空间
    function qualitySpace()
    {
        $category_id = Data_Mysql_Table_Spacepedia::getChildren(112);
        $conditions[] = "category_id IN (".implode(',',$category_id).")";
        $conditions['logo !=?'] = '';
        $conditions['status =?'] =1;
        $data = Data_Mysql_Table_Spacepedia::select('id,space_name,logo',$conditions,'ORDER BY create_time DESC',3);
        return $data;
    }

    /**
     *
     * 零售详情页面使用数据   ------------结束----------------
    */

}