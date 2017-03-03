<?php

/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/10
 * Time: 14:11
 * 集合分类处理
 *
 */
class Web_Baike_Classify extends Web_Global
{
    function seo(){
        if(!empty($this->getSiteName['childrenName'])){
            $title = $this->getSiteName['siteName'].'-'.$this->getSiteName['childrenName'];
        }else{
            $title = $this->getSiteName['siteName'];
        }
            return array(
                '网页标题'=>$title,
                '网页关键词'=>'云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地',
                '网页简介'=>'云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定'
            );



    }
    //集合名称及子类标签的名称
    function getSiteName(){
        if(!empty(Core::$urls['action'])){
            $action = Func_Url::str_urldecode(Func_String::utf8(Core::$urls['action']));
            $childrenName = explode('/',$action);
            $getType = explode('-',$action);
            $type = $getType[0];
        }else{
            $type=112;
        }
        switch ($type) {
            case '112':
                $sites['siteName'] = "【云SPACE】-优质场地空间展示";
                break;
            case '200':
                $sites['siteName'] = '【云SPACE】-IP项目_文创项目展示_商场体验式营销活动合作';
                break;
            case '400':
                $sites['siteName'] = "【云SPACE】-全国最新场地活动资讯_活动策划_活动方案_活动主题";
                break;
            case '300':
                $sites['siteName'] = '【云SPACE】-发现最新精彩城市活动';
                break;
            default:
                $sites['siteName'] = "【云SPACE】-优质场地空间展示";
        }
        if(!empty($childrenName[1])){
           $sites['childrenName'] = $childrenName[1];
        }else{
            $sites['childrenName']='';
        }
        return $sites;
    }
    // 获取集合action信息
    function action (){
        $action = Func_Url::str_urldecode(Func_String::utf8(Core::$urls['action']));
        $actionInfo = explode('-',$action);
        return $actionInfo;
    }
    // 获取集合分类标签
     function getType(){
         if(!empty($this->action[0])){
             $type = $this->action[0];
         }else{
             $type=112;
         }
         return $type;
     }
    // 获取子类标签
    function getChildrenType(){
        $childrenType = !isset($this->action[1])?'':$this->action[1];
        return $childrenType;
    }
    // 获取子类名称
    function getChildrenName(){
        // 子分类标签获取
        $children = Data_Mysql_Table_Spacepedia::$category_name;
        $childrenName[$this->getType] =array();
        foreach ($children as $k => $v) {
            if ($v['parent']==$this->getType) {
                $childrenName[$this->getType][]=$v;
            }
        }
        return $childrenName;
    }
    // 获取分类数据
     function getBaikeList(){
        if (empty($this->getChildrenType)) {
            $type['category_id'] = $this->getType;
            $data = Api_Baike_Sites_List::getBaikeList($type);
        }else{
            $type['category_id'] =  $this->getChildrenType;
            $data = Api_Baike_Sites_List::getBaikeList($type);
        }
         return $data['data'];
    }


}