<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2015/10/22
 * Time: 09:30
 * @场地百科
 */
@session_start();

class  Web_Baike_Info extends Web_Global
{
    function seo()
    {
        switch($this->baikeAction)
        {
            case '最新':
                $title = $this->info['space_name'].'最新活动资讯-【云SPACE】';
                break;
            case '精华':
                $title = $this->info['space_name'].'精华活动资讯-【云SPACE】';
                break;
            case '百科':
                if($this->item_id){
                    $title = $this->info['space_name'].'-'.$this->itemInfo['item_name'].'-场地价格-场地图片-场地租赁-【云SPACE】';
                }elseif (isset($this->action[2]) && $this->action[2] == '图片') {
                    $title = $this->info['space_name'] . '-场地图片-' . count($this->spaceMedia) . '张';
                }else{
                    $title = $this->info['space_name']."-".$this->info['city'].$this->info['category_name'].'-场地租赁-【云SPACE-场地百科】';
                }
                // $title = $this->info['space_name']."集合-".$this->info['category_name'].'-【云SPACE】';
                break;
//            case '讨论组':
//                $title = $this->info['space_name'].'讨论组-【云SPACE】';
//                break;
            default:
                $title = $this->info['space_name'].'讨论组-【云SPACE】';
        }
        return array(
//            '网页标题' => '云space-'.$this->info['space_name'] . '_场地百科|云SPACE',
            '网页标题' => $title,
            '网页关键词' => $this->info['category_name'].$this->info['space_name'].','.$this->info['addr'].$this->info['space_name'].','.$this->info['space_name'] . ',' . $this->info['city'] . $this->info['space_name'] . ',' . $this->info['space_name'] . '百科,' . $this->info['special_tags'] . ',',
            '网页简介' => $this->info['category_name'].'-'.$this->info['city'].$this->info['addr'].'-'.$this->info['space_name'].'-'.mb_substr(trim(strip_tags($this->info['des'])), 0, 300, 'utf-8')
        );
    }

    function action()
    {
        $action = Func_Url::str_urldecode(Func_String::utf8(Core::$urls['action']));
        $return = explode("-", $action);
        $action_type=array("最新","精华","百科","子空间","讨论组");
        if(!empty( $return[1]) && !in_array($return[1],$action_type)){
            foreach($return as $k=>$v){
                if(!empty($return[$k+1])){
                    $return1[]=$return[$k+1];
                }
            }
            $return1[0]=$return[0]."-".$return1[0];
            $return1[1] = empty($return1[1]) ? "最新" : $return1[1];
            return $return1;
        }else{
            $return[1] = empty($return[1]) ? "最新" : $return[1];
            return $return;
        }

    }
    /*
    *判断当前路径是否有inner
    */
    function is_inner(){
        if($this->action[1]=="百科" && !empty($this->action[2])){
            if(strstr($this->action[2],'inner')){
                return true;
            }        
        }
        return false;
    }
    /*
     *获取空间id
     */
    function item_id(){
        if($this->action[1]=="百科" && !empty($this->action[2])){
            $item_id=str_replace('inner','',$this->action[2]);
            return Func_NumEncode::d($item_id);
        }
        return false;
    }

    /*
     *获取空间详情
     */
    function itemInfo(){
        $itemInfo=array();
        if($this->item_id){
            // $item=Data_Mysql_Table_Space_Item::select('*',array("space_id"=>$this->info['id'],'id'=>$this->item_id,'status'=>1));
            // if(!empty($item[0])){
            //     $itemInfo=$item[0];
            //     if(!empty($itemInfo['media'])){
            //         $itemInfo['media']=json_decode($itemInfo['media'],1);
            //     }
            //     if(!empty($itemInfo['min_price'])){
            //         $itemInfo['min_price']=$itemInfo['min_price']/100;
            //     }
            //     if(!empty($itemInfo['max_price'])){
            //         $itemInfo['max_price']=$itemInfo['max_price']/100;
            //     }

            // }
            foreach ($this->spaceItem as $k => $v) {
                if($this->item_id == $v['id']){
                    $itemInfo=$v;
                }
            }
        }
        if(empty($itemInfo)){
            Func_Header::notFound();
        }
        $itemInfo['price_unit']=str_replace("元/",'',$itemInfo['price_unit']);
        return $itemInfo;
    }


