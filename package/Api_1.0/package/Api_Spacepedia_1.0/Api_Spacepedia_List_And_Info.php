<?php

/**
 * Created by PhpStorm.
 * User: yl
 * Date: 15-10-16
 * Time: 上午10:29
 * 查询场地百科列表和详情方法
 */
class Api_Spacepedia_List_And_Info
{
    /*
     *获取全部场地百科的列表
     * @param:$condition  array 检索条件
     * @return:列表数组
     */
    static function getSpacepediaList($condition = array(),$order='',$no_page=1,$limit=10)
    {
        $cols = "{table}.*,{prefix}baike_statistical.article_sum,{prefix}baike_statistical.update_time as article_update_time";
        $table = "{table} LEFT JOIN {prefix}baike_statistical ON {table}.id = {prefix}baike_statistical.space_id";
        //默认是有分页
        if($no_page==1){
            $data = Data_Mysql_Table_Spacepedia::page(0, 20, $cols, $condition, $order, $table);
            if (empty($data['rows'])) {
                return array();
            }
            $date = time(); // 更新文章数量使用
            foreach ($data['rows'] as $k => $v) {
                if (!empty($v['attr'])) {
                    $data['rows'][$k]['attr'] = json_decode($v['attr'], 1);
                }
                if (!empty($v['media'])) {
                    $data['rows'][$k]['media'] = json_decode($v['media'], 1);
                }
                if (!empty($v['other_demo'])) {
                    $data['rows'][$k]['other_demo'] = json_decode($v['other_demo'], 1);
                }
                // 查询百科文章数量
                if(empty($v['article_sum']) || (time()-$v['article_update_time']>86400*3)){
                    $data['rows'][$k]['article_sum'] = self::getArticleCount($v['id']);
//                    if(!empty($data['rows'][$k]['article_sum'])){
                        Data_Mysql_Table_Baike_Statistical::query('INSERT INTO {table} (space_id,update_time) VALUES ("'.$v['id'].'","'.$date.'")  ON DUPLICATE KEY UPDATE article_sum ='.$data['rows'][$k]['article_sum'].',update_time='.$date);
//                    }
                }
            }
        }else{
            $data = Data_Mysql_Table_Spacepedia::select($cols, $condition, $order, $limit,$table);
            if (empty($data)) {
                return array();
            }
            foreach ($data as $k => $v) {
                if (!empty($v['attr'])) {
                    $data[$k]['attr'] = json_decode($v['attr'], 1);
                }
                if (!empty($v['media'])) {
                    $data[$k]['media'] = json_decode($v['media'], 1);
                }
                if (!empty($v['other_demo'])) {
                    $data[$k]['other_demo'] = json_decode($v['other_demo'], 1);
                }
                // 查询百科文章数量
                if (empty($v['article_sum']) || (time() - $v['article_update_time'] > 86400 * 3)) {
                    $data[$k]['article_sum'] = self::getArticleCount($v['id']);
//                    if (!empty($data[$k]['article_sum'])) {
                        Data_Mysql_Table_Baike_Statistical::query('INSERT INTO {table} (space_id,update_time) VALUES ("' . $v['id'] . '","' . $date . '")  ON DUPLICATE KEY UPDATE article_sum =' . $data['rows'][$k]['article_sum'] . ',update_time=' . $date);
//                    }
                }
            }
        }
        return $data;
    }

    //获取历史表信息待审核的
    static function getHistory($condition = array(),$month,$limit=20)
    {
        $cols = "{table}.*";
        $order = "ORDER BY {table}.create_time DESC";
        $table = "{table}";
        if(empty($month)) {
            return false;
        }else{
           $data = Data_Mysql_Table_History::subTable('_baike_' . $month)->page(0, $limit, $cols, $condition, $order, $table);
        }
        if (empty($data['rows'])) {
            return array();
        }
        foreach ($data['rows'] as $k => $v) {
            if (!empty($v['data_backup'])) {
                $data['rows'][$k]['data_backup'] = json_decode($v['data_backup'], 1);
            }
//            if (!empty($v['media'])) {
//                $data['rows'][$k]['data_backup']['media'] = json_decode($v['data_backup']['media'], 1);
//            }
        }
        return $data;
    }

