<?php
/**
 * Created by PhpStorm.
 * User: bxy
 * Date: 2015/12/28
 * Time: 17:52
 *
 * 资讯 列表
 */
class Web_Article_List extends Web_Global{

    function seo(){
        if (!empty($this->getAction[0])) {
            $title = $this->getCategory[$this->getAction[0]]."-【云SPACE】";
        } else {
            $title = '全国最新活动资讯_活动策划_活动方案_活动主题-【云SPACE】';

        }
        return array(
            '网页标题' => $title,
            '网页关键词' => '云SPACE,活动场地,北京活动场地,上海活动场地,场地租赁,秀场租赁,路演场地,发布会场地,年会场地',
            '网页简介' => '云SPACE是专业的活动场地预订、租赁平台。为您提供上海、北京、广州、深圳、成都、杭州、南京、苏州等一二线城市活动场地,年会场地,购物中心,秀场,商场,loft空间,适合开办特卖,试乘试驾,走秀,高级定制,沙龙,集客等活动的特价活动空间。举办路演、推广活动、发布会选址是关键.一键直达,专业的服务,精准的报价,轻松搞定'
        );

    }
    function getArticleList(){
        if(!empty($this->getAction[0])){
            $categoryIds = Data_Mysql_Table_Raiders_Info::getCategoryChildren($this->getAction[0]);
            $condition[]='category_id IN ('.implode(',',$categoryIds).')';
        }
        $notCategoryIds = Data_Mysql_Table_Raiders_Info::getCategoryChildren(12);
        $condition[] = 'category_id NOT IN ('.implode(',',$notCategoryIds).')';
        $condition['status=?']=1;
        if($this->getAction[1]=='recommend'){
            $condition['is_good'] = 1;
        }
        $condition['create_time <=?'] = time();
        $order="ORDER BY create_time DESC, counter_praise DESC";
        $data = Data_Mysql_Table_Raiders_Info::page(0,15,'*',$condition,$order);
        return $data;
    }

    function getAction()
    {
        $action=array(
            '',
            'new'
        );
        $type_array= array('new','recommend');
        if(!empty(Core::$urls['action'])){
            $url = urldecode(Core::$urls['action']);
            $url =str_replace("\"><",'',$url);
            $url =str_replace("'",'',$url);
            $url =str_replace(">",'',$url);
            $url =str_replace("<",'',$url);
            $url =strip_tags($url);
            Core::$urls['action'] = urlencode($url);
            $actionStr = Func_Url::str_urldecode(Func_String::utf8(Core::$urls['action']));
            $action_new = explode('-',$actionStr);
            if($action && isset($action_new[1])){
                if(is_numeric($action_new[0])){
                    $action[0] = $action_new[0];
                }
                if(in_array( $action_new[1],$type_array)){
                    $action[1] = $action_new[1];
                }
            }
            if($action && !isset($action_new[1])){
                if(in_array( $action_new[0],$type_array)){
                    $action[1] = $action_new[0];
                }
            }
        }
        return $action;
    }
    function getCategory()
    {
        $category =Data_Mysql_Table_Raiders_Info::$category_name;
        if(!empty($category)){
            foreach($category as $k=>$v){
                if($v['id']!=12 && $v['parent']!=12 && $v['parent']==0){
                    $catagoryName[$v['id']] = $v['name'];
                }
            }
            return $catagoryName;
        }

    }
}