    /*
    * 获取百科名称
    */
    function spaceName()
    {
        $space_name = $this->action[0];
        return $space_name;
    }

    /*
   * 获取百科操作
   */
    function baikeAction()
    {
        $baike_action = $this->action[1];
        return $baike_action;
    }

    /*
   * 获取百科id
   */
    function id()
    {
        return $this->info['id'];
    }


    /*
     * 获取百科信息
     */
    function info()
    {
        //获取百科详情
        $condition['{table}.status = ?'] = 1;
        $spaceInfo = Api_Spacepedia_List_And_Info::getSpacepediaInfoByName($this->spaceName, $condition, 1);
        if (empty($spaceInfo)) {
            //判断旧数据中是否存在
            $old_data=Data_Mysql_Table_Space_Redirect::select('*',array("space_name"=>$this->spaceName));

            if(!empty($old_data[0]['space_id'])){
                $space_data = Api_Spacepedia_List_And_Info::getSpacepediaInfoById($old_data[0]['space_id'], $condition, 1);
                if(!empty($space_data[0])){
                    $spaceInfo=$space_data[0];
                    $this->spaceName = $spaceInfo['space_name'];
                }else{
                    Func_Header::notFound();
                }
            }else{
                Func_Header::notFound();
            }
        }
        $spaceInfo['seo_title'] = empty($spaceInfo['attr']['营销标题']) ? "" : $spaceInfo['attr']['营销标题'];
        $spaceInfo['special_tags'] = empty($spaceInfo['attr']['特色标签']) ? "" : $spaceInfo['attr']['特色标签'];
        $spaceInfo['special_tags'] = str_replace(',', " / ", $spaceInfo['special_tags']);
        $spaceInfo['special_tags_arr'] = explode('/', $spaceInfo['special_tags']);
        unset($spaceInfo['attr']['特色标签'], $spaceInfo['attr']['营销标题']);
        //将百科的城市放入cookie中
        $city_key = array_search($spaceInfo['city'], $_REQUEST['cities']);
        $_COOKIE['city_key'] = empty($city_key) ? "sh" : $city_key;
        $spaceInfo['category_name']=Data_Mysql_Table_Spacepedia::getCategoryNameById($spaceInfo['category_id']);
        return $spaceInfo;

    }


    /*
     *获取场地的子空间列表
     */
    function spaceItem()
    {
        $condition['space_id'] = $this->id;
        $condition['status'] = 1;
        $space_item = Api_Space_Item_List_And_Info::getSpaceItemList($condition, 1);
        $minPrice = array();
        if(!empty($space_item)){
            $minPrice = Api_Space_Item_List_And_Info::getMinPrice(array_column($space_item,'id'));
        }
        if(!empty($space_item) && $this->itemPrice){
            foreach ($space_item as $key => $value) {
                foreach ($this->itemPrice as $k => $v) {
                    if($v['item_id']==$value['id']){
                        $space_item[$key]["item_price"][$v['id']]=$v;
                    }
                }
                if(!empty($minPrice) && array_key_exists($value['id'],$minPrice)){
                    $space_item[$key]['item_min_price'] = $minPrice[$value['id']]['item_min_price'];
                    $space_item[$key]['item_price_unit'] = $minPrice[$value['id']]['item_price_unit'];
                }
            }
        }
        return $space_item;
    }

    /*
     *获取场地的子空间列表和价格
     */
    function itemPrice()
    {
        $condition['{table}.space_id = ?'] = $this->id;
        $item_price = Api_Item_Price_Info::getSpaceItemPrice($condition);
        return $item_price;
    }

    // /*
    //  *获取百科的均价
    //  */
    // function averagePrice(){
    //     $min_total=$max_total=0;
    //     $item_list=$this->spaceItem;
    //     foreach($item_list as $k=>$v){
    //         $min_total+=$v['min_price'];
    //         $max_total+=$v['max_price'];
    //         if(!empty($v['price_unit'])){
    //             $averagePrice['price_unit']=$v['price_unit'];
    //         }
    //     }
    //     $averagePrice['min_price']=floor($min_total/count($item_list));
    //     $averagePrice['max_price']=floor($max_total/count($item_list));
    //     return ($averagePrice['min_price']+$averagePrice['max_price'])/2;
    // }

    /*
     *获取百科的均价
     */
    function baikePrice(){
        $price=Api_Item_Price_Info::getSpacePriceByIds($this->id);
        return $price[$this->id];
    }