    //获取历史表的id和month获取信息
    static function getHistoryByHistoryId($history_id,$month)
    {
        $condition['id']=$history_id;
        $order = "ORDER BY create_time DESC";
        $data = Data_Mysql_Table_History::subTable('_baike_' . $month)->select("*", $condition, $order);
        if (empty($data[0])) {
            return array();
        }
        if (empty($data[0]['data_backup'])) {
            return array();
        }
        $data[0]['data_backup'] = json_decode($data[0]['data_backup'], 1);
        return $data[0];
    }


    /*
     *根据百科ID获取历史信息
     */
    static function getHistoryInfoById($id, $condition = array())
    {
        //获取当前百科的最后更新时间
        $spaceInfo=Data_Mysql_Table_Spacepedia::select('id,update_time',array("id"=>$id));
        if(empty($spaceInfo[0])){
            return array();
        }
        $condition['{table}.object_id = ?'] = $id;
//        $cols = "count(*) as count";
        $cols = "{table}.*";
        $table = "{table}";
        $data1 = Data_Mysql_Table_History::subTable('_baike_' . date("Ym"))->select($cols,$condition,'order by {table}.create_time DESC', 3, $table);
        if(count($data1)!=3){
            $tmp_date=date("Ym");
            //切割出年份
            $tmp_year=substr($tmp_date,0,4);
            //切割出月份
            $tmp_mon =substr($tmp_date,4,2);
            $tmp_forwardmonth=date("Ym",mktime(0,0,0,$tmp_mon-1,1,$tmp_year));
            $data2 = Data_Mysql_Table_History::subTable('_baike_' . $tmp_forwardmonth)->select($cols, $condition, 'order by {table}.create_time DESC', (3-count($data1)), $table);
            $data1=array_merge($data1,$data2);
            $update_month=date("Ym",$spaceInfo[0]['update_time']);
            if(count($data1)!=3 && $update_month !=date("Ym") && $update_month != $tmp_forwardmonth ){
                $data3 = Data_Mysql_Table_History::subTable('_baike_' . $update_month)->select($cols, $condition, 'order by {table}.create_time DESC', (3-count($data1)), $table);
                $data1=array_merge($data1,$data3);
            }
        }
        if (!empty($data1)) {
            foreach ($data1 as $k => $v) {
                $data1[$k]['data_backup'] = json_decode($v['data_backup'], 1);
            }
        }
        return $data1;
    }


    /*
       *根据百科ID获取百科信息
       */
    static function getSpacepediaInfoById($id, $condition = array())
    {
        if(strstr($id,',')){
            $condition[] = '{table}.id IN ('.$id.')';
            $count = count(explode(',',$id));
        }else{
            $condition['{table}.id = ?'] = $id;
            $count = 1 ;
        }
        $cols = "{table}.*";
        $table = "{table}";
        $data = Data_Mysql_Table_Spacepedia::select($cols, $condition, '', $count, $table);
        if (empty($data[0])) {
            return array();
        }
        if($count>1) {
            $data[0]['space_names'] = implode(',',array_column($data,'space_name'));
            $data[0]['ids'] =  implode(',',array_column($data,'id'));
        }
        if (!empty($data[0]['attr'])) {
            $data[0]['attr'] = json_decode($data[0]['attr'], 1);
        }
        if (!empty($data[0]['media'])) {
            $data[0]['media'] = json_decode($data[0]['media'], 1);
        }
        if (!empty($data[0]['subhead'])) {
            $data[0]['subhead'] = json_decode($data[0]['subhead'], 1);
        }
        if (!empty($data[0]['other_demo'])) {
            $data[0]['other_demo'] = json_decode($data[0]['other_demo'], 1);
        }
        return $data;
    }


