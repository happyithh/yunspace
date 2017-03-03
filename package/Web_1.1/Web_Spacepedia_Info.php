<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2015/10/22
 * Time: 09:30
 * @场地百科
 */

class  Web_Spacepedia_Info extends Page_Base
{
    function seo(){
        Tpl_Smarty::assign('__seo', array(
            '网页标题'=>$this->info['space_name'].'_场地百科|云SPACE',
            '网页关键词'=>$this->info['space_name'].','.$this->info['city'].$this->info['space_name'].','.$this->info['space_name'].'百科,'.$this->info['special_tags'].',',
            '网页简介'=>mb_substr(trim(strip_tags($this->info['des'])),0,300,'utf-8')
        ));
    }
    /*
    * 获取百科名称
    */
    function spaceName()
    {
        $space_name= Func_Url::str_urldecode(Func_String::utf8(Core::$urls['action']));
        return $space_name;
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
        $condition['{table}.status = ?']=1;
        $spaceInfo=Api_Spacepedia_List_And_Info::getSpacepediaInfoByName($this->spaceName,$condition,1);
        if(empty($spaceInfo)){
            Func_Header::notFound();
        }
        $spaceInfo['seo_title']=empty($spaceInfo['attr']['营销标题'])?"":$spaceInfo['attr']['营销标题'];
        $spaceInfo['special_tags']=empty($spaceInfo['attr']['特色标签'])?"":$spaceInfo['attr']['特色标签'];
        $spaceInfo['special_tags']=str_replace(','," / ",$spaceInfo['special_tags']);
        unset($spaceInfo['attr']['特色标签'],$spaceInfo['attr']['营销标题']);
        //将百科的城市放入cookie中
        $city_key=array_search($spaceInfo['city'], $_REQUEST['cities']);
        $_COOKIE['city_key']=empty($city_key)?"sh":$city_key;
        return $spaceInfo;
    }

    /*
     * 获取百科的banner
     */
    function banner(){
        $banner="";
        if(empty($this->info["logo"])){
            $media=$this->spaceMedia();
            foreach ($media as $mk => $mv) {
                //主图
                $banner= $mv['path'];
                if (!empty($mv['tags']) && strpos($mv['tags'], '@主图') !== false) {
                    $banner = $mv['path'];
                    break;
                }
            }
        }else{
            return $this->info["logo"];
        }
        return $banner;
    }



    /*
     *获取场地的子空间列表
     */
    function spaceItem(){
        $condition['space_id']=$this->id;
        $condition['status']=1;
        $space_item=Api_Space_Item_List_And_Info::getSpaceItemList($condition,$no_page=1);
        return $space_item;
    }


    /*
     *处理百科的图片
     */
    function spaceMedia(){
        $media_space=$media_item=$media=array();
        if(!empty($this->info['media'])){
            $media_space=$this->info['media'];
        }
        $item_list=$this->spaceItem;
        if(!empty($item_list)){
            foreach($item_list as $k=>$v){
                if(!empty($v['media'])){
                    foreach($v['media'] as $mk=>$mv){
                        $media_item[]=$mv;
                    }
                }
            }
        }
        $media=array_merge($media_space,$media_item);
        return $media;
    }

    /*
    *js获取图片,每次取9张
    */
    function getMediaByNum($start=0,$limit=9){
        $return=array();
        $media=$this->spaceMedia;
        if(empty($media)){
            return $return;
        }
        $i=$start;
        foreach($media as $k=>$v){
            if($start < $i+$limit && $start<=$k){
                $return['media_data'][$start]=$media[$start];
                $return['media_data'][$start]['big_src']=Page_Site_Global::displayMedia($media[$start]['path'],850,545,1);
                $return['media_data'][$start]['small_src']=Page_Site_Global::displayMedia($media[$start]['path'],294,252,1);
                $return['media_data'][$start]['order']=$k;
                $start++;
            }
            $return['start_num']=$start;
        }
        return $return;
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
        return $averagePrice;
    }


    /*
    *获取产品的标签属性
    */
    function tags()
    {
        $tags=array();
        $attr=$this->info['attr'];
        $tags_tree=$this->tagsTree();
        $tags_info=$this->tagsInfo();
        if(!empty($attr)){
            foreach($attr as $k=>$v){
                if(!empty($v)){
                    if (!empty($tags_info[$k])) {
                        $parent_name = $tags_tree[0][$tags_info[$k]['parent_id']];
                        $tags[$tags_info[$k]['parent_id']]["parent_name"]=$parent_name;
                        $tags[$tags_info[$k]['parent_id']][$tags_info[$k]['tags_name']]=$v;
                    }
                }
            }
        }
        return $tags;
    }

    /*
     * 获取分类信息
     */
    function categoryInfo()
    {
        return Data_Mysql_Table_Product_Category::getInfoCache();
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
     * 获取活动案例
     */
    function caseList()
    {
        $_REQUEST['space_name']=$this->info['space_name'];
       $case=Api_Spacepedia_Web_Case::handleGetMoreCase();
        if(empty($case['status'])){
            return array();
        }else{
            return $case['data'];
        }
    }



}