    /*
     *处理百科的图片
     */
    function spaceMedia()
    {
        $media_space = $media_item = $media = $return_media1=$return_media = array();
        if($this->item_id==false){
            if (!empty($this->info['media'])) {
                $media_space = $this->info['media'];
            }
            $item_list = $this->spaceItem;
            if (!empty($item_list)) {
                foreach ($item_list as $k => $v) {
                    if (!empty($v['media'])) {
                        foreach ($v['media'] as $mk => $mv) {
                            $media_item[] = $mv;
                        }
                    }
                }
            }
            $media = array_merge($media_space, $media_item);
        }else{
            $media = $this->itemInfo['media'];
        }

        //去除重复图片（name相同）
        $temp_arr=array();
        if (!empty($media)) {
            foreach ($media as $k => $v) {
                if(isset($v['name'])){
                    $temp_arr[$v['name']] = $v;
                }
            }
            foreach ($temp_arr as $k => $v) {
                $return_media[] = $v;
            }
        }
        foreach($return_media as $k=>$v){
            if(!empty($v['path'])){
                $return_media1[$k]["path"]=$v['path'];
                $return_media1[$k]['big_src']=Page_Site_Global::displayMedia($v['path'],750,500,1);
                $return_media1[$k]['small_src']=Page_Site_Global::displayMedia($v['path'],262,225,1);
            }
        }
        return $return_media1;
    }

    /*
     *判断是否为空间
     */
    function isSpace()
    {
        return Web_Global::catIsSpace($this->info['category_id']);
    }


    /*
    *获取产品的标签属性
    */
    function tags()
    {
        $tags = array();
        $attr = $this->info['attr'];
        $tags_tree = $this->tagsTree();
        $tags_info = $this->tagsInfo();
        if (!empty($attr)) {
            foreach ($attr as $k => $v) {
                if (!empty($v)) {
                    if (!empty($tags_info[$k])) {
                        $parent_name = $tags_tree[0][$tags_info[$k]['parent_id']];
                        $tags[$tags_info[$k]['parent_id']]["parent_name"] = $parent_name;
                        $tags[$tags_info[$k]['parent_id']][$tags_info[$k]['tags_name']] = $v;
                    }
                }
            }
        }
        return $tags;
    }

    /*
     * 获取标签信息
     */
    function tagsInfo()
    {
        return Data_Mysql_Table_Tags::getInfoCache();
    }

    /*
     * 获取标签列表
     */
    function tagsTree()
    {
        return Data_Mysql_Table_Tags::getTreeCache();
    }

    /*
     * 获取品牌故事,有副标题有图片的文章
     */
    function caseList()
    {
        $raiders_info = array();
        $subhead = $this->info['subhead'];
        if (!empty($subhead)) {
            $raiders_id = array_keys($subhead);
            $condition[] = "id in (" . implode(",", $raiders_id) . ")";
            $condition[] = "logo != '' ";
            $raiders_info = Data_Mysql_Table_Raiders_Info::select('id,logo,des', $condition, 'ORDER BY counter_praise DESC', 9);
        }
        if (!empty($raiders_info)) {
            foreach ($raiders_info as $k => $v) {
                $raiders_info[$k]["subhead"] = $subhead[$v['id']];
            }
        }
        return $raiders_info;
    }

    /*
    *更新百科的浏览量
    */
    function updateCountViewPage()
    {
        //获取百科关联的文章总浏览量
        $space=Data_Mysql_Table_Spacepedia::select('id',array("space_name"=>$this->spaceName,"status"=>1));
        if(!empty($space[0]['id'])){
            $article_view=Data_Mysql_Table_Raiders_Info::select("sum(counter_view) as total",array("space_ids"=>$space[0]['id']));
            $num=empty($article_view[0]['total'])?0:$article_view[0]['total'];
            Data_Mysql_Table_Baike_Statistical::query('INSERT INTO {table} (space_id ,click) VALUES ("' . $space[0]['id'] . '", '.$num.')  ON DUPLICATE KEY UPDATE click = click +1');
//            Data_Mysql_Table_Search_Space_Item::query('INSERT INTO {table} (baike_id ,click) VALUES ("' . $space[0]['id'] . '", '.$num.')  ON DUPLICATE KEY UPDATE click = click +1');
        }
    }