    /*
     *根据百科名称获取百科信息
     */
    static function getSpacepediaInfoByName($space_name, $condition = array(),$no_join=0)
    {
        if($no_join){
//            不要连表查询
            $condition['{table}.space_name = ?'] = $space_name;
            $cols = "{table}.*,{prefix}baike_statistical.click,{prefix}baike_statistical.is_love,{prefix}baike_statistical.is_go";
            $table = "{table} LEFT JOIN {prefix}baike_statistical ON {table}.id={prefix}baike_statistical.space_id";
        }else{
            $condition['{table}.space_name = ?'] = $space_name;
            $cols = "{table}.*,{prefix}baike_statistical.click,{prefix}baike_statistical.is_love,{prefix}baike_statistical.is_go";
            $table = "{table} LEFT JOIN {prefix}baike_statistical ON {table}.id={prefix}baike_statistical.space_id";
        }
//        $condition['{table}.space_name = ?'] = $space_name;
//        $cols = "{table}.*,{prefix}vendor_info_update.vendor_name,{prefix}account.username,{prefix}account.phone,{prefix}account.email";
//        $table = "{table} LEFT JOIN {prefix}vendor_info_update ON {table}.vendor_id = {prefix}vendor_info_update.id LEFT JOIN {prefix}account ON {prefix}vendor_info_update.vendor_account_id = {prefix}account.id";
        $data = Data_Mysql_Table_Spacepedia::select($cols, $condition, '', 1, $table);
        if (empty($data[0])) {
            return array();
        }
        if (!empty($data[0]['attr'])) {
            $data[0]['attr'] = json_decode($data[0]['attr'], 1);
        }
        if (!empty($data[0]['media'])) {
            $data[0]['media'] = json_decode($data[0]['media'], 1);
        }
        if (!empty($data[0]['subhead'])) {
            $data[0]['subhead'] = json_decode($data[0]['subhead'], 1);
        }
        if (!empty($data[0]['other_demo'])) {
            $data[0]['other_demo'] = json_decode($data[0]['other_demo'], 1);
        }
        if (!empty($data[0]['wenchuang_attr'])) {
            $data[0]['wenchuang_attr'] = json_decode($data[0]['wenchuang_attr'], 1);
        }
        return $data[0];
    }


    /*
     *获取百科的所有活动案例
     */
    static function getRaidersCaseBySpaceName($space_name)
    {
        $raider_list = array();
        $cols = "id,title,des,logo,media";
        $condition['title'] = $space_name;
//        $condition['des']=$space_name;
//        $condition['title = ? OR des = ?']=array($space_name,$space_name);
        $order = "ORDER BY counter_praise DESC,counter_view DESC";
        $raider_list = Data_Mysql_Table_Raiders_Info::select($cols, $condition, $order, 6);
        return $raider_list;
    }

    // 获取百科相关文章数量
    static function getArticleCount($space_id)
    {
        $article =  Data_Mysql_Table_Raiders_Info::select('count(*) as article_sum',array('space_ids'=>$space_id,'status'=>1));
        return $article[0]['article_sum'];
    }

    // 获取百科下的子空间详情
    static function getSpaceItemInfoById($item_id)
    {
        $conditions[] = '{table}.status = 1';
        $conditions[] = '{table}.id ='.$item_id;
        $conditions[] = '(price.id is null OR price.is_public=1)';
//        Data_Mysql_Table_Space_Item::debug(1);
        $item = Data_Mysql_Table_Space_Item::select('{table}.id,{table}.item_name,{table}.tags_new,{table}.tags,price.standard,price.price_unit,price.discount_price',$conditions,'',10,'{table} LEFT JOIN {prefix}item_price as price ON {table}.id = price.item_id');
        if(!empty($item[0])){
            if(!empty($item[0]['tags_new'])){
                $item[0]['tags_new'] = explode(',',$item[0]['tags_new']);
            }elseif(empty($item[0]['tags_new']) && !empty($item[0]['tags'])){
                $_REQUEST['search_type']=2;
                $tags_arr = Api_Demand_Offer_Get_Demand_Tag_List::getTagList();
                $tags = json_decode($item[0]['tags'],1);
                $item[0]['tags_new'] = array();
                foreach ($tags as $k => $v) {
                    if (!empty($v)) {
                        $item[0]['tags_new'][] = $tags_arr['data'][$k]['tag_value'];
                    }
                }
            }
        }
        return $item;
    }

}