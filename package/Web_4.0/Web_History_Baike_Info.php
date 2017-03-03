<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2015/10/22
 * Time: 09:30
 * @场地百科
 */
class  Web_History_Baike_Info extends Web_Global
{

    function seo()
    {
        return array(
            '网页标题' => $this->info['space_name']."预览页面",
        );
    }

    /*
    * 获取百科id
    */
    function spaceName()
    {
        $space_name = Core::$urls['action'];
        return $space_name;
    }

    /*
   * 获取百科id
   */
    function id()
    {
        return Func_NumEncode::d(Core::$urls['action']);
    }


    /*
     * 获取百科信息
     */
    function info()
    {
        //调取历史表数据
        $history = Api_Spacepedia_List_And_Info::getHistoryInfoById($this->id,array('{table}.status = ?'=>0));
        if(!empty($history[0])){
            $spaceInfo=$history[0]['data_backup'];
            $spaceInfo['id']=$spaceInfo['space_id'];
            $this->spaceName = $spaceInfo['space_name'];
        }
        if (empty($spaceInfo)) {
            Func_Header::notFound();
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
        $space_item = Api_Space_Item_List_And_Info::getSpaceItemList($condition, $no_page = 1);
        return $space_item;
    }

    /*
     *获取百科的均价
     */
    function averagePrice(){
        $min_total=$max_total=0;
        $item_list=$this->spaceItem;
        foreach($item_list as $k=>$v){
            $min_total+=$v['min_price'];
            $max_total+=$v['max_price'];
            if(!empty($v['price_unit'])){
                $averagePrice['price_unit']=$v['price_unit'];
            }
        }
        $averagePrice['min_price']=floor($min_total/count($item_list));
        $averagePrice['max_price']=floor($max_total/count($item_list));
        return ($averagePrice['min_price']+$averagePrice['max_price'])/2;
    }



    /*
     *处理百科的图片
     */
    function spaceMedia()
    {
        $media_space = $media_item = $media = $return_media1=$return_media = array();
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




    //获取附近场地
    function getNearSpace(){
        $search['id']=$this->id;
        $search['lng']=$this->info['geo_lng'];
        $search['lat']=$this->info['geo_lat'];
        $data=Api_Map_Search_PointShow_v2::getNearSpaceList($search);
        return $data;
    }
}