    // 获取百科评论列表
    function getBaikeCommentsList(){
        $baikeId['id'] = $this->id;
        $comments = Api_Comments_GetCommentsList::commentsList($baikeId);
        return $comments;
    }

    // 获取回复评论列表
    function getCommentsReplyList(){
        if(isset($this->action[2]) && $this->action[2]=='reply' && isset($this->action[3])){
            $condition['id']=$this->action[3];
            $replyData = Api_Comments_GetReplyList::GetCommentInfo($condition);
            if(empty($replyData)){
                Func_Header::notFound();
            }
            return $replyData;
        }
    }




    // 获取用户微信头像信息
    function getAccountInfo()
    {
        if (isset($_SESSION['wechat_id'])) {
            $user['wechat_id'] = $_SESSION['wechat_id'];
            $data = Api_Comments_GetUserInfo::userInfo($user);
            return $data;
        }
    }


    // 推荐阅读
    function recommendArticle()
    {
        $conditions['space_ids'] = $this->id;
        $conditions['logo !=?'] = '';
        $conditions['status']=1;
        $article = Data_Mysql_Table_Raiders_Info::select('*',$conditions,'ORDER BY is_good DESC,create_time DESC',4);
        if(empty($article)){
            unset($conditions['space_ids']);
            $article = Data_Mysql_Table_Raiders_Info::select('*',$conditions,'ORDER BY is_good DESC,create_time DESC',4);
        }elseif(!empty($article) && count($article)<4) {
            unset($conditions['space_ids']);
            $article_other = Data_Mysql_Table_Raiders_Info::select('*', $conditions, 'ORDER BY is_good DESC,create_time DESC', 4 - count($article));
            if (!empty($article_other)) {
                $article = array_merge($article, $article_other);
            }
        }
        return $article;
    }

    //获取附近场地
    function getNearSpace(){
        $search['id']=$this->id;
        $search['lng']=$this->info['geo_lng'];
        $search['lat']=$this->info['geo_lat'];
        $data=Api_Map_Search_PointShow_v2::getNearSpaceList($search);
        return $data;
    }
    function cityBaike(){
        Tpl_Smarty::assign('action_city_name',$this->spaceName);
//先判断城市百科是否存在


//获取城市百科信息  名称 说明（说明氛围介绍和地理位置介绍）  介绍图片。所有图片都显示（轮播）
//获取百科详情
        $condition['{table}.status = ?'] = 1;
        $spaceInfo =$this->info();
        $spaceInfo['seo_title'] = empty($spaceInfo['attr']['营销标题']) ? "" : $spaceInfo['attr']['营销标题'];
        $spaceInfo['special_tags'] = empty($spaceInfo['attr']['特色标签']) ? "" : $spaceInfo['attr']['特色标签'];
        $spaceInfo['special_tags'] = str_replace(',', " / ", $spaceInfo['special_tags']);
        unset($spaceInfo['attr']['特色标签'], $spaceInfo['attr']['营销标题']);
////将百科的城市放入cookie中
//$city_key = array_search($spaceInfo['city'], $_REQUEST['cities']);
//$_COOKIE['city_key'] = empty($city_key) ? "sh" : $city_key;
        Tpl_Smarty::assign('spaceInfo',$spaceInfo);
//获取百科下四篇文章
        $condition = array(
            'space_ids'=>$spaceInfo['id'],
            'logo !=?'=>''
        );
        $article_list = Web_Baike_New::getArticles($condition,1,"ORDER BY counter_view DESC, create_time DESC",8);
        Tpl_Smarty::assign('article_list',$article_list);
//获取该区域场地数据 缩放级别
//用ajax请求吧

//获取该地区的相关场地
//先默认显示多少条,然后再加载更多
        $getLists = Api_Spacepedia_List::getMoreList(array("city"=>$spaceInfo['space_name']));
        if($getLists['status']==1){
            $space_list = $getLists['data']['data'];
            Tpl_Smarty::assign('next_dp', $getLists['data']['next_dp']);
            Tpl_Smarty::assign('total_num', $getLists['data']['total_num']);
            Tpl_Smarty::assign('space_list',$space_list);
        }else{
            Tpl_Smarty::assign('next_dp',0);
            Tpl_Smarty::assign('space_list','');
        }

        $this::display('Web_Static::city_baike/city_baike_1.tpl');
    }

}