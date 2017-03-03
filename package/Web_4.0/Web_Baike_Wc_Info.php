<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 2015/10/22
 * Time: 09:30
 * @场地百科
 */
@session_start();

class  Web_Baike_Wc_Info extends Web_Global
{

    function seo()
    {
        switch($this->baikeAction)
        {
            case '最新':
                $title = $this->info['active_name'].'最新活动资讯-【云SPACE】';
                break;
            case '精华':
                $title = $this->info['active_name'].'精华活动资讯-【云SPACE】';
                break;
            case '百科':
                if (isset($this->action[2]) && $this->action[2] == '图片') {
                    $title = $this->info['active_name'] . '-场地图片-' . count($this->spaceMedia) . '张';
                }else{
                    $title = $this->info['active_name'].'-文创项目-【云SPACE-场地百科】';
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
            '网页关键词' => $this->info['category'].$this->info['active_name'].','.$this->info['city'].$this->info['active_name'],
            '网页简介' => $this->info['active_name'].'-'.$this->info['city'].'-'.$this->info['active_name'].'-'.mb_substr(trim(strip_tags($this->info['ip_brief_introduction'])), 0, 300, 'utf-8')
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
            Func_Header::notFound();
        }
        $condition =array(
            '{table}.status=?'=>1,
            '{table}.space_id=?'=>$spaceInfo['id'],
            '{table}.online_status=?'=>1
        );
        $cols = "{table}.*,{prefix}baike_statistical.click,{prefix}baike_statistical.is_love,{prefix}baike_statistical.is_go";
        $table = "{table} LEFT JOIN {prefix}baike_statistical ON {table}.space_id={prefix}baike_statistical.space_id";
        $data = Data_Mysql_Table_Winchance_New::select($cols, $condition, '', 1, $table);
        if($data[0]['cover_picture']){
            $data[0]['cover_picture'] = json_decode($data[0]['cover_picture'],1);
            $logo =  current($data[0]['cover_picture']);
            $data[0]['cover_logo'] = $logo['path'];
        }else{
            $data[0]['cover_logo'] = 'img/winchance/hz_img1.jpg';
        }
        //将百科的城市放入cookie中
        return $data[0];

    }


    function baikePrice(){
        $price=Api_Item_Price_Info::getSpacePriceByIds($this->id);
        return $price[$this->id];
    }



    /*
     *处理百科的图片
     */
    function spaceMedia()
    {
        $media = $this->info['cover_picture'];

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
    function  getArticleList(){
        $condition['space_id'] =$this->info['space_id'];
        $condition['type']='';
        $data = Api_Raiders_Get_List::getArticleList($condition);
        if($data){
            return $data;
        }else{
            return array();
        }
    }

}